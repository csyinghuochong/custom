using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using Assets.Scripts.Com.Game.Utils.Timers;
using Assets.Scripts.Com.Game.Loader;
using Assets.Scripts.Com.Game.Core.ScrollViewData;
using Assets.Scripts.Com.Game.Utils;

namespace Assets.Scripts.Com.Game.Core
{
    public class ScrollViewItem<T> : BaseView where T : ScrollViewVo
    {
        public T mData { get; private set; }

        protected UIDragScrollView mUIDragScrollView;
        public UIDragScrollViewItem mUIDragScrollViewItem;

        private Action<ScrollViewItem<T>> mOnScrollViewItemSelect;
        public bool mSelected { get; private set; }

        public Action<Vector2, Vector2, Vector2> mCustomDragAction;

        public virtual void InitContainer(Action callBack, T data, Action<ScrollViewItem<T>> OnScrollViewItemSelect, int index = 0)
        {
            mData = data;
            mOnScrollViewItemSelect = OnScrollViewItemSelect;

            if (mIsLoadComplete)
            {
                UpdateData(mData);

                callBack();
            }
            else
            {
                //if (AssetLoader.sLimitLoad)
                //{
                //    GameTimer.ExecuteTotalFrames(index / 10 + 1, null, delegate()
                //    {
                //        ShowView(callBack, mViewParam);
                //    });
                //}
                //else
                //{
                //    ShowView(callBack, mViewParam);
                //}

                ShowView(callBack, mViewParam);
            }
        }

        protected override void InternalInit()
        {
            mUIDragScrollView = gameObject.GetComponent<UIDragScrollView>();

            if (mCustomDragAction == null)
            {
                if (mUIDragScrollView == null)
                {
                    mUIDragScrollView = gameObject.AddComponent<UIDragScrollView>();
                }
            }
            else
            {
                if (mUIDragScrollView != null)
                {
                    GameObject.Destroy(mUIDragScrollView);
                }
            }

            mUIDragScrollViewItem = gameObject.GetComponent<UIDragScrollViewItem>();
            if (mUIDragScrollViewItem == null)
            {
                mUIDragScrollViewItem = gameObject.AddComponent<UIDragScrollViewItem>();
                mUIDragScrollViewItem.mCustomDragAction = mCustomDragAction;
            }

            base.InternalInit();

            UpdateData(mData);
        }

        public void UpdateData(T data)
        {
            mData = data;
            if (mIsLoadComplete)
                OnUpdateData();
        }

        protected virtual void OnUpdateData()
        {

        }

        public void DragEnabled(bool enabled)
        {
            if (mUIDragScrollView == null)
                return;

            if (mUIDragScrollView.enabled == enabled)
                return;

            mUIDragScrollView.enabled = enabled;
        }

        public virtual void OnRemove()
        {
            SetSelect(false);

            SetBoundActive(false);
        }

        //重载写选中效果
        public virtual void OnSelect(bool select)
        {

        }

        public void SetSelect(bool select = true)
        {
            if (mSelected != select)
            {
                mSelected = select;
                OnSelect(select);

                if (select)
                    mOnScrollViewItemSelect(this);
            }
        }

        GameObject mAddBoundGo;
        public void AddBound(bool add, int w, int h)
        {
            if (mAddBoundGo == null && add && gameObject.activeSelf)
            {
                mAddBoundGo = new GameObject();
                UIWidget widget = mAddBoundGo.AddComponent<UIWidget>();
                widget.pivot = UIWidget.Pivot.TopLeft;
                widget.width = w;
                widget.height = h;
                GameObjectUtil.AddChild(gameObject, mAddBoundGo);
            }

            SetBoundActive(add);
        }

        private void SetBoundActive(bool active)
        {
            if (mAddBoundGo != null)
                mAddBoundGo.SetActive(active);
        }
    }
}
