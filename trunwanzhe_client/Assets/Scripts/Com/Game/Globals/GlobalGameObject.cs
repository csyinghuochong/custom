using Assets.Scripts.Com.Game.Utils;
using UnityEngine;
using Assets.Scripts.Com.Game.Core;
using Assets.Scripts.Com.Game.Manager;
using Assets.Scripts.Com.Game.Mono;
using Assets.Scripts.Com.Game.Mono.Scene;
using Assets.Plugins.Assets.Scripts.Com.Game.Manager;
using Assets.Plugins.Assets.Scripts.Com.Game.Platform;
using Assets.Scripts.Com.Game.Mono.Utils;

namespace Assets.Scripts.Com.Game.Globals
{
    class GlobalGameObject : Singleton<GlobalGameObject>
    {
        GameManager mGameManager;

        public void Init(GameObject gameObject)
        {
            if (mGameManager == null)
            {
                mGameManager = GameManager.Instance;
                mGameManager.AddPluginsComponent(gameObject);

                PlatformManager.Instance.LoadPlatformConfig();

                AddComponent();
            
            }
        }

        public LevelController mLevelController { get; private set; }
        public AudioListener mAudioListener { get; private set; }

        private void AddComponent()
        {
            if (PlatformManager.Instance.mIsReleasePlatform == false)
                mGameManager.AddComponent<FPS>();

            mLevelController = mGameManager.AddComponent<LevelController>();

            mGameManager.AddComponent<CoroutineUtil>();
            CoroutineManager.Instance.InitCoroutine(mGameManager.mGameObject);

            if (Application.platform == RuntimePlatform.Android)
            {
                mGameManager.AddComponent<AndroidInfoManager>();
            }
        }
    }
}
