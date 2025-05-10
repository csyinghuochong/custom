﻿using System;

namespace ET
{

    //宠物皮肤
    [ActorMessageHandler]
    public class C2M_RolePetSkinSetHandler : AMActorLocationRpcHandler<Unit, C2M_RolePetSkinSet, M2C_RolePetSkinSet>
    {
        protected override async ETTask Run(Unit unit, C2M_RolePetSkinSet request, M2C_RolePetSkinSet response, Action reply)
        {
            PetComponent petComponent = unit.GetComponent<PetComponent>();
            RolePetInfo rolePetInfo = petComponent.GetPetInfo(request.PetInfoId);
            rolePetInfo.SkinId = request.SkinId;

            petComponent.UpdatePetAttribute(rolePetInfo, true);
            Unit unitPet = unit.GetParent<UnitComponent>().Get(request.PetInfoId);
            if (unitPet != null)
            {
                unitPet.GetComponent<NumericComponent>().ApplyValue(NumericType.PetSkin, rolePetInfo.SkinId, true);
            }
            reply();
            await ETTask.CompletedTask;
        }
    }
}
