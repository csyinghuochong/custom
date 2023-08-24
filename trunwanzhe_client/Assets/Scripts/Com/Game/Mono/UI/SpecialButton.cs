using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Assets.Scripts.Com.Game.Mono.UI
{
    public class SpecialButton
    {
        public SpecialButton(UISprite sprite, UILabel label)
        {
            mSprite = sprite;
            mLabel = label;
            mCollider = sprite.gameObject.GetComponent<BoxCollider>();

            mNormalSpriteName = mSprite.spriteName;
            mNormalLabelColor = mLabel.color;
            mNormalLabelEffectColor = mLabel.effectColor;

            gameObject = mSprite.gameObject;
        }

        public SpecialButton(UISprite sprite, UILabel label, string disableName, Color disableColor, Color disableEffectColor)
        {
            mSprite = sprite;
            mLabel = label;
            mCollider = sprite.gameObject.GetComponent<BoxCollider>();

            mNormalSpriteName = mSprite.spriteName;
            mNormalLabelColor = mLabel.color;
            mNormalLabelEffectColor = mLabel.effectColor;

            mDisableSpriteName = disableName;
            mDisableLabelColor = disableColor;
            mDisableLabelEffectColor = disableEffectColor;

            gameObject = mSprite.gameObject;
        }

        public bool isEnabled
        {
            get
            {
                return mEnabled;
            }
            set
            {
                mEnabled = value;

                if (mEnabled)
                {
                    mSprite.spriteName = mNormalSpriteName;
                    mLabel.color = mNormalLabelColor;
                    mLabel.effectColor = mNormalLabelEffectColor;
                }
                else
                {
                    mSprite.spriteName = mDisableSpriteName;
                    mLabel.color = mDisableLabelColor;
                    mLabel.effectColor = mDisableLabelEffectColor;
                }
                mCollider.enabled = mEnabled;
            }
        }

        public void SetActive(bool active)
        {
            gameObject.SetActive(active);
        }

        public GameObject gameObject { get; protected set; }

        private bool mEnabled;
        private UISprite mSprite;
        private UILabel mLabel;
        private BoxCollider mCollider;
        private string mNormalSpriteName = "";
        private Color mNormalLabelColor;
        private Color mNormalLabelEffectColor;
        private string mDisableSpriteName = "public_button_gray";
        private Color mDisableLabelColor = new Color(227f / 255f, 227f / 255f, 227f / 255f);
        private Color mDisableLabelEffectColor = Color.black;
    }
}
