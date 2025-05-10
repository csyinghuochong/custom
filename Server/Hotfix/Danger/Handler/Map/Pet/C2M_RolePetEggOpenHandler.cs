﻿using System;
using System.Collections.Generic;

namespace ET
{
    [ActorMessageHandler]
    public class C2M_RolePetEggOpenHandler : AMActorLocationRpcHandler<Unit, C2M_RolePetEggOpen, M2C_RolePetEggOpen>
    {
        protected override async ETTask Run(Unit unit, C2M_RolePetEggOpen request, M2C_RolePetEggOpen response, Action reply)
        {
            PetComponent petComponent = unit.GetComponent<PetComponent>();
            RolePetEgg rolePetEgg = petComponent.RolePetEggs[request.Index];
            if (rolePetEgg.ItemId == 0)
            {
                reply();
                return;
            }

            ItemConfig itemConf = ItemConfigCategory.Instance.Get(rolePetEgg.ItemId);
            string[] petinfos = itemConf.ItemUsePar.Split('@');
            int needCost = ComHelp.ReturnPetOpenTimeDiamond(rolePetEgg.ItemId,rolePetEgg.EndTime);

            UserInfo userInfo = unit.GetComponent<UserInfoComponent>().UserInfo;
            if (userInfo.Diamond < needCost)
            {
                response.Error = ErrorCode.ERR_DiamondNotEnoughError;
                reply();
                return;
            }
            unit.GetComponent<UserInfoComponent>().UpdateRoleMoneySub(UserDataType.Diamond, (needCost * -1).ToString(), true,ItemGetWay.PetChouKa);
            List<int> weights = new List<int>();
            List<int> petlists = new List<int>();
            for (int i = 2; i < petinfos.Length; i++)
            {
                string[] petitem = petinfos[i].Split(';');
                petlists.Add(int.Parse(petitem[0]));
                weights.Add(int.Parse(petitem[1]));
            }
            int index = RandomHelper.RandomByWeight(weights);
            if (petlists.Count <= index)
            {
                index = 0;
            }
            if (rolePetEgg.ItemId == 10010093)
            {
                unit.GetComponent<ChengJiuComponent>().TriggerEvent(ChengJiuTargetEnum.OpenZGPetEggNumber_306, 0, 1);
            }
            response.PetInfo =  unit.GetComponent<PetComponent>().OnAddPet(ItemGetWay.PetEggDuiHuan, petlists[index],0, rolePetEgg.FuLing);
            unit.GetComponent<TaskComponent>().TriggerTaskEvent( TaskTargetType.PetFuHuaNumber_34, 0, 1 );
            unit.GetComponent<TaskComponent>().TriggerTaskCountryEvent(TaskTargetType.PetFuHuaNumber_34, 0, 1);

            unit.GetComponent<TaskComponent>().TriggerTaskEvent(TaskTargetType.PetFuHuaId_35, rolePetEgg.ItemId, 1);
            unit.GetComponent<TaskComponent>().TriggerTaskCountryEvent(TaskTargetType.PetFuHuaId_35, rolePetEgg.ItemId, 1);

            rolePetEgg.ItemId = 0;
            rolePetEgg.EndTime = 0;
            rolePetEgg.FuLing = 0;
            reply();
            await ETTask.CompletedTask;
        }
    }
}
