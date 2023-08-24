using UnityEngine;
using System.Collections;
namespace Assets.Scripts.Com.Game.Mono
{
     class CameraShake : MonoBehaviour
    {
        public enum SHAKEMODE
        {
            NONE,
            LEFT_RIGHT,
            UP_DOWN,
            BOTH,
            SCALE,
            Animation
        }
        private bool mShouldShake = false;
        private float mShakeDelta = 0.01f;
        private float mDuration = 0.5f;
        private float mBeganShakeTime = 0;
        private float mCircle = 0.333f;
        private Rect mShakeRect;
        private SHAKEMODE mShakeMode = SHAKEMODE.BOTH;
        private float mFov;
        private float mDefaultFov;
        private bool mbShrink = false;
        private CameraControl mCameraControl;
        void Start()
        {
            this.mShakeRect = this.GetComponent<Camera>().rect;
            this.mDefaultFov = this.GetComponent<Camera>().fieldOfView;
            this.mCameraControl = this.GetComponent<CameraControl>();
        }


        public void Shake(float delta, float t,SHAKEMODE mode,float rate,string state = null)
        {
            if (mode == SHAKEMODE.Animation)
            {
                if (this.mCameraControl == null)
                {
                    this.mCameraControl = this.GetComponent<CameraControl>();
                }

                if (this.mCameraControl)
                {
                    this.mCameraControl.Shake("Base Layer."+state);
                }
                
            }
            else
            {
                this.mShouldShake = true;
                this.mBeganShakeTime = Time.time;
                this.mShakeDelta = Mathf.Clamp(Mathf.Abs(delta), 0, 0.1f);
                this.mDuration = Mathf.Clamp(t, 0.01f, 2);
                this.mShakeMode = mode;
                this.mCircle = 1.0f / Mathf.Max(0.001f, rate);
                this.mFov = this.GetComponent<Camera>().fieldOfView;
                this.mbShrink = delta < 0;
            }

        }

        void LateUpdate()
        {
            if (this.mShouldShake)
            {
                float t = ((Time.time-this.mBeganShakeTime)%this.mCircle)/this.mCircle;
                float d = 2 * Mathf.PingPong(t, this.mShakeDelta) - this.mShakeDelta;
                if (this.mShakeMode == SHAKEMODE.LEFT_RIGHT)
                {
                    this.mShakeRect.Set(d, 0, 1, 1);
                }
                else if (this.mShakeMode == SHAKEMODE.UP_DOWN)
                {
                    this.mShakeRect.Set(0, d, 1, 1);
                }
                else if (this.mShakeMode == SHAKEMODE.BOTH)
                {
                    this.mShakeRect.Set(d, d, 1, 1);
                }
                else if (this.mShakeMode == SHAKEMODE.SCALE)
                {
                    float scale = Mathf.PingPong(t, this.mShakeDelta)*(this.mbShrink?1:-1);
                    this.mFov = this.mDefaultFov * (1 - scale);
                }
                if (Time.time - this.mBeganShakeTime > this.mDuration)
                {
                    this.mShakeRect.Set(0, 0, 1, 1);
                    this.mShouldShake = false;
                    this.mFov = this.mDefaultFov;
                }
                if (this.mShakeMode == SHAKEMODE.SCALE)
                {
                    this.GetComponent<Camera>().fieldOfView = this.mFov;
                }
                else
                {
                    this.GetComponent<Camera>().rect = this.mShakeRect;
                }
                
            }
        }
    }
}

