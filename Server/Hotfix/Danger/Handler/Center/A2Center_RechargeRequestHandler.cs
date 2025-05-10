﻿using System;
using System.Collections.Generic;

namespace ET
{

    [ActorMessageHandler]
    public class A2Center_RechargeRequestHandler : AMActorRpcHandler<Scene, A2Center_RechargeRequest, Center2A_RechargeResponse>
    {
        protected override async ETTask Run(Scene scene, A2Center_RechargeRequest request, Center2A_RechargeResponse response, Action reply)
        {

            using (await CoroutineLockComponent.Instance.Wait(CoroutineLockType.Recharge, request.AccountId))
            {
                int zone = scene.DomainZone();
                Log.Warning($"A2Center_RechargeRequest: {scene.DomainZone()}");
                List<DBCenterAccountInfo> resulets = await Game.Scene.GetComponent<DBComponent>().Query<DBCenterAccountInfo>(zone, d => d.Id == request.AccountId);
                resulets[0].PlayerInfo.RechargeInfos.Add(request.RechargeInfo);
                Game.Scene.GetComponent<DBComponent>().Save<DBCenterAccountInfo>(scene.DomainZone(), resulets[0]).Coroutine();
                reply();
            }

            await ETTask.CompletedTask;
        }
    }
}
