using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Assets.Plugins.Assets.Scripts.Com.Game.Manager;
using Assets.Scripts.Com.Game.Core;
using UnityEngine;

namespace Assets.Plugins.Assets.Scripts.Com.Game.View
{
    public class LaunchViewRoot : Singleton<LaunchViewRoot>
    {
        GameObject mRoot;
        public LaunchView mLaunchView { get; private set; }
        public LaunchAlert mLaunchAlert { get; private set; }

        public void Init()
        {
            GameObject go = Resources.Load<GameObject>("Launch/LaunchViewRoot");
            mRoot = GameObject.Instantiate(go) as GameObject;
            Transform rootTransform = mRoot.transform;

            mLaunchView = new LaunchView();
            mLaunchView.InjectGameObject(rootTransform.Find("LaunchViewPanel/LaunchView").gameObject);

            mLaunchAlert = new LaunchAlert();
            mLaunchAlert.InjectGameObject(rootTransform.Find("AlertPanel/Alert").gameObject);
        }

        public void Dispose()
        {
            mLaunchView = null;
            mLaunchAlert = null;

            if (mRoot)
                GameObject.DestroyImmediate(mRoot);
        }
    }
}