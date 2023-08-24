using UnityEditor;
using System.IO;
using UnityEngine;
using Assets.Plugins.Assets.Scripts.Com.Game.Platform;
using Assets.Editor.PackAssetBundle.Depend;

public class CommandBuild
{
    private static void BuildGameResources(TargetType targetType)
    {
        BuildTool buildTool = new BuildTool();
        buildTool.DeleteMD5Bytes();

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

    public static void MakePlatformConfig()
    {
        string platformName = GetExternalArg("platformName");
        string versionNum = GetExternalArg("versionNum");

        if (string.IsNullOrEmpty(platformName))
            return;

        BuildTool buildTool = new BuildTool();
        buildTool.MakePlatformConfig(platformName, versionNum);
    }

    public static void BuildGameProjectFiles()
    {
        BuildTool buildTool = new BuildTool();
        //buildTool.GenerateProjectFiles();
    }

    private static void BuildArtResources(TargetType targetType)
    {
        File.Copy(Application.dataPath + "/Editor/GraphicsSettings.asset.template", Application.dataPath.Replace("Assets", "") + "ProjectSettings/GraphicsSettings.asset", true);
        AssetDatabase.Refresh();

        BuildTool.sReleaseBuild = true;
        BuildTool buildTool = new BuildTool();

        buildTool.PackByPath("Assets/RawResourcesExport");

        DependCollectTool.mSplit = false;

        DependCollectTool.mCollect = true;
        buildTool.Build(targetType);

        DependCollectTool.mCollect = false;
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
        string[] levels = { "Assets/Scenes/Login.unity", "Assets/Scenes/Main.unity" };
        return levels;
    }

    //------release-----------//
    public static void BuildAndroidRelease()
    {
        PlatformManager.Instance.DeserializeRawConfigXML(((AssetDatabase.LoadAssetAtPath("Assets/RawResources/PlatformConfig/PlatformConfig.xml", typeof(TextAsset)) as TextAsset).bytes));
        string versionFilePath = string.Format("Assets/Version/{0}/Version.bytes", PlatformManager.Instance.mRawPlatformConfigVo.platform);
        PlatformManager.Instance.DeserializeVersion(((AssetDatabase.LoadAssetAtPath(versionFilePath, typeof(TextAsset)) as TextAsset).text));

        PlayerSettings.bundleVersion = PlatformManager.Instance.mVersion;

        BuildPipeline.BuildPlayer(GetReleaseBuildLevels(), string.Format("Assets/Version/{0}/{1}/Export/英雄联萌 {1}.apk", PlatformManager.Instance.mRawPlatformConfigVo.platform, PlatformManager.Instance.mVersion), BuildTarget.Android, BuildOptions.None);
    }

    public static void BuildIOSRelease()
    {
        BuildPipeline.BuildPlayer(GetReleaseBuildLevels(), "ios", BuildTarget.iOS, BuildOptions.None);
    }

    //------debug-----------//
    public static void BuildAndroidDebug()
    {
        BuildPipeline.BuildPlayer(GetDebugBuildLevels(), "game.apk", BuildTarget.Android, BuildOptions.None);
    }

    public static void BuildIOSDebug()
    {
        BuildPipeline.BuildPlayer(GetReleaseBuildLevels(), "ios", BuildTarget.iOS, BuildOptions.None);
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