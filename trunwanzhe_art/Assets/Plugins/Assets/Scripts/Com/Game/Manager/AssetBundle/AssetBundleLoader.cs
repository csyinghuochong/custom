using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System;
using Assets.Scripts.Com.Game.Manager.AssetBundle;
using Assets.Scripts.Com.Game.Utils;

public class AssetBundleLoader : MonoBehaviour
{
    public DownLoadState state { get; private set; }

    public int size { get; private set; }

    public string path { get; private set; }

    public string assetPath { get; private set; }

    public IEnumerator Load(string path, LoadRequest loadRequest)
    {
        this.path = path;

        assetPath = ResourceURL.GetAssetPath(path);

        using (WWW downLoader = new WWW(assetPath))
        {
            yield return downLoader;

            if (downLoader.error != null)
            {
                Debug.Log("downLoader.error:" + downLoader.error);
                state = DownLoadState.LoadFail;
            }
            else
            {
                size = downLoader.bytesDownloaded;

                if (loadRequest.LoadQuestComplete(this, downLoader))
                {
                    state = DownLoadState.Complete;
                }
                else
                {
                    state = DownLoadState.LoadFail;
                }
            }
        }
    }

    public void SetStateWait()
    {
        state = DownLoadState.Wait;
    }

    public void SetStateLoading()
    {
        state = DownLoadState.Loading;
    }
}