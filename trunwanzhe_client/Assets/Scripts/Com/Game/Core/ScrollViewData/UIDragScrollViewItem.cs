using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Assets.Scripts.Com.Game.Core.ScrollViewData
{
    public class UIDragScrollViewItem : MonoBehaviour
    {
        public bool mOnDrag;
        public Action<Vector2, Vector2, Vector2> mCustomDragAction;

        void OnDrag(Vector2 delta)
        {
            mOnDrag = true;

            if (mCustomDragAction != null)
                mDragList.Add(delta);
        }

        public void OnDisable()
        {
            mOnDrag = false;
        }

        private List<Vector2> mDragList;
        void OnPress(bool pressed)
        {
            if (mCustomDragAction == null)
                return;

            if (mDragList == null)
                mDragList = new List<Vector2>();

            if (pressed)
            {
                mDragList.Clear();
            }
            else
            {
                int count = mDragList.Count;
                if (count < 2)
                    return;

                Vector2 delta = Vector2.zero;
                for (int i = 0; i < count; i++)
                {
                    delta += mDragList[i];
                }

                mCustomDragAction(mDragList[0], mDragList[1], delta);
            }
        }
    }
}
