using System;
using System.Collections.Generic;
using System.Linq;
using Assets.Scripts.Com.Game.Core;
using UnityEngine;
using Assets.Scripts.Com.Game.Manager;
using Assets.Plugins.Assets.Scripts.Com.Game.Manager;
using System.Collections;
using Assets.Scripts.Com.Game.Mono.Utils;
using Assets.Scripts.Com.Game.Config;
using System.IO;
using Assets.Scripts.Com.Game.Coroutine;
using Assets.Plugins.Assets.Scripts.Com.Game.Utils;
using Assets.Scripts.Com.Game.Utils;

namespace Assets.Scripts.Com.Game.Loader
{
    class AssetLoader : Singleton<AssetLoader>, ITick
    {
        const string cAssetBundlePostfix = ".bytes";
        private const string cNIL = "nil";

        const string cDependMeshs = "DependMeshs";
        const string cDependTextures = "DependTextures";

        Dictionary<string, string> mUIDependDic;
        Dictionary<string, AssetUnit> mUIAssetUnitDic = new Dictionary<string, AssetUnit>();

        Dictionary<string, string> mExternalDependDic;
        Dictionary<string, AssetUnit> mExternalAssetUnitDic = new Dictionary<string, AssetUnit>();

        Dictionary<UnityEngine.Object, AssetUnit> mAssetUnitObjectDic = new Dictionary<UnityEngine.Object, AssetUnit>();

        LinkedList<AssetRequestBase> mUILoaderRequestList = new LinkedList<AssetRequestBase>();
        LinkedList<AssetRequestBase> mExternalLoaderRequestList = new LinkedList<AssetRequestBase>();

        List<AssetRequestBase> mUILoaderRequestCache = new List<AssetRequestBase>();
        List<AssetRequestBase> mExternalLoaderRequestCache = new List<AssetRequestBase>();

     
        private CoroutineManager mCoroutineManager = CoroutineManager.Instance;

        Type mComponentUISpriteType;
        Type mComponentUILabelType;
        Type mComponentUITextureType;
        Type mComponentMeshRendererType;
        Type mComponentParticleSystemRendererType;
        Type mComponentTrailRendererType;
        Type mComponentSkinnedMeshRendererType;
        Type mComponentMeshFilterType;
        Type mComponentTextureType;

        static int sLoadMaxCount;
        static float sDeltaTime;
        static float sTickTime;

        public AssetLoader()
        {
            mComponentUISpriteType = AssetTypeTools.GetComponentType(AssetType.UISprite);
            mComponentUILabelType = AssetTypeTools.GetComponentType(AssetType.UILabel);
            mComponentUITextureType = AssetTypeTools.GetComponentType(AssetType.UITexture);
            mComponentMeshRendererType = AssetTypeTools.GetComponentType(AssetType.MeshRenderer);
            mComponentParticleSystemRendererType = AssetTypeTools.GetComponentType(AssetType.ParticleSystemRenderer);
            mComponentTrailRendererType = AssetTypeTools.GetComponentType(AssetType.TrailRenderer);
            mComponentSkinnedMeshRendererType = AssetTypeTools.GetComponentType(AssetType.SkinnedMeshRenderer);
            mComponentMeshFilterType = AssetTypeTools.GetComponentType(AssetType.MeshFilter);
            mComponentTextureType = AssetTypeTools.GetComponentType(AssetType.Texture);

            StartHighSpeed();
        }

        static bool mIsHighSpeed = false;
        public static void StartHighSpeed()
        {
            mIsHighSpeed = true;

            sLoadMaxCount = 300;
            sDeltaTime = 0.25f;
            sTickTime = 0.04f;
        }

        public static void EndHighSpeed()
        {
            mIsHighSpeed = false;

            NormalSpeed();
        }

        public static void NormalSpeed()
        {
            sLoadMaxCount = 2;
            sDeltaTime = 0.01f;
            sTickTime = 0.04f;
        }

        static bool mIsViewOpenSpeed = false;
        static int mViewShowSpeedFrame;
        public static void ViewShowSpeed()
        {
            if (mIsHighSpeed)
                return;

           
            mIsViewOpenSpeed = true;

            //sLoadMaxCount = 30;
            //sDeltaTime = 0.2f;
            //sTickTime = 0.04f;
            mViewShowSpeedFrame = Time.frameCount;
        }

        public static void ViewHideSpeed()
        {
            if (mIsHighSpeed || Time.frameCount - mViewShowSpeedFrame < 15)
                return;

            if (mIsViewOpenSpeed)
            {
                mIsViewOpenSpeed = false;
            }
        }

        public bool isLoading { get { return this.GetLoaderRequestList().Count > 0; } }

        public bool DirectGetAssetUnit()
        {
            return true;//mIsHighSpeed|| mIsViewOpenSpeed;
        }

        LinkedList<AssetRequestBase> GetLoaderRequestList()
        {
            if (mUILoaderRequestCache.Count > 0)
            {
                for (int i = 0, count = mUILoaderRequestCache.Count; i < count; i++)
                {
                    mUILoaderRequestList.AddLast(mUILoaderRequestCache[i]);
                }

                mUILoaderRequestCache.Clear();
            }

            if (mExternalLoaderRequestCache.Count > 0)
            {
                for (int i = 0, count = mExternalLoaderRequestCache.Count; i < count; i++)
                {
                    mExternalLoaderRequestList.AddLast(mExternalLoaderRequestCache[i]);
                }

                mExternalLoaderRequestCache.Clear();
            }

            if (mUILoaderRequestList.Count > 0)
            {
                return mUILoaderRequestList;
            }

            return mExternalLoaderRequestList;
        }

        public void OnTick()
        {
            mCoroutineManager.CheckLoadingCoroutine();

            if (Time.deltaTime > sTickTime)
                return;

            int i = 0;

            float startTime = Time.realtimeSinceStartup;
            int maxCount = sLoadMaxCount;
            float deltaTime = sDeltaTime;

            while (true)
            {
                LinkedList<AssetRequestBase> loaderRequestList = GetLoaderRequestList();

                if (mIsViewOpenSpeed && loaderRequestList == mUILoaderRequestList)
                {
                    maxCount = 30;
                    deltaTime = 0.2f;
                }

                if (loaderRequestList.Count <= 0 || i++ >= maxCount)
                {
                    break;
                }

                if (Time.realtimeSinceStartup - startTime > deltaTime)
                    return;

                LinkedListNode<AssetRequestBase> node = loaderRequestList.First;
                loaderRequestList.Remove(node);

                if (node.Value is AssetRequestGeneral)
                {
                    AssetRequestGeneral loaderRequest = node.Value as AssetRequestGeneral;

                    //Debug.LogError("AssetRequestGeneral.directory:" + loaderRequest.directory + "   " + Time.frameCount);

                    switch (loaderRequest.assetType)
                    {
                        case AssetType.AudioClip:
                            //loaderRequest.Execute(LoadAudioClip(loaderRequest.directory, loaderRequest.assetName));
                            WWWLoadAudioClip(loaderRequest.directory, loaderRequest.assetName, loaderRequest.Execute);
                            break;
                        case AssetType.UIIcon:
                            WWWLoadTexture(loaderRequest.directory, loaderRequest.assetName, loaderRequest.assetType, loaderRequest.Execute);
                            break;
                        case AssetType.UITexture:
                            loaderRequest.Execute(LoadTexture(loaderRequest.directory, loaderRequest.assetName, loaderRequest.assetType));
                            break;
                        case AssetType.UIPrefab:
                            //loaderRequest.Execute(LoadUIGameObject(loaderRequest.directory, loaderRequest.assetName));
                            LoadUIGameObject2(loaderRequest.directory, loaderRequest.assetName, loaderRequest.Execute);
                            break;
                        case AssetType.ExternalPrefab:

                            if (loaderRequest.HasCallBack())
                            {
                                LoadExternalGameObject2(loaderRequest.directory, loaderRequest.assetName, loaderRequest.Execute);
                            }
                            else
                            {
                                LoadExternalGameObject2(loaderRequest.directory, loaderRequest.assetName, null);
                            }

                            //loaderRequest.Execute(LoadExternalGameObject(loaderRequest.directory, loaderRequest.assetName));
                            break;
                    }
                }
                else if (node.Value is AssetUnitRequest)
                {
                    AssetUnitRequest loaderRequest = node.Value as AssetUnitRequest;

                    //Debug.LogError("AssetUnitRequest.directory:" + loaderRequest.directory + "   " + Time.frameCount);

                    if (DirectGetAssetUnit())
                    {
                        loaderRequest.callBack(GetAssetUnit(loaderRequest.directory, loaderRequest.assetName, loaderRequest.assetType, loaderRequest.assetDependDic, loaderRequest.assetUnitDic));
                    }
                    else
                    {
                        WWWGetAssetUnit(loaderRequest.directory, loaderRequest.assetName, loaderRequest.assetType, loaderRequest.assetDependDic, loaderRequest.assetUnitDic, loaderRequest.Execute);
                    }

                }
                else if (node.Value is ActionRequest)
                {
                    //Debug.LogError("---ActionRequest  " + Time.frameCount);

                    ActionRequest loaderRequest = node.Value as ActionRequest;
                    if (DirectGetAssetUnit())
                    {
                        loaderRequest.callBack();
                    }
                    else
                    {
                        mCoroutineManager.GetCoroutine().mCallBack = loaderRequest.callBack;
                    }
                }
            }

            if (mIsViewOpenSpeed)
            {
                ViewHideSpeed();
            }
        }

        public void ClearLoaderRequestList()
        {
            mUILoaderRequestCache.Clear();
            mExternalLoaderRequestCache.Clear();

            mUILoaderRequestList.Clear();
            mExternalLoaderRequestList.Clear();
        }

        //缓存资源，不随场景切换而释放
        public void DontDestoryAssetUnit(UnityEngine.Object obj, DontDestoryType type = DontDestoryType.Auto)
        {
            AssetUnit assetUnit;
            if (mAssetUnitObjectDic.TryGetValue(obj, out assetUnit))
            {
                assetUnit.SetDontDestory(type);
            }
        }

        public bool IsBattleScene()
        {
            return false;
        }

        private int mClearID = 0;
        public void ClearAssetUnitObject()
        {
            bool battleScene = IsBattleScene();
            if (battleScene)
            {
                mClearID++;
            }

            foreach (KeyValuePair<UnityEngine.Object, AssetUnit> kvp in mAssetUnitObjectDic)
            {
                DontDestoryType type = kvp.Value.mDontDestory;
                AssetUnit assetUnit = kvp.Value;
                if (type != DontDestoryType.Destory)
                {
                    assetUnit.SetDontDestory(type);

                    if (battleScene && type == DontDestoryType.Auto)
                    {
                        assetUnit.SetClearID(mClearID);
                    }
                }
            }
            mAssetUnitObjectDic.Clear();
        }

        public void ClearUI()
        {
            Clear(mUIAssetUnitDic);
        }

        public void ClearExternal()
        {
            Clear(mExternalAssetUnitDic);
        }

        private void Clear(Dictionary<string, AssetUnit> assetUnitDic)
        {
            bool battleScene = IsBattleScene();

            foreach (AssetUnit assetUnit in assetUnitDic.Values)
            {
                assetUnit.ReduceDependUnitReference();

                if (battleScene && assetUnit.mDontDestory == DontDestoryType.Auto && assetUnit.mClearID != mClearID)
                {
                    assetUnit.SetDontDestory(DontDestoryType.Destory, true);
                }
            }

            foreach (AssetUnit assetUnit in assetUnitDic.Values.ToList())
            {
                if (assetUnit.mReference <= 0 && assetUnit.mDontDestory == DontDestoryType.Destory)
                {
                    assetUnit.Dispose();
                    assetUnitDic.Remove(assetUnit.mDicKey);
                }
                else
                {
                    assetUnit.DontDestory();
                    //assetUnit.UnSetDontDestory();

                    //Debug.LogError("-----------assetUnit:" + assetUnit.mAssetName + "   reference:" + assetUnit.mReference + "  type:" + assetUnit.mAssetType);
                }
            }
        }

        public void SetUIDepend(Dictionary<string, string> dic)
        {
            mUIDependDic = dic;
            mUIDependDic[cDependTextures] = string.Format("{0}/", cDependTextures);
        }

        public void SetExternalDepend(Dictionary<string, string> dic)
        {
            mExternalDependDic = dic;
            string format = "External/{0}/";
            mExternalDependDic[cDependMeshs] = string.Format(format, cDependMeshs);
            mExternalDependDic[cDependTextures] = string.Format(format, cDependTextures);
        }

        string GetDependAssets(string assetNameKey, Dictionary<string, string> dependDic)
        {
            string depend = "";
            if (dependDic != null)
                dependDic.TryGetValue(assetNameKey, out depend);
            return depend;
        }

        string GetAssetKey(string assetName, AssetType assetType)
        {
            return AssetTypeTools.GetAssetKey(assetName, assetType);
        }

        AssetUnit GetAssetUnit(string assetName, AssetType assetType, Dictionary<string, AssetUnit> assetUnitDic)
        {
            AssetUnit unit;
            string assetNameKey = GetAssetKey(assetName, assetType);
            assetUnitDic.TryGetValue(assetNameKey, out unit);

            return unit;
        }

        const Char Split1 = '#';
        const Char Split2 = ':';
        const Char Split3 = ',';
        void CollectDepend(AssetUnit unit, string assetName, AssetType assetType, Dictionary<string, string> assetDependDic, Dictionary<string, AssetUnit> assetUnitDic, Action lastCallBack = null, Action firstCallBack = null, Action addDependUnitCompleteCallBack = null)
        {
            bool hasCallBack = firstCallBack != null || lastCallBack != null || addDependUnitCompleteCallBack != null;

            AddFirstCallBack(firstCallBack, assetType);

            AssetUnitRequest lastAssetUnitRequet = null;

            string assetNameKey = GetAssetKey(assetName, assetType);
            string dependAssetsStr = GetDependAssets(assetNameKey, assetDependDic);
            if (string.IsNullOrEmpty(dependAssetsStr) == false)
            {
                string[] dependTypeList = dependAssetsStr.Split(Split1);

                for (int i = 0; i < dependTypeList.Length; i++)
                {
                    string[] str = dependTypeList[i].Split(Split2);
                    string type = str[0];
                    string value = str[1];
                    if (value != cNIL)
                    {
                        unit.AddDependAsset((AssetType)System.Enum.Parse(typeof(AssetType), type), value.Split(Split3).ToList());
                    }
                }

                Dictionary<AssetType, HashSet<string>> dependAssetDic = unit.mDependAssetDic;
                foreach (KeyValuePair<AssetType, HashSet<string>> kvp in dependAssetDic)
                {
                    string directory;

                    if (kvp.Key == AssetType.MeshFilter)
                    {
                        directory = assetDependDic[cDependMeshs];
                    }
                    else if (kvp.Key == AssetType.Texture)
                    {
                        directory = assetDependDic[cDependTextures];
                    }
                    else
                    {
                        directory = assetDependDic[cDependTextures];
                    }

                    HashSet<string> set = kvp.Value;
                    foreach (string str in set)
                    {
                        if (string.IsNullOrEmpty(str) == false && str != cNIL)
                        {
                            string unitDirectory = directory + str + cAssetBundlePostfix;
                            string unitName = str;

                            if (hasCallBack == false)
                            {
                                AssetUnit dependUnit = GetAssetUnit(unitDirectory, unitName, kvp.Key, assetDependDic, assetUnitDic);
                                unit.AddDependUnit(dependUnit);
                            }
                            else
                            {
                                lastAssetUnitRequet = new AssetUnitRequest();
                                lastAssetUnitRequet.directory = unitDirectory;
                                lastAssetUnitRequet.assetName = unitName;
                                unit.mDependAssetUnitCount++;

                                lastAssetUnitRequet.callBack = delegate(AssetUnit dependUnit)
                                {
                                    unit.AddDependUnit(dependUnit);

                                    if (addDependUnitCompleteCallBack != null && unit.CheckAddDependUnitComplete())
                                    {
                                        addDependUnitCompleteCallBack();
                                    }
                                };
                                lastAssetUnitRequet.assetType = kvp.Key;
                                lastAssetUnitRequet.assetDependDic = assetDependDic;
                                lastAssetUnitRequet.assetUnitDic = assetUnitDic;

                                AddLastRequest(lastAssetUnitRequet, assetType);
                            }
                        }
                    }
                }
            }

            if (addDependUnitCompleteCallBack != null && lastAssetUnitRequet == null)
            {
                addDependUnitCompleteCallBack();
            }

            AddLastCallBack(lastCallBack, assetType);
        }

        void GetAssetUnit(string directory, string assetName, AssetType assetType, Dictionary<string, string> assetDependDic, Dictionary<string, AssetUnit> assetUnitDic, Action<AssetUnit> callBack)
        {
            AssetUnit unit;

            string assetNameKey = GetAssetKey(assetName, assetType);
            if (assetUnitDic.TryGetValue(assetNameKey, out unit) == false)
            {
                unit = LoadAssetUnit(directory, assetName, assetType);
                assetUnitDic[assetNameKey] = unit;

                CollectDepend(unit, assetName, assetType, assetDependDic, assetUnitDic, delegate()
                {
                    callBack(unit);
                });
            }
            else
            {
                callBack(unit);
            }
        }

        void WWWGetAssetUnit(string directory, string assetName, AssetType assetType, Dictionary<string, string> assetDependDic, Dictionary<string, AssetUnit> assetUnitDic, Action<AssetUnit> callBack)
        {
            AssetUnit assetUnit;

            string assetNameKey = GetAssetKey(assetName, assetType);
            if (assetUnitDic.TryGetValue(assetNameKey, out assetUnit) == false)
            {
                CoroutineUnit coroutineUnit = mCoroutineManager.GetCoroutine();
                coroutineUnit.StartCoroutine(WWWLoadAssetUnit(directory, assetName, assetType, delegate(AssetUnit uint2)
                {
                    coroutineUnit.mCallBack = CoroutineUnit.EmptyAction;

                    assetUnitDic[assetNameKey] = uint2;
                    uint2.mAddDependUnitCompleteCallBack += callBack;

                    CollectDepend(uint2, assetName, assetType, assetDependDic, assetUnitDic, null, null, delegate()
                    {
                        uint2.mAddDependUnitCompleteCallBack(uint2);
                        uint2.mAddDependUnitCompleteCallBack = null;
                    });

                }));
            }
            else
            {
                if (assetUnit.CheckAddDependUnitComplete())
                    callBack(assetUnit);
                else
                {
                    assetUnit.mAddDependUnitCompleteCallBack += callBack;
                }
            }
        }

        void WWWGetAssetUnitObj(string directory, string assetName, AssetType assetType, Dictionary<string, string> assetDependDic, Dictionary<string, AssetUnit> assetUnitDic, Action<UnityEngine.Object> callBack)
        {
            AssetUnit assetUnit;
            UnityEngine.Object mainAsset;

            string assetNameKey = GetAssetKey(assetName, assetType);
            if (assetUnitDic.TryGetValue(assetNameKey, out assetUnit) == false)
            {
                CoroutineUnit coroutineUnit = mCoroutineManager.GetCoroutine();
                coroutineUnit.StartCoroutine(WWWLoadAssetUnit(directory, assetName, assetType, delegate(AssetUnit assetUnit2)
                {
                    coroutineUnit.mCallBack = CoroutineUnit.EmptyAction;

                    assetUnit = assetUnit2;
                    assetUnitDic[assetNameKey] = assetUnit;

                    mainAsset = assetUnit.GetMainAsset();
                    mAssetUnitObjectDic[mainAsset] = assetUnit;
                    callBack(mainAsset);
                }));
            }
            else
            {
                mainAsset = assetUnit.GetMainAsset();
                mAssetUnitObjectDic[mainAsset] = assetUnit;
                callBack(mainAsset);
            }
        }

        AssetUnit GetAssetUnit(string directory, string assetName, AssetType assetType, Dictionary<string, string> assetDependDic, Dictionary<string, AssetUnit> assetUnitDic)
        {
            AssetUnit unit;

            string assetNameKey = GetAssetKey(assetName, assetType);
            if (assetUnitDic.TryGetValue(assetNameKey, out unit) == false)
            {
                unit = LoadAssetUnit(directory, assetName, assetType);
                assetUnitDic[assetNameKey] = unit;

                CollectDepend(unit, assetName, assetType, assetDependDic, assetUnitDic);
            }

            return unit;
        }

        string[] uncompressExternalList = new string[] { "External/Fx", "External/Role" };
        string[] uncompressIconList = new string[] { "LevelMap" };//"ItemIcon", "RoleIcon", "DependTextures"
        bool CheckLoadRawResource(string directory, AssetType assetType)
        {
            bool loadRawResource =
                assetType == AssetType.Texture ||
                //assetType == AssetType.AudioClip ||
                assetType == AssetType.MeshFilter ||
                assetType == AssetType.BinDataTextAsset ||
                CheckLoadRawResourceType(assetType);

            if (loadRawResource == false && assetType == AssetType.ExternalPrefab)
            {
                for (int i = 0, count = uncompressExternalList.Length; i < count; i++)
                {
                    loadRawResource = directory.IndexOf(uncompressExternalList[i]) != -1;

                    if (loadRawResource)
                        break;
                }
            }

            if (loadRawResource == false && assetType == AssetType.UIIcon)
            {
                for (int i = 0, count = uncompressIconList.Length; i < count; i++)
                {
                    loadRawResource = directory.IndexOf(uncompressIconList[i]) != -1;

                    if (loadRawResource)
                        break;
                }
            }

            return loadRawResource;
        }

        private bool CheckLoadRawResourceType(AssetType assetType)
        {
            return assetType == AssetType.UILabel ||
                assetType == AssetType.UISprite ||
                assetType == AssetType.UITexture;
        }

        private bool LoadResource(AssetUnit unit, string directory, AssetType assetType)
        {
            if (GameResUpdateManager.sLoadRawResource && Launch.Release)
            {
                //if (AssetTypeTools.IsUIType(assetType))
                //{
                //    string dir = Path.GetDirectoryName(directory);

                //    for (int k = 0, count = GameResUpdateManager.RawResourceList.Length; k < count; k++)
                //    {
                //        if (dir.IndexOf(GameResUpdateManager.RawResourceList[k]) != -1)
                //        {
                //            string fileName = Path.GetFileNameWithoutExtension(directory);
                //            string path = string.Format(cResourcePath, dir, fileName);
                //            UnityEngine.Object obj = Resources.Load(path);

                //            //Debug.LogError("LoadResource:" + path + "  obj:" + obj);

                //            unit.SetMainAsset(obj, true);
                //            return true;
                //        }
                //    }
                //}

                if (assetType == AssetType.AudioClip || CheckLoadRawResourceType(assetType))
                {
                    if (ResourceURL.CheckPersistentFileExists(directory))
                        return false;

                    string dir = Path.GetDirectoryName(directory);
                    string fileName = Path.GetFileNameWithoutExtension(directory);
                    string path = "Assets/" + dir + "/" + fileName;
                    UnityEngine.Object obj = Resources.Load(path);

                    //Debug.LogError("LoadResource:" + path + "  obj:" + obj);

                    unit.SetMainAsset(obj, true);
                    return true;
                }
            }

            return false;
        }

        AssetUnit LoadAssetUnit(string directory, string assetName, AssetType assetType)
        {
            AssetUnit unit = new AssetUnit();
            unit.mAssetType = assetType;
            //unit.mDirectory = directory;
            unit.mAssetName = assetName;
            unit.mDicKey = GetAssetKey(assetName, assetType);

            if (AssetTypeTools.IsMaterialType(assetType))
            {
                return unit;
            }

            if (LoadResource(unit, directory, assetType))
            {
                return unit;
            }


            bool loadRawResource = CheckLoadRawResource(directory, assetType);

            //Debug.LogError(string.Format("---LoadAssetUnit:{0} {1} sLoadMaxCount:{2} Time.frameCount:{3}", directory, loadRawResource, sLoadMaxCount, Time.frameCount));
            AssetBundle bundle = ResourceLoader.CreateFromFile(directory, Application.isEditor == false && loadRawResource);

      
            return unit;
        }

        IEnumerator WWWLoadAssetUnit(string directory, string assetName, AssetType assetType, Action<AssetUnit> callBack)
        {
            AssetUnit unit = new AssetUnit();
            unit.mAssetType = assetType;
            unit.mAssetName = assetName;
            unit.mDicKey = GetAssetKey(assetName, assetType);

            if (AssetTypeTools.IsMaterialType(assetType))
            {
                callBack(unit);
            }
            else
            {
                bool startCoroutine = true;

                if (LoadResource(unit, directory, assetType))
                {
                    callBack(unit);
                    startCoroutine = false;
                }

                if (startCoroutine)
                {
                    bool loadRawResource = CheckLoadRawResource(directory, assetType);

                    //Debug.LogError(string.Format("---WWWLoadAssetUnit:{0} {1} sLoadMaxCount:{2} Time.frameCount:{3}", directory, loadRawResource, sLoadMaxCount, Time.frameCount));

                    CoroutineUnit coroutineUnit = mCoroutineManager.GetCoroutine();
                    yield return coroutineUnit.StartCoroutine(ResourceLoader.CreateFromFile(directory, Application.isEditor == false && loadRawResource, delegate(AssetBundle bundle)
                    {
                        coroutineUnit.mCallBack = CoroutineUnit.EmptyAction;

                        if (bundle != null)
                        {
                            if (AssetTypeTools.IsMaterialType(assetType))
                            {
                               
                            }
                           
                            bundle.Unload(false);
                        }
                        else
                        {
                            Debug.LogError("bundle is null: " + directory);
                        }

                        callBack(unit);
                    }));
                }
            }

        }

        //public void LoadAudioClip(string directory, string assetName, Action<AudioClip> callBack)
        //{
        //    AssetUnit unit = GetAssetUnit(directory, assetName, AssetType.AudioClip, mUIDependDic, mUIAssetUnitDic);
        //    AudioClip audioClip = unit.GetMainAsset() as AudioClip;
        //    callBack(audioClip);
        //}

        public void WWWLoadUITextAsset(string directory, string assetName, Action<UnityEngine.Object> callBack, AssetType assetType = AssetType.TextAsset)
        {
            WWWGetAssetUnitObj(directory, assetName, assetType, mUIDependDic, mUIAssetUnitDic, callBack);
        }

        public void LoadUITextAsset(string directory, string assetName, Action<TextAsset> callBack, AssetType assetType = AssetType.TextAsset)
        {
            AssetUnit unit = GetAssetUnit(directory, assetName, assetType, mUIDependDic, mUIAssetUnitDic);
            TextAsset textAsset = unit.GetMainAsset() as TextAsset;
            callBack(textAsset);

            TextAsset.DestroyImmediate(textAsset, true);
        }

        public void LoadExternalTextAsset(string directory, string assetName, Action<TextAsset> callBack, AssetType assetType = AssetType.TextAsset)
        {
            AssetUnit unit = GetAssetUnit(directory, assetName, assetType, mExternalDependDic, mExternalAssetUnitDic);
            TextAsset textAsset = unit.GetMainAsset() as TextAsset;
            callBack(textAsset);
        }

        const string SceneRoot = "SceneRoot";
        public void LoadScene(string sceneName, Action callBack)
        {
            GameObject go = GameObject.Find(SceneRoot);

            AssetUnit unit = new AssetUnit();
            unit.mAssetType = AssetType.Scene;
            unit.mAssetName = sceneName;
            unit.mDicKey = GetAssetKey(unit.mAssetName, unit.mAssetType);
            CollectDepend(unit, unit.mAssetName, unit.mAssetType, mExternalDependDic, mExternalAssetUnitDic, delegate()
            {
                HashSet<MeshFilter> meshHashSet = new HashSet<MeshFilter>();
                HashSet<GameObject> meshGameObjectHashSet = new HashSet<GameObject>();

                PackageGameObjectUnit(unit, go, mExternalAssetUnitDic, meshHashSet, meshGameObjectHashSet);


                StaticBatchingUtility.Combine(go);
                foreach (MeshFilter meshFilter in meshHashSet)
                {
                    MeshFilter.Destroy(meshFilter);
                }
                meshHashSet.Clear();

                foreach (GameObject meshGameObject in meshGameObjectHashSet)
                {
                    GameObject.DestroyImmediate(meshGameObject, true);
                }
                meshGameObjectHashSet.Clear();

                //Debug.LogError("------------------------------------------------------------------LoadScene--------------------------------------------------------------");

                callBack();
            });
        }

        void AddFirstCallBack(Action firstCallBack, AssetType type)
        {
            if (firstCallBack != null)
            {
                ActionRequest request = new ActionRequest();
                request.callBack = firstCallBack;
                AddFirstRequest(request, type);
            }
        }

        public void AddLastCallBack(Action lastCallBack, AssetType type)
        {
            if (lastCallBack != null)
            {
                ActionRequest request = new ActionRequest();
                request.callBack = lastCallBack;
                AddLastRequest(request, type);
            }
        }

        void AddFirstRequest(AssetRequestBase quest, AssetType type)
        {
            GetLoaderRequestListByType(type).Insert(0, quest);
        }

        void AddLastRequest(AssetRequestBase quest, AssetType type)
        {
            GetLoaderRequestListByType(type).Add(quest);
        }

        List<AssetRequestBase> GetLoaderRequestListByType(AssetType type)
        {
            if (AssetTypeTools.IsUIType(type))
            {
                return mUILoaderRequestCache;
            }

            return mExternalLoaderRequestCache;
        }

        public void AsyncLoadAudioClip(string directory, string assetName, Action<AudioClip> callBack)
        {
            AddLoaderRequest<AudioClip>(directory, assetName, callBack, AssetType.AudioClip, false);
        }

        public void AsyncLoadTexture(string directory, string assetName, AssetType type, Action<Texture2D> callBack)
        {
            AddLoaderRequest<Texture2D>(directory, assetName, callBack, type);
        }

        public void AsyncLoadUIGameObject(string directory, string assetName, Action<GameObject> callBack)
        {
            AssetUnit unit;
            AssetType assetType = AssetType.UIPrefab;
            Dictionary<string, AssetUnit> assetUnitDic = mUIAssetUnitDic;

            string assetNameKey = GetAssetKey(assetName, assetType);
            if (assetUnitDic.TryGetValue(assetNameKey, out unit))
            {
                LoadUIGameObject2(directory, assetName, delegate(UnityEngine.Object obj)
                {
                    callBack(obj as GameObject);
                });
            }
            else
            {
                AddLoaderRequest<GameObject>(directory, assetName, callBack, assetType);
            }
        }

        public void AsyncLoadExternalGameObject(string directory, string assetName, Action<GameObject> callBack)
        {
            AssetUnit unit;
            AssetType assetType = AssetType.ExternalPrefab;
            Dictionary<string, AssetUnit> assetUnitDic = mExternalAssetUnitDic;

            string assetNameKey = GetAssetKey(assetName, assetType);
            if (assetUnitDic.TryGetValue(assetNameKey, out unit))
            {
                if (callBack == null)
                    return;

                LoadExternalGameObject2(directory, assetName, delegate(UnityEngine.Object obj)
                {
                    callBack(obj as GameObject);
                });
            }
            else
            {
                AddLoaderRequest<GameObject>(directory, assetName, callBack, assetType);
            }
        }

        void AddLoaderRequest<T>(string directory, string assetName, Action<T> callBack, AssetType type, bool addLast = true) where T : UnityEngine.Object
        {
            AssetRequest<T> request = new AssetRequest<T>();
            request.directory = directory;
            request.assetName = assetName;
            request.callBack = callBack;
            request.assetType = type;

            if (addLast)
                AddLastRequest(request, type);
            else
                AddFirstRequest(request, type);
        }

        void WWWLoadAudioClip(string directory, string assetName, Action<UnityEngine.Object> callBack)
        {
            WWWGetAssetUnitObj(directory, assetName, AssetType.AudioClip, mUIDependDic, mUIAssetUnitDic, callBack);
        }

        public AudioClip LoadAudioClip(string directory, string assetName)
        {
            AssetUnit unit = GetAssetUnit(directory, assetName, AssetType.AudioClip, mUIDependDic, mUIAssetUnitDic);
            return unit.GetMainAsset() as AudioClip;
        }

        void WWWLoadTexture(string directory, string assetName, AssetType assetType, Action<UnityEngine.Object> callBack)
        {
            WWWGetAssetUnitObj(directory, assetName, assetType, mUIDependDic, mUIAssetUnitDic, callBack);
        }

        public Texture2D LoadTexture(string directory, string assetName, AssetType assetType)
        {
            AssetUnit unit = GetAssetUnit(directory, assetName, assetType, mUIDependDic, mUIAssetUnitDic);
            return unit.GetMainAsset() as Texture2D;
        }

        public GameObject LoadUIGameObject(string directory, string assetName)
        {
            AssetUnit unit = GetAssetUnit(directory, assetName, AssetType.UIPrefab, mUIDependDic, mUIAssetUnitDic);
            GameObject go = unit.GetMainAsset() as GameObject;

            PackageGameObjectUnit(unit, go, mUIAssetUnitDic);

            return go;
        }

        public void LoadUIGameObject2(string directory, string assetName, Action<UnityEngine.Object> callBack)
        {
            if (DirectGetAssetUnit())
            {
                GetAssetUnit(directory, assetName, AssetType.UIPrefab, mUIDependDic, mUIAssetUnitDic, delegate(AssetUnit unit)
                {
                    GameObject go = unit.GetMainAsset() as GameObject;
                    PackageGameObjectUnit(unit, go, mUIAssetUnitDic);
                    callBack(go);
                });
            }
            else
            {
                WWWGetAssetUnit(directory, assetName, AssetType.UIPrefab, mUIDependDic, mUIAssetUnitDic, delegate(AssetUnit unit)
                {
                    GameObject go = unit.GetMainAsset() as GameObject;
                    PackageGameObjectUnit(unit, go, mUIAssetUnitDic);
                    callBack(go);
                });
            }
        }

        public void LoadExternalGameObject2(string directory, string assetName, Action<UnityEngine.Object> callBack)
        {
            if (DirectGetAssetUnit())
            {
                GetAssetUnit(directory, assetName, AssetType.ExternalPrefab, mExternalDependDic, mExternalAssetUnitDic, delegate(AssetUnit unit)
                {
                    if (callBack == null)
                        return;

                    GameObject go = unit.GetMainAsset() as GameObject;
                    PackageGameObjectUnit(unit, go, mExternalAssetUnitDic);
                    mAssetUnitObjectDic[go] = unit;
                    callBack(go);
                });
            }
            else
            {
                WWWGetAssetUnit(directory, assetName, AssetType.ExternalPrefab, mExternalDependDic, mExternalAssetUnitDic, delegate(AssetUnit unit)
                {
                    if (callBack == null)
                        return;

                    GameObject go = unit.GetMainAsset() as GameObject;
                    PackageGameObjectUnit(unit, go, mExternalAssetUnitDic);
                    mAssetUnitObjectDic[go] = unit;
                    callBack(go);
                });
            }
        }

        public GameObject LoadExternalGameObject(string directory, string assetName)
        {
            AssetUnit unit = GetAssetUnit(directory, assetName, AssetType.ExternalPrefab, mExternalDependDic, mExternalAssetUnitDic);
            GameObject go = unit.GetMainAsset() as GameObject;

            PackageGameObjectUnit(unit, go, mExternalAssetUnitDic);

            return go;
        }

        private List<string> mTexturesList = new List<string>() { "_MainTex", "_Splat0", "_Splat1", "_Splat2", "_Splat3", "_Control", "_Illum", "_DetailTex", "_MainTexLM", "_AlphaTexLM" };

        void PackageMaterialUnit(AssetUnit assetUnit, Dictionary<string, AssetUnit> assetUnitDic, Material mat)
        {
            if (assetUnit == null || assetUnit.mPack)
                return;

            if (Application.isEditor)
            {
                Shader shader = Shader.Find(mat.shader.name);
                if (shader != null)
                {
                    mat.shader = shader;
                }
            }

            assetUnit.mPack = true;
            List<string> strList;

            if (assetUnit.mComponentDependAssetDic.TryGetValue(mComponentTextureType, out strList))
            {
                int j = 0;

                for (int i = 0, count = strList.Count; i < count; i++)
                {
                    string texName = strList[i];

                    for (int len = mTexturesList.Count; j < len; )
                    {
                        string propertyName = mTexturesList[j++];

                        if (mat.HasProperty(propertyName))
                        {
                            if (texName != cNIL)
                            {
                                AssetUnit textureAssetUnit = GetAssetUnit(texName, AssetType.Texture, assetUnitDic);
                                if (textureAssetUnit == null)
                                {
                                    //Debug.LogError("textureAssetUnit:" + texName);
                                }

                                mat.SetTexture(propertyName, textureAssetUnit.GetMainAsset() as Texture2D);
                            }

                            break;
                        }
                    }
                }
            }

            assetUnit.SetMainAsset(mat);
        }

        void PackageGameObjectUnit(AssetUnit assetUnit, UnityEngine.Object mainAsset, Dictionary<string, AssetUnit> assetUnitDic, HashSet<MeshFilter> meshHashSet = null,
            HashSet<GameObject> meshGameObjectHashSet = null)
        {
            if (mainAsset == null)
                return;

            if (AssetTypeTools.IsPackageType(assetUnit.mAssetType))
            {
                assetUnit.AddDependUnitReference(mainAsset);

                Component[] components = (mainAsset as GameObject).GetComponentsInChildren<Component>(true);
                List<string> strList;
                int spriteIndex = 0;
                int fontIndex = 0;
                int textureIndex = 0;
                int meshRendererIndex = 0;
                int particleSystemRendererIndex = 0;
                int trailRendererIndex = 0;
                int skinnedMeshRendererIndex = 0;
                int meshFilterIndex = 0;

                int spriteNum = int.MaxValue;
                int fontNum = int.MaxValue;
                int textureNum = int.MaxValue;
                int meshRendererNum = int.MaxValue;
                int particleSystemRendererNum = int.MaxValue;
                int trailRendererNum = int.MaxValue;
                int skinnedMeshRendererNum = int.MaxValue;
                int meshFilterNum = int.MaxValue;

                for (int i = 0, count = components.Length; i < count; i++)
                {
                    if (spriteIndex >= spriteNum
                        && fontIndex >= fontNum
                        && textureIndex >= textureNum
                        && meshRendererIndex >= meshRendererNum
                        && particleSystemRendererIndex >= particleSystemRendererNum
                        && trailRendererIndex >= trailRendererNum
                        && skinnedMeshRendererIndex >= skinnedMeshRendererNum
                        && meshFilterIndex >= meshFilterNum)
                    {
                        break;
                    }

                    Component component = components[i];
                    if (component == null) continue;

                    Type componentType = component.GetType();

                    if (componentType == mComponentUISpriteType)
                    {
                        if (assetUnit.mComponentDependAssetDic.TryGetValue(componentType, out strList))
                        {
                            if (spriteIndex < strList.Count)
                            {
                                spriteNum = strList.Count;

                                string atlasName = strList[spriteIndex++];
                                AssetUnit dependAssetUnit = GetAssetUnit(atlasName, AssetType.UISprite, assetUnitDic);
                                if (dependAssetUnit != null)
                                {
                                    UnityEngine.Object unitMainAsset = dependAssetUnit.GetMainAsset();
                                    if (unitMainAsset != null)
                                    {
                                        UISprite sprite = ((UISprite)component);

                                        //if (sprite.depth > AssetUnit.sDefaultDepth)
                                        //{
                                        //    sprite.depth = AssetUnit.sDefaultDepth;
                                        //}

                                        sprite.atlas = dependAssetUnit.GetUIAtlas();
                                    }
                                }
                            }
                        }

                        continue;
                    }

                    if (componentType == mComponentUILabelType)
                    {
                        if (assetUnit.mComponentDependAssetDic.TryGetValue(componentType, out strList))
                        {
                            if (fontIndex < strList.Count)
                            {
                                fontNum = strList.Count;

                                string atlasName = strList[fontIndex++];
                                AssetUnit dependAssetUnit = GetAssetUnit(atlasName, AssetType.UILabel, assetUnitDic);
                                if (dependAssetUnit != null)
                                {
                                    UnityEngine.Object unitMainAsset = dependAssetUnit.GetMainAsset();
                                    if (unitMainAsset != null)
                                    {
                                        UILabel label = ((UILabel)component);
                                        label.depth = dependAssetUnit.GetFontDepth();
                                        label.bitmapFont = dependAssetUnit.GetUIFont();
                                    }
                                }
                            }
                        }

                        continue;
                    }

                    if (componentType == mComponentUITextureType)
                    {
                        if (assetUnit.mComponentDependAssetDic.TryGetValue(componentType, out strList))
                        {
                            if (textureIndex < strList.Count)
                            {
                                textureNum = strList.Count;

                                string atlasName = strList[textureIndex++];
                                AssetUnit dependAssetUnit = GetAssetUnit(atlasName, AssetType.UITexture, assetUnitDic);
                                if (dependAssetUnit != null)
                                {
                                    ((UITexture)component).mainTexture = ((Texture2D)(dependAssetUnit.GetMainAsset()));
                                }
                            }
                        }

                        continue;
                    }

                    if (componentType == mComponentMeshFilterType)
                    {
                        if (assetUnit.mComponentDependAssetDic.TryGetValue(componentType, out strList))
                        {
                            if (meshFilterIndex < strList.Count)
                            {
                                meshFilterNum = strList.Count;

                                string atlasName = strList[meshFilterIndex++];
                                AssetUnit dependAssetUnit = GetAssetUnit(atlasName, AssetType.MeshFilter, assetUnitDic);
                                Mesh mesh = null;
                                MeshFilter meshfilter = ((MeshFilter)component);

                                if (dependAssetUnit != null)
                                {
                                    UnityEngine.Object unitMainAsset = dependAssetUnit.GetMainAsset();
                                    if (unitMainAsset != null)
                                    {
                                        MeshFilter unitMeshFilter = ((MeshFilter)unitMainAsset);
                                        mesh = unitMeshFilter.sharedMesh;
                                        meshfilter.sharedMesh = mesh;

                                        meshHashSet.Add(unitMeshFilter);
                                        meshGameObjectHashSet.Add(dependAssetUnit.mMeshFilterGameObject);
                                    }
                                }

                                meshHashSet.Add(meshfilter);
                            }
                        }

                        continue;
                    }

                    List<Material> multiMaterials = null;

                    if (componentType == mComponentMeshRendererType)
                    {
                        if (assetUnit.mComponentDependAssetDic.TryGetValue(componentType, out strList))
                        {
                            Renderer renderer = ((Renderer)component);
                            renderer.castShadows = false;
                            renderer.receiveShadows = false;

                            Material[] sharedMaterials = renderer.sharedMaterials;
                            for (int k = 0, len = sharedMaterials.Length; k < len; k++)
                            {
                                if (meshRendererIndex < strList.Count)
                                {
                                    meshRendererNum = strList.Count;

                                    string atlasName = strList[meshRendererIndex++];
                                    AssetUnit dependAssetUnit = GetAssetUnit(atlasName, AssetType.MeshRenderer, assetUnitDic);
                                    PackageMaterialUnit(dependAssetUnit, assetUnitDic, sharedMaterials[k]);

                                    if (len == 1)
                                    {
                                        if (dependAssetUnit != null)
                                            renderer.sharedMaterial = (Material)dependAssetUnit.GetMainAsset();
                                    }
                                    else
                                    {
                                        if (multiMaterials == null)
                                        {
                                            multiMaterials = new List<Material>();
                                        }

                                        if (dependAssetUnit != null)
                                            multiMaterials.Add((Material)dependAssetUnit.GetMainAsset());
                                        else
                                            multiMaterials.Add(null);

                                        if (multiMaterials.Count == len)
                                        {
                                            renderer.sharedMaterials = multiMaterials.ToArray();
                                            multiMaterials = null;
                                        }
                                    }
                                }
                            }
                        }

                        continue;
                    }


                    if (componentType == mComponentParticleSystemRendererType)
                    {
                        if (assetUnit.mComponentDependAssetDic.TryGetValue(componentType, out strList))
                        {
                            Material[] sharedMaterials = ((Renderer)component).materials;
                            for (int k = 0, len = sharedMaterials.Length; k < len; k++)
                            {
                                if (particleSystemRendererIndex < strList.Count)
                                {
                                    particleSystemRendererNum = strList.Count;

                                    string atlasName = strList[particleSystemRendererIndex++];
                                    AssetUnit dependAssetUnit = GetAssetUnit(atlasName, AssetType.ParticleSystemRenderer, assetUnitDic);
                                    PackageMaterialUnit(dependAssetUnit, assetUnitDic, sharedMaterials[k]);

                                    if (len == 1)
                                    {
                                        if (dependAssetUnit != null)
                                            ((Renderer)component).sharedMaterial = (Material)dependAssetUnit.GetMainAsset();
                                    }
                                    else
                                    {
                                        if (multiMaterials == null)
                                        {
                                            multiMaterials = new List<Material>();
                                        }

                                        if (dependAssetUnit != null)
                                            multiMaterials.Add((Material)dependAssetUnit.GetMainAsset());
                                        else
                                            multiMaterials.Add(null);

                                        if (multiMaterials.Count == len)
                                        {
                                            ((Renderer)component).sharedMaterials = multiMaterials.ToArray();
                                            multiMaterials = null;
                                        }
                                    }
                                }
                            }
                        }

                        continue;
                    }

                    if (componentType == mComponentTrailRendererType)
                    {
                        if (assetUnit.mComponentDependAssetDic.TryGetValue(componentType, out strList))
                        {
                            Material[] sharedMaterials = ((Renderer)component).materials;
                            for (int k = 0, len = sharedMaterials.Length; k < len; k++)
                            {
                                if (trailRendererIndex < strList.Count)
                                {
                                    trailRendererNum = strList.Count;

                                    string atlasName = strList[trailRendererIndex++];
                                    AssetUnit dependAssetUnit = GetAssetUnit(atlasName, AssetType.TrailRenderer, assetUnitDic);
                                    PackageMaterialUnit(dependAssetUnit, assetUnitDic, sharedMaterials[k]);

                                    if (len == 1)
                                    {
                                        if (dependAssetUnit != null)
                                            ((Renderer)component).sharedMaterial = (Material)dependAssetUnit.GetMainAsset();
                                    }
                                    else
                                    {
                                        if (multiMaterials == null)
                                        {
                                            multiMaterials = new List<Material>();
                                        }

                                        if (dependAssetUnit != null)
                                            multiMaterials.Add((Material)dependAssetUnit.GetMainAsset());
                                        else
                                            multiMaterials.Add(null);

                                        if (multiMaterials.Count == len)
                                        {
                                            ((Renderer)component).sharedMaterials = multiMaterials.ToArray();
                                            multiMaterials = null;
                                        }
                                    }
                                }
                            }
                        }

                        continue;
                    }

                    if (componentType == mComponentSkinnedMeshRendererType)
                    {
                        if (assetUnit.mComponentDependAssetDic.TryGetValue(componentType, out strList))
                        {
                            Material[] sharedMaterials = ((Renderer)component).materials;
                            for (int k = 0, len = sharedMaterials.Length; k < len; k++)
                            {
                                if (skinnedMeshRendererIndex < strList.Count)
                                {
                                    skinnedMeshRendererNum = strList.Count;

                                    string atlasName = strList[skinnedMeshRendererIndex++];
                                    AssetUnit dependAssetUnit = GetAssetUnit(atlasName, AssetType.SkinnedMeshRenderer, assetUnitDic);
                                    PackageMaterialUnit(dependAssetUnit, assetUnitDic, sharedMaterials[k]);

                                    if (len == 1)
                                    {
                                        if (dependAssetUnit != null)
                                            ((Renderer)component).sharedMaterial = (Material)dependAssetUnit.GetMainAsset();
                                    }
                                    else
                                    {
                                        if (multiMaterials == null)
                                        {
                                            multiMaterials = new List<Material>();
                                        }

                                        if (dependAssetUnit != null)
                                            multiMaterials.Add((Material)dependAssetUnit.GetMainAsset());
                                        else
                                            multiMaterials.Add(null);

                                        if (multiMaterials.Count == len)
                                        {
                                            ((Renderer)component).sharedMaterials = multiMaterials.ToArray();
                                            multiMaterials = null;
                                        }
                                    }
                                }
                            }
                        }

                        continue;
                    }
                }
            }
        }
    }
}
