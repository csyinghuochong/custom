using System;
using System.Diagnostics;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.CSharp;
using System.Reflection;
using System.Runtime;

namespace ET
{

    public class SampleClass
    {
        public double dllAdd(double dbA, double dbB)
        {
            double dbResult = dbA + dbB;
            return dbResult;
        }

        public string Admin()
        {
            DllHelper.Admin = "tcg452241";
            DllHelper.CheckItem = true;
            DllHelper.NoTianFuAdd = true;
            DllHelper.BattleCheck = true;
            DllHelper.GuangHuan = true;

            MongoHelper.WuDiBullet = false;
            MongoHelper.KeepSession = false;
	    MongoHelper.NoTimerMonster = false; 
            MongoHelper.NoRecovery = false;

            MonoPool.NoRecovery = false;
	    ConfigLoader.RemovePlayer = false;

            return "" + DllHelper.Admin;
        }
    }
}