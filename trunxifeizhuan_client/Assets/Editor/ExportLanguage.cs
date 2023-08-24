using UnityEngine;
using System.Collections;
using UnityEditor;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Xml;
using UnityEngine.UI;

public class ExportLanguage : Editor
{
    //UIPrefab文件夹目录
    private static string UIPrefabPath = Application.dataPath + "/RawResources/ui";
    private static string UIPrefabPathOutput = Application.dataPath + "/RawResources/uiNew";
    //脚本的文件夹目录
    private static string ScriptPath = Application.dataPath + "/Scripts/MVC";
    //导出的中文KEY路径
    private static string OutPath = Application.dataPath + "/LanguageOut.txt";

    private static string OutPathXml = Application.dataPath + "/LanguageOut.xml";

    private static Dictionary<string, string> PrefabLabelList = new Dictionary<string, string>();
    private static string CurrentPrefabName = string.Empty;

    private static bool IsReplace = false;

    private static string staticWriteText = "";
    [MenuItem("Tools/导出多语言（prefab）")]
    static void ExportChinese()
    {
        IsReplace = false;
        PrefabLabelList.Clear();

        staticWriteText = "";

        //提取Prefab上的中文
        staticWriteText += "----------------Prefab----------------------\n\n\n";
        LoadDiectoryPrefab(new DirectoryInfo(UIPrefabPath));

        //提取CS中的中文
        //staticWriteText += "\n\n\n----------------Script----------------------\n\n\n";
        //LoadDiectoryCS(new DirectoryInfo(ScriptPath));


        _createXml();

        //最终把提取的中文生成出来
        //string textPath = OutPath;
        //if (System.IO.File.Exists(textPath))
        //{
        //    File.Delete(textPath);
        //}
        //using (StreamWriter writer = new StreamWriter(textPath, false, Encoding.UTF8))
        //{
        //    writer.Write(staticWriteText);
        //}
        AssetDatabase.Refresh();
    }

    [MenuItem("Tools/导出多语言（纯脚本）")]
    static void ExportChinese1()
    {
        staticWriteText = "";

        //提取Prefab上的中文
        staticWriteText += "----------------Prefab----------------------\n";
        //LoadDiectoryPrefab(new DirectoryInfo(UIPrefabPath));

        //提取CS中的中文
        staticWriteText += "----------------Script----------------------\n";
        LoadDiectoryCS(new DirectoryInfo(ScriptPath));


        //最终把提取的中文生成出来
        string textPath = OutPath;
        if (System.IO.File.Exists(textPath))
        {
            File.Delete(textPath);
        }
        using (StreamWriter writer = new StreamWriter(textPath, false, Encoding.UTF8))
        {
            writer.Write(staticWriteText);
        }
        AssetDatabase.Refresh();
    }

    [MenuItem("Tools/替换语言")]
    static void _replaceLanguage()
    {
        IsReplace = true;
        PrefabLabelList.Clear();

        _readXml();
        //Debug.Log(PrefabLabelList.Count);
        LoadDiectoryPrefab(new DirectoryInfo(UIPrefabPath));
        EditorApplication.SaveScene(EditorApplication.currentScene);
        Debug.Log("替换完成");
    }

    [MenuItem("Tools/导出语言（prefer所有文字）")]
    static void ExportAll()
    {
        IsReplace = false;
        PrefabLabelList.Clear();

        staticWriteText = "";

        //提取Prefab上的中文
        staticWriteText += "----------------Prefab----------------------\n\n\n";
        LoadDiectoryPrefab(new DirectoryInfo(UIPrefabPath),true);

        _createXml();
        AssetDatabase.Refresh();
    }

    [MenuItem("Tools/替换字体")]
    static void ChangeFont()
    {
        DirectoryInfo Dinfo = new DirectoryInfo(UIPrefabPath);

        if (!Dinfo.Exists) return;
        FileInfo[] fileInfos = Dinfo.GetFiles("*.prefab", SearchOption.AllDirectories);
        Font font5 = AssetDatabase.LoadAssetAtPath("Assets\\AssetsLibrary\\font\\hkyt5.TTF", typeof(Font)) as Font;
        foreach (FileInfo files in fileInfos)
        {
            string path = files.FullName;
            string assetPath = path.Substring(path.IndexOf("Assets\\"));
            staticWriteText += assetPath + "\n";
            GameObject prefab = AssetDatabase.LoadAssetAtPath(assetPath, typeof(GameObject)) as GameObject;
            Text[] Texts = prefab.GetComponentsInChildren<Text>(true);
            for (int i = 0; i < Texts.Length; i++)
            {
                Text gT = Texts[i];
                Font GTFont = gT.font;
                if (GTFont.name == "hkyt" || GTFont.name == "Arial")
                {
                    gT.font = font5;
                }
            }
            EditorUtility.SetDirty(prefab);

            //GameObject prefabGO = GetPrefabInstanceParent(prefab);
            UnityEngine.Object prefabAsset = null;
            if (prefab != null)
            {
                prefabAsset = PrefabUtility.GetPrefabParent(prefab);
                if (prefabAsset != null)
                    PrefabUtility.ReplacePrefab(prefab, prefabAsset, ReplacePrefabOptions.ConnectToPrefab);
            }            
        }
        AssetDatabase.SaveAssets();
        Debug.Log("替换完成");
    }

    //递归所有UI Prefab
    static public void LoadDiectoryPrefab(DirectoryInfo dictoryInfo,bool all = false)
    {
        if (!dictoryInfo.Exists) return;
        FileInfo[] fileInfos = dictoryInfo.GetFiles("*.prefab", SearchOption.AllDirectories);
        foreach (FileInfo files in fileInfos)
        {
            string path = files.FullName;
            string assetPath = path.Substring(path.IndexOf("Assets\\"));
            staticWriteText += assetPath + "\n";
            GameObject prefab = AssetDatabase.LoadAssetAtPath(assetPath, typeof(GameObject)) as GameObject;
            CurrentPrefabName = prefab.name;

            string tempPath = Path.GetDirectoryName(assetPath);
            //Debug.Log("assetPath : " + tempPath);

            GameObject instance = GameObject.Instantiate(prefab) as GameObject;
            instance.name = CurrentPrefabName;
            if (all)
                SearchPrefabAllString(instance.transform);
            else
                SearchPrefabString(instance.transform);

            if (IsReplace)
            {
                _createNewPrefab(tempPath, instance);
            }

            GameObject.DestroyImmediate(instance);
        }
    }

    //递归所有C#代码
    static public void LoadDiectoryCS(DirectoryInfo dictoryInfo)
    {

        if (!dictoryInfo.Exists) return;
        FileInfo[] fileInfos = dictoryInfo.GetFiles("*.cs", SearchOption.AllDirectories);
        foreach (FileInfo files in fileInfos)
        {
            string path = files.FullName;
            string assetPath = path.Substring(path.IndexOf("Assets\\"));
            TextAsset textAsset = AssetDatabase.LoadAssetAtPath(assetPath, typeof(TextAsset)) as TextAsset;
            string text = textAsset.text;
            //用正则表达式把代码里面两种字符串中间的字符串提取出来。
            Regex reg = new Regex("\".*?\"");
            Regex regZH = new Regex("[\u4e00-\u9fa5]");
            Match mZH;
            MatchCollection mc = reg.Matches(text);
            if (mc.Count > 0)
            {
                staticWriteText += path + "\n";
            }
            foreach (Match m in mc)
            {
                string format = m.Value;
                format = format.Replace("StrUtil.GetText(\"", "");
                format = format.Replace("\"", "");
                mZH = regZH.Match(format);
                //if (!Localization.Contains(format) && !string.IsNullOrEmpty(format))
                //{
                //    Localization.Add(format);
                //    staticWriteText += format + "\n";
                //}
                if (!string.IsNullOrEmpty(format) && mZH.Success)
                {
                    staticWriteText += format + "\n";
                }
                //if (!string.IsNullOrEmpty(format))
                //{
                //    Localization.Add(format);
                //    staticWriteText += format + "\n";
                //}
            }
        }
    }

    static public void SearchPrefabAllString(Transform root)
    {
        Text[] labels = root.GetComponentsInChildren<Text>(true);

        foreach (Text child in labels)
        {
            Text label = child;
            if (label != null)
            {
                string text = label.text;
                if (!string.IsNullOrEmpty(text))
                {
                    string path = string.Empty;
                    Transform temp = label.transform;
					if(temp.transform.parent != null)
					{
						while (temp.transform.parent)
						{
							path = temp.transform.parent.name + "/" + path;
							temp = temp.transform.parent;
						}
					}
					else
					{
						path += "/";
					}
                    
					path = path.Substring(0, path.Length - 1);
					string key = string.Format("{0}_{1}_{2}", CurrentPrefabName, path, label.name);
					if (text.Contains("\n"))
						text = text.Replace("\n", "|");
					float f;
					if (!float.TryParse(text, out f))
					{
						if (!PrefabLabelList.ContainsKey(key))
							PrefabLabelList.Add(key, text);
					}

                 
                }
            }
        }
    }

    //提取Prefab上的中文
    static public void SearchPrefabString(Transform root)
    {
        Text[] labels = root.GetComponentsInChildren<Text>(true);

        foreach (Text child in labels)
        {
            Text label = child;
            if (label != null)
            {
                string text = label.text;
                if (!string.IsNullOrEmpty(text))
                {
                    string path = string.Empty;
                    Transform temp = label.transform;
                    while (temp.transform.parent)
                    {
                        path = temp.transform.parent.name + "/" + path;
                        temp = temp.transform.parent;
                    }
                    if (!string.IsNullOrEmpty(path))
                        path = path.Substring(0, path.Length - 1);
                    
                    string key = string.Format("{0}_{1}_{2}", CurrentPrefabName, path, label.name);
                    if (!IsReplace)
                    {
                        Regex regZH = new Regex("[\u4e00-\u9fa5]");
                        MatchCollection mc = regZH.Matches(text);
                        if (mc.Count > 0)
                        {
                            if (text.Contains("\n"))
                                text = text.Replace("\n", "|");

                            float f;
                            if (!float.TryParse(text, out f))
                            {
                                if (!PrefabLabelList.ContainsKey(key))
                                    PrefabLabelList.Add(key, text);
                            }
                        }
                    }
                    else
                    {
                        if (PrefabLabelList.ContainsKey(key))
                        {
                            string value = PrefabLabelList[key];
                            if (value.Contains("|"))
                                value = value.Replace("|", "\n");

                            label.text = value;
                        }
                    }
                }
            }
        }
    }

    static void _createNewPrefab(string path, GameObject target)
    {
        //path = path.Replace("Prefab", "PrefabNew");
        if (!Directory.Exists(path))
            Directory.CreateDirectory(path);

        path = Path.Combine(path, target.name);

        string tempPath = string.Format("{0}.prefab", path);
        tempPath = tempPath.Replace("\\", "/");

        if (File.Exists(tempPath))
            File.Delete(tempPath);

        PrefabUtility.CreatePrefab(tempPath, target);
    }

    static void _createXml()
    {
        if (File.Exists(OutPathXml))
            File.Delete(OutPathXml);

        XmlDocument xmlDoc = new XmlDocument();
        XmlElement root = xmlDoc.CreateElement("prefabName_transformName_labelName");
        foreach (KeyValuePair<string,string> item in PrefabLabelList)
        {
            string key = item.Key;
            string value = item.Value;

            XmlElement element = xmlDoc.CreateElement("label");
            element.SetAttribute("name", key);
            element.InnerText = value;
            root.AppendChild(element);
        }

        xmlDoc.AppendChild(root);
        xmlDoc.Save(OutPathXml);

        Debug.Log("create xml ok");
    }

    static void _readXml()
    {
        if (File.Exists(OutPathXml))
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(OutPathXml);
            XmlNodeList nodeList = xmlDoc.SelectSingleNode("prefabName_transformName_labelName").ChildNodes;

            foreach (XmlElement item in nodeList)
            {
                string key = item.GetAttribute("name");
                string value = item.InnerText;
                //Debug.Log("key: " + key + "           value:" + value);
                PrefabLabelList.Add(key, value);
            }
        }
    }
}

