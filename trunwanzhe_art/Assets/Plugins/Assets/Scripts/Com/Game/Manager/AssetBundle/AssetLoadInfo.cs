using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Assets.Plugins.Assets.Scripts.Com.Game.Manager
{
    public class AssetLoadInfo
    {
        List<int> mWaitList = new List<int>();
        List<int> mLoadedList = new List<int>();

        private Action mUpdate;

        public float GetWaitCount()
        {
            return (float)mWaitList.Count;
        }

        public float GetLoadedCount()
        {
            return (float)mLoadedList.Count;
        }

        public AssetLoadInfo(Action update)
        {
            this.mUpdate = update;
        }

        public void AddWait(int id)
        {
            if (!mWaitList.Contains(id))
                mWaitList.Add(id);
        }

        public void AddLoaded(int id)
        {
            if (mWaitList.Contains(id))
            {
                mLoadedList.Add(id);

                mUpdate();
            }
        }

        public void Clear()
        {
            mWaitList.Clear();
            mLoadedList.Clear();
        }
    }
}
