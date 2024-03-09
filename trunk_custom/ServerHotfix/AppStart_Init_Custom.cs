using System;
using System.Net;

namespace ET
{

    public class AppStart_Init_Custom : AEvent<EventType.AppStart>
    {
        protected override void Run(EventType.AppStart args)
        {
            //服务器列表移过来
            ConfigData.AccountOldLogic = true;
            ConfigData.CleanSkill = true;
            ConfigData.PopularizeZone = 10;
            ConfigData.PackageLimit = 500;
            ConfigData.FunctionOpenIds.Remove(2000);
       
            Console.WriteLine($"CSkill: {ConfigData.CleanSkill}");
        }
    }
}
