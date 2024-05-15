using System;
using UnityEditor;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

namespace ET
{
    public class CheckReferences : EditorWindow
    {
        private const string KBuildAssetBundles = "XAsset/Bundles/Check Atlas References";
        private const string KBuildBloodBundles = "XAsset/Bundles/Check Blood References";
        private const string KBuildMainUIBundles = "XAsset/Bundles/Check MainUI References";
        private static string sBundleBloodPath = "Assets/Bundles/UI/Blood/";
        private static string sBundleUICheckPath = "Assets/Bundles/UI";
        private static string sBundleCheckPath = "Assets/Bundles";
        private static string sSceneCheckPath = "Assets/Scenes";
        private static string sResPath = "Assets/Res";

        // [MenuItem("Asset / ), false, 1]
        [MenuItem("Assets/Custom/Copy  Dependencies", false, 1)]//路径
        public static void CopyDependencies()
        {
            string fontPath = AssetDatabase.GetAssetPath(Selection.activeInstanceID);
            UnityEngine.Debug.Log("fontPath: " + fontPath);
            UnityEngine.Debug.Log("CopyDependencies: Begin");
            string dataPath = Application.dataPath;
            string[] dependPathList = AssetDatabase.GetDependencies(new string[] { fontPath });
            foreach (string path in dependPathList)
            {
                using (var stream = File.OpenRead(path))
                {
                    long fileSize = stream.Length;
                    string strNum = GetSizeNum(fileSize);
                    UnityEngine.Debug.Log(strNum + "   " + path);
                }

                string[] fileInfo = path.Split('/');
                string formPath = path.Replace("Assets", Application.dataPath);
                string toPath = "H:/TempFile/" + fileInfo[fileInfo.Length - 1];
                CopyDirectory(formPath, toPath);

                string formPathMeta = path.Replace("Assets", Application.dataPath) + ".meta";
                string toPathMata = "H:/TempFile/" + fileInfo[fileInfo.Length - 1] + ".meta";

                CopyDirectory(formPathMeta, toPathMata);
            }

            //dataPath: H:/GitWeiJing/Unity/Assets
            //Assets/Res/Models/RoleModelSet/RoleFaShi/Animtor/Girl_Act_1.fbx
            UnityEngine.Debug.Log("dataPath: " + dataPath);
            UnityEngine.Debug.Log("CopyDependencies: End");
        }

        /// <summary>
        /// 拷贝文件
        /// </summary>
        /// <param name="srcDir">起始文件夹</param>
        /// <param name="tgtDir">目标文件夹</param>
        public static void CopyDirectory(string srcDir, string tgtDir)
        {
            File.Copy(srcDir, tgtDir, true);
        }

        public static string GetSizeNum(long fileSize)
        {
            string strNum;
            int mb = 1024 * 1024;
            int kb = 1024;
            if (fileSize > kb)
            {
                float xx = fileSize * 1f / mb;
                decimal num1 = (decimal)xx;
                strNum = String.Format("{0:N3}", xx) + "mb    ";
            }
            else
            {
                float xx = fileSize * 1f / kb;
                strNum = String.Format("{0:N3}", xx) + "kb    ";
            }
            return strNum;
        }

        // [MenuItem("Asset / ), false, 1]
        [MenuItem("Assets/Custom/Check  Dependencies", false, 1)]//路径
        public static void CheckDependencies()
        {
            string fontPath = AssetDatabase.GetAssetPath(Selection.activeInstanceID);
            UnityEngine.Debug.Log("fontPath: " + fontPath);
            UnityEngine.Debug.Log("KCheckDependencies: Begin");

            string[] dependPathList = AssetDatabase.GetDependencies(new string[] { fontPath });
            foreach (string path in dependPathList)
            {
                using (var stream = File.OpenRead(path))
                {
                    long fileSize = stream.Length;
                    string strNum = GetSizeNum(fileSize);
                    UnityEngine.Debug.Log(strNum + "   " + path);
                }
            }

            UnityEngine.Debug.Log("KCheckDependencies: End");
        }

        // [MenuItem("Asset / ), false, 1]
        [MenuItem("Assets/Custom/Check References Bundler", false, 1)]//路径
        public static void KCheckBundleReferences()
        {
            string fontPath = AssetDatabase.GetAssetPath(Selection.activeInstanceID);

            string[] assetPath = fontPath.Split('/');
            string fontAssetName = assetPath[assetPath.Length - 1];
            if (fontAssetName.Contains("."))
            {
                fontAssetName = fontAssetName.Split('.')[0];
            }

            UnityEngine.Debug.Log("KCheckFontReferences: Begin");

            List<string> fileList = new List<string>();
            fileList.AddRange(GetFile(sBundleCheckPath, fileList));

            string dataPath = Application.dataPath;
            int pathLength = dataPath.Length - 6;
            for (int i = 0; i < fileList.Count; i++)
            {
                string itemPath = fileList[i];
                if (itemPath.Contains(".meta"))
                {
                    continue;
                }

                itemPath = itemPath.Remove(0, pathLength);
                string[] dependPathList = AssetDatabase.GetDependencies(new string[] { itemPath });
                foreach (string path in dependPathList)
                {
                    // string[] assetPath = path.Split('/');
                    //if (assetPath[assetPath.Length-1] == fongPath)
                    if (path == fontPath)
                    {
                        UnityEngine.Debug.Log($"以下文件有引用： {itemPath} ");

                        GameObject tmpObj = AssetDatabase.LoadAssetAtPath(itemPath, typeof(GameObject)) as GameObject;
                        //tmpObj = GameObject.Instantiate(tmpObj) as GameObject;
                        Text[] tmpAr = tmpObj.GetComponentsInChildren<Text>();
                        for (int t = 0; t < tmpAr.Length; t++)
                        {
                            Text textTemp = tmpAr[t];
                            Font fontTemp = textTemp.font;
                            if (fontTemp == null)
                            {
                                continue;
                            }
                            string assetName = fontTemp.name;
                            if (fontAssetName == assetName)
                            {
                                UnityEngine.Debug.Log($" {textTemp.name}");
                            }
                        }

                        TextMeshPro[] tmpProAr = tmpObj.GetComponentsInChildren<TextMeshPro>();
                        for (int t = 0; t < tmpProAr.Length; t++)
                        {
                            TextMeshPro textTemp = tmpProAr[t];
                            TMP_FontAsset fontTemp = textTemp.font;
                            if (fontTemp == null)
                            {
                                continue;
                            }
                            string assetName = fontTemp.name;
                            if (fontAssetName == assetName)
                            {
                                UnityEngine.Debug.Log($" {textTemp.name}");
                            }
                        }
                    }
                }
            }

            UnityEngine.Debug.Log("KCheckFontReferences: End");
        }

        // shader资源反向查找
        [MenuItem("Assets/Custom/Check References Shader", false, 1)]
        public static void KCheckShaderReferences()
        {
            string shaderPath = AssetDatabase.GetAssetPath(Selection.activeInstanceID);

            string[] assetPath = shaderPath.Split('/');
            string shaderAssetName = assetPath[assetPath.Length - 1];
            if (shaderAssetName.Contains("."))
            {
                shaderAssetName = shaderAssetName.Split('.')[0];
            }

            UnityEngine.Debug.Log("KCheckShaderReferences: Begin");



            List<string> matFileList = new List<string>();
            matFileList.AddRange(GetFile(sResPath, matFileList));

            string dataPath = Application.dataPath;
            int pathLength = dataPath.Length - 6;

            // 获取使用改Shader的Material
            // List<string> material_path = new List<string>();
            // for (int i = 0; i < matFileList.Count; i++)
            // {
            //     string matPath = matFileList[i];
            //     if (matPath.Contains(".meta"))
            //     {
            //         continue;
            //     }
            //
            //     matPath = matPath.Remove(0, pathLength);
            //     if (matPath.EndsWith(".mat"))
            //     {
            //         string[] dependPathList = AssetDatabase.GetDependencies(new string[] { matPath });
            //         foreach (string path in dependPathList)
            //         {
            //             if (path == shaderPath)
            //             {
            //                 // UnityEngine.Debug.Log($"以下材质使用了该Shader： {matPath} ");
            //                 material_path.Add(matPath);
            //             }
            //         }
            //     }
            // }

            List<string> fileList = new List<string>();
            fileList.AddRange(GetFile(sBundleCheckPath, fileList));
            fileList.AddRange(GetFile(sSceneCheckPath, fileList));

            for (int i = 0; i < fileList.Count; i++)
            {
                string itemPath = fileList[i];
                if (itemPath.Contains(".meta"))
                {
                    continue;
                }

                itemPath = itemPath.Remove(0, pathLength);
                string[] dependPathList = AssetDatabase.GetDependencies(new string[] { itemPath });
                foreach (string path in dependPathList)
                {
                    if (path == shaderPath)
                    {
                        UnityEngine.Debug.Log($"以下文件引用了该Shader： {itemPath} ");
                    }
                }
            }

            UnityEngine.Debug.Log("KCheckShaderReferences: End");
        }

        [MenuItem("Assets/Custom/Check References Bundler UI", false, 1)]//路径
        public static void KCheckBundleUIReferences()
        {
            string fontPath = AssetDatabase.GetAssetPath(Selection.activeInstanceID);

            string[] assetPath = fontPath.Split('/');
            string fontAssetName = assetPath[assetPath.Length - 1];
            if (fontAssetName.Contains("."))
            {
                fontAssetName = fontAssetName.Split('.')[0];
            }

            UnityEngine.Debug.Log("KCheckFontReferences: Begin");

            List<string> fileList = new List<string>();
            fileList.AddRange(GetFile(sBundleUICheckPath, fileList));

            string dataPath = Application.dataPath;
            int pathLength = dataPath.Length - 6;
            for (int i = 0; i < fileList.Count; i++)
            {
                string itemPath = fileList[i];
                if (itemPath.Contains(".meta"))
                {
                    continue;
                }

                itemPath = itemPath.Remove(0, pathLength);
                string[] dependPathList = AssetDatabase.GetDependencies(new string[] { itemPath });
                foreach (string path in dependPathList)
                {
                    // string[] assetPath = path.Split('/');
                    //if (assetPath[assetPath.Length-1] == fongPath)
                    if (path == fontPath)
                    {
                        UnityEngine.Debug.Log($"以下文件有引用： {itemPath} ");


                        //GameObject tmpObj = AssetDatabase.LoadAssetAtPath(itemPath, typeof(GameObject)) as GameObject;
                        ////tmpObj = GameObject.Instantiate(tmpObj) as GameObject;
                        //Text[] tmpAr = tmpObj.GetComponentsInChildren<Text>();
                        //for (int t = 0; t < tmpAr.Length; t++)
                        //{
                        //    Text textTemp = tmpAr[t];
                        //    Font fontTemp = textTemp.font;
                        //    if (fontTemp == null)
                        //    {
                        //        continue;
                        //    }
                        //    string assetName = fontTemp.name;
                        //    if (fontAssetName == assetName)
                        //    {
                        //        UnityEngine.Debug.Log($" {textTemp.name}");
                        //    }
                        //}

                        //TextMeshPro[] tmpProAr = tmpObj.GetComponentsInChildren<TextMeshPro>();
                        //for (int t = 0; t < tmpProAr.Length; t++)
                        //{
                        //    TextMeshPro textTemp = tmpProAr[t];
                        //    TMP_FontAsset fontTemp = textTemp.font;
                        //    if (fontTemp == null)
                        //    {
                        //        continue;
                        //    }
                        //    string assetName = fontTemp.name;
                        //    if (fontAssetName == assetName)
                        //    {
                        //        UnityEngine.Debug.Log($" {textTemp.name}");
                        //    }
                        //}
                    }
                }
            }

            UnityEngine.Debug.Log("KCheckFontReferences: End");
        }

        // [MenuItem("Asset / ), false, 1]
        [MenuItem("Assets/Custom/Check References Scene", false, 1)]//路径
        public static void KCheckSceneReferences()
        {
            string fontPath = AssetDatabase.GetAssetPath(Selection.activeInstanceID);

            string[] assetPath = fontPath.Split('/');
            string fontAssetName = assetPath[assetPath.Length - 1];
            if (fontAssetName.Contains("."))
            {
                fontAssetName = fontAssetName.Split('.')[0];
            }

            UnityEngine.Debug.Log("KCheckFontReferences: Begin");

            List<string> fileList = new List<string>();
            fileList.AddRange(GetFile(sSceneCheckPath, fileList));

            string dataPath = Application.dataPath;
            int pathLength = dataPath.Length - 6;
            for (int i = 0; i < fileList.Count; i++)
            {
                string itemPath = fileList[i];
                if (itemPath.Contains(".meta"))
                {
                    continue;
                }

                itemPath = itemPath.Remove(0, pathLength);
                string[] dependPathList = AssetDatabase.GetDependencies(new string[] { itemPath });
                foreach (string path in dependPathList)
                {
                    if (path == fontPath)
                    {
                        UnityEngine.Debug.Log($"以下文件有引用： {itemPath} ");
                    }
                }
            }

            UnityEngine.Debug.Log("KCheckFontReferences: End");
        }



        [MenuItem(KBuildAssetBundles)]
        public static void CheckAtlasReferences()
        {
            UnityEngine.Debug.LogError("CheckAtlasReferences: Begin");

            List<string> fileList = new List<string>();
            fileList = GetFile(sBundleCheckPath, fileList);

            string dataPath = Application.dataPath;
            int pathLength = dataPath.Length - 6;
            for (int i = 0; i < fileList.Count; i++)
            {
                string itemPath = fileList[i];
                if (itemPath.Contains(".meta"))
                {
                    continue;
                }

                itemPath = itemPath.Remove(0, pathLength);
                string[] dependPathList = AssetDatabase.GetDependencies(new string[] { itemPath });
                foreach (string path in dependPathList)
                {
                    if (path.Contains("UI/Icon"))
                    {
                        UnityEngine.Debug.LogError(string.Format("以下文件有引用{0}：{1}:  ", itemPath, path));
                        continue;
                    }
                }
            }
            UnityEngine.Debug.LogError("CheckAtlasReferences: End");
        }

        [MenuItem(KBuildMainUIBundles)]
        public static void CheckMainUIReferences()
        {
            UnityEngine.Debug.LogError("CheckMainUIReferences: Begin");

            List<string> fileList = new List<string>();
            List<string> uiList = new List<string>();
            fileList = GetFile("Assets/Res/UI/UIRes/Atlas/MainUI", fileList);

            string dataPath = Application.dataPath;
            int pathLength = dataPath.Length - 6;
            for (int i = 0; i < fileList.Count; i++)
            {
                string itemPath = fileList[i];
                if (itemPath.Contains(".meta"))
                {
                    continue;
                }

                itemPath = itemPath.Remove(0, pathLength);
                uiList.Add(itemPath);
            }

            fileList = new List<string>();
            fileList.AddRange(GetFile(sBundleUICheckPath, fileList));

            dataPath = Application.dataPath;
            pathLength = dataPath.Length - 6;
            for (int i = 0; i < fileList.Count; i++)
            {
                string itemPath = fileList[i];
                if (itemPath.Contains(".meta"))
                {
                    continue;
                }

                itemPath = itemPath.Remove(0, pathLength);
                if (itemPath == "UIMain")
                {
                }
                string[] dependPathList = AssetDatabase.GetDependencies(new string[] { itemPath });
                foreach (string path in dependPathList)
                {
                    if (uiList.Contains(path))
                    {
                        UnityEngine.Debug.Log($"以下文件有引用： {itemPath} ");
                    }
                }
            }

            UnityEngine.Debug.LogError("CheckMainUIReferences: End");
        }

        [MenuItem(KBuildBloodBundles)]
        public static void CheckBloodReferences()
        {
            UnityEngine.Debug.LogError("CheckBloodReferences: Begin");

            List<string> fileList = new List<string>();
            fileList = GetFile(sBundleBloodPath, fileList);

            string dataPath = Application.dataPath;
            int pathLength = dataPath.Length - 6;
            for (int i = 0; i < fileList.Count; i++)
            {
                string itemPath = fileList[i];
                if (itemPath.Contains(".meta"))
                {
                    continue;
                }
                if (!itemPath.Contains("Hp"))
                {
                    continue;
                }

                itemPath = itemPath.Remove(0, pathLength);
                string[] dependPathList = AssetDatabase.GetDependencies(new string[] { itemPath });
                foreach (string path in dependPathList)
                {
                    if (!path.Contains("UIRes/Atlas"))
                    {
                        UnityEngine.Debug.LogError(string.Format("以下文件有引用{0}：{1}:  ", itemPath, path));
                        continue;
                    }
                }
            }
            UnityEngine.Debug.LogError("CheckBloodReferences: End");
        }

        /// <summary>
        /// 获取路径下所有文件以及子文件夹中文件
        /// </summary>
        /// <param name="path">全路径根目录</param>
        /// <param name="FileList">存放所有文件的全路径</param>
        /// <returns></returns>
        public static List<string> GetFile(string path, List<string> FileList)
        {
            DirectoryInfo dir = new DirectoryInfo(path);
            FileInfo[] fil = dir.GetFiles();
            DirectoryInfo[] dii = dir.GetDirectories();
            foreach (FileInfo f in fil)
            {
                //int size = Convert.ToInt32(f.Length);
                long size = f.Length;
                FileList.Add(f.FullName);//添加文件路径到列表中
            }
            //获取子文件夹内的文件列表，递归遍历
            foreach (DirectoryInfo d in dii)
            {
                GetFile(d.FullName, FileList);
            }
            return FileList;
        }

    }

}
