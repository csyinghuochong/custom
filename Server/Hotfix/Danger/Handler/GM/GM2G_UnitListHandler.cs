﻿using System;
using System.Collections.Generic;

namespace ET
{
    [ActorMessageHandler]
    public class GM2G_UnitListHandler : AMActorRpcHandler<Scene, G2G_UnitListRequest, G2G_UnitListResponse>
    {
        protected override async ETTask Run(Scene scene, G2G_UnitListRequest request, G2G_UnitListResponse response, Action reply)
        {
            List<long> unitlist = new List<long>(); 
            Player[] players = scene.GetComponent<PlayerComponent>().GetAll();
            for (int i = 0; i < players.Length; i++)
            {
                if (players[i].RemoteAddress.Contains("127.0.0.1")
                 || players[i].RemoteAddress.Contains("39.96.194.143")
                 || players[i].RemoteAddress.Contains("47.94.107.92")
                 || players[i].RemoteAddress.Contains("220.202.201.144"))
                {
                    response.YaCeRobot++;
                }
                else
                {
                    response.OnLinePlayer++;
                    unitlist.Add(players[i].UnitId );
                }
            }
            response.UnitList = unitlist;   
            reply();
            await ETTask.CompletedTask;
        }

    }
}
