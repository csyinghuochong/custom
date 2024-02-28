using System;
using System.Net;

namespace ET
{

    public class AppStart_Init_Custom : AEvent<EventType.AppStart>
    {
        protected override void Run(EventType.AppStart args)
        {
            //服务器列表移过来
            ComHelp.AccountOldLogic = true;
            SkillHelp.CleanSkill = true;
            PopularizeHelper.PopularizeZone = 10;
            ConfigHelper.PackageLimit = 500;
            ConfigHelper.FunctionOpenIds.Remove(2000);
            Log.Warning($"PopularizeZone: {PopularizeHelper.PopularizeZone}");
            Console.WriteLine($"PopularizeZone: {PopularizeHelper.PopularizeZone}");
        }
    }
}
