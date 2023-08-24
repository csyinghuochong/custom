using UnityEngine;
using UnityEditor;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using System;
public class ExportEffectConfig : Editor
{
    [MenuItem("Tools/ExportEffectConfig")]
    public static void ExportEffectConfigsCommand()
    {
        ExportEffectConfigs(false);
    }
    public static void ExportEffectConfigs(bool destroyScript = true)
    {
        string configPath = "Assets/EffectConfigFile/EffectConfig.lua";
        if (!Directory.Exists("Assets/EffectConfigFile"))
        {
            Directory.CreateDirectory("Assets/EffectConfigFile");
        }
        string[] allFiles = System.IO.Directory.GetFiles("Assets/RawResources/fx", "*.prefab", System.IO.SearchOption.AllDirectories);
        string tableStr = "local EffectConfigs = {\n";
        if (allFiles != null)
        {
            for (int i = 0; i < allFiles.Length; i++)
            {
                string file = allFiles[i].Replace(@"\", "/");

                GameObject go = AssetDatabase.LoadAssetAtPath<GameObject>(file);
                EffectConfig ec = go.GetComponent<EffectConfig>();
                if (ec)
                {
                    string itemTableStr = GetObjectLuaTable(ec);
                    tableStr += string.Format(" [\"{0}\"] = {1},\n", go.name, itemTableStr);
                    if (destroyScript)
                    {
                        GameObject.DestroyImmediate(ec, true);
                    }
                }
            }
        }

        tableStr += "\n}\n return EffectConfigs;";
        byte[] fileBytes = System.Text.Encoding.UTF8.GetBytes(tableStr.ToCharArray());
        using (FileStream fileStream = new FileStream(configPath, FileMode.Create))
        {
            fileStream.Write(fileBytes, 0, fileBytes.Length);
        }

        AssetDatabase.Refresh();
    }


    public static bool CheckBasicType(Type type)
    {
        string typeName = type.FullName;
        List<string> list = new List<string> { "System.Int32", "System.Single", "System.String", "System.Boolean"};
        return list.IndexOf(typeName) != -1 || type.IsEnum;
    }

    public static String ConvertToString(Type type, object o, bool forceString = false)
    {
        if (type.IsEnum)
        {
            return ConvertEnumToString(o);
        }

        if (type.FullName == "System.Boolean")
        {
            return o.ToString().ToLower();
        }

        if (forceString || type.FullName == "System.String")
        {
            return String.Format("[[{0}]]", o.ToString());
        }

        return o.ToString();
    }

    public static string ConvertObjectNameToString(UnityEngine.Object o)
    {
        return o ? String.Format("[[{0}]]", o.name) : "nil";
    }

    public static string ConvertEnumToString(object o)
    {
        string str = o.ToString();
        return str == "None"?"nil":String.Format("[[{0}]]", o.ToString()); 
    }
    public static string GetObjectLuaTable(object obj, int tabIndex = 0, bool forceString = false)
    {
        if (obj == null)
        {
            return "nil";
        }

        Type type = obj.GetType();
        FieldInfo[] fields = type.GetFields();

        string tabString = "";
        for (int i = 0; i < tabIndex; i++)
        {
            tabString += "    ";
        }
        string ItemTabString = "\n  " + tabString;

        string tableStr = "{";


        foreach (FieldInfo info in fields)
        {
            Type infoType = info.FieldType;
            if (CheckBasicType(infoType))
            {
                tableStr += string.Format(ItemTabString + "{0} = {1},", info.Name, ConvertToString(infoType, info.GetValue(obj), forceString));
            }
            else
            {
                object objValue = (info.GetValue(obj));

                if (objValue is IList)
                {
                    tableStr += string.Format(ItemTabString + "{0} = {1},", info.Name, GetListLuaTable((IList)objValue, tabIndex + 2));
                }
                else
                {
                    UnityEngine.Object o = objValue as UnityEngine.Object;
                    tableStr += string.Format(ItemTabString + "{0} = {1},", info.Name, ConvertObjectNameToString(o));
                }
            }
        }

        return tableStr + "\n" + tabString + "}";
    }

    public static string GetListLuaTable(IList list, int tabIndex = 0)
    {
        if (list == null || list.Count == 0)
        {
            return "nil";
        }

        string tabString = "";
        for (int i = 0; i < tabIndex; i++)
        {
            tabString += "    ";
        }
        string ItemTabString = "\n  " + tabString;

        string tableStr = "{";

        foreach (var e in list)
        {
            if (e == null)
            {
                tableStr += string.Format(ItemTabString + "{0},","nil");
            }
            else
            {
                Type infoType = e.GetType();
                if (CheckBasicType(infoType))
                {
                    tableStr += string.Format(ItemTabString + "{0},", ConvertToString(infoType, e));
                }
                else
                {
                    UnityEngine.Object o = e as UnityEngine.Object;
                    tableStr += string.Format(ItemTabString + "{0},", ConvertObjectNameToString(o));
                }
            }

        }

        return tableStr + "\n" + tabString + "}";
    }
}
