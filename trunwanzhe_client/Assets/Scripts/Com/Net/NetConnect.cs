using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using Assets.Scripts.Com.Game.Events;
using Assets.Scripts.Com.Game.Utils;
using Assets.Scripts.Com.Game.Utils.Timers;
using UnityEngine;
using System.Threading;

namespace Assets.Scripts.Com.Net
{
    class NetConnect : NetBase
    {
        public string mIP { get; private set; }
        public string mIPV6;
        public int mPort { get; private set; }
        public NetStatus mNetStatus { get; private set; }
        private string mNetStatusMsg;

        public TcpClient mTcpClient { get; private set; }
        public Socket mSocket { get; private set; }
        public NetworkStream mNetworkStream { get; private set; }

        private bool mHasConnectSuccess = false;
        private bool mCheckConnectCallBack = false;
        private bool mReconnectTimeout = false;
        private int mReconnectTipViewCount = 0;

        private GameTimer mConnectGameTimer;

        public override void TraceNet()
        {
            base.TraceNet();

            Debug.Log("[NetConnect] mNetStatus:" + mNetStatus + " mNetStatusMsg:" + mNetStatusMsg);

            if (mTcpClient != null)
            {
                Debug.Log(string.Format("[NetConnect] SendBufferSize:{0},ReceiveBufferSize:{1},NoDelay:{2},LingerState:{3},ExclusiveAddressUse:{4},Connected:{5},Available:{6}", mTcpClient.SendBufferSize, mTcpClient.ReceiveBufferSize, mTcpClient.NoDelay, mTcpClient.LingerState, mTcpClient.ExclusiveAddressUse, mTcpClient.Connected, mTcpClient.Available));
            }
        }

        public NetConnect(NetSocket netSocket)
            : base(netSocket)
        {
            if (mNetSocketParam.ShowTip())
                mConnectGameTimer = new GameTimer(2f, 2, OnConnectTimerHandler, OnConnectTimerComplete);
        }

        public override void Init()
        {
            mIP = "";
            mPort = 0;
            mNetStatus = NetStatus.disconnect;
            mTcpClient = null;
            mSocket = null;
            mHasConnectSuccess = false;
            mCheckConnectCallBack = false;
            mReconnectTimeout = false;
            mReconnectTipViewCount = 0;
        }

        private void OnConnectTimerHandler()
        {
            if (mCheckConnectCallBack)
                return;

            if (mConnectGameTimer.mCurrentCount >= mConnectGameTimer.mRepeatCount)
                return;

            StartThreadConnect();
        }

        private void OnConnectTimerComplete()
        {
            Debug.Log("---OnConnectTimerComplete");

            OpenReconnectTipView();
        }

        private void OpenReconnectTipView()
        {
            ConnectShowTip(false);

            if (Connected() == false)
            {
                Close();

                if (mHasConnectSuccess == false)
                {
                    InternalReconnectManual();
                  
                    return;
                }

               

            }
        }

        public void InitIPAndPort(string ip, int port)
        {
            mIP = ip;
            mPort = port;

            mHasConnectSuccess = false;

            SetConnectStatus(NetStatus.reconnect, "InitIPAndPort");
        }

        public override void Update()
        {
            CheckConnectCallBack();

            if (!Connected())
            {
                if (mNetStatus == NetStatus.reconnect || mNetStatus == NetStatus.sendTimeout)
                {
                    Debug.Log("mNetStatusMsg:" + mNetStatusMsg);

                    Reconnect();
                }
            }
        }

        public void Connect(string ip, int port)
        {
            Close();
            SetConnectStatus(NetStatus.linking, "Connect");
            ConnectShowTip(true);

            AddressFamily addressFamily = AddressFamily.InterNetwork;

            if (Application.platform == RuntimePlatform.IPhonePlayer)
            {
                string IPv6 = IOSUtil.GetIPv6(ip);
                string[] ipList = IPv6.Split('&');

                mIPV6 = ipList[0];

                if (ipList[1] == "ipv6")
                {
                    addressFamily = AddressFamily.InterNetworkV6;
                }
            }

            mTcpClient = new TcpClient(addressFamily);
            mTcpClient.NoDelay = true;
            StartThreadConnect();
        }

        private void StartThreadConnect()
        {
            mConnectThread = new Thread(ThreadConnect);
            mConnectThread.Start();
        }

        Thread mConnectThread;
        private void ThreadConnect()
        {
            string ip = string.IsNullOrEmpty(mIPV6) ? mIP : mIPV6;
            int port = mPort;

            mConnectThread = null;

            try
            {
                Debug.Log(string.Format("ID:{3} 开始连接服务器 mIP:{0},ip:{1},port:{2}", mIP, ip, port, mNetSocketParam.mID));

                mTcpClient.Connect(ip, port);
                mSocket = mTcpClient.Client;
                mNetworkStream = mTcpClient.GetStream();
            }
            catch (Exception ex)
            {
                Debug.Log("ID:" + mNetSocketParam.mID + " ThreadConnect Error:" + ex.Message);
                return;
            }

            mHasConnectSuccess = true;
            mCheckConnectCallBack = true;
        }

        private void CheckConnectCallBack()
        {
            if (mCheckConnectCallBack == false)
                return;

            mCheckConnectCallBack = false;

            if (mTcpClient == null)
                return;

            if (mTcpClient.Connected)
            {
                Debug.Log("网络连接成功");

                SetConnectStatus(NetStatus.success, "CheckConnectCallBack");
                ConnectSuccessInit();
                ConnectShowTip(mNetStatus != NetStatus.success && !mReconnectTimeout);
            }
            else
            {
                Debug.Log("网络连接失败");

                SetConnectStatus(NetStatus.disconnect, "CheckConnectCallBack");
                ConnectShowTip(mNetStatus != NetStatus.success && !mReconnectTimeout);
            }
        }

        private void ConnectSuccessInit()
        {
            mReconnectTipViewCount = 0;
            mNetSocket.ConnectSuccessInit();
            EventDispatcher.Instance.Dispatch(EventConstant.NET_CONNECT_SUCCESS);
        }

        public void ConnectShowTip(bool value)
        {
            Debug.Log("ConnectShowTip:" + value);

            EventDispatcher.Instance.Dispatch(EventConstant.SHOW_REQUEST_LOADING, value);

            SetGameTimer(mConnectGameTimer, value);
        }

        public void SetGameTimer(GameTimer timer, bool run)
        {
            if (timer == null)
                return;

            if (run)
            {
                if (timer.mRunning == false)
                    timer.ReStart();
            }
            else
            {
                timer.Stop();
            }
        }

        public void ReconnectManual()
        {
            InternalReconnectManual();

            SetConnectStatus(NetStatus.reconnect, "ReconnectManual");
        }

        private void InternalReconnectManual()
        {
            mReconnectTimeout = false;
            SetConnectStatus(NetStatus.disconnect, "InternalReconnectManual");
        }

        private void Reconnect()
        {
            //已经连接和正在连接的情况下不允许重新连接
            if (Connected() || mNetStatus == NetStatus.linking)
                return;

            //重连超时也不允许连接
            if (mReconnectTimeout)
                return;

            Connect(mIP, mPort);
        }

        public override void Close()
        {
            mCheckConnectCallBack = false;

            try
            {
                if (mTcpClient != null)
                {
                    Debug.Log("#ID:" + mNetSocketParam.mID + "---NetConnect Close");
                    SetConnectStatus(NetStatus.disconnect, "CloseClient");
                    mTcpClient.Close();
                    mTcpClient = null;
                    mSocket = null;
                    mNetworkStream = null;

                    mNetSocket.mNetReceive.Close();
                    mNetSocket.mNetSend.Close();

                    EventDispatcher.Instance.Dispatch(EventConstant.NET_DISCONNECT);
                }
            }
            catch (System.Exception ex)
            {
                Debug.Log(ex.Message);
            }
        }

        public bool Connected()
        {
            return mNetStatus == NetStatus.success;
        }

        public void SetConnectStatus(NetStatus status, string msg = "", bool showError = false)
        {
            if (showError && mIsEditor)
            {
                if (string.IsNullOrEmpty(msg))
                {
                    Debug.LogError("【NetConnect】prevStatus:" + mNetStatus + " changeStatus:" + status);
                }
                else
                {
                    Debug.LogError("【NetConnect】prevStatus:" + mNetStatus + " changeStatus:" + status + " msg:" + msg);
                }
            }
            else
            {
                if (string.IsNullOrEmpty(msg))
                {
                    Debug.Log("【NetConnect】prevStatus:" + mNetStatus + " changeStatus:" + status);
                }
                else
                {
                    Debug.Log("【NetConnect】prevStatus:" + mNetStatus + " changeStatus:" + status + " msg:" + msg);
                }
            }


            mNetStatus = status;
            mNetStatusMsg = msg;
        }
    }
}
