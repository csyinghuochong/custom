using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Assets.Scripts.Com.Game.Mono.UI
{
    class ToggleButton
    {
        public ToggleButton(GameObject parent)
        {
            Transform trans = parent.transform;
            mNormal = trans.Find("normal").gameObject;
            mDisable = trans.Find("disable").gameObject;

            gameObject = parent;
            transform = trans;
        }

        private GameObject mNormal;
        private GameObject mDisable;

        public bool isEnabled
        {
            get
            {
                return mEnabled;
            }
            set
            {
                mEnabled = value;
                mNormal.SetActive(mEnabled);
                mDisable.SetActive(!mEnabled);
                gameObject.GetComponent<BoxCollider>().enabled = mEnabled;
            }
        }

        public GameObject gameObject
        {
            protected set;
            get;
        }

        public Transform transform
        {
            protected set;
            get;
        }

        private bool mEnabled = true;
    }
}
