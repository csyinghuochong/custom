using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEditor;
using UnityEngine;

namespace Assets.Editor
{
    public class ExportVariables : EditorWindow
    {
        private static List<string> sCheckTypeList = new List<string>()
        {
            "UISprite",
            "UITexture",
            "UILabel",
            "UIWidget",
            "UIGrid",
            "UITable",
            "UISlider"
        };

        [MenuItem("GameObject/ExportVariables", false, 0)]
        static public void Export()
        {
            GameObject[] gameObjectList = Selection.gameObjects;

            string varStr = "";
            string defStr = "";

            for (int i = 0, count = gameObjectList.Length; i < count; i++)
            {
                GameObject go = gameObjectList[i];

                string typeStr = "";
                string varName = "";

                for (int j = 0, len = sCheckTypeList.Count; j < len; j++)
                {
                    typeStr = sCheckTypeList[j];

                    if (go.GetComponent(typeStr) != null)
                    {
                        varName = "m" + typeStr.Replace("UI", "") + go.name;
                        varStr += "\n" + typeStr + " " + varName + ";";
                        defStr += "\n" + string.Format("{0}=FindComponent<{1}>(\"{2}\");", varName, typeStr, go.name);
                        break;
                    }
                }

                if (string.IsNullOrEmpty(varName))
                {
                    typeStr = "GameObject";
                    varName = "m" + typeStr.Replace("UI", "") + go.name;
                    varStr += "\n" + typeStr + " " + varName + ";";
                    defStr += "\n" + string.Format("{0}=FindChild(\"{1}\");", varName, go.name);
                }
            }

            Debug.Log("已拷贝,可以直接粘贴代码");

            System.Type T = typeof(GUIUtility);
            PropertyInfo systemCopyBufferProperty = T.GetProperty("systemCopyBuffer", BindingFlags.Static | BindingFlags.NonPublic);
            systemCopyBufferProperty.SetValue(null, varStr + "\n" + defStr, null);
        }
    }
}
