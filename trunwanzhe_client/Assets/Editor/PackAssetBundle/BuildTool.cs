using UnityEngine;
using UnityEditor;
using System.IO;
using System.Collections.Generic;
using SyntaxTree.VisualStudio.Unity.Bridge;
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

    public static bool sRelease = false;

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
        ProjectFilesGenerator.GenerateFiles();
    }

    void GetLuaBytes(string sourceDir, Dictionary<string, byte[]> luaScripts, string searchPattern = "*.lua", SearchOption option = SearchOption.AllDirectories)
    {
        string[] files = Directory.GetFiles(sourceDir, searchPattern, option);

        foreach (string fileName in files)
        {
            string path = fileName.Replace(@"\", @"/").Replace(sourceDir + @"/", "");
            string name = path.Replace(".lua", "");

            if (luaScripts.ContainsKey(name))
            {
                Debug.LogError("GetLuaBytes error:" + fileName);
                return;
            }

            luaScripts[name] = System.IO.File.ReadAllBytes(fileName);
        }
    }

    public void BuildLua()
    {
        Dictionary<string, byte[]> luaScripts = new Dictionary<string, byte[]>();

        GetLuaBytes(LuaConst.luaDir, luaScripts);
        GetLuaBytes(LuaConst.toluaDir, luaScripts);

        string luaPath = "Assets/RawResources/Dll/Lua.bytes";
        SaveAllBytes(luaScripts, luaPath);

        AssetDatabase.Refresh();
    }

    public void SaveAllBytes(Dictionary<string, byte[]> dic, string fileName)
    {
        using (MemoryStream ms = new MemoryStream())
        {
            foreach (KeyValuePair<string, byte[]> kvp in dic)
            {
                string unikey = kvp.Key;
                byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
                byte[] unikeyBytesLen = System.BitConverter.GetBytes(unikeyBytes.Length);

                ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
                ms.Write(unikeyBytes, 0, unikeyBytes.Length);

                using (MemoryStream item = new MemoryStream(kvp.Value))
                {
                    item.Position = 0;
                    byte[] itemMSBytesLen = System.BitConverter.GetBytes((int)item.Length);
                    ms.Write(itemMSBytesLen, 0, itemMSBytesLen.Length);

                    item.WriteTo(ms);
                }
            }

            byte[] fileBytes = ms.ToArray();
            using (FileStream fileStream = new FileStream(fileName, FileMode.Create))
            {
                fileStream.Write(fileBytes, 0, fileBytes.Length);
            }
        }
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

    public void EncryptDll()
    {
        mMD5Tool.EncryptDll();
    }

    public void EncryptConfig()
    {
        mMD5Tool.EncryptConfig();
    }

    public void MakePlatformConfig(string platform)
    {
        mMD5Tool.MakePlatformConfig(platform);
    }

    public void Build()
    {
        Build(mIndex);
    }

    public void Build(TargetType targetType)
    {
        isPacking = true;

        if (targetType == TargetType.IOS)
        {
            //ReplaceIOSAssets();
        }

        mIndex = targetType;
        SetBundleTarget();

        bool onlyBuildFile = mSubFolderInfoList == null;
        DoBuild(mFolderDirectory, mSavePath, onlyBuildFile);
        AssetDatabase.Refresh();

        mDependTool.Save();

        isPacking = false;
    }

    public void ReplaceIOSAssets()
    {
        string rootPath = "Assets";
        string srcPath = "AssetsLibrary/IOSAssets";
        string targetPath = "AssetsLibrary/UI/Background";

        List<string> list = new List<string>() { "Background01.jpg", "Background09.jpg" };

        for (int i = 0, count = list.Count; i < count; i++)
        {
            string name = list[i];
            FileUtil.ReplaceFile(string.Format("{0}/{1}/{2}", rootPath, srcPath, name), string.Format("{0}/{1}/{2}", rootPath, targetPath, name));
        }

        FileUtil.ReplaceFile("Assets/AssetsLibrary/IOSAssets/LoginBGView.prefab", "Assets/RawResources/UI/Login/LoginBGView.prefab");

        AssetDatabase.Refresh();
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
            return directoryInfo.FullName.IndexOf("RawResources/UI") != -1;
        }

        return directoryInfo.FullName.IndexOf("RawResources\\UI") != -1;
    }

    private void BuildAssetBundle(DirectoryInfo directoryInfo, string savePath, FileInfo[] fileInfoList)
    {
        if (fileInfoList.Length <= 0)
            return;

        bool uncompressDirectory =
            //directoryInfo.Name == "BinData" ||
            //IsUIDirectory(directoryInfo) ||
            //directoryInfo.Name == "Music" ||
            //directoryInfo.Name == "ItemIcon" ||
            //directoryInfo.Name == "RoleIcon" ||
                directoryInfo.Name == "LevelMap";

        foreach (FileInfo fileInfo in fileInfoList)
        {
            Object obj = EditorTools.LoadAssetAtPath(fileInfo.FullName) as Object;

            if (obj == null)
            {
                Debug.LogError("BuildAssetBundle null:" + fileInfo.FullName);
                continue;
            }

            mDependTool.AssetDependencies(fileInfo, obj, delegate()
            {
                string itemSavePath = savePath + "/" + obj.name + ".bytes";

                BuildAssetBundleOptions options = option;

                //&& mIndex == TargetType.ANDROID
                if (uncompressDirectory)
                {
                    options |= BuildAssetBundleOptions.UncompressedAssetBundle;
                }

                bool IsPackSuccess = BuildPipeline.BuildAssetBundle(null, new UnityEngine.Object[] { obj }, itemSavePath, options, mBuildTarget);

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

            mDependTool.SceneDependencies(fileInfo, SceneRoot);


            AssetDatabase.Refresh();

            string itemSavePath = string.Format("{0}/{1}.bytes", savePath, Path.GetFileNameWithoutExtension(fileInfo.Name));
            string result = string.Empty;

            if (string.IsNullOrEmpty(result) == false)
            {
                Debug.LogError("buildScene:" + directoryInfo.Name);
            }
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

