using System;
using System.Collections.Generic;
using System.IO;

namespace ET
{
    public class ConfigLoader : IConfigLoader
    {

        public static bool RemovePlayer = true;

        public void GetAllConfigBytes(Dictionary<string, byte[]> output)
        {
            foreach (string file in Directory.GetFiles($"../Config", "*.bytes"))
            {
                string key = Path.GetFileNameWithoutExtension(file);
                output[key] = File.ReadAllBytes(file);
            }

            output["StartMachineConfigCategory"] = File.ReadAllBytes($"../Config/{Game.Options.StartConfig}/StartMachineConfigCategory.bytes");
            output["StartProcessConfigCategory"] = File.ReadAllBytes($"../Config/{Game.Options.StartConfig}/StartProcessConfigCategory.bytes");
            output["StartSceneConfigCategory"] = File.ReadAllBytes($"../Config/{Game.Options.StartConfig}/StartSceneConfigCategory.bytes");
            output["StartZoneConfigCategory"] = File.ReadAllBytes($"../Config/{Game.Options.StartConfig}/StartZoneConfigCategory.bytes");
        }

        public void PreGetAllConfigBytes()
        {
            //CheckBytes("StartMachineConfigCategory");
            //CheckBytes("StartProcessConfigCategory");
            //CheckBytes("StartSceneConfigCategory");
            //CheckBytes("StartZoneConfigCategory");
        }

        public void CheckBytes(string key)
        {
            if (!string.IsNullOrEmpty(Game.Options.Parameters))
            {
                string password = Game.Options.Parameters + "00000";
                Console.WriteLine($"password:  {password}");
                string inputPath = $"../Config/{Game.Options.StartConfig}/{key}.bytes";
                string outputPath = $"../Config/{Game.Options.StartConfig}/{key}De.bytes";
                ByteHelper.Decrypt(inputPath, outputPath, password);

                File.Delete(inputPath);
                File.Move(outputPath, inputPath);
                File.Delete(outputPath);
            }
        }

        public byte[] GetOneConfigBytes(string configName)
        {
            if (configName.Contains("ET."))
            {
                configName = configName.Substring(3, configName.Length - 3);
            }
            byte[] configBytes = File.ReadAllBytes($"../Config/{configName}.bytes");
            return configBytes;
        }
    }
}