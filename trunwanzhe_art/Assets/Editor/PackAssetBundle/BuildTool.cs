using UnityEngine;
using UnityEditor;
using System.IO;
using System.Collections.Generic;
using Assets.Editor;

public enum TargetType
{
    ANDROID,
    IOS,
    WIN_64,
    WIN_32,
    WP
}

public class BuildTool
{
    public DirectoryInfo mFolderDirectory;//文件夹目录

    public FileInfo[] mSubFileInfoList; //子文件列表
    public DirectoryInfo[] mSubFolderInfoList; //子文件夹列表

    public string mFolderPath = ""; //选择文件夹的路径
    public string mSavePath = ""; //保存文件夹的路径

    public bool isPacking = false;

    public BuildTarget mBuildTarget = BuildTarget.Android;
    public string[] mTargetOptions = { "Android", "IOS", "Windows_64", "Windows_32" };
    BuildTarget[] targets = { BuildTarget.Android, BuildTarget.iOS, BuildTarget.StandaloneWindows64, BuildTarget.StandaloneWindows };
    public TargetType mIndex = TargetType.ANDROID;

    public BuildAssetBundleOptions option = BuildAssetBundleOptions.CollectDependencies | BuildAssetBundleOptions.DeterministicAssetBundle;

    private MD5Tool mMD5Tool;
    private DependTool mDependTool;

    public static bool sReleaseBuild = false;

    public void PackByPath(string path)
    {
        if (Path.HasExtension(path))
        {
            InitFolder(Path.GetDirectoryName(path));
            InitFile(path);
        }
        else
        {
            InitFolder(path);
        }
    }

    public void PackByPath(string[] assetGUIDs)
    {
        if (assetGUIDs.Length > 0)
        {
            //默认只支持第一个选中文件下选中文件打包，不支持跨目录打包
            string path = AssetDatabase.GUIDToAssetPath(assetGUIDs[0]);

            if (Path.HasExtension(path))
            {
                InitFolder(Path.GetDirectoryName(path));
                InitFile(path, assetGUIDs);
            }
            else
            {
                InitFolder(path);
            }
        }
    }

    public BuildTool()
    {
        //预编译资源包平台
#if UNITY_STANDALONE_WIN
        mIndex = TargetType.WIN_32;
#elif UNITY_ANDROID
        mIndex = TargetType.ANDROID;
#else
        mIndex = TargetType.IOS;
#endif

        mMD5Tool = new MD5Tool(this);
        mDependTool = new DependTool(this);
    }

    public void InitFolder(string folderPath)
    {
        mFolderPath = folderPath;
        mFolderDirectory = new DirectoryInfo(folderPath);

        mSubFileInfoList = GetFileInfoList(mFolderDirectory);
        mSubFolderInfoList = GetFolderInfoList(mFolderDirectory);

        mSavePath = GetSavePath(mFolderDirectory.FullName);
    }

    //初始化子文件列表
    public void InitFile(string filePath)
    {
        mSubFileInfoList = GetFileInfoList(mFolderDirectory);

        mSubFolderInfoList = null;
    }

    //初始化选中的子文件列表
    public void InitFile(string filePath, string[] assetGUIDs)
    {
        List<FileInfo> rawFileInfoList = new List<FileInfo>(GetFileInfoList(mFolderDirectory));

        for (int i = rawFileInfoList.Count - 1; i >= 0; i--)
        {
            FileInfo fileInfo = rawFileInfoList[i];

            bool match = false;

            for (int j = 0, count = assetGUIDs.Length; j < count; j++)
            {
                string path = AssetDatabase.GUIDToAssetPath(assetGUIDs[j]);

                if (Path.GetFileName(path) == fileInfo.Name)
                {
                    match = true;
                    break;
                }
            }

            if (match == false)
            {
                rawFileInfoList.RemoveAt(i);
            }
        }

        mSubFileInfoList = rawFileInfoList.ToArray();
        mSubFolderInfoList = null;
    }

    public void GenerateProjectFiles()
    {
        //ProjectFilesGenerator.GenerateFiles();
    }

    public void MakeMD5File(TargetType targetType)
    {
        mIndex = targetType;
        DoMakeMD5File();
    }

    //生成每个资源包的md5码
    public void MakeMD5File()
    {
        DoMakeMD5File();
    }

    private void DoMakeMD5File()
    {
        mMD5Tool.Make();
    }

    public void DeleteMD5Bytes()
    {
        //mMD5Tool.DeleteMD5Bytes();
    }

    public void CopyMD5ToVersion()
    {
        //mMD5Tool.CopyMD5ToVersion();
    }

    public void MakePlatformConfig(string str, string versionNum)
    {
        mMD5Tool.MakePlatformConfig(str, versionNum);
    }

    public void Build()
    {
        Build(mIndex);
    }

    public void Build(TargetType targetType)
    {
        isPacking = true;

        mIndex = targetType;
        SetBundleTarget();

        bool onlyBuildFile = mSubFolderInfoList == null;
        DoBuild(mFolderDirectory, mSavePath, onlyBuildFile);
        AssetDatabase.Refresh();

        mDependTool.Save();

        isPacking = false;
    }

    //选择打包平台
    void SetBundleTarget()
    {
        mBuildTarget = targets[(int)mIndex];
    }

    void DoBuild(DirectoryInfo directoryInfo, string savePath, bool onlyBuildFile)
    {
        if (Directory.Exists(savePath) == false)
            Directory.CreateDirectory(savePath);

        FileInfo[] sceneInfoList = GetSceneInfoList(directoryInfo);

        if (sceneInfoList.Length > 0)
        {
            if (onlyBuildFile)
            {
                BuildScene(directoryInfo, savePath, mSubFileInfoList);
            }
            else
            {
                BuildScene(directoryInfo, savePath, sceneInfoList);
            }
        }
        else
        {
            if (onlyBuildFile)
            {
                BuildAssetBundle(directoryInfo, savePath, mSubFileInfoList);
            }
            else
            {
                FileInfo[] fileInfoList = GetFileInfoList(directoryInfo);

                BuildAssetBundle(directoryInfo, savePath, fileInfoList);
            }
        }

        if (onlyBuildFile == false)
        {
            DirectoryInfo[] folderInfoList = GetFolderInfoList(directoryInfo);
            foreach (DirectoryInfo folderInfo in folderInfoList)
            {
                DoBuild(folderInfo, GetSavePath(folderInfo.FullName), onlyBuildFile);
            }
        }
    }

    private bool IsUIDirectory(DirectoryInfo directoryInfo)
    {
        if (mBuildTarget == BuildTarget.iOS)
        {
            return directoryInfo.FullName.IndexOf("RawResources/UI") != -1 || directoryInfo.FullName.IndexOf("RawResources/View") != -1;
        }

        return directoryInfo.FullName.IndexOf("RawResources\\UI") != -1 || directoryInfo.FullName.IndexOf("RawResources\\View") != -1;
    }

    private void BuildAssetBundle(DirectoryInfo directoryInfo, string savePath, FileInfo[] fileInfoList)
    {
        if (fileInfoList.Length <= 0)
            return;

        foreach (FileInfo fileInfo in fileInfoList)
        {
            Object obj = EditorTools.LoadAssetAtPath(fileInfo.FullName) as Object;

            if (obj == null)
            {
                Debug.LogError("BuildAssetBundle null:" + fileInfo.FullName);
                continue;
            }

            string directoryName = directoryInfo.Name;
            bool isUncompressDirectory = directoryName == "Fx" || directoryName == "Role";//&& mIndex == TargetType.ANDROID;

            mDependTool.AssetDependencies(fileInfo, obj, delegate()
            {
                string itemSavePath = savePath + "/" + obj.name + ".bytes";

                bool IsPackSuccess = BuildPipeline.BuildAssetBundle(null, new UnityEngine.Object[] { obj }, itemSavePath, isUncompressDirectory ? option | BuildAssetBundleOptions.UncompressedAssetBundle : option, mBuildTarget);

                if (IsPackSuccess == false)
                {
                    Debug.LogError("pack error:" + itemSavePath);
                }
            });
        }
    }

    private void BuildScene(DirectoryInfo directoryInfo, string savePath, FileInfo[] fileInfoList)
    {
        foreach (FileInfo fileInfo in fileInfoList)
        {
            string scenePath = EditorTools.GetAssetsPath(fileInfo.FullName);
            EditorApplication.OpenScene(scenePath);

            GameObject SceneRoot = GameObject.Find("SceneRoot");
            if (SceneRoot == null)
            {
                Debug.LogError("BuildScene null:" + fileInfo.FullName);
                continue;
            }

            mDependTool.SceneDependencies(fileInfo, SceneRoot, delegate()
            {
                
                AssetDatabase.Refresh();

                string itemSavePath = string.Format("{0}/{1}.bytes", savePath, Path.GetFileNameWithoutExtension(fileInfo.Name));
                string result = string.Empty;
               // BuildPipeline.BuildPlayer(new string[] { scenePath }, itemSavePath, mBuildTarget, BuildOptions.BuildAdditionalStreamedScenes);

                if (string.IsNullOrEmpty(result) == false)
                {
                    Debug.LogError("buildScene:" + directoryInfo.Name);
                }
            });

        }
    }

    public string GetSavePath(string filePath)
    {
        filePath = filePath.Replace("\\", "/");
        string savePath = filePath.Remove(0, filePath.IndexOf("Assets/") + "Assets/".Length);

        if (savePath.IndexOf("/") != -1)
        {
            savePath = savePath.Substring(savePath.IndexOf("/"));
        }
        else
        {
            savePath = "";
        }

        savePath = Application.dataPath + "/StreamingAssets" + savePath;

        return savePath;
    }

    public FileInfo[] GetFileInfoList(DirectoryInfo directoryInfo, string postfix = "")
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

    public FileInfo[] GetSceneInfoList(DirectoryInfo directoryInfo)
    {
        return directoryInfo.GetFiles("*.unity");
    }

    public DirectoryInfo[] GetFolderInfoList(DirectoryInfo directoryInfo)
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

