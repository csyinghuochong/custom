
using UnityEngine;
namespace Assets.Plugins.Assets.Scripts.Com.Game.Utils
{
    public class AndroidJavaClassUtil
    {
#if UNITY_ANDROID
        private static AndroidJavaObject sActivity;

        static AndroidJavaClassUtil()
        {
            AndroidJavaClass jc = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
            sActivity = jc.GetStatic<AndroidJavaObject>("currentActivity");
        }
#endif

        public static void Call(string value, params object[] args)
        {
#if UNITY_ANDROID
            sActivity.Call(value, args);
#endif
        }

        public static T Call<T>(string value, params object[] args)
        {
#if UNITY_ANDROID
            return sActivity.Call<T>(value, args);
#endif
            return default(T);
        }
    }
}
