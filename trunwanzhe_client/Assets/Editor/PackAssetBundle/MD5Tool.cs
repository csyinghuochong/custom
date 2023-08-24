using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using Assets.Plugins.Assets.Scripts.Com.Game.Utils;
using Assets.Scripts.Com.Game.Utils;
using UnityEditor;
using UnityEngine;
using Assets.Plugins.Assets.Scripts.Com.Game.Utils;
using Assets.Plugins.Assets.Scripts.Com.Game.Platform;
using Assets.Plugins.Assets.Scripts.Com.Game.MD5;
using Assets.Plugins.Assets.Scripts.Com.Game.Manager;
using Assets.Scripts.Com.Net;
using Ionic.Zlib;

namespace Assets.Editor
{
    public class MD5Tool
    {
        //获取加密服务  
        System.Security.Cryptography.MD5CryptoServiceProvider md5CSP = new System.Security.Cryptography.MD5CryptoServiceProvider();

        private BuildTool mBuildTool;

        private List<FileMD5Vo> mFileMD5List = new List<FileMD5Vo>();
        private List<FileBytesVo> mFileBytesList = new List<FileBytesVo>();
        private Dictionary<string, FileBytesVo> mFileBytesDic = new Dictionary<string, FileBytesVo>();

        public MD5Tool(BuildTool buildTool)
        {
            mBuildTool = buildTool;
        }

        public void EncryptDll()
        {
            AssetDatabase.Refresh();

            //EncryptDll("Dll", "vo");
            EncryptDll("Dll", "GameScript");

            //打包dll
            AssetDatabase.Refresh();
            mBuildTool.PackByPath("Assets/RawResources/Dll");
            mBuildTool.Build();
        }

        public void Make(bool exit = false)
        {
            mFileMD5List.Clear();
            mFileBytesList.Clear();
            mFileBytesDic.Clear();

            //删除之前的FileMD5 version PlatformConfig，这些文件不加入FileMD5，避免更新时候比对时提前下载了，这些文件只能是最后下载
            FileUtil.DeleteFileOrDirectory("Assets/StreamingAssets/FileMD5");
            FileUtil.DeleteFileOrDirectory("Assets/StreamingAssets/Version");
            FileUtil.DeleteFileOrDirectory("Assets/StreamingAssets/PlatformConfig");

            //加密dll,要保证加密解密顺序
            RC4Crypto.InitCiphertext((Resources.Load("Encrypt/Key") as TextAsset).text + "ReleaseGameCamera");
            RC4Crypto.EncryptEx((Resources.Load("Encrypt/Test") as TextAsset).bytes);

            if (mBuildTool.mIndex == TargetType.ANDROID)
                EncryptDll();

            //加密配置表
            //EncryptConfig();

            AssetDatabase.Refresh();
            Build("Assets/StreamingAssets", false);

            //生成FileMD5
            string fileMD5Path = "Assets/RawResources/FileMD5/FileMD5.bytes";
            SerializeUtils.SerializeToXml(mFileMD5List, fileMD5Path);

            AssetDatabase.Refresh();

            mBuildTool.PackByPath("Assets/RawResources/FileMD5");
            mBuildTool.Build();

            mBuildTool.PackByPath("Assets/RawResources/Version");
            mBuildTool.Build();

            mBuildTool.PackByPath("Assets/RawResources/PlatformConfig");
            mBuildTool.Build();

            AssetDatabase.Refresh();

            //这里打包是为了保证文件在解压缩时是最后生成
            Build("Assets/StreamingAssets/PlatformConfig", false);
            Build("Assets/StreamingAssets/FileMD5", false);
            Build("Assets/StreamingAssets/Version", false);

            //压缩原始资源
            CompressAsset();

            //if (mBuildTool.mIndex == TargetType.ANDROID)
            //{

            //}

            string moveFolderName = "Assets/GameStreamingAssets";
            FileUtil.DeleteFileOrDirectory(moveFolderName);
            new DirectoryInfo("Assets/StreamingAssets").MoveTo(moveFolderName);

            if (exit)
                EditorApplication.Exit(0);
        }

        private void EncryptDll(string dllDirectory, string dllName)
        {
            string path = string.Format("Assets/RawResources/{0}/{1}.bytes", dllDirectory, dllName);
            byte[] bytes = (AssetDatabase.LoadAssetAtPath(path, typeof(TextAsset)) as TextAsset).bytes;
            bytes = RC4Crypto.EncryptEx(bytes);

            SaveFile(path, bytes);
        }

        public void EncryptConfig()
        {
            string srcPath = "Assets/RawResources/BinData/BinData.bytes";
            string targetPath = "Assets/StreamingAssets/BinData/BinData.bytes";

            byte[] bytes = File.ReadAllBytes(srcPath);
            bytes = GZipStream.CompressBuffer(bytes);
            bytes = RC4Crypto.EncryptEx(bytes);

            SaveFile(targetPath, bytes);
        }

        private bool LoadRawResource()
        {
            //mBuildTool.mIndex == TargetType.ANDROID &&
            return GameResUpdateManager.sLoadRawResource;
        }

        private bool CheckRawResourceDir(string path)
        {
            if (LoadRawResource() == false)
                return false;

            string dirName = Path.GetDirectoryName(path);

            if (dirName.IndexOf("External") != -1)
                return false;

            for (int k = 0; k < GameResUpdateManager.RawResourceList.Length; k++)
            {
                if (dirName.IndexOf(GameResUpdateManager.RawResourceList[k]) != -1)
                    return true;
            }

            return false;
        }

        private void CompressAsset()
        {
            string resourcesFolderPath = "Assets/Resources/Assets";
            FileUtil.DeleteFileOrDirectory(resourcesFolderPath);
            Directory.CreateDirectory(resourcesFolderPath);

            string compressFolderPath = "Assets/CompressGameStreamingAssets";
            FileUtil.DeleteFileOrDirectory(compressFolderPath);
            Directory.CreateDirectory(compressFolderPath);

            List<string> filePathList = new List<string>();

            string bytes = ".bytes";

            for (int i = 0, count = mFileBytesList.Count - 1; i <= count; i++)
            {
                FileBytesVo vo = mFileBytesList[i];

                if (vo.path.IndexOf(bytes) == -1)
                    continue;

                filePathList.Add(vo.path.Replace(bytes, ""));

                bool androidPlatform = mBuildTool.mIndex == TargetType.ANDROID;

                if (CheckRawResourceDir(vo.path) == false)
                {
                    if (androidPlatform)
                    {
                        SaveFile(resourcesFolderPath + "/" + vo.path, vo.bytes);
                    }
                    else
                    {
                        SaveFile(resourcesFolderPath + "/" + vo.path, GameResUpdateManager.CompressBuffer(vo.bytes, !androidPlatform));
                    }
                }

                SaveFile(compressFolderPath + "/" + vo.path, GameResUpdateManager.CompressBuffer(vo.bytes, !androidPlatform));
            }

            SerializeUtils.SerializeToXml(filePathList, string.Format("{0}/{1}.bytes", resourcesFolderPath, "CompressFileList"));

            if (LoadRawResource())
            {
                for (int i = 0, count = GameResUpdateManager.RawResourceList.Length; i < count; i++)
                {
                    string folderName = GameResUpdateManager.RawResourceList[i];
                    AssetDatabase.MoveAsset("Assets/RawResources/" + folderName, "Assets/Resources/Assets/" + folderName);
                }
            }
        }

        public void SaveFile(string path, byte[] bytes)
        {
            string directory = Path.GetDirectoryName(path);

            if (Directory.Exists(directory) == false)
                Directory.CreateDirectory(directory);

            using (FileStream stream = new FileStream(path, FileMode.Create, FileAccess.ReadWrite))
            {
                try
                {
                    stream.Write(bytes, 0, bytes.Length);
                    stream.Flush();
                }
                catch (Exception exception)
                {
                    Debug.Log("SaveFile:" + exception.StackTrace);
                }
            }
        }

        private string GetPath(string path)
        {
            return path.Replace(@"\", "/");
        }

        private Dictionary<string, FileMD5Vo> GetFileMD5VoDic(DirectoryInfo dir)
        {
            string versionPath = dir.FullName.Replace(@"\", "/");
            versionPath = "Assets/" + versionPath.Replace(Application.dataPath + "/", "");

            Dictionary<string, FileMD5Vo> dic = new Dictionary<string, FileMD5Vo>();

            SerializeUtils.DeserializeXml<List<FileMD5Vo>>((AssetDatabase.LoadAssetAtPath(versionPath + "/FileMD5.bytes", typeof(TextAsset)) as TextAsset).bytes, delegate(List<FileMD5Vo> list)
            {
                foreach (FileMD5Vo vo in list)
                {
                    dic[vo.path] = vo;
                }
            });

            return dic;
        }

        public void MakePlatformConfig(string platform)
        {
            string platformPath = "Assets/Resources/Platform/Config.txt";
            using (StreamWriter writer = new StreamWriter(platformPath, false, Encoding.UTF8))
            {
                writer.Write(platform);
            }

            string versionFilePath = string.Format("Assets/RawResources/PlatformConfig/{0}/Version.bytes", platform);
            string version = ((AssetDatabase.LoadAssetAtPath(versionFilePath, typeof(TextAsset)) as TextAsset).text).Trim();

            string VersionPath = "Assets/Resources/Platform/Version.txt";
            using (StreamWriter writer = new StreamWriter(VersionPath, false, Encoding.UTF8))
            {
                writer.Write(version);
            }

            AssetDatabase.Refresh();
        }

        void Build(string path, bool onlyBuildFile)
        {
            DirectoryInfo streamingAssetFolder = new DirectoryInfo(path);
            string streamingAssetPath = mBuildTool.GetSavePath(streamingAssetFolder.FullName);
            DoBuild(streamingAssetFolder, streamingAssetPath, onlyBuildFile);
        }

        void DoBuild(DirectoryInfo directoryInfo, string savePath, bool onlyBuildFile)
        {
            FileInfo[] fileInfoList = mBuildTool.GetFileInfoList(directoryInfo);

            BuildMD5File(directoryInfo, savePath, fileInfoList);

            if (onlyBuildFile == false)
            {
                DirectoryInfo[] folderInfoList = mBuildTool.GetFolderInfoList(directoryInfo);
                foreach (DirectoryInfo folderInfo in folderInfoList)
                {
                    DoBuild(folderInfo, savePath, onlyBuildFile);
                }
            }
        }

        private void BuildMD5File(DirectoryInfo directoryInfo, string savePath, FileInfo[] fileInfoList)
        {
            foreach (FileInfo fileInfo in fileInfoList)
            {
                string fullName = fileInfo.FullName.Replace(@"\", "/");
                string itemPath = fullName.Replace(Application.streamingAssetsPath + "/", "");

                byte[] fileBytes = ReadFile(fullName);
                string result = GetMD5Str(fileBytes);

                FileMD5Vo md5Vo = new FileMD5Vo();
                md5Vo.md5 = result;
                md5Vo.size = fileBytes.Length;
                md5Vo.path = itemPath;
                mFileMD5List.Add(md5Vo);

                FileBytesVo md5BytesVo = new FileBytesVo();
                md5BytesVo.path = itemPath;
                md5BytesVo.bytes = fileBytes;
                mFileBytesList.Add(md5BytesVo);

                mFileBytesDic[md5BytesVo.path] = md5BytesVo;
            }
        }

        private string GetMD5Str(byte[] fileBytes)
        {
            byte[] resultEncrypt = md5CSP.ComputeHash(fileBytes);

            string result = "";
            for (int i = 0; i < resultEncrypt.Length; ++i)
            {
                result += resultEncrypt[i].ToString("X");
            }

            return result;
        }

        public byte[] ReadFile(string fileName)
        {
            FileStream pFileStream = null;
            byte[] pReadByte = new byte[0];
            try
            {
                pFileStream = new FileStream(fileName, FileMode.Open, FileAccess.Read);
                BinaryReader r = new BinaryReader(pFileStream);
                r.BaseStream.Seek(0, SeekOrigin.Begin);    //将文件指针设置到文件开
                pReadByte = r.ReadBytes((int)r.BaseStream.Length);
                return pReadByte;
            }
            catch
            {
                return pReadByte;
            }
            finally
            {
                if (pFileStream != null)
                    pFileStream.Close();
            }
        }
    }
}
