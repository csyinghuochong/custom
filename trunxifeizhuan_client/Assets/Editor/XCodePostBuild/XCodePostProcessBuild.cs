#if UNITY_IOS
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEditor.Callbacks;
using UnityEditor.iOS.Xcode;
using UnityEngine;

public static class XCodePostProcessBuild
{
	[PostProcessBuild(int.MaxValue)]
	public static void OnPostProcessBuild(BuildTarget target, string pathToBuiltProject)
	{
		if (target != BuildTarget.iOS)
		{
			Debug.LogWarning("Target is not iOS. XCodePostProcessBuild will not run");
			return;
		}

        string projectPath = PBXProject.GetPBXProjectPath(pathToBuiltProject);
        var project = new PBXProject();
        project.ReadFromString(File.ReadAllText(projectPath));

        var targetGUID = project.TargetGuidByName(PBXProject.GetUnityTargetName());

        project.SetBuildProperty(targetGUID, "ENABLE_BITCODE", "NO");

        project.AddBuildProperty(targetGUID, "SystemCapabilities", @"{
                            com.apple.BackgroundModes = {
                                enabled = 1;
                            };
                            com.apple.GameControllers.appletvos = {
                                enabled = 1;
                            };
                            com.apple.InAppPurchase = {
                                enabled = 1;
                            };
                            com.apple.Push = {
                                enabled = 1;
                            };
                        };");


        File.WriteAllText(projectPath, project.WriteToString());
	}
}
#endif