
using System;
using System.Collections.Generic;
using UnityEngine;
using Assets.Scripts.Com.Game.Utils.Timers;

namespace Assets.Scripts.Com.Game.Core
{
    class UIGridExtend<K, V, T>
        where V : ScrollViewVo
        where T : ScrollViewItem<V>, new()
    {
        public UIGrid mUIGrid { get; private set; }
        Transform mUIGridTransform;
        UIScrollView mUIScrollView;
        public UIPanel mUIPanel { get; private set; }
        Transform mUIPanelTransform;
        float mPageChildsCount; //每页显示子对象个数
        Vector3 mUIPanelStartPos; //panel起始位置
        Vector3 mUIPanelRawStartPos; //panel起始位置
        Vector2 mUIPanelClipOffset; //panel裁剪区域

        bool mRollShowMoreGrid = false; //滚动的时候显示更多格子
        bool mShowAllGrid = false;//默认自动切换显示隐藏,true的话则显示全部
        bool mResetPositionUpdatePanel = false;//刷新时更新panel

        ScrollViewDataSource<K, V> mDataSource;
        Dictionary<K, T> mChildDic = new Dictionary<K, T>();
        Dictionary<Transform, T> mTransformDic = new Dictionary<Transform, T>();
        List<Transform> mTransformList = new List<Transform>();
        LinkedList<T> mCacheViewItems = new LinkedList<T>();

        Action mRefreshCallBackHandler;

        private bool mLockRefresh = false;

        public bool IsInitDataSource()
        {
            return mDataSource != null;
        }

        public UIGridExtend(UIGrid grid, ScrollViewDataSource<K, V> dataSource = null)
        {
            mUIGrid = grid;
            mUIGrid.hideInactive = false;
            mUIGridTransform = mUIGrid.transform;
            mUIGrid.onReposition += delegate()
            {
                mUIGridTransform.localPosition = Vector3.zero;
            };

            mUIScrollView = NGUITools.FindInParents<UIScrollView>(mUIGrid.gameObject);
            mUIScrollView.onStoppedMoving += OnStoppedMoving;
            mUIScrollView.onDragFinished += OnDragFinished;
            mUIScrollView.onDragStarted += onDragStarted;
            mUIScrollView.momentumAmount = 100f;

            mUIPanel = mUIScrollView.GetComponent<UIPanel>();
            mUIPanelTransform = mUIPanel.transform;
            mUIPanelStartPos = mUIPanelTransform.localPosition;
            mUIPanelRawStartPos = mUIPanelStartPos;
            mUIPanelClipOffset = mUIPanel.clipOffset;
            mUIPanel.onClipMove = onClipMove;

            InitPageChildCount();
            UpdateDataSource(dataSource);
        }

        public void RollShowMoreGrid(bool value)
        {
            mRollShowMoreGrid = value;
        }

        public void ShowAllGrid(bool value)
        {
            mShowAllGrid = value;
        }

        public Action<Vector2, Vector2, Vector2> mCustomDragAction;
        public void CustomDragAction(Action<Vector2, Vector2, Vector2> action)
        {
            mCustomDragAction = action;

            if (mCustomDragAction != null)
            {
                mUIPanel.onClipMove = null;
            }
            else
            {
                mUIPanel.onClipMove = onClipMove;
            }
        }

        public void ResetPositionUpdatePanel(bool value)
        {
            mResetPositionUpdatePanel = value;
        }

        private int CustomSort(Transform t1, Transform t2)
        {
            return mDataSource.CustomSort(mTransformDic[t1].mData, mTransformDic[t2].mData);
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

            if (mUIGrid.sorting == UIGrid.Sorting.Custom)
                mUIGrid.onCustomSort = CustomSort;

            DataRefreshHandler();
        }

        private SpringPanel mSpringPanel;
        private void InitCreateView()
        {
            mUIPanelTransform.localPosition = mUIPanelStartPos;
            mUIPanel.clipOffset = mUIPanelClipOffset;
            //mUIGridTransform.localPosition = Vector3.zero;

            SpringPanel springPanel = mUIPanel.GetComponent<SpringPanel>();
            if (springPanel != null)
            {
                springPanel.target = mUIPanelStartPos;
                springPanel.enabled = false;
            }

            int index = 0;
            int count = mDataSource.mDic.Count;

            if (mDataSource.mSortData)
            {
                List<V> list = mDataSource.GetSortData();
                for (int i = 0, len = list.Count; i < len; i++)
                {
                    V value = list[i];
                    LoadView((K)value.mKey, value, ++index, count);
                }
            }
            else
            {
                foreach (KeyValuePair<K, V> kvp in mDataSource.mDic)
                {
                    LoadView(kvp.Key, kvp.Value, ++index, count);
                }
            }

            //以免数据为空，不会执行回调...
            if (mDataSource.mDic.Count == 0)
            {
                ExecuteRefreshCallBackHandler();
                mLockRefresh = false;
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
            child.mCustomDragAction = mCustomDragAction;

            child.InitContainer(ChildLoadComplete(child, key, index, count), value, OnScrollViewItemSelect, index);
        }

        private Action ChildLoadComplete(T child, K key, int index = 0, int count = 0)
        {
            return delegate()
            {
                Transform transform = child.transform;
                mTransformDic[transform] = child;
                child.HideView();
                transform.parent = mUIGridTransform;
                transform.localScale = Vector3.one;
                transform.localPosition = Vector3.zero;
                child.gameObject.name = key.ToString();

                if (index == count)
                {
                    ExecuteRefreshCallBackHandler();
                    ResetPosition();
                    mLockRefresh = false;
                }
                else if (index == mPageChildsCount)
                {
                    ExecuteRefreshCallBackHandler();
                    ResetPosition();
                }
            };
        }

        public T GetChildInCache(K key)
        {
            T child = GetChild(key);

            if (mDataSource != null)
            {
                V data = mDataSource.GetValue(key);
                if (child == null && data != null)
                {
                    LinkedListNode<T> node = mCacheViewItems.First;

                    for (; node != null; node = node.Next)
                    {
                        if (node.Value.mData == data)
                        {
                            child = node.Value;
                            break;
                        }
                    }
                }
            }

            return child;
        }

        public int GetChildNum()
        {
            return mTransformList.Count;
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

        float mHeightCount = 1;
        float mWdithCount = 1;
        int mMinPageChildsCount = 1;
        private void InitPageChildCount()
        {
            if (mUIGrid.cellHeight != 0)
            {
                mHeightCount = mUIPanel.GetViewSize().y / mUIGrid.cellHeight;
            }

            if (mUIGrid.cellWidth != 0)
            {
                mWdithCount = mUIPanel.GetViewSize().x / mUIGrid.cellWidth;
            }

            mPageChildsCount = Mathf.Ceil(mHeightCount * mWdithCount);
            mMinPageChildsCount = Mathf.FloorToInt(mHeightCount * mWdithCount);
            //Debug.LogError(string.Format("mHeightCount:{0},mWdithCount:{1},mPageChildsCount:{2}", mHeightCount, mWdithCount, mPageChildsCount));
        }

        void AddBound(bool add)
        {
            if (add)
            {
                if (mUIScrollView.movement == UIScrollView.Movement.Vertical)
                {
                    if (mUIPanelTransform.localPosition.y > mUIPanelStartPos.y)
                        return;
                }
                else
                {
                    if (mUIPanelTransform.localPosition.x < mUIPanelStartPos.x)
                        return;
                }
            }

            if (mTransformList.Count > 0 && mTransformList.Count <= mMinPageChildsCount)
            {
                Transform transform = mTransformList[0];
                T child = mTransformDic[transform];
                child.AddBound(add, (int)mUIPanel.GetViewSize().x, (int)mUIPanel.GetViewSize().y);
            }
        }

        private bool mDragMove = false;
        void onDragStarted()
        {
            mDragMove = false;

            AddBound(false);
        }

        void OnDragFinished()
        {
            mDragMove = true;

            AddBound(true);
        }

        void OnStoppedMoving()
        {
            mDragMove = false;

            mUIPanelStartPos.x = Mathf.Max(mUIPanelStartPos.x, mUIPanelTransform.localPosition.x);
            mUIPanelStartPos.y = Mathf.Min(mUIPanelStartPos.y, mUIPanelTransform.localPosition.y);

            OnDragStartHandler(true);

            AddBound(false);
        }

        protected void onClipMove(UIPanel panel)
        {
            OnDragStartHandler();

            AddBound(true);

            if (mDragMove)
            {
                if (mSpringPanel == null)
                {
                    mSpringPanel = mUIPanel.GetComponent<SpringPanel>();
                }

                if (mSpringPanel != null)
                {
                    if (mSpringPanel.target == mUIPanelStartPos)
                    {
                        mSpringPanel.target = mUIPanelRawStartPos;
                    }
                }
            }
        }

        private void OnDragStartHandler(bool forceHide = false)
        {
            //Debug.LogError("OnDragStartHandler:" + forceHide + "     " + this.GetHashCode());

            float hideCell = 0;
            float hideCellCount = 0;
            float addCellCount = 0;

            if (mUIScrollView.movement == UIScrollView.Movement.Vertical)
            {
                hideCell = Mathf.Floor((mUIPanelTransform.localPosition.y - mUIPanelStartPos.y) / mUIGrid.cellHeight);
                hideCell = Mathf.Max(hideCell, 0);

                addCellCount = Mathf.Floor(mWdithCount);
                hideCellCount = hideCell * addCellCount;
            }
            else
            {
                hideCell = Mathf.Floor((mUIPanelStartPos.x - mUIPanelTransform.localPosition.x) / mUIGrid.cellWidth);
                hideCell = Mathf.Max(hideCell, 0);

                addCellCount = Mathf.Floor(mHeightCount);
                hideCellCount = hideCell * addCellCount;
            }

            //Debug.LogError(string.Format("hideCell:{0},addCellCount:{1},hideCellCount:{2}", hideCell, addCellCount, hideCellCount));

            if (mRollShowMoreGrid)
            {
                addCellCount *= 2;
            }

            float showPageChildsCount = mPageChildsCount;
            if (forceHide == false)
            {
                showPageChildsCount *= 2.0f;
            }

            float minIndex = hideCellCount - addCellCount;
            float maxIndex = hideCellCount + showPageChildsCount + addCellCount;

            int transformCount = mTransformList.Count;

            if (maxIndex > transformCount)
            {
                maxIndex = transformCount;
                minIndex = maxIndex - showPageChildsCount - addCellCount;
            }

            for (int i = 0; i < transformCount; i++)
            {
                Transform transform = mTransformList[i];
                T child = mTransformDic[transform];

                if (forceHide)
                {
                    child.ToggleShow((i >= minIndex && i <= maxIndex) || mShowAllGrid);
                }
                else
                    child.ToggleShow((i >= minIndex && i <= maxIndex) || child.mUIDragScrollViewItem.mOnDrag);
            }

        }

        void DataRefreshHandler()
        {
            if (mLockRefresh)
                return;

            mLockRefresh = true;

            RemoveAllChild();
            InitCreateView();
        }

        public void RemoveAllChild()
        {
            foreach (KeyValuePair<K, T> kvp in mChildDic)
            {
                T child = kvp.Value;
                RemoveChild(child);
            }

            mChildDic.Clear();
            mTransformDic.Clear();
            mTransformList.Clear();
        }

        void RemoveChild(T child)
        {
            child.HideView();
            child.OnRemove();
            child.transform.parent = mUIPanelTransform;
            mCacheViewItems.AddLast(child);
        }

        void DataAddHandler(K key, V value)
        {
            LoadView(key, value);
        }

        void DataRemoveHandler(K key, bool update)
        {
            T child = mChildDic[key];
            mChildDic.Remove(key);

            mTransformDic.Remove(child.transform);
            RemoveChild(child);

            if (update)
            {
                mUIGrid.keepWithinPanel = true;
                ResetPosition();
                mUIGrid.keepWithinPanel = false;
            }
        }

        void DataUpdateHandler(K key, V value, bool updateSort)
        {
            mChildDic[key].UpdateData(value);

            if (updateSort)
                ResetPosition();
        }

        void ResetPosition()
        {
            mUIGrid.Reposition();
            mTransformList = mUIGrid.GetChildList();

            OnDragStartHandler();

            if (mResetPositionUpdatePanel)
            {
                InitPanelPos();
                mUIPanel.SetDirty();
            }
        }

        // 将panel移动到指定的子目标位置
        public void MoveToSelectChildPos(int index, bool tween = false)
        {
            float fOffsetX = mUIGrid.cellWidth * (index - 1);
            float fOffsetY = mUIGrid.cellHeight * (index - 1);

            Vector2 clipOffset = Vector2.zero;
            Vector3 localPosition = Vector3.zero;

            if (mUIScrollView.movement == UIScrollView.Movement.Horizontal)
            {
                localPosition = new Vector3(mUIPanelStartPos.x - fOffsetX, mUIPanelStartPos.y, mUIPanelStartPos.z);
                clipOffset = new Vector2(mUIPanelClipOffset.x + fOffsetX, mUIPanelClipOffset.y);
            }
            else if (mUIScrollView.movement == UIScrollView.Movement.Vertical)
            {
                localPosition = new Vector3(mUIPanelStartPos.x, mUIPanelStartPos.y + fOffsetY, mUIPanelStartPos.z);
                clipOffset = new Vector2(mUIPanelClipOffset.x, mUIPanelClipOffset.y - fOffsetY);
            }

            if (tween)
            {
                float maxDistanceDelta = mUIGrid.cellWidth / 30f;

                GameTimer.SetFrameExecute(0.5f, delegate()
                {
                    mUIPanelTransform.localPosition = Vector2.MoveTowards(mUIPanelTransform.localPosition, localPosition, maxDistanceDelta);
                    //mUIPanel.clipOffset = Vector2.MoveTowards(mUIPanel.clipOffset, clipOffset, maxDistanceDelta);
                }, delegate()
                {
                    mUIPanelTransform.localPosition = localPosition;
                    mUIPanel.clipOffset = clipOffset;
                    OnDragStartHandler();
                }, true);
                return;
            }

            mUIPanelTransform.localPosition = localPosition;
            mUIPanel.clipOffset = clipOffset;

            //Debug.LogError(string.Format("clipOffset:{0},localPosition:{1},code:{2}", mUIPanel.clipOffset, mUIPanelTransform.localPosition, this.GetHashCode()));

            OnDragStartHandler();

            if (mCustomDragAction != null)
            {
                mUIPanelTransform.localPosition = localPosition;
                mUIPanel.clipOffset = clipOffset;
            }

            GameTimer.ExecuteTotalFrames(1, delegate()
            {
                mUIPanel.SetDirty();
            });

        }

        public void MoveToSelectChildPosSpecial(int index)
        {
            index--;
            if (index < 0)
            {
                index = 0;
            }

            float fOffsetX = 0f;
            float fOffsetY = 0f;
            if (mUIGrid.arrangement == UIGrid.Arrangement.Horizontal)
            {
                if (mUIGrid.maxPerLine > 0)
                {
                    int nRow = index / mUIGrid.maxPerLine;
                    //if (index % mUIGrid.maxPerLine > 0)
                    //{
                    //    nRow++;
                    //}
                    fOffsetY = mUIGrid.cellHeight * nRow;
                }
                else
                {
                    fOffsetX = mUIGrid.cellWidth * index;
                }
            }
            else if (mUIGrid.arrangement == UIGrid.Arrangement.Vertical)
            {
                if (mUIGrid.maxPerLine > 0)
                {
                    int nRow = index / mUIGrid.maxPerLine;
                    //if (index % mUIGrid.maxPerLine > 0)
                    //{
                    //    nRow++;
                    //}
                    fOffsetX = mUIGrid.cellHeight * nRow;
                }
                else
                {
                    fOffsetY = mUIGrid.cellHeight * index;
                }
            }

            if (fOffsetX > 0)
            {
                mUIPanel.clipOffset = new Vector2(mUIPanelClipOffset.x + fOffsetX, mUIPanelClipOffset.y);
                mUIPanelTransform.localPosition = new Vector3(mUIPanelStartPos.x - fOffsetX, mUIPanelStartPos.y, mUIPanelStartPos.z);
            }
            else if (fOffsetY > 0)
            {
                mUIPanel.clipOffset = new Vector2(mUIPanelClipOffset.x, mUIPanelClipOffset.y - fOffsetY);
                mUIPanelTransform.localPosition = new Vector3(mUIPanelStartPos.x, mUIPanelStartPos.y + fOffsetY, mUIPanelStartPos.z);
            }
        }

        // 初始化panel的位置
        public void InitPanelPos()
        {
            mUIPanel.transform.localPosition = mUIPanelRawStartPos;
            mUIPanel.clipOffset = mUIPanelClipOffset;
            mUIScrollView.DisableSpring();
            //SpringPanel spring = mUIPanel.gameObject.GetComponent<SpringPanel>();
            //if (spring != null)
            //{
            //    spring.enabled = false;
            //    spring.target = mUIPanelRawStartPos;
            //}

            mUIScrollView.currentMomentum = Vector3.zero;
        }

        /// <summary>
        /// 改变排序
        /// </summary>
        /// <param name="customSort"></param>
        public void SetDataSourceSort(Func<V, V, int> customSort = null)
        {
            if (mDataSource != null)
            {
                if (mDataSource.SetCustomSortFunc(customSort))
                    ResetPosition();
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


        private Vector3 mUIPanelFinalPos = Vector3.zero;
     
    }
}
