using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Assets.Plugins.Assets.Scripts.Com.Game.Manager;
using Assets.Scripts.Com.Game.Core;
using UnityEngine;
using Assets.Scripts.Com.Game.Utils;

namespace Assets.Plugins.Assets.Scripts.Com.Game.MD5
{
    class FileMD5Manager : Singleton<FileMD5Manager>
    {
        public const string cFileMD5URL = "FileMD5/FileMD5.bytes";
        const string cFileMD5Name = "FileMD5";

        private Dictionary<string, FileMD5Vo> mLocalFileMD5List = new Dictionary<string, FileMD5Vo>();
        private Dictionary<string, FileMD5Vo> mRemoteFileMD5List = new Dictionary<string, FileMD5Vo>();
        private List<FileMD5Vo> mDeltaList = new List<FileMD5Vo>();

        private float mDeltaSize;
        private float mSaveSize;

        GameResUpdateManager mGameResUpdateManager;

        public void LoadLocalFileMD5()
        {
            mLocalFileMD5List.Clear();
            mRemoteFileMD5List.Clear();
            mDeltaList.Clear();
            mDeltaSize = 0;
            mSaveSize = 0;

            mGameResUpdateManager = GameManager.Instance.mGameResUpdateManager;

            ResourceLoader.Instance.LoadAsset<TextAsset>(cFileMD5URL, cFileMD5Name, delegate(TextAsset textAsset)
            {
                SerializeUtils.DeserializeXml<List<FileMD5Vo>>(textAsset.bytes, delegate(List<FileMD5Vo> list)
                {
                    foreach (FileMD5Vo vo in list)
                    {
                        mLocalFileMD5List[vo.path] = vo;
                    }

                    LoadRemoteFileMD5();
                });
            }, true);
        }

        private void LoadRemoteFileMD5()
        {
            mGameResUpdateManager.DownLoadRemote(mGameResUpdateManager.GetRemoteURL(cFileMD5URL), ReceiveRemoteFileMD5, mGameResUpdateManager.RetryCheckNewVersion);
        }

        private void ReceiveRemoteFileMD5(WWW www)
        {
            SerializeUtils.DeserializeXml<List<FileMD5Vo>>((www.assetBundle.LoadAsset(cFileMD5Name) as TextAsset).bytes, delegate(List<FileMD5Vo> list)
            {
                foreach (FileMD5Vo vo in list)
                {
                    mRemoteFileMD5List[vo.path] = vo;
                }

                CompareLocalRemoteFildMD5();
            });
        }

        private void CompareLocalRemoteFildMD5()
        {
            foreach (KeyValuePair<string, FileMD5Vo> kvp in mRemoteFileMD5List)
            {
                FileMD5Vo localFileMD5Vo;

                if (mLocalFileMD5List.TryGetValue(kvp.Key, out localFileMD5Vo) && kvp.Value.md5 == localFileMD5Vo.md5)
                {
                    continue;
                }

                AddDeltaFileMD5Vo(kvp.Value);
            }

            AddDeltaFileMD5Vo(new FileMD5Vo { path = cFileMD5URL });
            AddDeltaFileMD5Vo(new FileMD5Vo { path = GameResUpdateManager.cRemoteVersionUrl });

            mGameResUpdateManager.mLaunchAlert.ShowTip(
                string.Format("当前版本更新到[00ff00]{0}[-],本次更新包为[00ff00]{1}[-],是否下载更新资源？", mGameResUpdateManager.mRemoteVersion, GetSizeStr(mDeltaSize)), LoadDeltaFile);
        }

        private string GetSizeStr(float size)
        {
            float num = size / (1024 * 1024);
            float num2 = size / 1024f;
            if (num > 1f)
            {
                return string.Format("{0:0.#}M", num);
            }
            if (num2 > 1f)
            {
                return string.Format("{0:0.#}kb", num2);
            }
            return (size.ToString() + "b");
        }

        private void AddDeltaFileMD5Vo(FileMD5Vo vo)
        {
            mDeltaList.Add(vo);
            mDeltaSize += vo.size;
        }

        private void LoadDeltaFile()
        {
            if (mDeltaList.Count == 0)
            {
                Debug.Log("LoadDeltaFile Complete");

                mGameResUpdateManager.UpdateComplete();
            }
            else
            {
                FileMD5Vo vo = mDeltaList[0];

                mGameResUpdateManager.DownLoadRemote(mGameResUpdateManager.GetRemoteURL(vo.path), ReceiveRemoteFile, mGameResUpdateManager.RetryCheckNewVersion);
            }
        }

        private void ReceiveRemoteFile(WWW www)
        {
            FileMD5Vo vo = mDeltaList[0];
            mDeltaList.RemoveAt(0);

            mSaveSize += vo.size;
            mGameResUpdateManager.mLaunchView.progress = mSaveSize / mDeltaSize;
            mGameResUpdateManager.SaveFile(vo.path, www.bytes);
            LoadDeltaFile();
        }
    }
}
