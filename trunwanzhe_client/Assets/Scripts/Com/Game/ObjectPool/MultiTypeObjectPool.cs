using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Assets.Scripts.Com.Game.ObjectPool
{
    class MultiTypeObjectPool<T1, T2> where T2 : new()
    {
        private Dictionary<T1, ObjectPool<T2>> mObjectDict;

        public MultiTypeObjectPool()
        {
            mObjectDict = new Dictionary<T1, ObjectPool<T2>>();
        }

        public T2 Get(T1 key)
        {
            ObjectPool<T2> valueList;
            if (!mObjectDict.TryGetValue(key, out valueList))
            {
                valueList = new ObjectPool<T2>();
                mObjectDict[key] = valueList;
            }

            return valueList.Get(true);
        }

        public void Put(T1 key, T2 value)
        {
            ObjectPool<T2> valueList;
            if (mObjectDict.TryGetValue(key, out valueList))
            {
                valueList.Put(value);
            }
        }

        public void ClearPool()
        {
            if (mObjectDict != null)
            {
                mObjectDict.Clear();
            }
        }

    }
}
