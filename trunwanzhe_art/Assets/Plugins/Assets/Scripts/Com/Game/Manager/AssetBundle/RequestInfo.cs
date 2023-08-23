using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Assets.Scripts.Com.Game.Manager.AssetBundle
{
    public enum AssetsType
    {
        assetBundle,
        bytes,
        assetBundleAndBytes,
        bytesAndAssetBundle
    }

    public interface IRequestInfoUser
    {
        bool IsDestory();
    }

    public interface IRequestInfo
    {
        AssetsType GetAssetsType();
        string GetAssetName();
        string GetAssetPath();
        int GetCallBackHashCode();
        bool IsUnLoad();
        void DoCallBack(UnityEngine.Object obj);
        void DoCallBack(System.Object obj);
        void DoCallBack();
        string ToString();
        void SetUser(IRequestInfoUser user);
        bool UserIsDestory();
    }

    /// <summary>
    /// 不需要获取返回值，主要给场景使用
    /// </summary>
    public class RequestInfo : IRequestInfo
    {
        public string path;     //路径
        public string assetName;        //资源名称
        public bool unLoad;     //是否加载后卸载包
        public Action callback;     //回调函数
        public AssetsType assetsType;

        public RequestInfo(string path, string assetName, Action callback, bool unLoad, AssetsType assetsType = AssetsType.assetBundle)
        {
            this.path = path;
            this.assetName = assetName;
            this.callback = callback;
            this.unLoad = unLoad;
            this.assetsType = assetsType;
        }

        public void SetUser(IRequestInfoUser user)
        {

        }

        public bool UserIsDestory()
        {
            return false;
        }

        public AssetsType GetAssetsType()
        {
            return this.assetsType;
        }

        public string GetAssetName()
        {
            return assetName;
        }

        public string GetAssetPath()
        {
            return path;
        }

        public bool IsUnLoad()
        {
            return unLoad;
        }

        public int GetCallBackHashCode()
        {
            return this.callback.GetHashCode();
        }

        public void DoCallBack(UnityEngine.Object obj)
        {
            Debug.LogError("RequestInfo call DoCallBck(param)");
        }

        public void DoCallBack(System.Object obj)
        {
            Debug.LogError("RequestInfo call DoCallBck(param)");
        }

        public void DoCallBack()
        {
            this.callback();
        }

        public override string ToString()
        {
            string str = string.Format("path:{0},assetName:{1},unLoad:{2}", path, assetName, unLoad);

            return str;
        }
    }

    public class RequestInfo<T> : IRequestInfo
    {
        public string path;     //路径
        public string assetName;        //资源名称
        public bool unLoad;     //是否加载后卸载包
        public Action<T> callback;     //回调函数
        public AssetsType assetsType;

        private IRequestInfoUser user;

        public RequestInfo(string path, string assetName, Action<T> callback, bool unLoad, AssetsType assetsType)
        {
            this.path = path;
            this.assetName = assetName;
            this.callback = callback;
            this.unLoad = unLoad;
            this.assetsType = assetsType;
        }

        public void SetUser(IRequestInfoUser user)
        {
            this.user = user;
        }

        public bool UserIsDestory()
        {
            return user != null && user.IsDestory();
        }

        public AssetsType GetAssetsType()
        {
            return this.assetsType;
        }

        public string GetAssetName()
        {
            return assetName;
        }

        public string GetAssetPath()
        {
            return path;
        }

        public bool IsUnLoad()
        {
            return unLoad;
        }

        public int GetCallBackHashCode()
        {
            return this.callback.GetHashCode();
        }

        public void DoCallBack(UnityEngine.Object obj)
        {
            try
            {
                callback((T)Convert.ChangeType(obj, typeof(T)));
            }
            catch (System.Exception ex)
            {
                Debug.LogError(string.Format("path:{0},assetName:{1}", path, assetName));
                Debug.LogError(ex.StackTrace);
            }
        }

        public void DoCallBack(System.Object obj)
        {
            try
            {
                callback((T)Convert.ChangeType(obj, typeof(T)));
            }
            catch (System.Exception ex)
            {
                Debug.LogError(string.Format("path:{0},assetName:{1}", path, assetName));
                Debug.LogError(ex.StackTrace);
            }
        }

        public void DoCallBack()
        {
            Debug.LogError("RequestInfo<T> call DoCallBck()");
        }

        public override string ToString()
        {
            string str = string.Format("path:{0},assetName:{1},unLoad:{2}", path, assetName, unLoad);

            return str;
        }
    }
}
