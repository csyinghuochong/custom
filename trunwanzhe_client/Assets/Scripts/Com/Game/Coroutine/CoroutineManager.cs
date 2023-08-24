using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Assets.Scripts.Com.Game.Core;
using UnityEngine;
using Assets.Scripts.Com.Game.Coroutine;

namespace Assets.Scripts.Com.Game.Manager
{
    class CoroutineManager : Singleton<CoroutineManager>
    {
        const int cMaxCount = 10;
        public LinkedList<CoroutineUnit> mCoroutineUnitList { get; private set; }
        LinkedList<CoroutineUnit> mLoadingList = new LinkedList<CoroutineUnit>();
        GameObject mGameObject;

        public void InitCoroutine(GameObject go)
        {
            mGameObject = go;
            mCoroutineUnitList = new LinkedList<CoroutineUnit>();

            for (int i = 0; i < cMaxCount; i++)
            {
                CoroutineUnit unit = mGameObject.AddComponent<CoroutineUnit>();
                mCoroutineUnitList.AddLast(unit);
            }
        }

        public CoroutineUnit GetCoroutine()
        {
            CoroutineUnit unit;

            if (mCoroutineUnitList.Count > 0)
            {
                LinkedListNode<CoroutineUnit> node = mCoroutineUnitList.First;
                unit = node.Value;

                mCoroutineUnitList.RemoveFirst();
            }
            else
            {
                unit = mGameObject.AddComponent<CoroutineUnit>();
            }

            mLoadingList.AddLast(unit);

            //Debug.LogError("GetCoroutine:" + mLoadingList.Count);

            return unit;
        }

        public void CheckLoadingCoroutine()
        {
            if (mLoadingList.Count <= 0)
                return;

            while (mLoadingList.Count > 0)
            {
                LinkedListNode<CoroutineUnit> node = mLoadingList.First;
                CoroutineUnit unit = node.Value;

                if (unit.mCallBack == null)
                {
                    //Debug.LogError("CheckLoadingCoroutine:" + unit.mName);
                    break;
                }
                    

                mLoadingList.RemoveFirst();
                mCoroutineUnitList.AddLast(unit);

                Action callBack = unit.mCallBack;
                unit.mCallBack = null;

                if (callBack != CoroutineUnit.EmptyAction)
                    callBack();
            }
        }
    }
}
