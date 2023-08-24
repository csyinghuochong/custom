using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Assets.Plugins.Assets.Scripts.Com.Game.Manager;
using Assets.Scripts.Com.Game.Core;
using UnityEngine;
using Assets.Scripts.Com.Game.Utils;
using System.IO;

namespace Assets.Plugins.Assets.Scripts.Com.Game.Platform
{
    public class PlatformManager : Singleton<PlatformManager>
    {
        public const string PlatformConfigURL = "PlatformConfig/PlatformConfig.bytes";
        public PlatformConfigVo mRawPlatformConfigVo { get; private set; }
        public string mVersion { get; private set; }

        public void LoadPlatformConfig(Action callBack = null)
        {
            if (mRawPlatformConfigVo == null)
            {
                AssetBundle bundle = AssetBundle.LoadFromFile(string.Format("{0}/{1}", Application.streamingAssetsPath, PlatformConfigURL));

                DeserializeRawConfigXML((bundle.mainAsset as TextAsset).bytes);

                if (callBack != null)
                {
                    callBack();
                }
            }
            else
            {
                if (callBack != null)
                {
                    callBack();
                }
            }
        }

        public void DeserializeRawConfigXML(byte[] bytes)
        {
            SerializeUtils.DeserializeXml<PlatformConfigVo>(bytes, delegate(PlatformConfigVo vo)
            {
                mRawPlatformConfigVo = vo;
            });
        }

        public void DeserializeVersion(string version)
        {
            mVersion = version;
        }
    }
}
