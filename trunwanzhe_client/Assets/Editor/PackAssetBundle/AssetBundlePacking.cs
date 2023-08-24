using UnityEngine;
using System.Collections;
using UnityEditor;
using System.IO;
using System.Collections.Generic;
using System.Timers;

public class AssetBundlePacking : EditorWindow
{
    static Rect windowRect = new Rect(100, 100, 700, 400);
    Vector2 mFolderPosition;
    Vector2 mFilePosition;

    BuildTool mBuild;

    [MenuItem("Editor/AssetBundlePacking/Packing")]
    static public void Packing()
    {
        AssetBundlePacking packTool = EditorWindow.GetWindowWithRect(typeof(AssetBundlePacking), windowRect, true, "AssetBundlePacking") as AssetBundlePacking;
        packTool.mBuild = new BuildTool();
    }

    [MenuItem("Assets/BundleEditor/SelectPacking", false, 0)]
    static public void SelectPacking()
    {
        AssetBundlePacking pack = EditorWindow.GetWindowWithRect(typeof(AssetBundlePacking), windowRect, true, "AssetBundlePacking") as AssetBundlePacking;
        pack.mBuild = new BuildTool();

        string[] assetGUIDs = Selection.assetGUIDs;

        pack.mBuild.PackByPath(assetGUIDs);
    }

    void OnGUI()
    {
        if (mBuild.isPacking)
            return;

        EditorGUILayout.BeginVertical();
        {
            //选择文件
            EditorGUILayout.BeginHorizontal("Box");
            EditorGUILayout.BeginVertical();
            GUI.color = Color.white;
            EditorGUILayout.TextField("所选择的文件夹路径：" + mBuild.mFolderPath);
            EditorGUILayout.EndVertical();
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal("Box");
            GUI.color = Color.white;
            if (GUILayout.Button(("选择文件夹")))
            {
                mBuild.InitFolder(EditorUtility.OpenFolderPanel("选择需要打包的文件或文件夹", "", ""));
            }

            if (GUILayout.Button(("选择文件")))
            {
                mBuild.InitFile(EditorUtility.OpenFilePanel("选择需要打包的文件", "", ""));
            }

            EditorGUILayout.BeginVertical();
            GUI.color = Color.white;
            EditorGUILayout.TextField("子文件：");
            mFolderPosition = EditorGUILayout.BeginScrollView(mFolderPosition);
            ShowFileList();
            EditorGUILayout.EndScrollView();
            EditorGUILayout.EndVertical();

            EditorGUILayout.BeginVertical();
            GUI.color = Color.yellow;
            EditorGUILayout.TextField("子文件夹：");
            mFilePosition = EditorGUILayout.BeginScrollView(mFilePosition);
            ShowFolderList();
            EditorGUILayout.EndScrollView();
            EditorGUILayout.EndVertical();

            EditorGUILayout.EndHorizontal();

            //选择路径
            EditorGUILayout.BeginHorizontal("Box");
            EditorGUILayout.BeginVertical();

            GUI.color = Color.green;
            EditorGUILayout.TextField("资源包保存路径：" + mBuild.mSavePath);

            GUI.color = Color.green;
            if (GUILayout.Button("修改保存路径"))
            {
                mBuild.mSavePath = EditorUtility.SaveFolderPanel("保存资源包路径", "", "");
            }
            EditorGUILayout.EndVertical();
            EditorGUILayout.EndHorizontal();


            //打包环节
            EditorGUILayout.BeginHorizontal("Box");
            EditorGUILayout.BeginVertical();
            GUI.color = Color.green;
            mBuild.mIndex = (TargetType)EditorGUILayout.Popup((int)mBuild.mIndex, mBuild.mTargetOptions);
            EditorGUILayout.EndVertical();

            GUI.color = Color.red;

            if (GUILayout.Button("打包"))
            {
                mBuild.Build();
                //mBuild.MakeMD5File();
            }

            if (GUILayout.Button("生成md5文件"))
            {
                mBuild.MakeMD5File();
            }

            if (GUILayout.Button("生成Lua"))
            {
                mBuild.BuildLua();
            }

            if (GUILayout.Button("脚本加密"))
            {
                mBuild.EncryptDll();
            }

            if (GUILayout.Button("配置加密"))
            {
                mBuild.EncryptConfig();
            }

            if (GUILayout.Button("生成apk"))
            {
                CommandBuild.BuildAndroidRelease();
            }

        }
        EditorGUILayout.EndVertical();
    }

    //显示子文件
    void ShowFileList()
    {
        if (mBuild.mSubFileInfoList != null)
        {
            foreach (var item in mBuild.mSubFileInfoList)
            {
                EditorGUILayout.TextField(item.Name);
            }
        }
    }

    //显示子文件夹
    void ShowFolderList()
    {
        if (mBuild.mSubFolderInfoList != null)
        {
            foreach (var item in mBuild.mSubFolderInfoList)
            {
                EditorGUILayout.TextField(item.Name);
            }
        }
    }
}

