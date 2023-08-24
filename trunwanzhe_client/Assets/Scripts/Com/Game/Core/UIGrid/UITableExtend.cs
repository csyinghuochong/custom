
using Assets.Scripts.Com.Game.Utils.Timers;
using System;
using System.Collections.Generic;
using UnityEngine;
namespace Assets.Scripts.Com.Game.Core
{
    class UITableExtend<K, V, T>
        where V : ScrollViewVo
        where T : ScrollViewItem<V>, new()
    {
        public UITable mUITable { get; private set; }
        Transform mUITableTransform;
        public UIScrollView mUIScrollView { get; private set; }
        public UIPanel mUIPanel { get; private set; }
        Transform mUIPanelTransform;
        float mPageChildsCount; //每页显示子对象个数
        Vector3 mUIPanelStartPos; //panel起始位置
        Vector2 mUIPanelClipOffset; //panel裁剪区域

        ScrollViewDataSource<K, V> mDataSource;
        Dictionary<K, T> mChildDic = new Dictionary<K, T>();
        Dictionary<Transform, T> mTransformDic = new Dictionary<Transform, T>();
        List<Transform> mTransformList = new List<Transform>();
        LinkedList<T> mCacheViewItems = new LinkedList<T>();

        Action mRefreshCallBackHandler;

        public float mPrevScrollBarValue { get; private set; }
        public event Action mOnRepositionEvent;
        private bool mFirstSetBarValue = true;

        public UITableExtend(UITable table, ScrollViewDataSource<K, V> dataSource = null, uint defaultItemHeight = 0)
        {
            mUITable = table;
            mUITable.hideInactive = true;
            mUITableTransform = mUITable.transform;
            mUITable.onReposition += onReposition;

            mUIScrollView = NGUITools.FindInParents<UIScrollView>(mUITable.gameObject);
            mUIScrollView.onDragStarted += OnDragStartHandler;

            mUIPanel = mUIScrollView.GetComponent<UIPanel>();
            mUIPanelTransform = mUIPanel.transform;
            mUIPanelStartPos = mUIPanelTransform.localPosition;
            mUIPanelClipOffset = mUIPanel.clipOffset;

            if (defaultItemHeight != 0)
                mPageChildsCount = Mathf.Ceil(mUIPanel.GetViewSize().y / defaultItemHeight);
            else
                mPageChildsCount = 1;

            UpdateDataSource(dataSource);
        }

        private int CustomSort(Transform t1, Transform t2)
        {
            return mDataSource.CustomSort(mTransformDic[t1].mData, mTransformDic[t2].mData);
        }

        public int GetDataCount()
        {
            return mDataSource.mDic.Count;
        }

        public void Dispose()
        {
            if (mDataSource != null)
            {
                mDataSource.ClearAction(DataRefreshHandler, DataAddHandler, DataRemoveHandler, DataUpdateHandler);
                mDataSource = null;
            }

            foreach (KeyValuePair<K, T> kvp in mChildDic)
            {
                T child = kvp.Value;
                child.CloseView();
            }

            for (LinkedListNode<T> node = mCacheViewItems.First; node != null; node = node.Next)
            {
                node.Value.CloseView();
            }

            mCacheViewItems.Clear();
            mChildDic.Clear();
            mTransformDic.Clear();
            mTransformList.Clear();

            mUITable.onReposition -= onReposition;
            mOnRepositionEvent = null;
        }

        public void UpdateDataSource(ScrollViewDataSource<K, V> dataSource, Action refreshCallBackHandler = null)
        {
            if (dataSource == null)
                return;

            mRefreshCallBackHandler = refreshCallBackHandler;

            if (dataSource == mDataSource)
            {
                DataRefreshHandler();
                return;
            }

            if (mDataSource != null)
            {
                mDataSource.ClearAction(DataRefreshHandler, DataAddHandler, DataRemoveHandler, DataUpdateHandler);
            }

            mDataSource = dataSource;
            mDataSource.RegisterAction(DataRefreshHandler, DataAddHandler, DataRemoveHandler, DataUpdateHandler);

            if (mUITable.sorting == UITable.Sorting.Custom)
                mUITable.onCustomSort = CustomSort;

            DataRefreshHandler();
        }

        private void InitCreateView()
        {
            //             mUIPanelTransform.localPosition = mUIPanelStartPos;
            //             mUIPanel.clipOffset = mUIPanelClipOffset;
            //             mUITableTransform.localPosition = Vector3.zero;
            // 
            //             SpringPanel springPanel = mUIPanel.GetComponent<SpringPanel>();
            //             if (springPanel != null)
            //             {
            //                 springPanel.target = mUIPanelStartPos;
            //                 springPanel.enabled = false;
            //             }

            int index = 0;
            int count = mDataSource.mDic.Count;

            foreach (KeyValuePair<K, V> kvp in mDataSource.mDic)
            {
                LoadView(kvp.Key, kvp.Value, ++index, count);
            }

            //以免数据为空，不会执行回调...
            if (mDataSource.mDic.Count == 0)
            {
                ExecuteRefreshCallBackHandler();
            }
        }

        private void ExecuteRefreshCallBackHandler()
        {
            if (mRefreshCallBackHandler != null)
            {
                mRefreshCallBackHandler();
                mRefreshCallBackHandler = null;
            }
        }

        private void LoadView(K key, V value, int index = 0, int count = 0)
        {
            T child = GetView(value);
            mChildDic[key] = child;

            child.InitContainer(ChildLoadComplete(child, key, index, count), value, OnScrollViewItemSelect);
        }

        static Vector3 sInitPos = new Vector3(0, 10000);
        private Action ChildLoadComplete(T child, K key, int index = 0, int count = 0)
        {
            return delegate()
            {
                Transform transform = child.transform;
                mTransformDic[transform] = child;
                transform.parent = mUITableTransform;
                transform.localScale = Vector3.one;
                transform.localPosition = sInitPos;
                child.gameObject.name = key.ToString();

                if (index == count)
                {
                    ExecuteRefreshCallBackHandler();
                    ResetPosition();

                    if (mFirstSetBarValue)
                    {
                        mFirstSetBarValue = false;
                        mPrevScrollBarValue = 1.0f;
                    }
                }
                else if (index == mPageChildsCount)
                {
                    ResetPosition();
                }
            };
        }

        public T GetChild(K key)
        {
            T child = null;
            mChildDic.TryGetValue(key, out child);

            return child;
        }

        private T GetView(V value)
        {
            if (mCacheViewItems.Count > 0)
            {
                T child = mCacheViewItems.First.Value;
                mCacheViewItems.RemoveFirst();
                child.ShowView();

                return child;
            }

            return CreateView(value);
        }

        protected virtual T CreateView(V value)
        {
            T child = new T();
            return child;
        }

        private float GetCurPage()
        {
            float curPage = (mUIPanelTransform.localPosition.y - mUIPanelStartPos.y) / mUIPanel.GetViewSize().y;

            return Mathf.Abs(curPage);
        }

        private void OnDragStartHandler()
        {
            float curPage = GetCurPage();
            float maxPage = Mathf.Ceil(mDataSource.mDic.Count / mPageChildsCount);

            curPage = Mathf.Min(curPage, maxPage);

            float minIndex = (curPage - 2) * mPageChildsCount - 3;
            float maxIndex = (curPage + 2) * mPageChildsCount + 3;

            bool dragEnabled = mTransformList.Count >= mPageChildsCount;

            for (int i = 0; i < mTransformList.Count; i++)
            {
                Transform transform = mTransformList[i];
                T child = mTransformDic[transform];
                //child.ToggleShow(i >= minIndex && i <= maxIndex);
                child.ToggleShow(true);

                if (child.mIsShow)
                    child.DragEnabled(dragEnabled);
            }
        }

        void DataRefreshHandler()
        {
            foreach (KeyValuePair<K, T> kvp in mChildDic)
            {
                T child = kvp.Value;
                RemoveChild(child);
            }

            mChildDic.Clear();
            mTransformDic.Clear();
            mTransformList.Clear();
            InitCreateView();
        }

        void RemoveChild(T child)
        {
            //child.HideView();
            child.OnRemove();
            child.transform.localPosition = sInitPos;

            if (child.transform != null)
                child.transform.parent = mUIPanelTransform;

            mCacheViewItems.AddLast(child);
        }

        void DataAddHandler(K key, V value)
        {
            LoadView(key, value);
        }

        void DataRemoveHandler(K key, bool update)
        {
            T child = GetChild(key);
            if (child == null)
                return;

            mChildDic.Remove(key);

            if (child.transform == null)
                return;

            mTransformDic.Remove(child.transform);
            RemoveChild(child);

            if (update)
            {
                mUITable.keepWithinPanel = true;
                ResetPosition();
                mUITable.keepWithinPanel = false;
            }
        }

        void DataUpdateHandler(K key, V value, bool updateSort)
        {
            mChildDic[key].UpdateData(value);

            if (updateSort)
                ResetPosition();
        }

        public bool mIsScrollBar = false;
        void ResetPosition()
        {
            if (mUITable.direction == UITable.Direction.Down)
            {
                if (mUIScrollView.verticalScrollBar != null)
                {
                    if (mIsScrollBar)
                        mPrevScrollBarValue = (mUIScrollView.verticalScrollBar as UIScrollBar).value;
                    else
                        mPrevScrollBarValue = mUIScrollView.verticalScrollBar.value;
                }
            }
            else
            {
                if (mUIScrollView.horizontalScrollBar != null)
                {
                    if (mIsScrollBar)
                        mPrevScrollBarValue = (mUIScrollView.horizontalScrollBar as UIScrollBar).value;
                    else
                        mPrevScrollBarValue = mUIScrollView.horizontalScrollBar.value;
                }
            }

            mUITable.repositionNow = true;
        }

        void onReposition()
        {
            mTransformList = mUITable.GetChildList();

            OnDragStartHandler();

            if (mCacheIndex != -1)
            {
                MoveToSelectChildPos(mCacheIndex);
            }

            if (mOnRepositionEvent != null)
            {
                mOnRepositionEvent();
            }
        }

        // 将panel移动到指定的子目标位置
        public void MoveToSelectChildPos(int index, bool tween)
        {
            float fOffsetX = 0f;
            float fOffsetY = 0f;

            if (mUITable.columns > 0)
            {
                Transform trans = mTransformList[0];
                Bounds b = NGUIMath.CalculateRelativeWidgetBounds(trans);
                int nRow = index / mUITable.columns;
                if (index % mUITable.columns > 0)
                {
                    nRow++;
                }
                fOffsetY = (b.size.y + mUITable.padding.y) * nRow;
            }
            else
            {
                for (int i = 0; i < index; i++)
                {
                    Transform trans = mTransformList[i];
                    Bounds b = NGUIMath.CalculateRelativeWidgetBounds(trans);
                    fOffsetY += b.size.y + mUITable.padding.y;
                }
            }

            Vector2 clipOffset = Vector2.zero;
            Vector3 localPosition = Vector3.zero;
            if (tween)
            {

                if (mUITable.direction == UITable.Direction.Down)
                {
                    localPosition = new Vector3(mUIPanelStartPos.x, mUIPanelStartPos.y + fOffsetY, mUIPanelStartPos.z);
                    clipOffset = new Vector2(mUIPanelClipOffset.x, mUIPanelClipOffset.y - fOffsetY);
                }
                else
                {
                    localPosition = new Vector3(mUIPanelStartPos.x, mUIPanelStartPos.y - fOffsetY, mUIPanelStartPos.z);
                    clipOffset = new Vector2(mUIPanelClipOffset.x, mUIPanelClipOffset.y + fOffsetY);
                }

                float maxDistanceDelta = fOffsetY / 30f;

                GameTimer.SetFrameExecute(0.3f, delegate()
                {
                    if (mUIPanelTransform == null)
                        return;
                    mUIPanelTransform.localPosition = Vector2.MoveTowards(mUIPanelTransform.localPosition, localPosition, maxDistanceDelta);
                    mUIPanel.clipOffset = Vector2.MoveTowards(mUIPanel.clipOffset, clipOffset, maxDistanceDelta);
                }, delegate()
                {
                    if (mUIPanelTransform == null)
                        return;
                    mUIPanelTransform.localPosition = localPosition;
                    mUIPanel.clipOffset = clipOffset;
                    OnDragStartHandler();
                }, true);

                return;
            }

            GameTimer.ExecuteTotalFrames(1, delegate()
            {
                mUIPanel.SetDirty();
            });

        }

        private int mCacheIndex;
        public void MoveToSelectChildPos(int index)
        {
            if (mTransformList.Count == 0)
            {
                mCacheIndex = index;
                return;
            }

            mCacheIndex = -1;

            index--;
            if (index < 0)
            {
                index = 0;
            }
            float fOffsetY = 0f;
            if (mUITable.columns > 0)
            {
                Transform trans = mTransformList[0];
                Bounds b = NGUIMath.CalculateRelativeWidgetBounds(trans);
                int nRow = index / mUITable.columns;
                if (index % mUITable.columns > 0)
                {
                    nRow++;
                }
                fOffsetY = (b.size.y + mUITable.padding.y) * nRow;
            }
            else
            {
                for (int i = 0; i < index; i++)
                {
                    Transform trans = mTransformList[i];
                    Bounds b = NGUIMath.CalculateRelativeWidgetBounds(trans);
                    fOffsetY += b.size.y + mUITable.padding.y;
                }
            }
            if (mUITable.direction == UITable.Direction.Down)
            {
                mUIPanelTransform.localPosition = new Vector3(mUIPanelStartPos.x, mUIPanelStartPos.y + fOffsetY, mUIPanelStartPos.z);
                mUIPanel.clipOffset = new Vector2(mUIPanelClipOffset.x, mUIPanelClipOffset.y - fOffsetY);
            }
            else
            {
                mUIPanelTransform.localPosition = new Vector3(mUIPanelStartPos.x, mUIPanelStartPos.y - fOffsetY, mUIPanelStartPos.z);
                mUIPanel.clipOffset = new Vector2(mUIPanelClipOffset.x, mUIPanelClipOffset.y + fOffsetY);
            }
        }

        // 初始化panel的位置
        public void InitPanelPos()
        {
            mUIPanel.transform.localPosition = mUIPanelStartPos;
            mUIPanel.clipOffset = mUIPanelClipOffset;
            SpringPanel spring = mUIPanel.gameObject.GetComponent<SpringPanel>();
            if (spring != null)
            {
                spring.enabled = false;
                spring.target = mUIPanelStartPos;
            }
        }

        private void OnScrollViewItemSelect(ScrollViewItem<V> scrollViewItem)
        {
            Transform transform = scrollViewItem.gameObject.transform;

            foreach (KeyValuePair<Transform, T> kvp in mTransformDic)
            {
                if (kvp.Key != transform && kvp.Value.mSelected)
                {
                    kvp.Value.SetSelect(false);
                    break;
                }
            }
        }

        public void MoveToBottomForChat()
        {
            float fHeight = 0;
            for (int i = 0; i < mTransformList.Count; i++)
            {
                Transform trans = mTransformList[i];
                Bounds b = NGUIMath.CalculateRelativeWidgetBounds(trans);
                fHeight += b.size.y + mUITable.padding.y;
            }

            if (fHeight >= mUIPanel.height)
            {
                UIScrollBar bar = mUIScrollView.verticalScrollBar as UIScrollBar;
                bar.value = 1.0f;
            }
        }
    }
}
