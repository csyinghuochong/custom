using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using Assets.Editor.Depend;
using Assets.Scripts.Com.Game.Utils;
using UnityEditor;
using UnityEngine;

namespace Assets.Editor
{
    public class DependTool
    {
        private static string dependSaveFolder = "Assets/RawResources/DependPrefabs";

        private static string dependSaveFile = dependSaveFolder + "/Depend.txt";
        private static string dependSerializeFile = dependSaveFolder + "/Depend.bytes";

        const string RawResourceDependTextures = "Assets/RawResources/DependTextures";

        private BuildTool mBuildTool;
        private Dictionary<string, string> mDependDic;
        private Dictionary<string, int> mPrefabCount = new Dictionary<string, int>();
        private Dictionary<string, string> mAllDependDic = new Dictionary<string, string>();

        private bool mSave = true;

        public DependTool(BuildTool buildTool)
        {
            mBuildTool = buildTool;

            if (System.IO.File.Exists(dependSerializeFile) && BuildTool.sRelease == false)
            {
                mDependDic = SerializeUtils.Deserializer(dependSerializeFile) as Dictionary<string, string>;
            }
            else
            {
                mDependDic = new Dictionary<string, string>();
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

            AssetDatabase.DeleteAsset(RawResourceDependTextures);
            Directory.CreateDirectory(RawResourceDependTextures);

            foreach (string str in mAllDependDic.Values)
            {
                BuildAssetBundle(str);
            }
            mAllDependDic.Clear();

            if (System.IO.File.Exists(dependSaveFile))
            {
                File.Delete(dependSaveFile);
            }

            if (System.IO.File.Exists(dependSerializeFile))
            {
                File.Delete(dependSerializeFile);
            }

            foreach (KeyValuePair<string, string> kvp in mDependDic)
            {
                using (StreamWriter writer = new StreamWriter(dependSaveFile, true, Encoding.UTF8))
                {
                    string dependStr = kvp.Value;

                    writer.WriteLine(kvp.Key + ":" + dependStr);
                    writer.WriteLine();
                }
            }

            SerializeUtils.Serializer(dependSerializeFile, mDependDic);

            AssetDatabase.Refresh();
            //打包生成的序列化
            mBuildTool.PackByPath(dependSaveFolder);
            mBuildTool.Build();
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

        private List<DependBase> CheckDependencies(FileInfo fileInfo, GameObject go, Dictionary<string, string> dependPathDic)
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
                        mAllDependDic[kvp.Key] = kvp.Value;
                }
            }

            return dependBaseList;
        }

        public void SceneDependencies(FileInfo fileInfo, GameObject go)
        {
            Dictionary<string, string> dependPathDic = GetDependencies(fileInfo);
            string fileName = Path.GetFileNameWithoutExtension(fileInfo.Name);

            List<DependBase> dependBaseList = CheckDependencies(fileInfo, go, dependPathDic);
            string result = DependBase.Output(dependBaseList);
            AddDepend(fileName + ".scene", DependBase.Output(dependBaseList));
        }

        public void AssetDependencies(FileInfo fileInfo, UnityEngine.Object obj, Action buildAction)
        {
            Debug.Log("AssetDependencies:" + fileInfo.Name);

            GameObject go = obj as GameObject;

            if (go == null)
            {
                buildAction();
                return;
            }

            List<DependBase> dependBaseList = CheckDependencies(fileInfo, go);

            buildAction();

            AddDepend(fileInfo.Name, DependBase.Output(dependBaseList));
        }

        private void BuildAssetBundle(string dependPathStr)
        {
            string viewPubPath = Application.streamingAssetsPath + "/DependTextures";
            if (Directory.Exists(viewPubPath) == false)
                Directory.CreateDirectory(viewPubPath);

            string str = EditorTools.GetAssetsPath(dependPathStr);

            if (BuildTool.sRelease)
                AssetDatabase.CopyAsset(str, RawResourceDependTextures + "/" + Path.GetFileName(str));

            string name = Path.GetFileNameWithoutExtension(str);
            string dependSavePath = viewPubPath + "/" + name + ".bytes";
            bool isPackSuccess = BuildPipeline.BuildAssetBundle(null, new UnityEngine.Object[] { EditorTools.LoadAssetAtPath(dependPathStr) }, dependSavePath, mBuildTool.option | BuildAssetBundleOptions.UncompressedAssetBundle, mBuildTool.mBuildTarget);

            if (isPackSuccess == false)
            {
                Debug.LogError("pack error:" + dependSavePath);
            }
        }
    }
}
