﻿using System;
using System.Collections.Generic;

namespace ET
{

    [ActorMessageHandler]
    public class C2M_PetShouHuActiveHandler : AMActorLocationRpcHandler<Unit, C2M_PetShouHuActiveRequest, M2C_PetShouHuActiveResponse>
    {
        protected override async ETTask Run(Unit unit, C2M_PetShouHuActiveRequest request, M2C_PetShouHuActiveResponse response, Action reply)
        {
            unit.GetComponent<PetComponent>().PetShouHuActive  = request.PetShouHuActive;
            response.PetShouHuActive = request.PetShouHuActive;
            Function_Fight.GetInstance().UnitUpdateProperty_Base( unit, true, true );
            reply();
            await ETTask.CompletedTask;
        }
    }
}
