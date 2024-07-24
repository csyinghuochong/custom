
#if UNITY_IPHONE

using UnityEngine;
using System;
using System.IO;
using System.Collections.Generic;
#if UNITY_EDITOR
using UnityEditor;
using UnityEditor.iOS.Xcode;
using UnityEditor.Callbacks;
using UnityEditor.XCodeEditor;
#endif

public static class XCodePostProcess
{

#if UNITY_EDITOR

	public static void SetUrlSchemes(PlistDocument plist)
	{
        List<string> urllist = new List<string>()
            {
                "taptap",
                "sinaweibosso",
                "weibo",
                "weibosdk",
                "weibosdk2.5",
                "sinaweibo",
                "sinaweibohd",
                "weixin",
                "wechat",
                "weixinULAPI",
                "mqq",
                "mqqapi",
                "mqqwpa",
                "mqqbrowser",
                "mttbrowser",
                "mqqOpensdkSSoLogin",
                "mqqopensdkapiV2",
                "mqqopensdkapiV3",
                "mqqopensdkapiV4",
                "wtloginmqq2",
                "mqzone",
                "mqzoneopensdk",
                "mqzoneopensdkapi",
                "mqzoneopensdkapi19",
                "mqzoneopensdkapiV2",
                "mqqapiwallet",
                "mqqopensdkfriend",
                "mqqopensdkdataline",
                "mqqgamebindinggroup",
                "mqqopensdkgrouptribeshare",
                "tencentapi.qq.reqContent",
                "tencentapi.qzone.reqContent",
                "tim",
                "timapi",
                "timopensdkfriend",
                "timwpa",
                "timgamebindinggroup",
                "timapiwallet",
                "timOpensdkSSoLogin",
                "wtlogintim",
                "timopensdkgrouptribeshare",
                "timopensdkapiV4",
                "timopensdkdataline",
                "wtlogintimV1",
                "timapiV1",
                "mqqopensdkminiapp",
                "tapsdk",
                "tapiosdk",
            };

        PlistElementArray plistDocument;
		plistDocument = plist.root.CreateArray("LSApplicationQueriesSchemes");

        foreach (var url in urllist)
        {
            plistDocument.AddString(url);
        }
	}

	[PostProcessBuild(999)]
	public static void OnPostProcessBuild( BuildTarget target, string pathToBuiltProject )
	{
		UnityEngine.Debug.Log("PostProcess_1");
        if (target != BuildTarget.iOS)
		{
			Debug.LogWarning("Target is not iPhone. XCodePostProcess will not run");
			return;
		}
		UnityEngine.Debug.Log("PostProcess_1: " + pathToBuiltProject);
		// Create a new project object from build target

		XCProject project = new XCProject( pathToBuiltProject );

		// Find and run through all projmods files to patch the project.
		// Please pay attention that ALL projmods files in your project folder will be excuted!
		string[] files = Directory.GetFiles( Application.dataPath, "*.projmods", SearchOption.AllDirectories );
		foreach( string file in files ) {
			UnityEngine.Debug.Log("ProjMod File: "+file);
			//project.ApplyMod( file );
		}

		//TODO disable the bitcode for iOS 9
		project.overwriteBuildSetting("ENABLE_BITCODE", "NO", "Release");
		project.overwriteBuildSetting("ENABLE_BITCODE", "NO", "Debug");

		//TODO implement generic settings as a module option
//		project.overwriteBuildSetting("CODE_SIGN_IDENTITY[sdk=iphoneos*]", "iPhone Distribution", "Release");

		var mainAppPath = Path.Combine(pathToBuiltProject, "MainApp", "main.mm");
		var mainContent = File.ReadAllText(mainAppPath);
		var newContent = mainContent.Replace("#include <UnityFramework/UnityFramework.h>", @"#include ""../UnityFramework/UnityFramework.h""");
		File.WriteAllText(mainAppPath, newContent);

		string path_1 = "//Users/tangzhen/project/gitwj/Unity/HybridCLRData/iOSBuild/build/libil2cpp.a";
		string path_2 = "//Users/tangzhen/project/gitwj/Unity/ios/Libraries/libil2cpp.a";
		File.Copy(path_1, path_2, true);

		// 修改Info.plist文件
		string plistPath = Path.Combine(pathToBuiltProject, "Info.plist");
		PlistDocument plist = new PlistDocument();
		plist.ReadFromFile(plistPath);

		plist.root.SetString("NSPhotoLibraryUsageDescription", "保存照片到系统相册");

		SetUrlSchemes(plist);

		plist.WriteToFile(plistPath);

		// Finally save the xcode project
		project.Save();
		UnityEngine.Debug.Log("PostProcess_2");
	}
#endif

	public static void Log(string message)
	{
		UnityEngine.Debug.Log("PostProcess: "+message);
	}
}

#endif