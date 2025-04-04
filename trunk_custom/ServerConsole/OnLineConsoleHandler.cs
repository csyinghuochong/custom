﻿using System.Collections.Generic;
using System.Linq;

namespace ET
{

    [ConsoleHandler(ConsoleMode.OnLineNumer)]
    public class OnLineConsoleHandler : IConsoleHandler
    {
        public async ETTask Run(ModeContex contex, string content)
        {
            switch (content)
            {
                case ConsoleMode.OnLineNumer:
                    contex.Parent.RemoveComponent<ModeContex>();
                    Log.Console($"C must have zone id");
                    Log.Warning($"C must have zone id");
                    break;
                default:
                    string[] ss = content.Split(" ");
                    string zoneid = ss[1];

#if SERVER
                    int number = 0;
                    int robot = 0;
                    int yace = 0;
                    if (zoneid == "0")
                    {
                        List<int> zones = ServerMessageHelper.GetAllZone();
                        for (int i = 0; i < zones.Count; i++)
                        {
                            long gateServerId = StartSceneConfigCategory.Instance.GetBySceneName(zones[i], "Gate1").InstanceId;
                            G2G_UnitListResponse g2M_UpdateUnitResponse = (G2G_UnitListResponse)await ActorMessageSenderComponent.Instance.Call
                                (gateServerId, new G2G_UnitListRequest() { });
                            number += g2M_UpdateUnitResponse.OnLinePlayer;
                            robot += g2M_UpdateUnitResponse.OnLineRobot;
                            yace += g2M_UpdateUnitResponse.YaCeRobot;
                        }
                    }
                    else
                    {
                        long gateServerId = StartSceneConfigCategory.Instance.GetBySceneName(int.Parse(zoneid), "Gate1").InstanceId;
                        G2G_UnitListResponse g2M_UpdateUnitResponse = (G2G_UnitListResponse)await ActorMessageSenderComponent.Instance.Call
                            (gateServerId, new G2G_UnitListRequest() { });
                        number = g2M_UpdateUnitResponse.OnLinePlayer;
                        robot = g2M_UpdateUnitResponse.OnLineRobot;
                        yace = g2M_UpdateUnitResponse.YaCeRobot;
                    }
                    string zonestr = zoneid == "0" ? "全部" : zoneid;
                    Log.Console($"{zonestr}区 在线人数: 玩家：{number}  机器人：{robot} 压测:{yace}");
                    Log.Warning($"{zonestr}区 在线人数: 玩家：{number}  机器人：{robot} 压测:{yace}");

#endif
                    break;
            }

            await ETTask.CompletedTask;
        }
    }
}
