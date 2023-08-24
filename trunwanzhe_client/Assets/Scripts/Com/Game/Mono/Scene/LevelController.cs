using UnityEngine;
using System.Collections;
using Assets.Scripts.Com.Game.Globals;
using Assets.Scripts.Com.Game.Utils;
using Assets.Scripts.Com.Game.Events;
using System;
using Assets.Scripts.Com.Game.Manager;
using Assets.Scripts.Com.Game.Loader;
using Assets.Scripts.Com.Game.Utils.Timers;

namespace Assets.Scripts.Com.Game.Mono.Scene
{
    class LevelController : MonoBehaviour
    {
        Action mCallBack;

        public void LoadRawScene(string sceneName, Action callBack)
        {
            mCallBack = delegate()
            {
                callBack();
            };

            StartCoroutine(LoadAsync(sceneName));
        }

        public void LoadExternalScene(string sceneName, Action callBack)
        {
            if (DebugControl.debugOnFrequent)
            {
                Debug.Log("LoadExternalScene:" + sceneName);
            }

            mCallBack = callBack;

            StartCoroutine(CreateScene(sceneName));
        }

        IEnumerator CreateScene(string sceneName)
        {
            yield return StartCoroutine(LoadScene(sceneName));

            StartCoroutine(LoadAsync(sceneName));
        }

        AssetBundle mSceneAssetBundle;
        IEnumerator LoadScene(string sceneName)
        {
            DisposeSceneLoader();

            string path = PathUtil.GetGameScenePath(sceneName);
            string scenePath = ResourceURL.GetAssetPath(path);

            using(WWW sceneLoader = new WWW(scenePath))
            {
                yield return sceneLoader;

                if (sceneLoader.error != null)
                {
                    Debug.Log("mSceneLoader.error:" + sceneLoader.error);
                }
                else
                {
                    mSceneAssetBundle = sceneLoader.assetBundle;
                }
            }
        }

        IEnumerator LoadAsync(string sceneName)
        {
            AsyncOperation async = Application.LoadLevelAsync(sceneName);
            yield return async;
            if (async.isDone)
            {
                DisposeSceneLoader();

                AssetLoader.Instance.LoadScene(sceneName, mCallBack);
            }
        }

        private void DisposeSceneLoader()
        {
            if (mSceneAssetBundle != null)
            {
                mSceneAssetBundle.Unload(false);
                mSceneAssetBundle = null;
            }
        }
    }
}
