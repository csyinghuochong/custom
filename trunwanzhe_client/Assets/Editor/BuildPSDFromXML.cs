using System;
using UnityEditor;
using UnityEngine;
using System.IO;
using System.Collections.Generic;
using System.Xml;
using System.Reflection;
using System.Text;

namespace Assets.Editor
{
    public class BuildPSDFromXML : EditorWindow
    {
        [MenuItem("Assets/BuildPSDFromXML")]
        static public void Packing()
        {
            string path = "";
            string[] assetGUIDs = Selection.assetGUIDs;
            if (assetGUIDs.Length > 0)
            {
                path = AssetDatabase.GUIDToAssetPath(assetGUIDs[0]);
            }

            if (string.IsNullOrEmpty(path))
            {
                return;
            }

            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(path);

            XmlNode root = xmlDoc.SelectSingleNode("objs");
            XmlNodeList nodeList = root.ChildNodes;

            GameObject parent = new GameObject();
            parent.transform.localPosition = Vector3.zero;
            parent.name = "parent";

            foreach (XmlNode xn in nodeList)
            {
                XmlElement xe = (XmlElement)xn;
                string name = xe.GetAttribute("name");
                string sX = xe.GetAttribute("x");
                float x = float.Parse(sX);
                string sY = xe.GetAttribute("y");
                float y = float.Parse(sY);
                float w = float.Parse(xe.GetAttribute("w"));
                float h = float.Parse(xe.GetAttribute("h"));

                GameObject obj = new GameObject();
                obj.transform.parent = parent.transform;
                UISprite sprite = obj.AddComponent<UISprite>();
                sprite.width = (int)w;
                sprite.height = (int)h;

                obj.name = name;
                obj.transform.localPosition = new Vector3(x - 960 / 2,
                    640 / 2 - y, 0.0f);
                NGUITools.SetActive(obj, false);
            }
        }
    }
}
