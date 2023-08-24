using UnityEditor;
using System.IO;
using System.Collections.Generic;
using UnityEngine;

namespace Assets.Editor
{
    public class UITypeEnum
    {
        public static string FONT = "Font Material";
        public static string ICON = "CommonIcon";
        public static string TEXTURE = "Hidden/Unlit/Transparent Colored 1";
    }

    public class AdjustDepthForDrawCall : EditorWindow
    {
        public static int fontDepth = 80;
        public static int commonIconDepth = 75;
        public static int textureDepth = 70;
        public static DirectoryInfo mFileDirectory;
        public static FileInfo[] mFileInfoList;

        [MenuItem("Assets/NGUI/AdjustDepthForDC", false, 0)]
        static public void AdjustDepthForDC()
        {
            string[] assetGUIDs = Selection.assetGUIDs;

            if (assetGUIDs.Length > 0)
            {
                string path = AssetDatabase.GUIDToAssetPath(assetGUIDs[0]);
                mFileDirectory = new DirectoryInfo(path);
                mFileInfoList = GetFileInfoList(mFileDirectory);
            }

            for (int i = 0; i < mFileInfoList.Length;i++ )
            {
                FileInfo fileInfo = mFileInfoList[i];

                string itemPath = fileInfo.FullName.Remove(0, fileInfo.FullName.IndexOf("Assets"));
                GameObject obj = AssetDatabase.LoadAssetAtPath(itemPath, typeof(object)) as GameObject;
                SetDepth(obj);
            }
        }

        static public FileInfo[] GetFileInfoList(DirectoryInfo directoryInfo, string postfix = "")
        {
            FileInfo[] rawFileList = directoryInfo.GetFiles();
            List<FileInfo> fileList = new List<FileInfo>();

            foreach (FileInfo info in rawFileList)
            {
                if (string.IsNullOrEmpty(postfix))
                {
                    if (info.Name.EndsWith("meta"))
                        continue;

                    if (info.Name.EndsWith("mat"))
                        continue;

                    if (info.Name.EndsWith("exr"))
                        continue;

                    if (info.Name.EndsWith("asset"))
                        continue;

                    if (info.Name.EndsWith("txt"))
                        continue;
                }
                else
                {
                    if (info.Name.EndsWith(postfix) == false)
                        continue;
                }

                fileList.Add(info);
            }

            return fileList.ToArray();
        }

        public static void  SetDepth(GameObject go)
        {
            if (go == null)
            {
                return;
            }

            int labelCount = 0;
            int iconCount = 0;
            int textureCount = 0;

            Component[] list = go.GetComponentsInChildren(typeof(Transform), true);
            for (int i = 0, count = list.Length; i < list.Length; i++)
            {
                GameObject target = list[i].gameObject;

                UILabel label = target.GetComponent<UILabel>();
                if (label != null)
                {
                    label.depth = fontDepth;
                    labelCount++;
                    continue;
                }
                else
                {
                    UITexture texture = target.GetComponent<UITexture>();
                    if (texture != null)
                    {
                        texture.depth = textureDepth;
                        textureCount++;
                        continue;
                    }
                    else
                    {
                        UISprite sprite = target.GetComponent<UISprite>();
                        if (sprite != null)
                        {
                            if (sprite.atlas != null)
                            {
                                if (sprite.atlas.name == UITypeEnum.ICON)
                                {
                                    sprite.depth = commonIconDepth;
                                    iconCount++;
                                    continue;
                                }
                            }
                        }
                    }
                }
            }

            Debug.LogError(string.Format("{3}设置层级成功！ Icon：{0}； Font：{1}； Texture：{2}；", iconCount, labelCount, textureCount,go.name));
        }
    }
}
