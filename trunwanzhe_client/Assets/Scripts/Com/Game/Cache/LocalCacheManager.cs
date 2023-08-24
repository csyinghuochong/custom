using UnityEngine;

namespace Assets.Scripts.Com.Game.Cache
{
    class LocalCacheManager
    {
        //保存本地缓存
        public static void SaveLocalCache(string keyType, string data)
        {
            if (string.IsNullOrEmpty(keyType) || "".Equals(keyType)) return;
            PlayerPrefs.SetString(keyType, data);
        }

        public static string GetLocalCache(string keyType)
        {
            if (string.IsNullOrEmpty(keyType) || "".Equals(keyType)) return "";
            string result = "";
            if (PlayerPrefs.HasKey(keyType))
            {
                result = PlayerPrefs.GetString(keyType);
            }
            return result;
        }

        //保存用户本地缓存
        public static void SavePlayerLocalCache(string keyType, string data)
        {
//             PRoleAttr role = RoleModel.Instance.roleInfo;
//             if (role == null) return;
//             string key = keyType + role.id.ToString();
//             SaveLocalCache(key, data);
        }

        public static string GetPlayerLocalCache(string keyType)
        {
//             PRoleAttr role = RoleModel.Instance.roleInfo;
//             if (role == null) return "";
//             string key = keyType + role.id.ToString();
//             return GetLocalCache(key);

            return "";
        }


        //删除缓存
        public static void DeleteCache(string keyType)
        {
            if (PlayerPrefs.HasKey(keyType))
            {
                PlayerPrefs.DeleteKey(keyType);
            }
        }

        //清空缓存
        public static void ClearCache()
        {
            PlayerPrefs.DeleteAll();
        }

    }
}
