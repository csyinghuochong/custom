using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Assets.Scripts.Com.Game.Manager.AssetBundle
{
    public class LoadRequest
    {
        private static int sIndex = 0;

        public int mID { get; private set; }

        private Dictionary<int, IRequestInfo> mRequestInfoList;
        private LinkedList<IRequestInfo> mRequestInfoLinkedList;

        public string path { get; private set; }
        public RequestState mRequestState { get; private set; }
        private UnityEngine.AssetBundle mAssetBundle;
        private byte[] mBytes;
        private Dictionary<string, UnityEngine.Object> mAssetList;
        public bool isSerial;
        private AssetsType mAssetType;
        private bool isDoCompleteing = false;

        public bool mAssetNameIsNull { get; private set; }

        public void Unload()
        {
            if (mAssetBundle != null)
            {
                mAssetBundle.Unload(false);
            }
        }

        public LoadRequest(string path)
        {
            mID = ++sIndex;

            this.mRequestState = RequestState.Wait;
            this.path = path;
            mRequestInfoList = new Dictionary<int, IRequestInfo>();
            mRequestInfoLinkedList = new LinkedList<IRequestInfo>();
            mAssetList = new Dictionary<string, UnityEngine.Object>();
            mAssetNameIsNull = false;
        }

        public void AddRequestInfo(IRequestInfo requestInfo)
        {
            if (!mRequestInfoList.ContainsKey(requestInfo.GetCallBackHashCode()))
            {
                mRequestInfoList[requestInfo.GetCallBackHashCode()] = requestInfo;

                this.mRequestInfoLinkedList.AddLast(requestInfo);
            }

            mAssetType = requestInfo.GetAssetsType();
        }

        public void ChangeState(RequestState state)
        {
            this.mRequestState = state;
        }

        public bool LoadQuestComplete(AssetBundleLoader loader, WWW www)
        {
            switch (mAssetType)
            {
                case AssetsType.assetBundle:
                    mAssetBundle = www.assetBundle;
                    break;
                case AssetsType.bytes:
                    mBytes = www.bytes;
                    break;
                case AssetsType.assetBundleAndBytes:
                case AssetsType.bytesAndAssetBundle:
                    mAssetBundle = www.assetBundle;
                    mBytes = www.bytes;
                    break;
            }

            return mAssetBundle != null || mBytes != null;
        }

        public bool OnComplete()
        {
            if (isDoCompleteing)
                return false;

            isDoCompleteing = true;

            switch (mAssetType)
            {
                case AssetsType.assetBundle:
                    return OnCompleteByAssetBundle();
                case AssetsType.bytes:
                    return OnCompleteByBytes();
                case AssetsType.assetBundleAndBytes:
                    if (mAssetBundle != null)
                    {
                        return OnCompleteByAssetBundle();
                    }
                    else
                    {
                        return OnCompleteByBytes();
                    }
                case AssetsType.bytesAndAssetBundle:
                    if (mBytes != null)
                    {
                        return OnCompleteByBytes();
                    }
                    else
                    {
                        return OnCompleteByAssetBundle();
                    }
            }

            return true;
        }

        public bool OnCompleteByAssetBundle()
        {
            bool unLoad = false;

            for (LinkedListNode<IRequestInfo> node = mRequestInfoLinkedList.First; node != null; node = node.Next)
            {
                IRequestInfo info = node.Value;

                if (unLoad == false)
                    unLoad = info.IsUnLoad();

                string assetName = info.GetAssetName();

                if (string.IsNullOrEmpty(assetName))
                {
                    mAssetNameIsNull = true;

                    info.DoCallBack();
                }
                else
                {
                    if (mAssetBundle == null)
                    {
                        info.DoCallBack(null);
                    }
                    else
                    {
                        if (info.UserIsDestory() == false)
                        {
                            UnityEngine.Object obj;
                            if (!mAssetList.TryGetValue(assetName, out obj))
                            {
                                obj = mAssetBundle.LoadAsset(assetName);
                                mAssetList[assetName] = obj;
                            }

                            info.DoCallBack(obj);
                        }
                    }
                }
            }

            mRequestInfoList.Clear();
            mRequestInfoLinkedList.Clear();
            isDoCompleteing = false;

            if (unLoad)
            {
                if (mAssetBundle != null)
                {
                    mAssetBundle.Unload(false);
                    mAssetBundle = null;
                }

                mAssetList.Clear();

                return mBytes == null && true;
            }

            return false;
        }

        public bool OnCompleteByBytes()
        {
            bool unLoad = false;

            for (LinkedListNode<IRequestInfo> node = mRequestInfoLinkedList.First; node != null; node = node.Next)
            {
                IRequestInfo info = node.Value;

                if (unLoad == false)
                    unLoad = info.IsUnLoad();

                if (mBytes == null)
                {
                    info.DoCallBack(null);
                }
                else
                {
                    if (info.UserIsDestory() == false)
                    {
                        info.DoCallBack(mBytes);
                    }
                }
            }

            mRequestInfoList.Clear();
            mRequestInfoLinkedList.Clear();
            isDoCompleteing = false;

            if (unLoad)
            {
                mBytes = null;

                return mAssetBundle == null && true;
            }

            return false;
        }
    }
}
