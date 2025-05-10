﻿using System.IO;
using System.Reflection;
using System.Runtime.Loader;

namespace ET
{
    public static class DllHelper
    {

        public static string Admin = "admin";

        public static bool CheckItem = false;

        public static bool NoTianFuAdd = true;

        public static bool BattleCheck = true;

        public static bool GuangHuan = false;

        private static AssemblyLoadContext assemblyLoadContext;
        
        public static Assembly GetHotfixAssembly()
        {
            assemblyLoadContext?.Unload();
            System.GC.Collect();
            assemblyLoadContext = new AssemblyLoadContext("Hotfix", true);
            byte[] dllBytes = File.ReadAllBytes("./Server.Hotfix.dll");
            byte[] pdbBytes = File.ReadAllBytes("./Server.Hotfix.pdb");
            Assembly assembly = assemblyLoadContext.LoadFromStream(new MemoryStream(dllBytes), new MemoryStream(pdbBytes));
            return assembly;
        }
    }
}