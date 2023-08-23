using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System;
using Assets.Scripts.Com.Game.Manager.AssetBundle;
using Assets.Scripts.Com.Game.Utils;
using Assets.Plugins.Assets.Scripts.Com.Game.Manager;

public class AssetBundleManager : MonoBehaviour
{
    private int mMaxLoaderNum = 20;
    List<AssetBundleLoader> mAssetBundleLoaderList = new List<AssetBundleLoader>();
    LinkedList<LoadRequest> mWaitLoadRequestList = new LinkedList<LoadRequest>();
    LinkedList<LoadRequest> mParallelList = new LinkedList<LoadRequest>();
    LinkedList<LoadRequest> mSerialList = new LinkedList<LoadRequest>();
    static Dictionary<string, LoadRequest> mLoadRequestList = new Dictionary<string, LoadRequest>();

    private bool mLockSerial;

    public void WWW(string url, Action<string> callBack)
    {
        StartCoroutine(DoWWW(url, callBack));
    }

    private IEnumerator DoWWW(string url, Action<string> callBack)
    {
        WWW getData = new WWW(url);
        yield return getData;

        if (getData.error != null)
        {
            Debug.Log("DoWWW error:" + getData.error);
            callBack("");
        }
        else
        {
            Debug.Log("DoWWW getData.text:" + getData.text);

            callBack(getData.text);
        }
    }

    private AssetLoadInfo mAssetLoadInfo;
    public void SetAssetLoadInfo(AssetLoadInfo assetLoadInfo)
    {
        mAssetLoadInfo = assetLoadInfo;
    }

    public int GetLoadingLoaderCount()
    {
        int count = 0;

        for (int i = 0; i < mMaxLoaderNum; ++i)
        {
            AssetBundleLoader loader = mAssetBundleLoaderList[i];

            if (loader.state != DownLoadState.Wait)
            {
                count++;
            }
        }
        return count;
    }

    void Awake()
    {
        for (int i = 0; i < mMaxLoaderNum; ++i)
        {
            mAssetBundleLoaderList.Add(gameObject.AddComponent<AssetBundleLoader>());
        }
    }

    public void DumpRequestListInfo()
    {
        foreach (KeyValuePair<string, LoadRequest> kvp in mLoadRequestList)
        {
            Debug.LogError("DumpRequestListInfo:" + kvp.Key);
        }
    }

    public void ReleaseLoadRequests()
    {
        List<LoadRequest> list = new List<LoadRequest>();

        foreach (KeyValuePair<string, LoadRequest> kvp in mLoadRequestList)
        {
            LoadRequest loadRequest = kvp.Value;
            list.Add(loadRequest);
        }

        for (int i = 0, count = list.Count; i < count; i++)
        {
            UnloadLoadRequest(list[i]);
        }
    }

    private void UnloadLoadRequest(LoadRequest loadRequest, bool forceUnload = false)
    {
        if (loadRequest != null && (loadRequest.mRequestState == RequestState.Complete || loadRequest.mRequestState == RequestState.Fail))
        {
            if (forceUnload || loadRequest.mAssetNameIsNull == false)
            {
                loadRequest.Unload();
                mLoadRequestList.Remove(loadRequest.path);
            }
        }
    }

    public void Unload(string path)
    {
        LoadRequest loadRequest;
        if (mLoadRequestList.TryGetValue(path, out loadRequest))
        {
            UnloadLoadRequest(loadRequest, true);
        }
    }

    //并行预加载
    public void Preload(string path, Action callBack, bool unLoad)
    {
        RequestInfo requestInfo = new RequestInfo(path, "", callBack, unLoad);

        InitLoadRequestInfo(requestInfo, false);
    }

    //串行预加载
    public void PreloadBySerial(string path, Action callBack, bool unLoad)
    {
        RequestInfo requestInfo = new RequestInfo(path, "", callBack, unLoad);

        InitLoadRequestInfo(requestInfo, true);
    }

    public void LoadScene(string path, Action callBack, bool unLoad)
    {
        RequestInfo requestInfo = new RequestInfo(path, "", callBack, unLoad);

        InitLoadRequestInfo(requestInfo, true);
    }

    //串行加载
    public IRequestInfo LoadAssetBySerial<T>(string path, string assetName, Action<T> callBack, bool unLoad, AssetsType assetsType = AssetsType.assetBundle)
    {
        RequestInfo<T> requestInfo = new RequestInfo<T>(path, assetName, callBack, unLoad, assetsType);

        InitLoadRequestInfo(requestInfo, true);

        return requestInfo;
    }

    //并行加载
    public IRequestInfo LoadAsset<T>(string path, string assetName, Action<T> callBack, bool unLoad, AssetsType assetsType = AssetsType.assetBundle)
    {
        RequestInfo<T> requestInfo = new RequestInfo<T>(path, assetName, callBack, unLoad, assetsType);

        InitLoadRequestInfo(requestInfo, false);

        return requestInfo;
    }

    private void InitLoadRequestInfo(IRequestInfo info, bool isSerial)
    {
        string path = info.GetAssetPath();
        LoadRequest loadRequest;

        if (!mLoadRequestList.TryGetValue(path, out loadRequest))
        {
            loadRequest = new LoadRequest(path);
            mLoadRequestList[path] = loadRequest;
            loadRequest.isSerial = isSerial;
        }

        if (loadRequest.isSerial != isSerial && loadRequest.mRequestState == RequestState.Deal)
        {
            Debug.LogError(string.Format("path:{0} isSerial not match ", path));
        }

        if (DebugControl.debugOnFrequent && info.IsUnLoad() == false)
        {
            Debug.Log("[LOAD]" + info.ToString());
        }

        loadRequest.AddRequestInfo(info);

        LoadRequestHandler(loadRequest);
    }

    private void LoadRequestHandler(LoadRequest loadRequest)
    {
        switch (loadRequest.mRequestState)
        {
            case RequestState.Wait:
                if (!mWaitLoadRequestList.Contains(loadRequest))
                {
                    mWaitLoadRequestList.AddFirst(loadRequest);
                }

                if (mAssetLoadInfo != null)
                {
                    mAssetLoadInfo.AddWait(loadRequest.mID);
                }

                CheckLoad();
                break;
            case RequestState.Fail:
            case RequestState.Complete:
                if (mAssetLoadInfo != null)
                {
                    mAssetLoadInfo.AddLoaded(loadRequest.mID);
                }

                if (loadRequest.isSerial)
                {
                    if (!mSerialList.Contains(loadRequest))
                    {
                        mSerialList.AddFirst(loadRequest);
                    }

                    DealSerialList();
                }
                else
                {
                    if (mParallelList.Contains(loadRequest))
                    {
                        mParallelList.Remove(loadRequest);
                    }

                    if (loadRequest.OnComplete())
                    {
                        mLoadRequestList.Remove(loadRequest.path);
                    }
                }

                CheckLoad();
                break;
        }
    }

    private void DealSerialList()
    {
        if (mLockSerial)
            return;

        mLockSerial = true;

        LinkedListNode<LoadRequest> node = mSerialList.Last;

        while (node != null)
        {
            LinkedListNode<LoadRequest> prveNode = node.Previous;

            LoadRequest request = node.Value;

            if (request.mRequestState == RequestState.Complete || request.mRequestState == RequestState.Fail)
            {
                mSerialList.Remove(node);

                if (request.OnComplete())
                {
                    mLoadRequestList.Remove(request.path);
                }
            }
            else
            {
                break;
            }

            node = prveNode;

            //lock的时候会导致第一个node索引不了新加的node，需要再遍历
            if (node == null)
            {
                node = mSerialList.Last;
            }
        }

        mLockSerial = false;
    }

    private void CheckLoad()
    {
        if (mWaitLoadRequestList.Count <= 0)
            return;

        DealLoadRequest();
    }

    private void DealLoadRequest()
    {
        LinkedListNode<LoadRequest> node = mWaitLoadRequestList.Last;

        while (node != null)
        {
            LinkedListNode<LoadRequest> prveNode = node.Previous;
            LoadRequest loadRequest = node.Value;

            if (loadRequest.mRequestState == RequestState.Wait)
            {
                AssetBundleLoader loader = GetFreeLoader();

                if (loader != null)
                {
                    loadRequest.ChangeState(RequestState.Deal);
                    mWaitLoadRequestList.Remove(node);

                    if (loadRequest.isSerial)
                    {
                        mSerialList.AddFirst(loadRequest);
                    }
                    else
                    {
                        mParallelList.AddFirst(loadRequest);
                    }

                    loader.SetStateLoading();
                    StartCoroutine(LoadingRequest(loader, loadRequest));
                }
                else
                {
                    break;
                }
            }

            node = prveNode;
        }
    }

    private IEnumerator LoadingRequest(AssetBundleLoader assetBundleLoader, LoadRequest loadRequest)
    {
        yield return StartCoroutine(assetBundleLoader.Load(loadRequest.path, loadRequest));

        if (assetBundleLoader.state != DownLoadState.Complete)
        {
            Debug.LogError("[LOAD]载入失败 path:" + assetBundleLoader.assetPath);

            loadRequest.ChangeState(RequestState.Fail);
        }
        else
        {
            if (DebugControl.debugOnMobile)
            {
                Debug.Log("[LOAD]载入成功 path:" + assetBundleLoader.assetPath);
            }

            loadRequest.ChangeState(RequestState.Complete);
        }

        assetBundleLoader.SetStateWait();
        LoadRequestHandler(loadRequest);
    }

    private AssetBundleLoader GetFreeLoader()
    {
        for (int i = 0; i < mMaxLoaderNum; ++i)
        {
            AssetBundleLoader loader = mAssetBundleLoaderList[i];

            if (loader.state == DownLoadState.Wait)
            {
                return loader;
            }
        }
        return null;
    }

}
