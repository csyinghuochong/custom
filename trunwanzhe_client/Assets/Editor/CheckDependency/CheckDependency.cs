using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using UnityEditor;

namespace Assets.Editor
{
    public class CheckDependency
    {
        private string[] showPostfix = new string[]
        {
                    
        };

        /// <summary>
        /// 显示在输出结果中的依赖检测结果
        /// </summary>
        public virtual string[] mFinalShowPostfix
        {
            get
            {
                return showPostfix;
            }
            set
            {
                showPostfix = value;
            }
        }

        private string[] ignoreFilePostfix = new string[]
        {
            ".meta", ".cs", ".txt",        
        };

        /// <summary>
        /// 不进行依赖检测的文件后缀名
        /// </summary>
        public virtual string[] mIngnoreFilePostfix
        {
            get
            {
                return ignoreFilePostfix;
            }
            set
            {
                ignoreFilePostfix = value;
            }
        }

        public event Action<int, string, string> ValidateCheck;

        public void Check(string checkPath)
        {
            if (IsDirectory(checkPath))
            {
                DirectoryInfo currentDirInfo = new DirectoryInfo(checkPath);
                DirectoryInfo[] directoryInfos = GetFolderInfoList(currentDirInfo);
                
                if (directoryInfos != null && directoryInfos.Length != 0)
                {
                    foreach (DirectoryInfo info in directoryInfos)
                    {
                        Check(info.FullName);
                    }
                }
                else
                {
                    foreach (FileInfo f in currentDirInfo.GetFiles())
                    {
                        CheckItem(f.FullName);
                    }
                }
            }
            else
            {
                CheckItem(checkPath);
            }                 

        }

        private bool IsDirectory(string checkPath)
        {
            FileAttributes attr = File.GetAttributes(checkPath);
            return (attr & FileAttributes.Directory) == FileAttributes.Directory;
        }

        private void CheckItem(string checkPath)
        {
            foreach (string filter in mIngnoreFilePostfix)
            {
                if (checkPath.EndsWith(filter))
                    return;
            }

            string itemPath = checkPath.Remove(0, checkPath.IndexOf("Assets"));
            string[] dependPathList = AssetDatabase.GetDependencies(new string[] { itemPath });
            itemPath = itemPath.Replace("\\", "/");

            int refCount = 0;
            foreach (string path in dependPathList)
            {
                if (mFinalShowPostfix != null && mFinalShowPostfix.Length != 0)
                {
                    foreach (string filter in mFinalShowPostfix)
                    {
                        if (path.EndsWith(filter))
                        {
                            refCount++;
                            PrintResult(refCount, itemPath, path);
                        }
                    }
                }
                else
                {
                    refCount++;
                    PrintResult(refCount, itemPath, path);
                }
            }            
        }

        protected virtual void PrintResult(int count, string checkPath, string refPath)
        {
            if (ValidateCheck != null)
            {
                ValidateCheck(count, checkPath, refPath);
            }
            else
                UnityEngine.Debug.Log(string.Format("{0} 引用了 {1}", checkPath, refPath));
        }

        protected virtual DirectoryInfo[] GetFolderInfoList(DirectoryInfo directoryInfo)
        {
            DirectoryInfo[] rawFolderList = directoryInfo.GetDirectories();
            List<DirectoryInfo> folderList = new List<DirectoryInfo>();

            foreach (DirectoryInfo info in rawFolderList)
            {
                if (info.Name.EndsWith(".svn"))
                    continue;

                folderList.Add(info);
            }

            return folderList.ToArray();
        }
    }
}
