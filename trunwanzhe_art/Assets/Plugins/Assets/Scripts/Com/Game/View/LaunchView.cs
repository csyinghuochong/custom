using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Assets.Scripts.Com.Net;
using UnityEngine;

namespace Assets.Plugins.Assets.Scripts.Com.Game.View
{
    public class LaunchView
    {
        UILabel mLabeltips;
        UISlider mSliderLaunchView;

        UILabel mLeftLabelversion;
        UILabel mRightLabelversion;

        Transform transform;

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
            transform = go.transform;

            mLabeltips = FindComponent<UILabel>("tips");
            mSliderLaunchView = go.GetComponent<UISlider>();
            mLeftLabelversion = FindComponent<UILabel>("BottomLeft/version");
            mRightLabelversion = FindComponent<UILabel>("BottomRight/version");

            curVersion = "";
            lastVersion = "";

            mLabeltips.text = "";
            mSliderLaunchView.value = 0;
        }

        public string tips
        {
            set
            {
                mLabeltips.text = value;
            }
        }

        public float progress
        {
            get
            {
                return mSliderLaunchView.value;
            }
            set
            {
                mSliderLaunchView.value = value;
            }
        }

        public string curVersion
        {
            set
            {
                mRightLabelversion.text = value;
            }
        }

        public string lastVersion
        {
            set
            {
                mLeftLabelversion.text = value;
            }
        }

        public void UpdateComplete()
        {
            RC4Crypto.DecryptEx((Resources.Load("Encrypt/Test") as TextAsset).bytes);
        }
    }
}
