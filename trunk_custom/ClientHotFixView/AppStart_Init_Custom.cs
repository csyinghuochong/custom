using System;

namespace ET
{

    public class AppStart_Init_Custom : AEvent<EventType.AppStart>
    {
        protected override void Run(EventType.AppStart args)
        {
            Log.ILog.Debug("AppStart_Init_Custom");

            ///技能按钮事件
        }
    }
}
