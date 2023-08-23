using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Assets.Scripts.Com.Game.Core;
using Assets.Scripts.Com.Game.Utils;
using UnityEngine;
using Assets.Plugins.Assets.Scripts.Com.Game.Platform;

namespace Assets.Plugins.Assets.Scripts.Com.Game.Manager
{
    public class GameManager : Singleton<GameManager>
    {
        public GameObject mGameObject { get; private set; }
        public AssetBundleManager mAssetBundleManager { get; private set; }
        public OutputLog mOutputLog { get; private set; }
        public GameResUpdateManager mGameResUpdateManager { get; private set; }
        public Launch mLaunch { get; private set; }

        public void AddPluginsComponent(GameObject gameObject)
        {
            if (mGameObject == null)
            {
                mGameObject = gameObject;
                GameObject.DontDestroyOnLoad(mGameObject);

                mAssetBundleManager = gameObject.AddComponent<AssetBundleManager>();

                if (Application.isEditor == false)
                {
                    mOutputLog = gameObject.AddComponent<OutputLog>();
                }

                mGameResUpdateManager = AddComponent<GameResUpdateManager>();
                mLaunch = gameObject.GetComponent<Launch>();
            }
        }

        public T AddComponent<T>() where T : Component
        {
            T component = mGameObject.GetComponent<T>();

            if (component == null)
            {
                component = mGameObject.AddComponent<T>();
            }

            return component;
        }
    }
}
