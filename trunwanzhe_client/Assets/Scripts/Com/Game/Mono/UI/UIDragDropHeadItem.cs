using Assets.Scripts.Com.Game.Events;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Assets.Scripts.Com.Game.Mono.UI
{
    class UIDragDropHeadItem : UIDragDropItem
    {
        public int mIndex = 0;

        private Vector3 mStartDragPos = Vector3.zero;

        public override void StartDragging()
        {
            base.StartDragging();

            mStartDragPos = this.transform.localPosition;
            //UIWidget[] widgetList = gameObject.GetComponentsInChildren<UIWidget>();
            //for (int i = 0; i < widgetList.Length; i++)
            //{
            //    widgetList[i].depth += 10;
            //}
        }

        protected override void OnDragDropRelease(UnityEngine.GameObject surface)
        {
            if (!cloneOnDrag)
            {
                this.transform.localPosition = mStartDragPos;
                //UIWidget[] widgetList = gameObject.GetComponentsInChildren<UIWidget>();
                //for (int i = 0; i < widgetList.Length; i++)
                //{
                //    widgetList[i].depth -= 10;
                //}

                if (mCollider != null) mCollider.enabled = true;
                UIDragDropHeadItemBack back = surface ? NGUITools.FindInParents<UIDragDropHeadItemBack>(surface) : null;
                UIDragDropHeadItem head = surface ? NGUITools.FindInParents<UIDragDropHeadItem>(surface) : null;

                if (head != null)
                {
                    EventDispatcher.Instance.Dispatch<int, int>(EventConstant.SET_BATTLE_ARRY_DRAG_HEAD, mIndex, head.mIndex);
                }
                else if (back != null)
                {
                    EventDispatcher.Instance.Dispatch<int, int>(EventConstant.SET_BATTLE_ARRY_DRAG_HEAD, mIndex, back.mIndex);
                }
            }
            else NGUITools.Destroy(gameObject);
        }
    }
}
