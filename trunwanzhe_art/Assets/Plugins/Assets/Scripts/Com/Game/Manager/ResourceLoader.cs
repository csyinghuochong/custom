using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Assets.Scripts.Com.Game.Core;
using UnityEngine;

namespace Assets.Plugins.Assets.Scripts.Com.Game.Manager
{
    public class ResourceLoader : Singleton<ResourceLoader>
    {
        GameManager mGameManager = GameManager.Instance;

        public void LoadAsset<T>(string path, string assetName, Action<T> callBack, bool unLoad = false)
        {
            mGameManager.mAssetBundleManager.LoadAssetBySerial<T>(path, assetName, callBack, unLoad);
        }
    }
}
