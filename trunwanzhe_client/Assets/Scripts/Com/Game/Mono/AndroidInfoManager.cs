using System;
using System.Collections.Generic;
using UnityEngine;
using Assets.Scripts.Com.Game.Events;
using Assets.Plugins.Assets.Scripts.Com.Game.Utils;
using Assets.Scripts.Com.Game.Manager;

namespace Assets.Scripts.Com.Game.Mono
{
    class AndroidInfoManager : MonoBehaviour
    {
        private int BYTES_2_MB = 1024 * 1024;

        private EventDispatcher mEventDispatcher = EventDispatcher.Instance;

        void Start()
        {
            //SetNetworkInfo(activity.Call<string>("GetNetworkType"));

            //Debug.LogError("GetPhoneModel:" + activity.Call<string>("GetPhoneModel"));
            //Debug.LogError("GetOsVersion:" + activity.Call<string>("GetOsVersion"));
            //Debug.LogError("GetCpuName:" + activity.Call<string>("GetCpuName"));
            //Debug.LogError("GetCpuUsage:" + activity.Call<int>("GetCpuUsage"));
            //Debug.LogError("GetCpuCoreNum:" + activity.Call<int>("GetCpuCoreNum"));
            //Debug.LogError("GetCurCpuFreq:" + activity.Call<int>("GetCurCpuFreq"));
            //Debug.LogError("GetMinCpuFreq:" + activity.Call<int>("GetMinCpuFreq"));
            //Debug.LogError("GetMaxCpuFreq:" + activity.Call<int>("GetMaxCpuFreq"));
            //Debug.LogError("GetAvailMemory:" + activity.Call<long>("GetAvailMemory"));
            //Debug.LogError("GetTotalMemory:" + activity.Call<long>("GetTotalMemory"));

            mEventDispatcher.AddEventListener(EventConstant.SEND_MOBILE_INFO, SendMobileInfo);
            mEventDispatcher.AddEventListener<bool>(EventConstant.SHOW_IME, OnShowIME);
            mEventDispatcher.AddEventListener<bool>(EventConstant.SHOW_FULLSCREEN, OnShowFullScreen);
            mEventDispatcher.AddEventListener(EventConstant.VOICE_CHAT_START, OnVoiceChatStart);
            mEventDispatcher.AddEventListener<int>(EventConstant.VOICE_CHAT_STOP, OnVoiceChatStop);
            mEventDispatcher.AddEventListener<uint[], string>(EventConstant.VOICE_LOGIN, OnVoiceLogin);
            mEventDispatcher.AddEventListener(EventConstant.VOICE_LOGOUT, OnVoiceLogout);
            mEventDispatcher.AddEventListener<string>(EventConstant.VOICE_MSG_PLAY, OnVoiceMsgPlay);
        }

        public void VoiceLoginSuccess(String value)
        {
            Debug.Log("OnVoiceLoginSuccess");

            mEventDispatcher.Dispatch(EventConstant.VOICE_LOGIN_SUCCESS);
        }

        public void VoiceLoginFail(String value)
        {
            Debug.Log("VoiceLoginFail");
        }

        public void VoiceMsgNotify(string value)
        {
            mEventDispatcher.Dispatch<string>(EventConstant.VOICE_MSG_NOTIFY, value);
        }

        public void VoicePlayCompletion(string value)
        {
            mEventDispatcher.Dispatch(EventConstant.VOICE_PLAY_COMPLETION);
        }

        private void OnVoiceLogin(uint[] values, string roomID)
        {
            AndroidJavaClassUtil.Call("voiceLogin", new object[] { roomID, (int)values[0], (int)values[1], (int)values[2], (int)values[3] });
        }

        private void OnVoiceLogout()
        {
            AndroidJavaClassUtil.Call("voiceLogout");
        }

        private void OnVoiceChatStart()
        {
            AndroidJavaClassUtil.Call("voiceRecordStart");
        }

        private void OnVoiceChatStop(int type)
        {
            AndroidJavaClassUtil.Call("voiceRecordStop", new object[] { type });
        }

        private void OnVoiceMsgPlay(string str)
        {
            AndroidJavaClassUtil.Call("voiceMsgPlay", new object[] { str });
        }

        private void OnShowIME(bool isShow)
        {
            if (isShow)
                AndroidJavaClassUtil.Call("ShowIME");
            else
                AndroidJavaClassUtil.Call("HideIME");
        }

        private void OnShowFullScreen(bool isShow)
        {
            //             if (isShow)
            //             {
            //                 activity.Call("SetFullScreen");
            //             }
            //             else
            //             {
            //                 activity.Call("CancelFullScreen");
            //             }
        }

        public void ImeKey(string key)
        {
            EventDispatcher.Instance.Dispatch<string>(EventConstant.IME_KEY, key);
        }

        public void ImeChange(string str)
        {
            EventDispatcher.Instance.Dispatch<string>(EventConstant.IME_CHANGE, str);
        }

        private void SendMobileInfo()
        {
            StartNotificationService();

            List<ushort> mobileInfo = new List<ushort>();

          
        }

        private void StartNotificationService()
        {
            //             string accountName = LoginModel.Instance.mAccount;
            //             string url = BuildPlatformURL.NOTIFICATION_URL;
            //             long delay = 1000L;
            //             long period = 30 * 60 * 1000L;
            //             AndroidJavaClassUtil.Call("writeNotificationParam", new object[] { accountName, url, delay, period });
        }

        private ushort ByteConvertToMB(long bytes)
        {
            return (ushort)(bytes / BYTES_2_MB);
        }

        public void NetworkChange(string str)
        {
            GetNetType(str);
        }

        public void CpuUsage(string usage)
        {
            Debug.LogError("cpuUsage:" + usage);
        }

        private ushort GetNetType(string str)
        {
            return (ushort)1;
        }

        public void OnLoginResult(string result)
        {
           
        }

        public void OnLogoutSuccess(string str)
        {
           
        }

        public void PayResult(string result)
        {
            
        }

        public void ExitResult(string result)
        {
            
        }
    }
}
