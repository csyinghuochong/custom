using System;
using System.Net;

namespace ET
{

    public class AppStart_Init_Custom : AEvent<EventType.AppStart>
    {
        protected override void Run(EventType.AppStart args)
        {
            Log.Console("AppStart_Init_Custom");
            ComHelp.AccountOldLogic = true;
            SkillHelp.CleanSkill = true;
        }
    }
}
