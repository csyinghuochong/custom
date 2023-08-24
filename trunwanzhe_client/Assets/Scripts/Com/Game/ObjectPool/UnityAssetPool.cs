using Assets.Scripts.Com.Game.Globals;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using Assets.Scripts.Com.Game.Loader;
using Assets.Scripts.Com.Game.Utils;
using Assets.Scripts.Com.Game.Core;
using Assets.Scripts.Com.Game.Manager;

namespace Assets.Scripts.Com.Game.ObjectPool
{
    class UnityAssetPool : ITick
    {
        private ObjectPool<GameObject> mObjectPool;
        private string mResourceURL;
        private string mResourceName;

        private GameObject mRawGameObject;
        private List<Action<GameObject>> mCallBackList;

        private bool mDontDestoryAssetUnit;
        private bool mLoadExternal;

        private AssetLoader mAssetLoader;

        public UnityAssetPool(string resourceURL, string resourceName, bool unload = true, bool dontDestoryAssetUnit = false, bool external = true)
        {
            if (mObjectPool == null)
            {
                mObjectPool = new ObjectPool<GameObject>();

                mAssetLoader = AssetLoader.Instance;
            }

            mDontDestoryAssetUnit = dontDestoryAssetUnit;
            mLoadExternal = external;

            mResourceURL = resourceURL;
            mResourceName = resourceName;
        }

        public void AsyncGet(Action<GameObject> callBack)
        {
            if (callBack == null)
                return;

            GameObject go = mObjectPool.Get(false);

            //Debug.LogError("--------------AsyncGet:" + mResourceURL+"   go:" + go);

            if (go == null)
            {
                if (mRawGameObject == null)
                {
                    if (mCallBackList == null)
                    {
                        mCallBackList = new List<Action<GameObject>>();

                        Action<string, string, Action<GameObject>> loadAction = null;
                        if (mLoadExternal)
                        {
                            loadAction = mAssetLoader.AsyncLoadExternalGameObject;
                        }
                        else
                        {
                            loadAction = mAssetLoader.AsyncLoadUIGameObject;
                        }

                        loadAction(mResourceURL, mResourceName, delegate(GameObject obj)
                        {
                            if (mDontDestoryAssetUnit)
                            {
                                AssetLoader.Instance.DontDestoryAssetUnit(obj);
                            }

                            mRawGameObject = obj;
                            mRawGameObject.SetActive(false);

                          
                        });
                    }

                    mCallBackList.Add(callBack);
                }
                else
                {
                    mCallBackList.Add(callBack);
                  
                }
            }
            else
            {
                callBack(go);
            }
        }

        static int sLastInstantiateFrame;
        static int sInstantiateCount;
        const int mMaxCount = 5;
        public void OnTick()
        {
            if (sLastInstantiateFrame == Time.frameCount)
            {
                if (sInstantiateCount >= mMaxCount)
                    return;
            }
            else
            {
                sLastInstantiateFrame = Time.frameCount;
                sInstantiateCount = 0;
            }

            while (mCallBackList.Count > 0)
            {
                Action<GameObject> action = mCallBackList[0];
                mCallBackList.RemoveAt(0);
                Instantiate(action);

                if (++sInstantiateCount >= mMaxCount)
                    return;
            }

        
        }

        private void Instantiate(Action<GameObject> callBack)
        {
            GameObject go = GameObjectUtil.Instantiate(mRawGameObject) as GameObject;
            go.name = mResourceName;
            go.SetActive(true);

            if (Application.isEditor)
            {
                callBack(go);
            }
            else
            {
                try
                {
                    callBack(go);
                }
                catch (System.Exception ex)
                {
                    Debug.LogError("mResourceURL:" + mResourceURL);
                    Debug.LogError(ex.StackTrace);
                }
            }
        }

        public void Put(GameObject go)
        {
            mObjectPool.Put(go);
        }

        public void ClearPool()
        {
            mObjectPool.ClearPool();

            if (mRawGameObject != null)
            {
                GameObject.DestroyImmediate(mRawGameObject);
            }
        }

        public void Dispose()
        {
            ClearPool();
        }
    }
}
