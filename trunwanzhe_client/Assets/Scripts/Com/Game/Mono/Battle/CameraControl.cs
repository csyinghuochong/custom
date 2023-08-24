using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;
using Assets.Scripts.Com.Game.Utils.Timers;
using Assets.Scripts.Com.Game.Config;
using Assets.Scripts.Com.Game.Manager;
using Assets.Scripts.Com.Game.Utils;
using Assets.Scripts.Com.Game.Core;

//相机移动相关__待改进
public enum CaremaMoveType
{
    None,
    StoryBegin,     //剧情开始
    StoryEnd,       //剧情结束
    ArenaView,      //竞技场镜头
    DungeonOver,    //副本结束时镜头跳转
}
namespace Assets.Scripts.Com.Game.Mono
{
    class CATask
    {
        /// <summary>
        /// 执行当时的回调
        /// </summary>
        public Action playback;
        /// <summary>
        /// 执行完毕的回调
        /// </summary>
        public Action callback;
        public string state;
    }

    class CameraControl : MonoBehaviour
    {
        // Use this for initialization
        public Transform followTarget { get; private set; }

        public Vector3 offset;
      
        public Vector3 lookOffset = new Vector3(0, 1, 0);
        private bool mSetPosition;
        private Vector3 mTargetPos;
        private float mSpeed = 35f;
        private Action mSetPositionCallback;

        private Action mMovePositionCallback = null;
        private CaremaMoveType mMoveType = CaremaMoveType.None;

        private Vector3 mStartPos;
        private float mStartTime;
      
        private CATask mCATask = null;
        Camera mCamera;
        Transform mTransform;

        bool mLookAtTarget = true;
        bool mDragCamera = false;

        /// <summary>
        /// 手指拖动屏幕查看其它地方的战况
        /// </summary>
        private float mTestMoveSpeed = 0.05f;
        //死亡时的焦点
        private Vector3? mLookAtPoint = null;

        const string cCamera = "Camera";
        const string cCameraShake = "CameraShake";
        const string cCameraAnimation = "CameraAnimation";
        void Start()
        {
            if (Application.platform == RuntimePlatform.Android)
            {
                this.mTestMoveSpeed = 0.2f;
            }

            if (mCamera == null)
                mCamera = gameObject.GetComponent<Camera>();
            mTransform = this.transform;

          
        }
        CameraShake cameraShake;
        public void SetFieldOfView(float value)
        {
            if (mCamera == null)
            {
                mCamera = gameObject.GetComponent<Camera>();
            }

            mCamera.fieldOfView = value;
            mPingPongEndFieldView = value;
        }


        public bool mPingPongMove;
        public bool mPingPongBeginMove = true;
        public bool mPingPongEndMove = false;
        public bool mPingPongContinue = true;

        public float mPingPongBeginScale = 3.5f;
        public float mPingPongEndScale = 5f;
        public float mPingPongBeginFieldView = 45;
        public float mPingPongEndFieldView = 40;

        private Transform mDynamicTransform;

        Action mPingPongBeginComplete;
        Action mPingPongEndComplete;
        Vector3 mPingPongTargetPos = new Vector3(11, 16, -6);

        //pos:角色的位置或者是具体的某个世界坐标点;
        public void SetPingPongTargetPos(Vector3 pos, Action beginCompleteAction = null, Action endCompleteAction = null)
        {
            mPingPongTargetPos = pos + offset;

            mPingPongBeginComplete = beginCompleteAction;
            mPingPongEndComplete = endCompleteAction;

            mPingPongBeginMove = true;
            mPingPongEndMove = false;
            mPingPongMove = true;
            mPingPongContinue = true;
        }

        public void SetPingPongBegin(Transform dynamicTransform, Action completeAction)
        {
            mPingPongBeginComplete = completeAction;
            mPingPongTargetPos = dynamicTransform.position + offset;
            mDynamicTransform = dynamicTransform;
            mLookAtTarget = true;

            mPingPongBeginMove = true;
            mPingPongEndMove = false;
            mPingPongMove = true;
            mPingPongContinue = false;
        }

        public void SetPingPongBegin(Vector3 pos, Action completeAction)
        {
            mPingPongBeginComplete = completeAction;
            mPingPongTargetPos = pos + offset;

            mPingPongBeginMove = true;
            mPingPongEndMove = false;
            mPingPongMove = true;
            mPingPongContinue = false;
        }

        public void SetPingPongEnd(Action completeAction)
        {
            mPingPongEndComplete = completeAction;

            mPingPongBeginMove = false;
            mPingPongEndMove = true;
            mPingPongMove = true;
            mPingPongContinue = true;
        }

        void PlayPingPong()
        {
            if (mPingPongBeginMove)
            {
                if (mDynamicTransform)
                {
                    mPingPongTargetPos = mDynamicTransform.position + offset;
                }

                mTransform.position = Vector3.Lerp(mTransform.position, mPingPongTargetPos, Time.deltaTime * mPingPongBeginScale);
                GetComponent<Camera>().fieldOfView = Mathf.Lerp(GetComponent<Camera>().fieldOfView, mPingPongBeginFieldView, Time.deltaTime * mPingPongBeginScale);

                if (Vector3.Distance(transform.position, mPingPongTargetPos) < 0.01f)
                {
                    mPingPongBeginMove = false;
                    mTransform.position = mPingPongTargetPos;

                    if (mDynamicTransform)
                    {
                        mDynamicTransform = null;
                        mPingPongMove = mPingPongContinue && mPingPongEndMove;
                    }

                    if (mPingPongBeginComplete != null)
                    {
                        mPingPongBeginComplete();
                        mPingPongBeginComplete = null;
                    }

                }
            }
            else if (mPingPongContinue && mPingPongEndMove)
            {
                mPingPongTargetPos = this.followTarget.position + offset;
                mTransform.position = Vector3.Lerp(mTransform.position, mPingPongTargetPos, Time.deltaTime * mPingPongEndScale);
                GetComponent<Camera>().fieldOfView = Mathf.Lerp(GetComponent<Camera>().fieldOfView, mPingPongEndFieldView, Time.deltaTime * mPingPongEndScale);

                if (Vector3.Distance(transform.position, mPingPongTargetPos) < 0.01f)
                {
                    mPingPongMove = false;

                    if (mPingPongEndComplete != null)
                    {
                        mPingPongEndComplete();
                        mPingPongEndComplete = null;
                    }
                }
            }
        }
        private Animator mCameraShake;
        private Transform mShakeOffset;

        private void LoadCameraShake(GameObject go)
        {
            this.mCameraShake = go.GetComponent<Animator>();
            this.mShakeOffset = go.transform;
            this.mShakeOffset.parent = this.mTransform;
            this.mShakeOffset.localPosition = Vector3.zero;
            this.mShakeOffset.localEulerAngles = Vector3.zero;
        }

        public void Shake(string shake)
        {
            if (this.mCameraShake && shake != null && shake != string.Empty)
            {
                this.mCameraShake.Play(shake, 0);
            }
        }

        private Animator mCAAnimator;

        public void PlayAnimation(string state, Action callback = null, Action play_back = null)
        {
         
        }

        private Animator mAnimator = null;

        protected void LoadModelComplete(GameObject go)
        {
            this.mAnimator = go.GetComponent<Animator>();//3dmax调的镜头动画

            Transform child = go.transform.Find(cCameraAnimation);
            if (child)
            {
                child.parent = null;
                this.mCAAnimator = child.GetComponent<Animator>();//unity调的镜头动画
                if (this.mCATask != null)
                {
                    this.PlayAnimation(this.mCATask.state, this.mCATask.callback, this.mCATask.playback);
                    this.mCATask = null;
                }
            }

            go.gameObject.SetActive(false);
        }
       

        public void OnWin(Action callback)
        {
          
        }

        private Vector3 mLastMousePosition;
        private void GetKeyboardMoveMent()
        {
            if (Input.GetKey(KeyCode.W))
            {
                this.MoveLookAtPoint(0);
            }
            if (Input.GetKey(KeyCode.S))
            {
                this.MoveLookAtPoint(180);
            }
            if (Input.GetKey(KeyCode.A))
            {
                this.MoveLookAtPoint(-90);
            }
            if (Input.GetKey(KeyCode.D))
            {
                this.MoveLookAtPoint(90);
            }

            if (Input.GetMouseButtonDown(0))
            {
                this.mLastMousePosition = Input.mousePosition;
            }
            else if (Input.GetMouseButton(0))
            {
                Vector3 mousePosition = Input.mousePosition;
                this.MoveLookAtPoint((mousePosition - this.mLastMousePosition) * 0.1f);
                this.mLastMousePosition = mousePosition;
            }
        }

        private void MoveLookAtPoint(Vector2 delta)
        {
            float angle = Mathf.Atan2(-delta.x, -delta.y) * Mathf.Rad2Deg;
            Vector3 forward = this.mTransform.forward;
            forward.y = 0;
            this.mLookAtPoint += delta.magnitude * (Quaternion.Euler(0, angle, 0) * forward);
        }
        private void MoveLookAtPoint(float angle)
        {
            Vector3 forward = this.mTransform.forward;
            forward.y = 0;
            this.mLookAtPoint += Quaternion.Euler(0, angle, 0) * forward * Time.deltaTime * 20;
        }

        public void MoveToLookAtPoint(Vector3 pos)
        {
            this.mLookAtPoint = pos;
        }

        public void OnCameraStart(bool start)
        {
            mDragCamera = start;
        }

        void UpdateLerps()
        {
          
            
        }

        void UpdateAudioListener()
        {
          
        }
        void Update()
        {
            this.UpdateAudioListener();
            this.UpdateLerps();
        }
        void LateUpdate()
        {
            if (mSetPosition)
            {
                var targetPos = Vector3.MoveTowards(mTransform.position, mTargetPos, mSpeed * Time.deltaTime);
                mTransform.position = targetPos;

                if (mTransform.position == mTargetPos)
                {
                    mSetPosition = false;
                    if (mSetPositionCallback != null)
                        mSetPositionCallback();
                }
                return;
            }

          


            Animator aaa;
            if (mMoveType != CaremaMoveType.None)
            {
                MovePosition();
                return;
            }

            if (mPingPongMove)
            {
                PlayPingPong();
                return;
            }


            if (this.followTarget)
            {
                Vector3 position = this.followTarget.position + this.offset;
                mTransform.position = position;
                if (mLookAtTarget)
                {
                    mTransform.LookAt(this.followTarget.position + this.lookOffset);
                }
            }
            else
            {
            }
            if (this.mShakeOffset)
            {
                this.mTransform.eulerAngles = this.mShakeOffset.eulerAngles;
                this.mTransform.position = this.mShakeOffset.position;
            }

        }
        /// 镜头移动相关
        public void SetMoveType(CaremaMoveType type, System.Action callback = null)
        {
            if (type == CaremaMoveType.StoryBegin)
            {
                mTargetPos = this.followTarget.position + this.followTarget.forward * 10;
                SetPingPongBegin(mTargetPos, callback);
            }
            else if (type == CaremaMoveType.StoryEnd)
            {
                SetPingPongEnd(callback);
            }
            else if (type == CaremaMoveType.ArenaView)
            {
                mTargetPos = this.followTarget.position + this.offset;
                mMoveType = CaremaMoveType.ArenaView;
            }
        }

        private void MovePosition()
        {

            float speed = mSpeed;
            if (mMoveType == CaremaMoveType.ArenaView)
                speed = 20f;

            var targetPos = Vector3.MoveTowards(mTransform.position, mTargetPos, speed * Time.deltaTime);

            mTransform.position = targetPos;
            if (mTransform.position == mTargetPos)
            {
                if (mMovePositionCallback != null)
                    mMovePositionCallback();
                mMovePositionCallback = null;
                mLookAtTarget = true;
                mMoveType = CaremaMoveType.None;
            }

            mTransform.LookAt(this.followTarget);
        }

        /*public void ArenaSetLerpCamera()
        {
            CameraControl cc = SceneManager.Instance.GetCameraControl();
            MainHeroControl.Instance.OnSetCameraControl(cc);
            if (cc && cc.followTarget)
            {
                cc.offset = cc.transform.position - cc.followTarget.position;
            }
            LerpCameraOffset lerpCameraOffset = cc.GetLerpCamera<LerpCameraOffset>();
            lerpCameraOffset.Begin(SceneManager.Instance.GetCurScene.defaultOffset, 20);
        }*/

        /// <summary>
        /// 特写到某一位置
        ///     大乱斗特写基地爆炸
        /// </summary>
        /// <param name="position"></param>
        public void SetPosition(Vector3 position, System.Action callback, float speed = 35f)
        {
            mSetPosition = true;
            mTargetPos = position + this.offset;
            mSetPositionCallback = callback;
            mSpeed = speed;

            this.followTarget = null;
        }


    }
}