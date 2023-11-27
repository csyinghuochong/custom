using System;

namespace ET
{

    public class AppStart_Init_Custom : AEvent<EventType.AppStart>
    {
        protected override void Run(EventType.AppStart args)
        {
            int packetSize = TimeHelper.GetRandomNumber();
            Log.ILog.Debug($"AppStart_Init_Custom: {packetSize}");
            PacketParser.OuterPacketSizeLengthC = packetSize;
            ///技能按钮事件
        }
    }
}
