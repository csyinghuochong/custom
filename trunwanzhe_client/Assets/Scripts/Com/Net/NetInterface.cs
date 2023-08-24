using Assets.Scripts.Com.Game.Utils;
using Assets.Scripts.Com.Net.Protos.Proto;
using System;
using System.IO;
using System.Text;
using UnityEngine;
using System.Collections.Generic;
using Com.Net.Lua;

namespace Assets.Scripts.Com.Net
{
    public enum LoginType
    {
        LOGIN,
        RELOGIN,
    }

    //供上层使用
    public static class NetInterface
    {
        private static NetSocket sNetSocket = new NetSocket(new NetSocketParam());

        public static LoginType sLoginType = LoginType.LOGIN;

        public static string mIP;
        public static int mPort;

        public static void InitLuaSocketParam(LuaNetSocketParam luaSocketParam)
        {
            sNetSocket.mNetSocketParam.mLuaNetSocketParam = luaSocketParam;
        }

        public static void SendDataFromLua(LuaRawPacket rawPacket)
        {
            var data = new RawPacket();
            data.InitLuaRawPacket(rawPacket);
            SendData(data);
        }

        public static void InitIPAndPort(string ip, int port)
        {
            mIP = ip;
            mPort = port;

            sNetSocket.InitIPAndPort(ip, port);
        }

        public static void CloseConnect()
        {
            sNetSocket.Close();
        }

        public static void SetConnectInitParam(int baseValue, int addValue)
        {
            sNetSocket.SetConnectInitParam(baseValue, addValue);
        }

        public static void SendData(RawPacket rawPacket)
        {
            sNetSocket.Send(rawPacket);
        }

        public static void SetRawPacketPackAction(Action<int> action)
        {
            MsgManager.sPackAction += action;
        }

        public static void SetRawPacketUnpackAction(Action<int> action)
        {
            MsgManager.sUnpackAction += action;
        }

        public static void Update()
        {
            sNetSocket.Update();
        }

        public static bool Connected()
        {
            return sNetSocket.Connected();
        }

        public static void ReconnectManual()
        {
            sNetSocket.ReconnectManual();
        }

        public static void AddPBNetCMDData(IPBNetCMDData cmdData)
        {
            sNetSocket.mNetMsgManager.AddNetCMDData(cmdData);
        }

        public static void TraceNet()
        {
            sNetSocket.TraceNet();
        }

        public static void SendTimeout()
        {
            sNetSocket.SetConnectStatus(NetStatus.sendTimeout, "心跳包超时", true);
        }
    }
}
