using Assets.Plugins.Assets.Scripts.Com.Game.Utils;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace Assets.Scripts.Com.Game.Utils
{
    public static class ResourceURL
    {
        public static string RAW_STREAMING_ASSETS { get; private set; }

        public static string PERSISTENT_STREAMING_ASSETS { get; private set; }

        public const string FILE_FLAG = "file:///";

        public static bool sUsePersistentPath = false;

        static ResourceURL()
        {
            if (Application.platform == RuntimePlatform.Android)
            {
                RAW_STREAMING_ASSETS = Application.streamingAssetsPath;
                PERSISTENT_STREAMING_ASSETS = FILE_FLAG + Application.persistentDataPath;
            }
            else
            {
                RAW_STREAMING_ASSETS = FILE_FLAG + Application.streamingAssetsPath;
                PERSISTENT_STREAMING_ASSETS = FILE_FLAG + Application.persistentDataPath;
            }
        }

        public static string GetRawPath(string path)
        {
            return RAW_STREAMING_ASSETS + "/" + path;
        }

        public static string GetPersistentPath(string path)
        {
            return PERSISTENT_STREAMING_ASSETS + "/StreamingAssets/" + path;
        }

        public static string GetPersistentFilePath(string path)
        {
            return Application.persistentDataPath + "/StreamingAssets/" + path;
        }

        public static bool CheckPersistentFileExists(string path)
        {
            return File.Exists(GetPersistentFilePath(path));
        }

        public static string GetAssetPath(string path)
        {
            if (sUsePersistentPath)
            {
                return GetPersistentPath(path);
            }

            return GetRawPath(path);
        }

    }
}
