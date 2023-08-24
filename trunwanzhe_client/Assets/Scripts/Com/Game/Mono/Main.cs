using Assets.Scripts.Com.Game.Events;
using Assets.Scripts.Com.Game.Globals;
using Assets.Scripts.Com.Game.Manager;
using Assets.Scripts.Com.Game.Utils.Timers;
using Assets.Scripts.Com.Net;
using UnityEngine;
using Assets.Plugins.Assets.Scripts.Com.Game.Utils;
using Assets.Plugins.Assets.Scripts.Com.Game.Platform;
using Assets.Scripts.Com.Game.Utils;
using System;

namespace Assets.Scripts.Com.Game.Mono
{
    public class Main : MonoBehaviour
    {

        private GameTimerManager mGameTimerManager = GameTimerManager.Instance;
        public static Main sMainInstance { get; private set; }

        void Awake()
        {
            sMainInstance = this;
            AppAwake();
        }

        public static void SetTargetFrameRate()
        {
            Application.targetFrameRate = 30;
        }

        void Start()
        {
            if (Application.isEditor && Launch.Release == false)
            {
                OnStart();
            }
            else
            {
             
            }
        }

        void OnStart()
        {
            SetTargetFrameRate();
            GlobalGameObject.Instance.Init(this.gameObject);
           
        }

        private void AppAwake()
        {
            RegisterController();
        }

        private bool mIsApplicationPause = false;
        void OnApplicationPause()
        {
            mIsApplicationPause = !mIsApplicationPause;
            EventDispatcher.Instance.Dispatch<bool>(EventConstant.APPLICATION_PAUSE, mIsApplicationPause);

            if (mIsApplicationPause)
            {
            }
            else
            {
            }

            //Debug.Log("OnApplicationPause:" + mIsApplicationPause + " realtimeSinceStartup:" + Time.realtimeSinceStartup + " time:" + DateTime.Now.ToString("mm:ss"));

            //if (mIsApplicationPause == false)
            //{
            //    NetInterface.TraceNet();
            //    DebugControl.debugOnFrequent = true;
            //}
        }
        void OnApplicationQuit()
        {
        }
        public void IosMsg(string msg)
        {
            EventDispatcher.Instance.Dispatch<bool>(EventConstant.SHOW_UI_LOADING, false);

          
        }

        public void IosReceipt(string receipt)
        {
          
        }

        public void IosOnLoginResult(string result)
        {
          
        }

        public void IosOnLogoutSuccess(string str)
        {
           
        }

        public void IosPayResult(string result)
        {
           
        }

        public void IosExitResult(string result)
        {
          
        }

        int mEscapeFrameCount = 0;
        void Update()
        {
            NetInterface.Update();

            mGameTimerManager.Execute();
          

            if (Input.GetKey(KeyCode.Escape))
            {
                //EventDispatcher.Instance.Dispatch(EventConstant.QUIT_TIP);
                //SDKManager.Instance.OnQuit();
                if (Time.frameCount - mEscapeFrameCount > 30)
                {
                    mEscapeFrameCount = Time.frameCount;
                  
                }
            }

            if (Application.isEditor && Input.GetKey(KeyCode.P))
            {
               
            }
        }

        void LateUpdate()
        {
         
        }
        void FixedUpdate()
        {
          
        }
        void OnDestory()
        {
            print("main Destory Call");
        }

        void OnDisable()
        {
            print("main Disable Call");

           
            NetInterface.CloseConnect();
        }

        void RegisterController()
        {
          
        }
    }
}