using System;
using UnityEditor;
using UnityEngine;
using System.IO;
using System.Collections.Generic;
using System.Xml;
using System.Reflection;
using System.Text;
using Assets.Scripts.Com.Game.Manager;
using Assets.Scripts.Com.Game.Config;

namespace Assets.Editor
{
    public class BuildProtoBuffXML : EditorWindow
    {
        [MenuItem("Assets/CreateProtoBuffFile")]
        static public void Packing()
        {
            Assembly[] assemblyList = AppDomain.CurrentDomain.GetAssemblies();

        

            //             string path = Application.dataPath + "/ProtoBuff/base_protocol.xml";
            //             XmlDocument xmlDoc = new XmlDocument();
            //             xmlDoc.Load(path);
            // 
            //             XmlNode root = xmlDoc.SelectSingleNode("RECORDS");
            //             XmlNodeList nodeList = root.ChildNodes;

            string c2sString = "";
            string c2sDescString = "";
            string s2cString = "";

            //             foreach (XmlNode xn in nodeList)
            //             {
            //                 XmlElement xe = (XmlElement)xn;
            //                 string id = xe.GetAttribute("id");
            //                 string c2s = xe.GetAttribute("c2s");
            //                 string s2c = xe.GetAttribute("s2c");
            //                 string memo = xe.GetAttribute("memo");
            //                 string constStr = xe.GetAttribute("const");

          
            OutputC2SFile(c2sString, c2sDescString);
            OutputS2CFile(s2cString);

            AssetDatabase.Refresh();

            Debug.Log("CreateProtoBuffFile Complete...");
        }

        private static object GetClassInstance(Assembly[] assemblyList, string clsName)
        {
            string className = "";
            object obj = null;

            if (string.IsNullOrEmpty(clsName) == false && clsName != "null")
            {
                foreach (Assembly assembly in assemblyList)
                {
                    className = "PROTO." + clsName;
                    obj = assembly.CreateInstance(className);

                    if (obj == null)
                    {
                        className = "pb_common." + clsName;
                        obj = assembly.CreateInstance(className);
                    }

                    if (obj == null)
                    {
                        className = "tutorial." + clsName;
                        obj = assembly.CreateInstance(className);
                    }

                    if (obj != null)
                    {
                        return obj;
                    }
                }
            }

            return obj;
        }

        private static string S2CObjToCodeString(string id, string memo, string clsName, string constStr)
        {
            return string.Format("public static PBNetCMDData<{0}> CLS_{2} {4} CreateNetCMDData<{0}>({1}, \"{3}\");{5}", clsName, id, constStr, memo, "{ get { return", "}}");
        }

        private static string C2SObjToCodeString(string id, object obj, string clsName, string constStr, string memo, int isBack)
        {
            List<string> outputList = null;

            List<string> codeStrList = new List<string>()
            {
                "\t//{0}",
                "\tpublic static void {0}({1})",
                "\t{",
                   "\t\t//MemoryStream databuf = new MemoryStream();",
                   "\t\t{0}",
                   "\t\t//ProtoBuf.Serializer.NonGeneric.Serialize(databuf, data);",
                   "\t\tvar rawPacket=RawPacket.CreateInstance().Init({0},data,{1});",
                   "\t\tif (sendAction != null)\n\t\t{\n\t\t\t\tsendAction(rawPacket);\n\t\t\t\treturn;\n\t\t}",
                   "\t\tNetInterface.SendData(rawPacket);",
                "\t}"
            };

            List<string> codeStrListForEmpty = new List<string>()
            {
                "\t//{0}",
                "\tpublic static void {0}({1})",
                "\t{",
                   "\t\t//MemoryStream databuf = new MemoryStream();",
                   "\t\tvar rawPacket=RawPacket.CreateInstance().Init({0},null,{1});",
                   "\t\tif (sendAction != null)\n\t\t{\n\t\t\t\tsendAction(rawPacket);\n\t\t\t\treturn;\n\t\t}",
                   "\t\tNetInterface.SendData(rawPacket);",
                "\t}"
            };

            List<string> bodyStrList = new List<String>()
            {
                string.Format("{0} data = new {0}();", clsName)
            };

            string paramStr = "";

            if (obj != null)
            {
                PropertyInfo[] props = obj.GetType().GetProperties(BindingFlags.Public | BindingFlags.Instance | BindingFlags.SetProperty | BindingFlags.SetField);

                foreach (PropertyInfo prop in props)
                {
                    string paramTempStr = "";

                    if (prop.PropertyType.IsGenericType)
                    {
                        //continue;
                        paramTempStr = string.Format("List<{0}>", prop.PropertyType.GetGenericArguments()[0]) + " " + prop.Name;
                    }
                    else
                    {
                        if (prop.Name.IndexOf("Specified") != -1)
                        {
                            continue;
                        }

                        paramTempStr = prop.PropertyType.Name + " " + prop.Name;
                    }

                    if (paramStr.Length > 0)
                    {
                        paramStr += ", " + paramTempStr;
                    }
                    else
                    {
                        paramStr = paramTempStr;
                    }

                    if (prop.PropertyType.IsGenericType)
                    {
                        bodyStrList.Add(string.Format("data.{0}.AddRange({0});", prop.Name));
                    }
                    else
                        bodyStrList.Add(string.Format("data.{0} = {0};", prop.Name));
                }
                outputList = codeStrList;

                codeStrList[4] = string.Format(outputList[4], string.Join("\n\t\t", bodyStrList.ToArray()));
                outputList[6] = string.Format(outputList[6], id, isBack);
            }
            else
            {
                outputList = codeStrListForEmpty;
                outputList[4] = string.Format(outputList[4], id, isBack);
            }

            if (string.IsNullOrEmpty(paramStr))
            {
                paramStr = "Action<RawPacket> sendAction = null";
            }
            else
            {
                paramStr += ",Action<RawPacket> sendAction = null";
            }

            outputList[0] = string.Format(outputList[0], memo);
            outputList[1] = string.Format(outputList[1], constStr, paramStr);

            string result = "";
            for (int i = 0, count = outputList.Count; i < count; i++)
            {
                result += outputList[i] + "\n";
            }

            return result;
        }

        private static void OutputC2SFile(string content, string c2sDescString)
        {
            string descContent = "\n\tpublic static Dictionary<int, string> descList = new Dictionary<int, string>();\n" +
            "\tstatic C2S()" +
            "\n\t{\n" +
             c2sDescString +
            "\t}\n";

            string result = "using Assets.Scripts.Com.Net.Protos.Proto;\n" +
                "using System; \n" +
                "using UnityEngine; \n" +
                "using PROTO; \n" +
                "using pb_common; \n" +
                "using System.IO;\n" +
                "using System.Collections.Generic; \n" +
                "using Assets.Scripts.Com.Net; \n" +
                "public class C2S \n{" + descContent + content + "\n}";

            using (StreamWriter writer = new StreamWriter(Application.dataPath + "/ProtoBuff/c2s.cs", false, Encoding.UTF8))
            {
                writer.Write(result);
            }
        }

        private static void OutputS2CFile(string content)
        {
            string s2cTemplateString = "";
            string s2cTemplatePath = Application.dataPath + "/ProtoBuff/s2cTemplate.txt";
            StreamReader sr = new StreamReader(s2cTemplatePath);
            string line;
            while ((line = sr.ReadLine()) != null)
            {
                s2cTemplateString += "\n" + line;
            }

            int insertPos = s2cTemplateString.IndexOf("{0}");

            string result = s2cTemplateString.Substring(0, insertPos) + content + s2cTemplateString.Substring(insertPos + 3);

            using (StreamWriter writer = new StreamWriter(Application.dataPath + "/ProtoBuff/s2c.cs", false, Encoding.UTF8))
            {
                writer.Write(result);
            }
        }


    }
}
