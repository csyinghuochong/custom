using System;
using System.Collections.Generic;
using Assets.Scripts.Com.Game.Utils;
using UnityEngine;

namespace Assets.Scripts.Com.Game.Loader
{
    enum DontDestoryType
    {
        Destory,
        Auto,
        Never
    }

    class AssetUnit
    {
        public AssetType mAssetType;
        //public string mDirectory;
        public string mAssetName;
        public string mDicKey;

        public bool mPack = false;

        public GameObject mMeshFilterGameObject;
        UnityEngine.Object mMainAsset;
        public Dictionary<Type, List<string>> mComponentDependAssetDic = new Dictionary<Type, List<string>>();
        public Dictionary<AssetType, HashSet<string>> mDependAssetDic = new Dictionary<AssetType, HashSet<string>>();
        public HashSet<AssetUnit> mDependAssetUnitSet = new HashSet<AssetUnit>();
        public int mDependAssetUnitCount = 0;
        private List<UnityEngine.Object> mInstanceList = new List<UnityEngine.Object>();

        public int mReference { get; private set; }

        bool mResourceAssets;

        public void Dispose()
        {
            //Debug.LogError(string.Format("---AssetUnit Dispose mAssetName:{0}",mAssetName));

            mComponentDependAssetDic.Clear();
            mDependAssetDic.Clear();
            mDependAssetUnitSet.Clear();
            mInstanceList.Clear();

            mMeshFilterGameObject = null;

            if (mResourceAssets)
            {
                mMainAsset = null;
            }
            else
                GameObject.DestroyImmediate(mMainAsset, true);
        }

        public void DontDestory()
        {
            GameObject.DontDestroyOnLoad(mMainAsset);
        }

        public void AddDependAsset(AssetType type, List<string> list)
        {
            mComponentDependAssetDic[AssetTypeTools.GetComponentType(type)] = list;

            HashSet<string> set = new HashSet<string>();
            foreach (string str in list)
            {
                set.Add(str);
            }
            mDependAssetDic[type] = set;
        }

        public void SetMainAsset(UnityEngine.Object obj, bool resourceAssets = false)
        {
            mResourceAssets = resourceAssets;

            if (mAssetType == AssetType.UISprite || mAssetType == AssetType.UILabel)
            {
                mMainAsset = GameObjectUtil.Instantiate(obj);
            }
            else if (mAssetType == AssetType.MeshFilter)
            {
                mMeshFilterGameObject = GameObjectUtil.Instantiate(obj) as GameObject;
                mMeshFilterGameObject.SetActive(false);
                mMainAsset = mMeshFilterGameObject.GetComponent<MeshFilter>();
            }
            else
                mMainAsset = obj;

            mMainAsset.name = mAssetName;

            //GameObject.DontDestroyOnLoad(mMainAsset);
        }

        public UnityEngine.Object GetMainAsset()
        {
            if (mAssetType == AssetType.UIPrefab || mAssetType == AssetType.ExternalPrefab)
            {
                if (mMainAsset)
                {
                    GameObject go = GameObjectUtil.Instantiate(mMainAsset) as GameObject;
                    go.name = mAssetName;
                    return go;
                }

            }

            return mMainAsset;
        }

        UIAtlas mUIAtlas;
        public UIAtlas GetUIAtlas()
        {
            if (mUIAtlas == null)
            {
                mUIAtlas = ((GameObject)(mMainAsset)).GetComponentInChildren<UIAtlas>();

                (mMainAsset as GameObject).SetActive(false);
            }

            return mUIAtlas;
        }

        UIFont mUIFont;
        public UIFont GetUIFont()
        {
            if (mUIFont == null)
            {
                mUIFont = ((GameObject)(mMainAsset)).GetComponentInChildren<UIFont>();

                (mMainAsset as GameObject).SetActive(false);
            }

            return mUIFont;
        }

        public static int sDefaultDepth = 150;
        public static int sInitDepth = sDefaultDepth;
        int mFontDepth = 0;
        public int GetFontDepth()
        {
            if (mFontDepth == 0)
            {
                mFontDepth = ++sInitDepth;
            }

            return mFontDepth;
        }

        public void AddReference()
        {
            mReference++;
        }

        public void ReduceReference()
        {
            mReference--;
        }

        public void AddDependUnit(AssetUnit unit)
        {
            mDependAssetUnitSet.Add(unit);
        }

        public Action<AssetUnit> mAddDependUnitCompleteCallBack;
        public bool CheckAddDependUnitComplete()
        {
            return mDependAssetUnitSet.Count >= mDependAssetUnitCount;
        }

        public void AddDependUnitReference(UnityEngine.Object obj)
        {
            if (obj == null || mAssetType != AssetType.UIPrefab)
                return;

            mInstanceList.Add(obj);
            AddReference();

            foreach (AssetUnit unit in mDependAssetUnitSet)
            {
                unit.AddReference();
            }
        }

        public void ReduceDependUnitReference()
        {
            int count = mInstanceList.Count;
            if (count <= 0)
                return;

            for (int i = 0; i < count; i++)
            {
                if (mInstanceList[i] == null)
                {
                    ReduceReference();

                    foreach (AssetUnit unit in mDependAssetUnitSet)
                    {
                        unit.ReduceReference();
                    }
                }
            }
        }

        public int mClearID { get; private set; }
        public void SetClearID(int clearID)
        {
            mClearID = clearID;

            foreach (AssetUnit unit in mDependAssetUnitSet)
            {
                unit.SetClearID(clearID);
            }
        }

        public DontDestoryType mDontDestory { get; private set; }
        public void SetDontDestory(DontDestoryType type, bool checkClearID = false)
        {
            mDontDestory = type;

            foreach (AssetUnit unit in mDependAssetUnitSet)
            {
                if (!checkClearID || mClearID >= unit.mClearID)
                    unit.SetDontDestory(type, checkClearID);
            }
        }
    }
}
