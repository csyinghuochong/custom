using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Assets.Plugins.Assets.Scripts.Com.Game.View
{
    public class LaunchAlert
    {
        public UILabel mTip;

        Transform transform;
        GameObject gameObject;

        //path只支持完整路径，不支持名字查找
        public T FindComponent<T>(string path) where T : Component
        {
            GameObject obj = FindChild(path);

            return obj.GetComponent<T>();
        }

        //path只支持完整路径，不支持名字查找
        public GameObject FindChild(string path)
        {
            return transform.Find(path).gameObject;
        }

        public GameObject FindChild(Transform transform, string path)
        {
            return transform.Find(path).gameObject;
        }

        public void InjectGameObject(GameObject go)
        {
            gameObject = go;
            transform = go.transform;

            mTip = FindComponent<UILabel>("tip");

            UIEventListener.Get(FindChild("btn_sure")).onClick = delegate(GameObject go2)
            {
                gameObject.SetActive(false);

                if (mAction != null)
                {
                    mAction();
                }
            };

            gameObject.SetActive(false);
        }

        Action mAction;

        public void ShowTip(string tip, Action action)
        {
            mTip.text = tip;
            mAction = action;

            gameObject.SetActive(true);
        }
    }
}
