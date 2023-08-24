using UnityEditor;
using System.IO;
using UnityEngine;
using Assets.Plugins.Assets.Scripts.Com.Game.Platform;

public class CommandBuild
{
    public static void DelNonVersion()
    {
        string strReadFilePath = Application.dataPath + "/SvnStatus.txt";

        if (File.Exists(strReadFilePath) == false)
            return;

        using (StreamReader srReadFile = new StreamReader(strReadFilePath))
        {
            while (!srReadFile.EndOfStream)
            {
                string strReadLine = srReadFile.ReadLine();
                if (strReadLine.IndexOf("?") != -1)
                {
                    string filePath = strReadLine.Replace("?       ", "").Trim();
                    FileUtil.DeleteFileOrDirectory("Assets/" + filePath);
                }
            }
        };

        AssetDatabase.Refresh();
    }

    private static void BuildGameResources(TargetType targetType)
    {
        BuildTool.sRelease = true;

        BuildTool buildTool = new BuildTool();
        buildTool.DeleteMD5Bytes();
        buildTool.BuildLua();

        buildTool.PackByPath("Assets/RawResources");
        buildTool.Build(targetType);
    }

    private static void BuildGameDll(TargetType targetType)
    {
        BuildTool buildTool = new BuildTool();

        buildTool.PackByPath("Assets/RawResources/Dll");
        buildTool.Build(targetType);
    }

    public static void BuildGameResourcesAndroid()
    {
        BuildGameResources(TargetType.ANDROID);
    }

    public static void BuildGameResourcesIOS()
    {
        BuildGameResources(TargetType.IOS);
    }

    public static void BuildGameResourcesWP()
    {
        BuildGameResources(TargetType.WP);
    }

    public static void BuildGameDllAndroid()
    {
        BuildGameDll(TargetType.ANDROID);
    }

    public static void BuildGameDllIOS()
    {
        BuildGameDll(TargetType.IOS);
    }

    public static void BuildGameDllWP()
    {
        BuildGameDll(TargetType.WP);
    }

    private static void MakeMD5File(TargetType targetType)
    {
        BuildTool buildTool = new BuildTool();
        buildTool.MakeMD5File(targetType);
    }

    public static void MakeMD5FileAndroid()
    {
        MakeMD5File(TargetType.ANDROID);
    }

    public static void MakeMD5FileIOS()
    {
        MakeMD5File(TargetType.IOS);
    }

    public static void MakeMD5FileWP()
    {
        MakeMD5File(TargetType.WP);
    }

    //     public static void MakePlatformConfig()
    //     {
    //         string platformName = GetExternalArg("platformName");
    //         string versionNum = GetExternalArg("versionNum");
    // 
    //         if (string.IsNullOrEmpty(platformName))
    //             return;
    // 
    //         BuildTool buildTool = new BuildTool();
    //         buildTool.MakePlatformConfig(platformName, versionNum);
    //     }

    public static void BuildGamesAndroid()
    {
        string[] platformList = GetExternalArg("platformList").Split('_');
        string version = GetExternalArg("version");

        BuildTool buildTool = new BuildTool();

        for (int i = 0, count = platformList.Length; i < count; i++)
        {
            buildTool.MakePlatformConfig(platformList[i]);

            if (version == "Release")
            {
                BuildAndroidRelease();
            }
            else
            {
                BuildAndroidDebug();
            }
        }
    }

    public static void BuildGamesIOS()
    {
        string[] platformList = GetExternalArg("platform").Split('_');
        string version = GetExternalArg("version");

        BuildTool buildTool = new BuildTool();

        for (int i = 0, count = platformList.Length; i < count; i++)
        {
            buildTool.MakePlatformConfig(platformList[i]);

            if (version == "Release")
            {
                BuildIOSRelease();
            }
            else
            {
                BuildIOSDebug();
            }
        }
    }

    public static void BuildGameProjectFiles()
    {
        BuildTool buildTool = new BuildTool();
        buildTool.GenerateProjectFiles();
    }

    private static void BuildArtResources(TargetType targetType)
    {
        File.Copy(Application.dataPath + "/Editor/GraphicsSettings.asset.template", Application.dataPath.Replace("Assets", "") + "ProjectSettings/GraphicsSettings.asset", true);
        AssetDatabase.Refresh();

        BuildTool buildTool = new BuildTool();

        buildTool.PackByPath("Assets/RawResourcesExport");
        buildTool.Build(targetType);
    }

    public static void BuildArtResourcesAndroid()
    {
        BuildArtResources(TargetType.ANDROID);
    }

    public static void BuildArtResourcesIOS()
    {
        BuildArtResources(TargetType.IOS);
    }

    public static void BuildArtResourcesWP()
    {
        BuildArtResources(TargetType.WP);
    }

    private static string[] GetReleaseBuildLevels()
    {
        string[] levels = { "Assets/Scenes/LoginRelease.unity", "Assets/Scenes/Main.unity" };
        return levels;
    }

    private static string[] GetDebugBuildLevels()
    {
        string[] levels = { "Assets/Scenes/LoginDebug.unity", "Assets/Scenes/Main.unity" };
        return levels;
    }

    private static void SetBundleVersion(bool android)
    {
        PlatformManager.Instance.LoadVersion();

        string version = PlatformManager.Instance.mVersion;

        PlayerSettings.bundleVersion = version;
      
        if (android)
        {
            PlayerSettings.Android.bundleVersionCode = new PlatformVersion(version).version;
        }
    }

    private static void SetProduct()
    {
        return;
        PlayerSettings.productName = "超神之战";
        PlayerSettings.applicationIdentifier = "com.maipao.cszz";
        //PlayerSettings.companyName = "Guangzhou Maipao Information Technology Co., Ltd.";
    }

    public static void SetAndroidSDK(bool movePlatform)
    {
        return;

        string platformName = PlatformManager.GetLastPlatformName();

        string[] pathList = new string[] { "Assets/Plugins/Android", "Assets/StreamingAssets" };
        for (int i = 0, count = pathList.Length; i < count; i++)
        {
            AssetDatabase.DeleteAsset(pathList[i]);
        }
        AssetDatabase.Refresh();

        MoveSDK("ApkBase");

        if (movePlatform)
            MoveSDK(platformName);

        AssetDatabase.Refresh();
    }

    static void MoveSDK(string name)
    {
        string path = string.Format("Editor/SDKAssets/{0}", name);

        FileStaticAPI.CopyFolder(path + "/Plugins", "Plugins");
        FileStaticAPI.CopyFolder(path + "/StreamingAssets", "StreamingAssets");
    }

    public static void BuildAndroid(string[] levels, string name = "")
    {
        SetBundleVersion(true);
        SetAndroidSDK(true);

        PlayerSettings.keyaliasPass = "keystore20160804";
        PlayerSettings.keystorePass = "mp0703";

        string platformName = PlatformManager.GetLastPlatformName();
        name = platformName + name;

        if (platformName == "Apk360")
        {
            FileUtil.DeleteFileOrDirectory(platformName);
            BuildPipeline.BuildPlayer(levels, platformName, BuildTarget.Android, BuildOptions.AcceptExternalModificationsToPlayer);
        }
        //else
        {
            BuildPipeline.BuildPlayer(levels, string.Format("Assets/{0}_{1}.apk", name, PlatformManager.Instance.mVersion), BuildTarget.Android, BuildOptions.None);
        }

        SetAndroidSDK(false);
    }

    //------release-----------//
    public static void BuildAndroidRelease()
    {
        BuildAndroid(GetReleaseBuildLevels());
    }

    public static void BuildIOSRelease()
    {
        SetBundleVersion(false);

        SetProduct();

        //BuildPipeline.BuildPlayer(GetReleaseBuildLevels(), "ios", BuildTarget.iPhone, BuildOptions.None);
    }

    //------debug-----------//
    public static void BuildAndroidDebug()
    {
        BuildAndroid(GetDebugBuildLevels(), "Debug");
    }

    public static void BuildIOSDebug()
    {
        SetBundleVersion(false);

        SetProduct();

        //BuildPipeline.BuildPlayer(GetDebugBuildLevels(), "ios", BuildTarget.iPhone, BuildOptions.None);
    }

    public static string GetExternalArg(string name)
    {
        foreach (string arg in System.Environment.GetCommandLineArgs())
        {
            if (arg.StartsWith(name))
            {
                return arg.Split('-')[1];
            }
        }

        return "";
    }
}