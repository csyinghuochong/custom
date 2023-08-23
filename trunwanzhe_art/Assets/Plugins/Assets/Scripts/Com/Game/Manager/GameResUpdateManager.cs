using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using Assets.Plugins.Assets.Scripts.Com.Game.MD5;
using Assets.Plugins.Assets.Scripts.Com.Game.Platform;
using Assets.Scripts.Com.Game.Core;
using Assets.Scripts.Com.Game.Utils;
using UnityEngine;
using Assets.Plugins.Assets.Scripts.Com.Game.View;
using System.Collections;
using Assets.Scripts.Com.Net;

namespace Assets.Plugins.Assets.Scripts.Com.Game.Manager
{
    public class DownLoadParam
    {
        public string url;
        public Action<WWW> mSuccessAction;
        public Action mFailAction;
        public bool dispose;
    }

    public class GameResUpdateManager : MonoBehaviour
    {
        public const string cRemoteVersionUrl = "Version/Version.bytes";

        string mOriginalAssetNumStr;
        int mOriginalAssetNum;
        int mOriginalAssetIndex;
        string mOriginalAssetVersion;
        public string mRemoteVersion { get; private set; }
        float mDecompressionProgress = 0;
        DownLoadParam mDownLoadParam;

        bool mCheckDownLoadOverTime;
        float mCheckDownLoadTotalTime;

        LaunchViewRoot mLaunchViewRoot = LaunchViewRoot.Instance;
        public LaunchView mLaunchView { get; private set; }
        public LaunchAlert mLaunchAlert { get; private set; }

        PlatformManager mPlatformManager = PlatformManager.Instance;

        public void Init()
        {
            mLaunchViewRoot.Init();
            mLaunchView = mLaunchViewRoot.mLaunchView;
            mLaunchAlert = mLaunchViewRoot.mLaunchAlert;

            CheckMoveRawFilesToPersistentPath();
        }

        public void Dispose()
        {
            if (mLaunchViewRoot != null)
            {
                mLaunchViewRoot.Dispose();
                mLaunchViewRoot = null;
            }
        }

        void Update()
        {
            if (mCheckDownLoadOverTime)
            {
                mCheckDownLoadTotalTime += Time.unscaledDeltaTime;

                if (mCheckDownLoadTotalTime >= 10.0f)
                {
                    CallFailAction();
                }
            }
        }

        void CheckMoveRawFilesToPersistentPath()
        {
            TextAsset OriginalAssetNum = Resources.Load<TextAsset>("Assets/OriginalAssetNum");
            mOriginalAssetNumStr = OriginalAssetNum.text.Trim();

            Debug.Log("mOriginalAssetNumStr:" + mOriginalAssetNumStr);

            string[] paramList = mOriginalAssetNumStr.Split('_');
            mOriginalAssetNum = int.Parse(paramList[0].Trim());
            mOriginalAssetVersion = paramList[1].Trim();
            Resources.UnloadAsset(OriginalAssetNum);

            if (ResourceURL.CheckPersistentFileExists(cRemoteVersionUrl))
            {
                ResourceLoader.Instance.LoadAsset<TextAsset>("Version/Version.bytes", "Version", delegate(TextAsset textAsset)
                {
                    string localVersion = textAsset.text.Trim();

                    Debug.Log("localVersion:" + localVersion);

                    if (PlatformVersion.CompareVersion(mOriginalAssetVersion, localVersion) > 0)
                    {
                        MoveRawFilesToPersistentPath();
                        return;
                    }
                    else
                    {
                        //本地版本更高
                        mOriginalAssetVersion = localVersion;
                    }
                }, true);
            }
            else
            {
                MoveRawFilesToPersistentPath();
                return;
            }

            CheckNewVersion();
        }

        private void MoveRawFilesToPersistentPath()
        {
            mLaunchView.tips = "第一次进入游戏，正在解压资源，请稍等，不消耗流量哦";

            mOriginalAssetIndex = 0;
            LoadOriginalAsset();
        }

        void LoadOriginalAsset()
        {
            if (++mOriginalAssetIndex <= mOriginalAssetNum)
            {
                mDecompressionProgress = (float)(mOriginalAssetIndex - 1) / mOriginalAssetNum;
                TextAsset OriginalAsset = Resources.Load<TextAsset>("Assets/OriginalAsset" + mOriginalAssetIndex);
                SerializeUtils.DeserializeXml<List<FileBytesVo>>(OriginalAsset.bytes, delegate(List<FileBytesVo> voList)
                {
                    StartCoroutine(DeserializeOriginalAssetComplete(voList));
                });
                Resources.UnloadAsset(OriginalAsset);
            }
            else
            {
                CheckNewVersion();
            }
        }

        IEnumerator DeserializeOriginalAssetComplete(List<FileBytesVo> fileBytesVoList)
        {
            for (int i = 0, count = fileBytesVoList.Count; i < count; i++)
            {
                FileBytesVo vo = fileBytesVoList[i];
                SaveFile(vo.path, vo.bytes);

                mLaunchView.progress = Mathf.Max(mDecompressionProgress + (float)i / (mOriginalAssetNum * count), mLaunchView.progress);
                yield return 0;
            }

            yield return 0;
            LoadOriginalAsset();
        }

        public void SaveFile(string path, byte[] bytes)
        {
            path = Application.persistentDataPath + "/StreamingAssets/" + GetPath(path);
            string directory = Path.GetDirectoryName(path);

            if (Directory.Exists(directory) == false)
                Directory.CreateDirectory(directory);

            using (FileStream stream = new FileStream(path, FileMode.Create, FileAccess.ReadWrite))
            {
                try
                {
                    stream.Write(bytes, 0, bytes.Length);
                    stream.Flush();
                }
                catch (Exception exception)
                {
                    Debug.Log("DeserializeOriginalAssetComplete:" + exception.StackTrace);
                }
            }
        }

        private string GetPath(string path)
        {
            return path.Replace(@"\", "/");
        }

        public string GetRemoteURL(string url)
        {
            return mPlatformManager.mRawPlatformConfigVo.resourceList + mPlatformManager.mRawPlatformConfigVo.assetFolderName + "/" + url;
        }

        private void CheckNewVersion()
        {
            Debug.Log("CheckNewVersion...");

            mLaunchView.progress = 0;
            mLaunchView.tips = "正在初始化游戏...";

            mPlatformManager.LoadPlatformConfig(delegate()
            {
                DownLoadRemote(GetRemoteURL(cRemoteVersionUrl), ReceiveRemoteVersion, RetryCheckNewVersion);
            });
        }

        public void RetryCheckNewVersion()
        {
            GameManager.Instance.mGameResUpdateManager.mLaunchAlert.ShowTip("网络异常，是否重试？", CheckNewVersion);
        }

        public void DownLoadRemote(string url, Action<WWW> successAction, Action failAction, bool dispose = true)
        {
            DownLoadParam downLoadParam = new DownLoadParam();
            downLoadParam.url = url;
            downLoadParam.mSuccessAction = successAction;
            downLoadParam.mFailAction = failAction;
            downLoadParam.dispose = dispose;

            StopCoroutine("DownLoad");
            StartCoroutine("DownLoad", downLoadParam);
        }

        public IEnumerator DownLoad(DownLoadParam downloadParam)
        {
            mDownLoadParam = downloadParam;
            BeginCheckDownLoadOverTime();

            string url = mDownLoadParam.url;
            WWW getData = new WWW(url);
            yield return getData;
            EndCheckDownLoadOverTime();

            if (string.IsNullOrEmpty(getData.error) == false)
            {
                Debug.Log(string.Format("url:{0},error:{1}", url, getData.error));

                if (mDownLoadParam.dispose)
                {
                    getData.Dispose();
                }

                CallFailAction();
            }
            else
            {
                Action<WWW> action = mDownLoadParam.mSuccessAction;
                action(getData);

                if (mDownLoadParam.dispose)
                {
                    if (getData.assetBundle != null)
                        getData.assetBundle.Unload(false);

                    getData.Dispose();
                }
            }
        }

        private void CallFailAction()
        {
            StopCoroutine("DownLoad");
            EndCheckDownLoadOverTime();

            if (mDownLoadParam != null && mDownLoadParam.mFailAction != null)
            {
                mDownLoadParam.mFailAction();
            }
        }

        private void BeginCheckDownLoadOverTime()
        {
            mCheckDownLoadOverTime = true;
            mCheckDownLoadTotalTime = 0;
        }

        private void EndCheckDownLoadOverTime()
        {
            mCheckDownLoadOverTime = false;
        }

        private void ReceiveRemoteVersion(WWW www)
        {
            mRemoteVersion = (www.assetBundle.LoadAsset("Version") as TextAsset).text;

            mLaunchView.curVersion = "当前版本：" + mOriginalAssetVersion;
            mLaunchView.lastVersion = "最新版本：" + mRemoteVersion;

            mLaunchView.progress = 0;

            if (PlatformVersion.CheckUpdateApk(mRemoteVersion, mOriginalAssetVersion))
            {
                //更新apk
                GameManager.Instance.mGameResUpdateManager.mLaunchAlert.ShowTip(string.Format("需要更新到最新版本 [00ff00]{0}.apk[-]", mRemoteVersion), delegate()
                {

                });
            }
            else if (PlatformVersion.CompareVersion(mRemoteVersion, mOriginalAssetVersion) > 0)
            {
                //增量更新
                mLaunchView.tips = "正在更新到最新版本...";

                FileMD5Manager.Instance.LoadLocalFileMD5();
            }
            else
            {
                //不需要更新
                mLaunchView.tips = "当前已是最新版本";
                UpdateComplete();
            }
        }

        public void UpdateComplete()
        {
            mLaunchView.UpdateComplete();
            mLaunchView.tips = "正在初始化游戏...";

            GameManager.Instance.mLaunch.LoadGameScript();
        }
    }
}
