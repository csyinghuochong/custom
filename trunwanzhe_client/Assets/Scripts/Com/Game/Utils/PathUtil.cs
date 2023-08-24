using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace Assets.Scripts.Com.Game.Utils
{
    public static class PathUtil
    {
        public const string SPLIT_FLAG = "_";
        public static string GetGameScenePath(string sceneName)
        {
            string rawSceneName = "";

            if (sceneName.IndexOf(SPLIT_FLAG) == -1)
            {
                rawSceneName = sceneName;
            }
            else
            {
                rawSceneName = sceneName.Substring(0, sceneName.LastIndexOf(SPLIT_FLAG));
            }

            return "External/GameScenes/" + rawSceneName + "/" + sceneName + ".bytes";
        }

        public static string GetMusicPath(string musicName)
        {
            return "Music/" + musicName + ".bytes";
        }

        public static string GetUIEffectPath(string name)
        {
            return "External/UI_Fx/" + name + ".bytes";
        }

        public static string GetFXPath(string effectName)
        {
            return "External/Fx/" + effectName + ".bytes";
        }

        public static string GetTitleFXPath(string effectName)
        {
            return "External/Title_Fx/" + effectName + ".bytes";
        }

        public static string GetExternalRolePath(string modelName)
        {
            return "External/Role/" + modelName + ".bytes";
        }

        //场景道具
        public static string GetExternalItemPath(string objName)
        {
            return "External/Sence_Item_FX/" + objName + ".bytes";
        }

        public static string GetSceneXmlPath(string name)
        {
            return "External/ScenesXml/" + name + ".bytes";
        }
    }
}
