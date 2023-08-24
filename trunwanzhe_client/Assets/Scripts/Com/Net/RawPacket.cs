using System;
using System.IO;
using Assets.Scripts.Com.Game.ObjectPool;
using Assets.Scripts.Com.Game.Utils;
using UnityEngine;
using ProtoBuf;
using Com.Net.Lua;
using System.Text;

namespace Assets.Scripts.Com.Net.Protos.Proto
{
    public class RawPacket : IPool
    {
        private RecycleMS msg;
        private IExtensible data;

        public int mAskUniqueID { get; private set; }
        private ushort mCMDID;
        public int mIsBack;
        private LuaRawPacket mLuaRawPacket;

        public static RawPacket CreateInstance()
        {
            //lock (ObjectPoolManager.sRawPacketPool)
            //{
            //    return ObjectPoolManager.sRawPacketPool.Get();
            //}

            return new RawPacket();
        }

        public void Release()
        {
            if (msg != null)
            {
                msg.Release();
                msg = null;
            }

            mAskUniqueID = 0;

            //lock (ObjectPoolManager.sRawPacketPool)
            //{
            //    ObjectPoolManager.sRawPacketPool.Put(this);
            //}
        }

        public void InitLuaRawPacket(LuaRawPacket luaRawPacket)
        {
            mLuaRawPacket = luaRawPacket;
            this.mCMDID = mLuaRawPacket.mCMDID;
        }

        public RawPacket Init(int cmdID, IExtensible data, int isBack = 0)
        {
            this.mCMDID = (ushort)cmdID;
            this.data = data;
            this.mIsBack = isBack;

            return this;
        }

        public int GetMsgID()
        {
            return this.mCMDID;
        }

        public bool IsHeartPacket()
        {
            return mCMDID == MsgManager.cHeartPackageID;
        }

        public byte[] PackProtobuf(proto_util protoUtil)
        {
            if (msg == null)
            {
                msg = RecycleMS.CreateInstance();

                if (data != null)
                {
                    ProtoBuf.Serializer.NonGeneric.Serialize(msg, data);
                }

                if (mLuaRawPacket != null && mLuaRawPacket.byteString!= null)
                {
                    var stringBytes = mLuaRawPacket.byteString;// System.Text.Encoding.UTF8.GetBytes(mLuaRawPacket.byteString);
                    msg.Write(stringBytes, 0, stringBytes.Length);
                }
            }

            mAskUniqueID = protoUtil.AskUniqueID();
            //Debug.LogError("mAskUniqueID:" + mAskUniqueID);

            ushort packageLen = Convert.ToUInt16(NetConstant.cPackageHeadSize + msg.Length);
            byte[] bytes = msg.ToArray();

            RecycleMS packageCrc = RecycleMS.CreateInstance();
            proto_util.writeInt(packageCrc, mAskUniqueID);
            proto_util.EncryptPackage(packageCrc, bytes);
            byte[] crcBytes = packageCrc.ToArray();
            packageCrc.Release();

            RecycleMS package = RecycleMS.CreateInstance();
            package.SetLength(packageLen);

            proto_util.writeUShort(package, packageLen);
            proto_util.writeUShort(package, this.mCMDID);

            proto_util.writeInt(package, CRC16Util.ConCRC(crcBytes, crcBytes.Length));
            proto_util.writeInt(package, mAskUniqueID);

            proto_util.EncryptPackage(package, bytes);

            byte[] packBytes = package.ToArray();
            package.Release();//package在后面的代码不再使用，则释放

            if (DebugControl.debugOnFrequent)
            {
                Debug.Log(string.Format("[NET] SEND>>>>>>>>{0}  mAskUniqueID:{1},time:{2}", C2S.descList[mCMDID], mAskUniqueID, DateTime.Now.ToString("mm:ss:ffff")));
            }

            return packBytes;
        }
    }
}
