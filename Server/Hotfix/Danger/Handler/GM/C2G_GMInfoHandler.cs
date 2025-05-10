﻿using System;
using System.Linq;
using System.Collections.Generic;

namespace ET
{

    public class C2G_GMInfoHandler : AMActorRpcHandler<Scene, C2C_GMInfoRequest, C2C_GMInfoResponse>
    {
        protected override async ETTask Run(Scene scene, C2C_GMInfoRequest request, C2C_GMInfoResponse response, Action reply)
        {
            if (AdminHelper.AdminAccount.Contains(request.Account))
            {
                int totalNumber = 0;
                int robotNumber = 0;
                List<int> zones = ServerMessageHelper.GetAllZone();
                for (int i = 0; i < zones.Count; i++)
                {
                    long gateServerId = StartSceneConfigCategory.Instance.GetBySceneName(zones[i], "Gate1").InstanceId;
                    G2G_UnitListResponse g2M_UpdateUnitResponse = (G2G_UnitListResponse)await ActorMessageSenderComponent.Instance.Call
                        (gateServerId, new G2G_UnitListRequest() { });
                    totalNumber+= g2M_UpdateUnitResponse.OnLinePlayer;
                    robotNumber += g2M_UpdateUnitResponse.OnLineRobot;
                    robotNumber += g2M_UpdateUnitResponse.YaCeRobot;
                }
                response.OnLineNumber = totalNumber;
                response.OnLineRobot = robotNumber;
            }
            else
            {
                response.Error = ErrorCode.ERR_GMError;
            }
            reply();
        }
    }
}
