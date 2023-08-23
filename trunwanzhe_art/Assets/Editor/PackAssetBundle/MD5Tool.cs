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

namespace Assets.Editor
{
    public class MD5Tool
    {
        //获取加密服务  
        System.Security.Cryptography.MD5CryptoServiceProvider md5CSP = new System.Security.Cryptography.MD5CryptoServiceProvider();

        private const string PLATFORM_TEMPLATE_PATH = "Assets/Version";
        private const string PLATFORM_PLUGINS_PATH = "Assets/Plugins/BuildPlatform";
        private const string PLATFORM_CONFIG_PATH = "Assets/RawResources/PlatformConfig";

        private BuildTool mBuildTool;

        private List<FileMD5Vo> mFileMD5List = new List<FileMD5Vo>();
        private List<FileBytesVo> mFileBytesList = new List<FileBytesVo>();
        private Dictionary<string, FileBytesVo> mFileBytesDic = new Dictionary<string, FileBytesVo>();

        public MD5Tool(BuildTool buildTool)
        {
            mBuildTool = buildTool;
        }

        public void Make()
        {
            mFileMD5List.Clear();
            mFileBytesList.Clear();
            mFileBytesDic.Clear();

            PlatformManager.Instance.DeserializeRawConfigXML(((AssetDatabase.LoadAssetAtPath("Assets/RawResources/PlatformConfig/PlatformConfig.xml", typeof(TextAsset)) as TextAsset).bytes));
            string versionFilePath = string.Format("Assets/Version/{0}/Version.bytes", PlatformManager.Instance.mRawPlatformConfigVo.platform);
            PlatformManager.Instance.DeserializeVersion(((AssetDatabase.LoadAssetAtPath(versionFilePath, typeof(TextAsset)) as TextAsset).text));

            //清空版本目录
            FileUtil.DeleteFileOrDirectory(GetVersionFolderPath());
            Directory.CreateDirectory(GetVersionFolderPath());
            Directory.CreateDirectory(GetVersionFolderPath() + "/Export");

            //删除之前的FileMD5 version，这两个文件不加入FileMD5，避免更新时候比对时提前下载了，这两个文件只能是最后下载
            FileUtil.DeleteFileOrDirectory("Assets/StreamingAssets/FileMD5");
            FileUtil.DeleteFileOrDirectory("Assets/StreamingAssets/Version");

            AssetDatabase.Refresh();

            //加密dll,要保证加密解密顺序
            RC4Crypto.InitCiphertext((Resources.Load("Encrypt/Key") as TextAsset).text + "ReleaseGameCamera");
            RC4Crypto.EncryptEx((Resources.Load("Encrypt/Test") as TextAsset).bytes);
            EncryptDll("vo");
            EncryptDll("GameScript");

            //打包dll
            AssetDatabase.Refresh();
            mBuildTool.PackByPath("Assets/RawResources/Dll");
            mBuildTool.Build();

            AssetDatabase.Refresh();
            Build("Assets/StreamingAssets", false);

            //生成FileMD5
            string fileMD5Path = "Assets/RawResources/FileMD5/FileMD5.bytes";
            SerializeUtils.SerializeToXml(mFileMD5List, fileMD5Path);

            //拷贝FileMD5到版本目录
            FileUtil.CopyFileOrDirectory(fileMD5Path, GetVersionFolderPath("FileMD5.bytes"));

            //生成Version
            string versionRawResourcesPath = "Assets/RawResources/Version/Version.bytes";
            File.Copy(versionFilePath, versionRawResourcesPath, true);

            AssetDatabase.Refresh();

            mBuildTool.PackByPath(fileMD5Path);
            mBuildTool.Build();

            mBuildTool.PackByPath(versionRawResourcesPath);
            mBuildTool.Build();

            AssetDatabase.Refresh();

            //这里打包是为了保证文件在解压缩时是最后生成
            Build("Assets/StreamingAssets/FileMD5", true);
            Build("Assets/StreamingAssets/Version", true);

            //跟上一版本比对，生成差量资源包，便于快速发版本
            ComparePrevVersion();

            //压缩原始资源
            SaveOriginalAsset();

            FileUtil.DeleteFileOrDirectory("Assets/" + PlatformManager.Instance.mRawPlatformConfigVo.assetFolderName);
            new DirectoryInfo("Assets/StreamingAssets").MoveTo("Assets/" + PlatformManager.Instance.mRawPlatformConfigVo.assetFolderName);

            string copyToDir = GetVersionFolderPath("Export/" + PlatformManager.Instance.mRawPlatformConfigVo.assetFolderName);
            FileUtil.CopyFileOrDirectory("Assets/" + PlatformManager.Instance.mRawPlatformConfigVo.assetFolderName, copyToDir);

            //删除.svn文件
            FileUtil.DeleteFileOrDirectory(copyToDir + "/External/.svn");

            AssetDatabase.Refresh();
        }

        private void EncryptDll(string dllName)
        {
            byte[] bytes = (AssetDatabase.LoadAssetAtPath(string.Format("Assets/RawResources/Dll/{0}.bytes", dllName), typeof(TextAsset)) as TextAsset).bytes;
            bytes = RC4Crypto.EncryptEx(bytes);

            SaveFile(string.Format("Assets/RawResources/Dll/{0}.bytes", dllName), bytes);
        }

        private void SaveOriginalAsset()
        {
            string assetName = "OriginalAsset";
            string resourcesFolderPath = "Assets/Resources/Assets";

            FileUtil.DeleteFileOrDirectory(resourcesFolderPath);
            Directory.CreateDirectory(resourcesFolderPath);

            List<FileBytesVo> fileBytesVoList = new List<FileBytesVo>();
            int OriginalAssetSize = 5 * 1024 * 1024; //MB
            int size = 0;
            int assetNum = 0;

            for (int i = 0, count = mFileBytesList.Count - 1; i <= count; i++)
            {
                FileBytesVo vo = mFileBytesList[i];
                size += vo.bytes.Length;
                fileBytesVoList.Add(vo);

                if (size >= OriginalAssetSize || i == count)
                {
                    size = 0;
                    SerializeUtils.SerializeToXml(fileBytesVoList, string.Format("{0}/{1}{2}.bytes", resourcesFolderPath, assetName, ++assetNum));
                    fileBytesVoList.Clear();
                }
            }

            using (StreamWriter writer = new StreamWriter(string.Format("{0}/{1}.bytes", resourcesFolderPath, "OriginalAssetNum"), true, Encoding.UTF8))
            {
                writer.Write(string.Format("{0}_{1}", assetNum, PlatformManager.Instance.mVersion));
            }
        }

        private void ComparePrevVersion()
        {
            DirectoryInfo directoryInfo = new DirectoryInfo(GetPlatformFolderPath());
            List<DirectoryInfo> folderInfoList = new List<DirectoryInfo>(mBuildTool.GetFolderInfoList(directoryInfo));

            if (folderInfoList.Count < 2)
                return;

            folderInfoList.Sort(delegate(DirectoryInfo dir1, DirectoryInfo dir2)
            {
                return PlatformVersion.CompareVersion(dir1.Name, dir2.Name);
            });

            DirectoryInfo curVersionDir = folderInfoList[folderInfoList.Count - 1];
            DirectoryInfo prevVersionDir = folderInfoList[folderInfoList.Count - 2];

            Dictionary<string, FileMD5Vo> curVersionList = GetFileMD5VoDic(curVersionDir);
            Dictionary<string, FileMD5Vo> prevVersionList = GetFileMD5VoDic(prevVersionDir);

            //FileMD5 和 Version是不在FileMD5.bytes，所以需要遍历mFileBytesDic
            foreach (KeyValuePair<string, FileBytesVo> kvp in mFileBytesDic)
            {
                FileBytesVo bytesVo = kvp.Value;
                FileMD5Vo curFileMD5Vo;
                FileMD5Vo prevFileMD5Vo;

                if (prevVersionList.TryGetValue(kvp.Key, out prevFileMD5Vo) && curVersionList.TryGetValue(kvp.Key, out curFileMD5Vo) && curFileMD5Vo.md5 == prevFileMD5Vo.md5)
                {
                    continue;
                }

                SaveFile(GetVersionFolderPath(string.Format("Export/{0}_{1}/{2}", prevVersionDir.Name, curVersionDir.Name, bytesVo.path)), bytesVo.bytes);
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

        private string GetPlatformFolderPath()
        {
            return string.Format("Assets/Version/{0}", PlatformManager.Instance.mRawPlatformConfigVo.platform);
        }

        private string GetVersionFolderPath()
        {
            return string.Format("Assets/Version/{0}/{1}", PlatformManager.Instance.mRawPlatformConfigVo.platform, PlatformManager.Instance.mVersion);
        }

        private string GetVersionFolderPath(string path)
        {
            return string.Format("Assets/Version/{0}/{1}/{2}", PlatformManager.Instance.mRawPlatformConfigVo.platform, PlatformManager.Instance.mVersion, path);
        }

        public void MakePlatformConfig(string str, string versionNum)
        {
            string targetXmlPath = string.Format("{0}/PlatformConfig.xml", PLATFORM_CONFIG_PATH);
            File.Copy(string.Format("{0}/{1}/PlatformConfig.xml", PLATFORM_TEMPLATE_PATH, str), targetXmlPath, true);

            string versionFilePath = string.Format("Assets/Version/{0}/Version.bytes", str);
            using (StreamWriter writer = new StreamWriter(versionFilePath, false, Encoding.UTF8))
            {
                writer.Write(versionNum);
            }
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
                byte[] resultEncrypt = md5CSP.ComputeHash(fileBytes);

                string result = "";
                for (int i = 0; i < resultEncrypt.Length; ++i)
                {
                    result += resultEncrypt[i].ToString("X");
                }

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
