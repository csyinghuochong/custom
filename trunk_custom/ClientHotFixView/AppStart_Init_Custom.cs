using System;
using UnityEngine;


namespace ET
{

    public class AppStart_Init_Custom : AEvent<EventType.AppStart>
    {
        protected override void Run(EventType.AppStart args)
        {
            //int packetSize = GMHelp.GetRandomNumber();
            //Log.ILog.Debug($"AppStart_Init_Custom: {packetSize}");
            //PacketParser.OuterPacketSizeLengthC = packetSize;
            ///技能按钮事件

            Vector2 dest = new Vector2(6, 8);
            Vector2 todo = ShaderMathHelper.GetNormalized(dest);

            Log.ILog.Debug($"矢量长度  : {dest.magnitude}   {Math.Sqrt(dest.x * dest.x + dest.y * dest.y)}");
            Log.ILog.Debug($"矢量归一化: {todo}");
        }

    }
}
