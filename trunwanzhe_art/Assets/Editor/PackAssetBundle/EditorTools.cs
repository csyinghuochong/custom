using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEditor;

namespace Assets.Editor
{
    public static class EditorTools
    {
        public static string GetAssetsPath(string path)
        {
            return path.Remove(0, path.IndexOf("Assets"));
        }

        public static UnityEngine.Object LoadAssetAtPath(string path)
        {
            return AssetDatabase.LoadAssetAtPath(GetAssetsPath(path), typeof(Object));
        }
    }
}
