using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using Assets.Editor.Depend;
using Assets.Scripts.Com.Game.Utils;
using UnityEditor;
using UnityEngine;
using Assets.Editor.PackAssetBundle.Depend;

namespace Assets.Editor
{
    public class DependTool
    {
        private static string dependSaveFolder = "Assets/RawResources/DependPrefabs";
        private static string dependSerializeFile = dependSaveFolder + "/Depend.xml";

        private static string dependStreamingAssetsSerializeFileXml = "Assets/StreamingAssets/DependPrefabs/Depend.xml";

        private BuildTool mBuildTool;
        private Dictionary<string, string> mDependDic;
        private Dictionary<string, int> mPrefabCount = new Dictionary<string, int>();
        private Dictionary<string, string> mAllDependDic = new Dictionary<string, string>();
        private Dictionary<string, FileInfo> mAllDependFileInfoDic = new Dictionary<string, FileInfo>();

        private bool mSave = true;

        public DependTool(BuildTool buildTool)
        {
            mBuildTool = buildTool;

            mDependDic = new Dictionary<string, string>();

            if (BuildTool.sReleaseBuild == false && System.IO.File.Exists(dependSerializeFile))
            {
                byte[] bytes = (AssetDatabase.LoadAssetAtPath(dependSerializeFile, typeof(TextAsset)) as TextAsset).bytes;
                SerializeUtils.DeserializeXml<List<KeyValuePair<string, string>>>(bytes, delegate(List<KeyValuePair<string, string>> kvpList)
                {
                    for (int i = 0; i < kvpList.Count; i++)
                    {
                        KeyValuePair<string, string> kvp = kvpList[i];
                        mDependDic[kvp.Key] = kvp.Value;
                    }
                });
            }
        }

        public void AddDepend(string viewName, string str)
        {
            if (string.IsNullOrEmpty(str))
            {
                return;
            }

            mSave = false;
            mDependDic[viewName] = str;
        }

        public void Save()
        {
            if (mSave)
                return;

            mSave = true;

            if (DependCollectTool.mCollect)
                return;

            foreach (KeyValuePair<string, string> kvp in mAllDependDic)
            {
                FileInfo fileInfo = null;
                mAllDependFileInfoDic.TryGetValue(kvp.Key, out fileInfo);

                BuildAssetBundle(kvp.Value, "DependPrefabs", fileInfo);
            }

            //打包Textures
            foreach (string texturePath in DependCollectTool.mTexturesHasSet)
            {
                BuildAssetBundle(texturePath, "DependTextures", null, true);
            }
            DependCollectTool.mTexturesHasSet.Clear();

            //打包mesh预设体
            HashSet<string> meshFilterDependPrefab = DependCollectTool.sMeshFilterPrefabSet;
            foreach (string prefabPath in meshFilterDependPrefab)
            {
                BuildAssetBundle(prefabPath, "DependMeshs",null,true);
            }

            mAllDependDic.Clear();
            mAllDependFileInfoDic.Clear();
            meshFilterDependPrefab.Clear();

            if (System.IO.File.Exists(dependSerializeFile))
            {
                File.Delete(dependSerializeFile);
            }

            if (System.IO.File.Exists(dependStreamingAssetsSerializeFileXml))
            {
                File.Delete(dependStreamingAssetsSerializeFileXml);
            }

            List<KeyValuePair<string, string>> kvpList = new List<KeyValuePair<string, string>>();

            foreach (KeyValuePair<string, string> kvp in DependCollectTool.mDependDesDic)
            {
                mDependDic[kvp.Key] = kvp.Value;
            }
            DependCollectTool.mDependDesDic.Clear();

            foreach (KeyValuePair<string, string> kvp in mDependDic)
            {
                kvpList.Add(kvp);
            }
            SerializeUtils.SerializeToXml(kvpList, dependSerializeFile);

            if (BuildTool.sReleaseBuild)
            {
                AssetDatabase.Refresh();
                //打包生成的序列化
                mBuildTool.PackByPath(dependSaveFolder);
                mBuildTool.Build();
            }
            else
            {
                SerializeUtils.SerializeToXml(kvpList, dependStreamingAssetsSerializeFileXml);
            }

            AssetDatabase.Refresh();
        }

        public Dictionary<string, string> GetDependencies(FileInfo fileInfo)
        {
            Dictionary<string, string> dependPathDic = new Dictionary<string, string>();

            List<string> dependPathList = new List<string>();
            string itemPath = EditorTools.GetAssetsPath(fileInfo.FullName);
            dependPathList.AddRange(AssetDatabase.GetDependencies(new string[] { itemPath }));
            foreach (string str in dependPathList)
            {
                dependPathDic[Path.GetFileName(str)] = str;
            }

            return dependPathDic;
        }

        private List<DependBase> CheckDependencies(FileInfo fileInfo, GameObject go)
        {
            return CheckDependencies(fileInfo, go, GetDependencies(fileInfo));
        }

        private List<DependBase> CheckDependencies(FileInfo fileInfo, GameObject go, Dictionary<string, string> dependPathDic, bool isScene = false)
        {
            Dictionary<string, string> allDependDic = new Dictionary<string, string>();
            Component[] components = go.GetComponentsInChildren<Component>(true);
            List<DependBase> dependBaseList = new List<DependBase>();
            dependBaseList.Add(new UISpriteDepend());
            dependBaseList.Add(new UILabelDepend());
            dependBaseList.Add(new UITextureDepend());
            dependBaseList.Add(new MeshRendererDepend());
            dependBaseList.Add(new ParticleSystemRendererDepend());
            dependBaseList.Add(new TrailRendererRendererDepend());
            dependBaseList.Add(new SkinnedMeshRendererDepend());

            if (isScene)
            {
                //dependBaseList.Add(new MeshFilterDepend());
            }

            DependCollectTool.CollectAssetsStart();

            for (int i = 0, count = components.Length; i < count; i++)
            {
                Component component = components[i];

                if (component == null)
                    continue;

                for (int j = 0, len = dependBaseList.Count; j < len; j++)
                {
                    DependBase dependBase = dependBaseList[j];
                    List<string> dependAssetNameList = dependBase.CompareComponent(component);
                    if (dependAssetNameList != null)
                    {
                        for (int k = 0; k < dependAssetNameList.Count; k++)
                        {
                            string dependAssetName = dependAssetNameList[k];

                            if (dependAssetName.Length == 0)
                            {
                                dependBase.AddAssets("nil");
                            }
                            else
                            {
                                dependBase.AddAssets(dependAssetName);

                                if (dependAssetName == "Default-Diffuse")
                                {
                                    Debug.LogError(string.Format("Default-Diffuse: component.name:{0},gameObject.name:{1}", component.name, component.gameObject.name));
                                }

                                if (dependBase is MeshFilterDepend || DependCollectTool.mCollect)
                                {
                                    continue;
                                }

                                List<string> keys = dependBase.GetWithExtension(dependAssetName);
                                foreach (string key in keys)
                                {
                                    if (dependPathDic.ContainsKey(key))
                                        allDependDic[key] = dependPathDic[key];
                                }
                            }
                        }
                        break;
                    }
                }
            }

            DependCollectTool.CollectAssetsEnd();

            if (allDependDic.Count > 0)
            {
                foreach (KeyValuePair<string, string> kvp in allDependDic)
                {
                    if (mAllDependDic.ContainsKey(kvp.Key))
                    {
                        if (mAllDependDic[kvp.Key] != kvp.Value)
                        {
                            string errorStr = string.Format("mAllDependDic error key:{0} value1:{1},value2:{2}", kvp.Key, kvp.Value, mAllDependDic[kvp.Key]);
                            Debug.LogError(errorStr);
                            //throw new Exception(errorStr);
                        }
                    }
                    else
                    {
                        mAllDependDic[kvp.Key] = kvp.Value;
                        mAllDependFileInfoDic[kvp.Key] = fileInfo;
                    }

                }
            }

            return dependBaseList;
        }

        public void SceneDependencies(FileInfo fileInfo, GameObject go, Action callBack)
        {
            Dictionary<string, string> dependPathDic = GetDependencies(fileInfo);
            string fileName = Path.GetFileNameWithoutExtension(fileInfo.Name);

            List<DependBase> dependBaseList = CheckDependencies(fileInfo, go, dependPathDic, true);

            if (DependCollectTool.mCollect == false)
            {
                AddDepend(fileName + ".scene", DependBase.Output(dependBaseList));
                callBack();
            }

        }

        public void AssetDependencies(FileInfo fileInfo, UnityEngine.Object obj, Action callBack)
        {
            Debug.Log("AssetDependencies:" + fileInfo.Name);

            GameObject go = obj as GameObject;

            if (go == null)
            {
                if (DependCollectTool.mCollect == false)
                    callBack();

                return;
            }

            List<DependBase> dependBaseList = CheckDependencies(fileInfo, go);

            if (DependCollectTool.mCollect == false)
            {
                callBack();
                AddDepend(fileInfo.Name, DependBase.Output(dependBaseList));
            }
        }

        private void BuildAssetBundle(string dependPathStr, string folderName = "DependPrefabs", FileInfo rawFileInfo = null, bool Uncompressed = false)
        {
            string viewPubPath = Application.streamingAssetsPath + "/" + folderName;
            if (Directory.Exists(viewPubPath) == false)
                Directory.CreateDirectory(viewPubPath);

            string str = EditorTools.GetAssetsPath(dependPathStr);
            string name = Path.GetFileNameWithoutExtension(str);
            string dependSavePath = viewPubPath + "/" + name + ".bytes";
            UnityEngine.Object packObj = EditorTools.LoadAssetAtPath(dependPathStr);

            if (packObj is Material)
                return;

            BuildAssetBundleOptions options = mBuildTool.option;

            //&& mBuildTool.mIndex == TargetType.ANDROID
            if (Uncompressed)
            {
                options |= BuildAssetBundleOptions.UncompressedAssetBundle;
            }

            bool isPackSuccess = BuildPipeline.BuildAssetBundle(null, new UnityEngine.Object[] { packObj }, dependSavePath, options, mBuildTool.mBuildTarget);
            if (isPackSuccess == false)
            {
                Debug.LogError("pack error:" + dependSavePath);
            }
        }
    }
}
