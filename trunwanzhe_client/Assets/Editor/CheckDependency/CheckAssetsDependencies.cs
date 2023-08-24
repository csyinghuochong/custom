using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using UnityEditor;

namespace Assets.Editor
{
    public class CheckAssetsDependencies : EditorWindow
    {
        [MenuItem("Assets/Check/CheckUIDependencies", false, 0)]
        public static void CheckDependencies()
        {
            string[] assetGUIDs = Selection.assetGUIDs;

            if (assetGUIDs.Length > 0)
            {
                string path = AssetDatabase.GUIDToAssetPath(assetGUIDs[0]);
                UnityEngine.Debug.Log(string.Format("开始检测{0}的资源引用", path));
                CheckDependency check = new CheckDependency();
                check.mFinalShowPostfix = new string[]
                {
                    ".prefab",                
                };
                check.ValidateCheck += delegate(int refCount, string checkPath, string refPath)
                {
                    string[] checkStrs = checkPath.Split('/');
                    string[] refStrs = refPath.Split('/');

                    if (checkStrs.Length < 2 || refStrs.Length < 2) return;

                    string refName = refStrs[refStrs.Length - 1];                    
                    string checkName = checkStrs[checkStrs.Length - 1];

                    string refFloder = refStrs[refStrs.Length - 2];
                    string checkFloder = checkStrs[checkStrs.Length - 2];
                    if (refFloder != checkFloder && refName != "Common1Atlas.prefab" && refName != "FZZhunYuanFont.prefab")
                    {
                        UnityEngine.Debug.LogError(string.Format("警告！！！ {0}  引用了  {1}", checkName, refName));
                    }
                    
                };
                check.Check(path);
                UnityEngine.Debug.Log("检测结束");
            }
        }

        [MenuItem("Assets/Check/CheckAllDependencies", false, 1)]
        public static void CheckAllDependencies()
        {
            string[] assetGUIDs = Selection.assetGUIDs;

            if (assetGUIDs.Length > 0)
            {
                string path = AssetDatabase.GUIDToAssetPath(assetGUIDs[0]);
                UnityEngine.Debug.Log(string.Format("开始检测{0}的资源引用", path));
                CheckDependency check = new CheckDependency();                
                check.Check(path);
                UnityEngine.Debug.Log("检测结束");
            }
        }
        
        
    }
}
