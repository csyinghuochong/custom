using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Assets.Scripts.Com.Game.ObjectPool
{
    class UnityAssetPoolManager
    {
        private Dictionary<string, UnityAssetPool> mDicAsset = new Dictionary<string, UnityAssetPool>();

        public void LoadAsset(string path, string assetName, Action<GameObject> callBack, bool dontDestoryAssetUnit = false, bool external = true)
        {
            UnityAssetPool pool;

            if (!mDicAsset.TryGetValue(path, out pool))
            {
                pool = new UnityAssetPool(path, assetName, true, dontDestoryAssetUnit, external);

                mDicAsset[path] = pool;
            }

            pool.AsyncGet(callBack);
        }

        public void Put(string path, GameObject go)
        {
            //Debug.LogError(">>>>>>>>>>>>>>>>>>>>>Put:" + path);

            UnityAssetPool pool;

            if (mDicAsset.TryGetValue(path, out pool))
            {
                pool.Put(go);
            }
        }

        public void Clear()
        {
            foreach (KeyValuePair<string, UnityAssetPool> kvp in mDicAsset)
            {
                kvp.Value.Dispose();
            }

            mDicAsset.Clear();
        }
    }
}
