using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using UnityEngine;
using System.Threading;
using Assets.Scripts.Com.Net.Protos.Proto;
using System.IO;
using LuaInterface;

namespace Assets.Scripts.Com.Net
{
    public class PacketBytes
    {
        public int cmdID;
       
    }

    public class PreReadObject
    {
        public IPBNetCMDData netCMDData;
        public int cmdID;
        public object dataObj;

        public void Clear()
        {
            netCMDData = null;
            dataObj = null;
           
        }
    }

    public class NetReceive : NetBase
    {
        private ushort mPackageLen = 0;
        private ushort mCMDID = 0;
        private int mReadPackageLen = 0;
        private byte[] mHeadBuff;
        private byte[] mBodyBuff;
        private Thread mThread;
        private List<PreReadObject> mPreReadObjList;
        private List<PacketBytes> mPreReadPacketBytes;
        private Stack<PreReadObject> mPreReadObjCache;
        private bool mThreadRunning;

        private List<PacketBytes> buffList;
     
        public override void TraceNet()
        {
            base.TraceNet();

            Socket socket = InternalSocket();

            if (socket != null)
            {
                Debug.Log(GetStatusDesc());

                //Debug.Log("SelectWrite:" + socket.Poll(1000000, SelectMode.SelectWrite));
                Debug.Log("SelectRead:" + socket.Poll(100000, SelectMode.SelectRead));
                //Debug.Log("SelectError:" + socket.Poll(1000000, SelectMode.SelectError));
            }
        }

        public string GetStatusDesc()
        {
            return "";
        }

        public NetReceive(NetSocket netSocket)
            : base(netSocket)
        {
            mHeadBuff = new byte[NetConstant.cPackageCMDLenSize];
            mPreReadObjList = new List<PreReadObject>();
            mPreReadObjCache = new Stack<PreReadObject>();
            mPreReadPacketBytes = new List<PacketBytes>();
        }

        public override void Init()
        {

        }

        public override void Close()
        {
            base.Close();

            if (mThread != null)
            {
                mThreadRunning = false;
                //mThread.Abort();
                mThread = null;
            }
        }

        public void ConnectSuccessInit()
        {
            mPreReadObjList.Clear();
            mPackageLen = 0;
            mCMDID = 0;
            mReadPackageLen = 0;

            if (mThread == null)
            {
                mThreadRunning = true;
                mThread = new Thread(ThreadRunReceiveData);
                mThread.Start();
            }

        }

        void ThreadRunReceiveData()
        {
            while (mThreadRunning)
            {
                ThreadReceiveData();
                Thread.Sleep(1);
            }
        }

        void ThreadReceiveData()
        {
            NetworkStream stream = InternalNetworkStream();
            if (stream != null && stream.CanRead && stream.DataAvailable)
            {
                try
                {
                    if (mPackageLen == 0)
                    {
                        int readSize = stream.Read(mHeadBuff, mReadPackageLen, NetConstant.cPackageCMDLenSize - mReadPackageLen);
                        if (readSize <= 0)
                            return;

                        mReadPackageLen += readSize;
                        if (mReadPackageLen >= NetConstant.cPackageCMDLenSize)
                        {
                            mProtoUtil.GetHeadData(mHeadBuff, out mCMDID, out mPackageLen);
                            mBodyBuff = new byte[mPackageLen];

                            if (mPackageLen == 0)
                            {
                                Unpack(mBodyBuff, mCMDID);
                                mBodyBuff = null;
                                mReadPackageLen = 0;
                            }
                            else
                            {
                                mReadPackageLen = 0;
                            }
                        }

                    }
                    else
                    {
                        int readSize = stream.Read(mBodyBuff, mReadPackageLen, mPackageLen - mReadPackageLen);
                        if (readSize <= 0)
                            return;

                        mReadPackageLen += readSize;
                        if (mReadPackageLen >= mPackageLen)
                        {
                            Unpack(mBodyBuff, mCMDID);
                            mBodyBuff = null;
                            mReadPackageLen = 0;
                            mPackageLen = 0;
                        }
                    }
                }
                catch (IOException exception)
                {
                    InternalSetConnectStatus(NetStatus.reconnect, "ThreadReceiveData ID:" + mNetSocketParam.mID + " msg:" + exception.Message, true);
                }
                catch (Exception exception2)
                {
                    Debug.LogError("ThreadReceiveData:" + exception2.StackTrace);
                }
            }
        }

        List<PreReadObject> mMainThreadReadObjList = new List<PreReadObject>();
        void ReceiveData()
        {
            if (mPreReadObjList.Count > 0)
            {
                lock (mPreReadObjList)
                {
                    mMainThreadReadObjList.Clear();
                    mMainThreadReadObjList.AddRange(mPreReadObjList);
                    mPreReadObjList.Clear();
                }

                for (int i = 0, count = mMainThreadReadObjList.Count; i < count; i++)
                {
                    PreReadObject obj = mMainThreadReadObjList[i];

                    mNetMsgManager.Read(obj);
                    mNetSocketParam.MsgReceiveComplete(obj.cmdID);

                    //obj.Clear();
                    //mPreReadObjCache.Push(obj);
                }
            }

            if (buffList == null)
            {
              
            }

            if (mPreReadPacketBytes.Count > 0)
            {
                lock (mPreReadPacketBytes)
                {
                    buffList.Clear();
                    buffList.AddRange(mPreReadPacketBytes);

                    mPreReadPacketBytes.Clear();
                }

                //调用lua
                
            }

        }

        public override void Update()
        {
            if (InternalConnected())
            {
                if (mIsEditor)
                {
                    ReceiveData();
                }
                else
                {
                    try
                    {
                        ReceiveData();
                    }
                    catch (Exception ex)
                    {
                        Debug.LogError("Receive err:" + ex.StackTrace);
                    }
                }
            }
        }

        public static bool CheckLuaReceive(ushort cmdID)
        {
            if (cmdID >= 29000 && cmdID < 30000)
                return true;
            else if (cmdID >= 26005 && cmdID < 27000)
                return true;
            else if (cmdID == 8002 || cmdID == 9024)
                return true;

            return false;
        }

        public int mReceiveIndex { get; private set; }
        void Unpack(byte[] buff, ushort cmdID)
        {
            mReceiveIndex++;

            //活动
            if (CheckLuaReceive(cmdID))
            {
                PacketBytes packetBytes = new PacketBytes();
                packetBytes.cmdID = cmdID;
              
                lock (mPreReadPacketBytes)
                {
                    mPreReadPacketBytes.Add(packetBytes);
                }
                return;
            }



            PreReadObject obj = null;

            obj = new PreReadObject();
            //if (mPreReadObjCache.Count > 0)
            //{
            //    obj = mPreReadObjCache.Pop();
            //}
            //else
            //{
            //    obj = new PreReadObject();
            //}

            mNetMsgManager.PreRead(buff, cmdID, obj);
            lock (mPreReadObjList)
            {
                mPreReadObjList.Add(obj);
            }
        }
    }
}
