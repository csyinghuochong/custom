using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Assets.Scripts.Com.Game.Core
{
    public class ScrollViewDataSource<K, V>
    {
        public event Action mNumChangeEvent; //数量改变事件
        public event Action mRefreshEvent; //刷新整个列表
        public event Action<K, V> mAddEvent;
        public event Action<K, bool> mRemoveEvent;
        public event Action<K, V, bool> mUpdateEvent;//更新单个列表控件

        public Dictionary<K, V> mDic { get; private set; }
        private List<K> mList { get; set; }
        public int mMaxCount { get; private set; }
        public bool mSortData { get; private set; }

        private Func<V, V, int> mCustomSortFunc;

        public int Count
        {
            get
            {
                return mDic.Count;
            }
        }

        public List<V> GetSortData()
        {
            List<V> list = mDic.Values.ToList();
            list.Sort(delegate(V v1, V v2)
            {
                return mCustomSortFunc(v1, v2);
            });
            return list;
        }

        public void RegisterAction(Action refresh, Action<K, V> add, Action<K, bool> remove, Action<K, V, bool> update)
        {
            mRefreshEvent += refresh;
            mAddEvent += add;
            mRemoveEvent += remove;
            mUpdateEvent += update;
        }

        public void ClearAction(Action refresh, Action<K, V> add, Action<K, bool> remove, Action<K, V, bool> update)
        {
            mRefreshEvent -= refresh;
            mAddEvent -= add;
            mRemoveEvent -= remove;
            mUpdateEvent -= update;
        }

        public ScrollViewDataSource(Func<V, V, int> customSort = null, int maxCount = 0, bool sortData = false)
        {
            mSortData = sortData;
            mDic = new Dictionary<K, V>();
            mList = new List<K>();
            mMaxCount = maxCount;
            mCustomSortFunc = customSort;

            if (maxCount > 0)
            {
                mList = new List<K>();
            }
        }

        public void Refresh()
        {
            if (mRefreshEvent != null)
            {
                mRefreshEvent();
            }
        }

        public void Clear()
        {
            if (mDic != null)
                mDic.Clear();

            if (mList != null)
                mList.Clear();

            Refresh();
        }

        public void Remove(K key)
        {
            InternalRemove(key, true);

            DispatchNumChangeEvent();
        }

        void DispatchNumChangeEvent()
        {
            if (mNumChangeEvent != null)
            {
                mNumChangeEvent();
            }
        }

        private void InternalRemove(K key, bool update = true)
        {
            if (ContainsKey(key))
            {
                mDic.Remove(key);
                mList.Remove(key);

                if (mRemoveEvent != null)
                {
                    mRemoveEvent(key, update);
                }
            }
        }

        //添加或者更新时候重新排序
        public void AddOrUpdateRefreshSort(K key, V value)
        {
            InternalAddOrUpdate(key, value, true);
        }

        //更新或者刷新单个数据对象
        public void AddOrUpdate(K key, V value)
        {
            InternalAddOrUpdate(key, value, false);
        }

        private void InternalAddOrUpdate(K key, V value, bool updateSort)
        {
            if (mSortData)
            {
                (value as ScrollViewVo).mKey = key;
            }

            if (ContainsKey(key))
            {
                mDic[key] = value;

                if (mUpdateEvent != null)
                {
                    mUpdateEvent(key, value, updateSort);
                }
            }
            else
            {
                mList.Add(key);
                mDic[key] = value;

                if (mMaxCount > 0 && mList.Count >= mMaxCount)
                {
                    InternalRemove(mList[0], false);

                    if (mAddEvent != null)
                    {
                        mAddEvent(key, value);
                    }
                }
                else
                {
                    if (mAddEvent != null)
                    {
                        mAddEvent(key, value);
                    }
                }
            }

            DispatchNumChangeEvent();
        }

        public V GetValue(K key)
        {
            V value = default(V);
            mDic.TryGetValue(key, out value);
            return value;
        }

        public bool ContainsKey(K key)
        {
            return mDic.ContainsKey(key);
        }

        public virtual int CustomSort(V v1, V v2)
        {
            if (mCustomSortFunc != null)
                return mCustomSortFunc(v1, v2);

            return 0;
        }

        //设置排序方法
        public bool SetCustomSortFunc(Func<V, V, int> customSort = null)
        {
            if (mCustomSortFunc == customSort)
                return false;

            mCustomSortFunc = customSort;
            return true;
        }
    }
}
