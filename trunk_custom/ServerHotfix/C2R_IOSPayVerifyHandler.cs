﻿using System;
using System.Collections.Generic;

namespace ET
{

    [ActorMessageHandler]
    public class C2R_IOSPayVerifyHandler : AMActorRpcHandler<Scene, C2R_IOSPayVerifyRequest, R2C_IOSPayVerifyResponse>
    {

        protected override async ETTask Run(Scene scene, C2R_IOSPayVerifyRequest request, R2C_IOSPayVerifyResponse response, Action reply)
        {
            int zone = UnitIdStruct.GetUnitZone(request.UnitId);
            zone = StartZoneConfigCategory.Instance.Get(zone).PhysicZone;

            using (await CoroutineLockComponent.Instance.Wait(CoroutineLockType.Recharge, request.UnitId))
            {
                await scene.GetComponent<ReChargeIOSComponent>().OnIOSPayVerify(new M2R_RechargeRequest()
                {
                    Zone = zone,
                    UnitId = request.UnitId,
                    payMessage = request.payMessage
                });
            }
              
            reply();
            await ETTask.CompletedTask;
        }
    }
}
