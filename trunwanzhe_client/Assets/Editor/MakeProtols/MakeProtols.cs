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
using System.Text.RegularExpressions;
using Assets.Scripts.Com.Net;

namespace Assets.Editor
{
	public class ProtoData
	{
		public string moduleName;
		public string messageName;
		public List<string> mFiledType = new List<string>();
		public List<string> mFieldName = new List<string>();

		public string GetLuaModuleName()
		{
			return moduleName + "_pb";
		}
	}

	public class MakeProtols : EditorWindow
	{
		public static void ReadProto(String protoPath)
		{
			string moduleName = Path.GetFileNameWithoutExtension(protoPath);
			string[] allLines = File.ReadAllLines(protoPath);
			ProtoData data = null;

			//Debug.LogError("moduleName:" + moduleName);

			foreach (string line in allLines)
			{
				if (line.IndexOf("message") != -1)
				{
					data = new ProtoData();
					data.moduleName = moduleName;
					MatchCollection matchs = Regex.Matches(line, "\\w+");
					data.messageName = matchs[1].ToString();

					//Debug.LogError("messageName:" + data.messageName);
				}
				else if (line.IndexOf("}") != -1)
				{
					if (line.Trim().Length == 1)
					{
						if (ProtoDataMap.ContainsKey(data.messageName))
						{
							Debug.LogError(moduleName + "  " + data.messageName + " repeat error");
						}

						ProtoDataMap[data.messageName] = data;
						ProtoModuleName.Add(data.GetLuaModuleName());
						data = null;
					}
				}
				else if (data != null && line.IndexOf("=") != -1)
				{
					MatchCollection matchs = Regex.Matches(line, "\\w+");
					data.mFiledType.Add(matchs[1].ToString());
					data.mFieldName.Add(matchs[2].ToString());
				}
			}

			if (data != null)
			{
				Debug.LogError(moduleName + "  " + data.messageName + " parse error");
			}
		}

		static private Dictionary<string, ProtoData> ProtoDataMap = new Dictionary<string, ProtoData>();
		static private HashSet<string> ProtoModuleName = new HashSet<string>();

		[MenuItem("Assets/MakeProtols")]
		static public void Packing()
		{
			ProtoDataMap = new Dictionary<string, ProtoData>();
			ProtoModuleName = new HashSet<string>();

			String path = "Assets/Editor/MakeProtols/protos";
			string[] allFiles = System.IO.Directory.GetFiles(path, "*.proto", System.IO.SearchOption.AllDirectories);

			foreach (string file in allFiles)
			{
				ReadProto(file);
			}

			Assembly[] assemblyList = AppDomain.CurrentDomain.GetAssemblies();

		
			string c2sString = "";
			string descString = "";
			string s2cString = "";

			Dictionary<int, Sysproto_data> protoDatas = new Dictionary<int, Sysproto_data>();

			foreach (KeyValuePair<int, Sysproto_data> kvp in protoDatas)
			{
				Sysproto_data data = kvp.Value;
				string id = data.id.ToString().Trim();

				ushort cmdID = ushort.Parse(id);
				if (NetReceive.CheckLuaReceive(cmdID) == false)
					continue;

				string c2s = data.c2s.Trim();
				string s2c = data.s2c.Trim();
				string memo = data.memo;
				string constStr = data.constStr;
				int isBack = data.back;//服务器是否会回包

				ProtoData c2sObj = GetProtoData(c2s);
				ProtoData s2cObj = GetProtoData(s2c);

				descString += "\t\t" + string.Format("[{0}] = \"{1}\",\n", id, memo);
				c2sString += "\n" + C2SObjToCodeString(id, c2sObj, c2s, constStr, memo, isBack);
				if (s2cObj != null)
				{
					s2cString += "\n" + S2CObjToCodeString(id, s2cObj, s2c, constStr, memo, isBack);
				}

				//Debug.LogError("c2s:" + c2s + "  c2sObj:" + c2sObj + "  s2c:" + s2c + "  s2cObj:" + s2cObj);
			}

			OutputC2SFile(c2sString, descString);
			OutputS2CFile(s2cString, descString);

			AssetDatabase.Refresh();

			Debug.Log("CreateProtolManager Complete...");
		}

		private static ProtoData GetProtoData(string messageName)
		{
			ProtoData data = null;
			ProtoDataMap.TryGetValue(messageName, out data);
			return data;
		}

		private static string S2CObjToCodeString(string id, ProtoData obj, string messageName, string constStr, string memo, int isBack)
		{
			List<string> outputList = null;

			List<string> codeStrList = new List<string>()
			{
				"--{0}",
				"function S2C:{0}({1})",
				   "\t{0}",
				"end"
			};

			string paramStr = "callback_" + messageName;
			string luaModuleName = obj.GetLuaModuleName();
			List<string> bodyStrList = new List<String>()
				{
					"local msg = nil;",
					"local doCallback = function(byteBuffer)",
						"\tif msg == nil then",
							"\t\t{0} = {0} or require('{1}');",
							"\t\tmsg = {0}.{1}();",
						"\tend",
						"\tmsg:ParseFromString(byteBuffer);",
						"\t{0}(msg);",
					"end",
					"self.mReceiveCallback[{0}] = doCallback;",
				};
			outputList = codeStrList;
			bodyStrList[3] = string.Format(bodyStrList[3], luaModuleName, "Protol." + luaModuleName);
			bodyStrList[4] = string.Format(bodyStrList[4], luaModuleName, messageName);
			bodyStrList[7] = string.Format(bodyStrList[7], paramStr);
			bodyStrList[9] = string.Format(bodyStrList[9], id);

			outputList[2] = string.Format(outputList[2], string.Join("\n\t", bodyStrList.ToArray()));

			outputList[0] = string.Format(outputList[0], memo);
			outputList[1] = string.Format(outputList[1], constStr, paramStr);

			string result = "";
			for (int i = 0, count = outputList.Count; i < count; i++)
			{
				result += outputList[i] + "\n";
			}

			return result;
		}

		private static string C2SObjToCodeString(string id, ProtoData obj, string messageName, string constStr, string memo, int isBack)
		{
			List<string> outputList = null;

			List<string> codeStrList = new List<string>()
			{
				"--{0}",
				"function C2S:{0}({1})",
				   "\t{0}",
				   "\tmNetManager:SendData({0},msg:SerializeToString());",
				"end"
			};

			List<string> codeStrListForEmpty = new List<string>()
			{
				"--{0}",
				"function C2S:{0}({1})",
				   "\tmNetManager:SendData({0},nil);",
				"end"
			};

			string paramStr = "";

			if (obj != null)
			{
				string luaModuleName = obj.GetLuaModuleName();
				List<string> bodyStrList = new List<String>()
				{
					string.Format("{0} = {0} or require('{1}');",luaModuleName ,"Protol."+luaModuleName),
					string.Format("local msg = {0}();", luaModuleName + "." + messageName)
				};

				List<string> fieldTypes = obj.mFiledType;
				List<string> fieldNames = obj.mFieldName;

				for (int i = 0; i < fieldTypes.Count; i++)
				{
					string fieldName = fieldNames[i];
					string paramFieldName = fieldName + "_" + fieldTypes[i];

					if (paramStr.Length > 0)
					{
						paramStr += ", " + paramFieldName;
					}
					else
					{
						paramStr = paramFieldName;
					}

					bodyStrList.Add(string.Format("msg.{0} = {1};", fieldName, paramFieldName));
				}
				outputList = codeStrList;

				outputList[2] = string.Format(outputList[2], string.Join("\n\t", bodyStrList.ToArray()));
				outputList[3] = string.Format(outputList[3], id, isBack);
			}
			else
			{
				outputList = codeStrListForEmpty;
				outputList[2] = string.Format(outputList[2], id, isBack);
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

		private static void OutputC2SFile(string content, string descString)
		{
			string varContent = "\t";
			foreach (var moduleName in ProtoModuleName)
			{
				varContent += "\n" + "local " + moduleName + ";";
			}
			varContent += "\t\n";

			string descContent = "\nProtolDesc={\n" +
			 descString +
			"}\n";

			string result = "local mLuaClass = require 'Core/LuaClass'\n" +
				"local mBaseLua = require 'Core/BaseLua' \n" +
				"local mNetManager = require 'Net/NetManager' \n" +
				"local C2S = mLuaClass('C2S',mBaseLua);" +
				"\n" + varContent + descContent + content + "\n" +
				"return C2S.LuaNew();";

			File.WriteAllText(Application.dataPath + "/Lua/ProtolManager/C2S.lua", result);
		}

		private static void OutputS2CFile(string content, string descString)
		{
			string varContent = "\t";
			foreach (var moduleName in ProtoModuleName)
			{
				varContent += "\n" + "local " + moduleName + ";";
			}
			varContent += "\t\n";

			string descContent = "\nS2C.mDesc={\n" +
			 descString +
			"}\n";

			string s2cReceiveCallback = "\nS2C.mReceiveCallback={};\n";

			string result = "local mLuaClass = require 'Core/LuaClass'\n" +
				"local mBaseLua = require 'Core/BaseLua' \n" +
				"local mNetManager = require 'Net/NetManager' \n" +
				"local S2C = mLuaClass('S2C',mBaseLua);" +
				"\n" + varContent + s2cReceiveCallback + content + "\n" +
				"return S2C.LuaNew();";

			File.WriteAllText(Application.dataPath + "/Lua/ProtolManager/S2C.lua", result);
		}


	}
}
