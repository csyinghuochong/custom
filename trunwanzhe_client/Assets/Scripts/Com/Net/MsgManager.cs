using UnityEngine;
using System.Collections.Generic;
using System.IO;

using Assets.Scripts.Com.Net.Protos.Proto;
using Assets.Scripts.Com.Game.Utils;
using System;

namespace Assets.Scripts.Com.Net
{
    public class MsgManager
    {
        private Dictionary<int, IPBNetCMDData> sCmdList = new Dictionary<int, IPBNetCMDData>();

        public static Action<int> sWaitAction;
        public static Action<int> sPackAction;
        public static Action<int> sUnpackAction;

        public static void ClearAction()
        {
            sWaitAction = null;
            sPackAction = null;
            sUnpackAction = null;
        }

        public void AddNetCMDData(IPBNetCMDData cmdData)
        {
            if (cmdData.HasAction() && !sCmdList.ContainsKey(cmdData.GetKey()))
            {
                sCmdList[cmdData.GetKey()] = cmdData;
            }
            else
            {
                Debug.LogError(string.Format("AddNetCMDData key:{0} error", cmdData.GetKey()));
            }
        }

        public const int cHeartPackageID = 10001;
        public void Read(PreReadObject obj)
        {
            int key = obj.cmdID;
            IPBNetCMDData netCMDData = obj.netCMDData;
            if (netCMDData != null)
            {
                if (DebugControl.debugOnFrequent)
                {
                    Debug.Log("[NET] RECEIVE<<<<<<<<<" + S2C.descList[key] + " key:" + key + " time:" + DateTime.Now.ToString("mm:ss:ffff"));
                }

                //如果不是心跳包
                if (key != cHeartPackageID && sUnpackAction != null)
                    sUnpackAction(key);

              
            }
            else
            {
                Debug.LogError(string.Format("没有侦听cmdID为{0}的消息解析逻辑", key));
            }
        }

        public void PreRead(byte[] buff, ushort cmdID, PreReadObject obj)
        {
            int key = cmdID;
            IPBNetCMDData netCMDData = null;
            sCmdList.TryGetValue(key, out netCMDData);
            obj.cmdID = cmdID;
            if (netCMDData != null)
            {
                obj.netCMDData = netCMDData;
              
            }
        }
    }
}
