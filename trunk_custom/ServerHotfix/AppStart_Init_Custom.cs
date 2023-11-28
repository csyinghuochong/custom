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
            //int packetSize = GMHelp.GetRandomNumber();
            //Log.Console($"AppStart_Init_Custom: {packetSize}");
            //PacketParser.OuterPacketSizeLengthS = packetSize;
        }
    }
}
