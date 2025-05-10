﻿using System;

namespace ET
{
    [ActorMessageHandler]
    public class C2M_PetFubenRewardHandler : AMActorLocationRpcHandler<Unit, C2M_PetFubenRewardRequest, M2C_PetFubenRewardResponse>
    {

        protected override async ETTask Run(Unit unit, C2M_PetFubenRewardRequest request, M2C_PetFubenRewardResponse response, Action reply)
        {
            int rewardId = unit.GetComponent<PetComponent>().GetCanRewardId();
            if (rewardId == 0)
            {
                response.Error = ErrorCode.ERR_AlreadyFinish;
                reply();
                return;
            }
            PetFubenRewardConfig rewardConfig = PetFubenRewardConfigCategory.Instance.Get(rewardId);
            int needCell =   ItemHelper.GetNeedCell(rewardConfig.RewardItems);
            if ( unit.GetComponent<BagComponent>().GetBagLeftCell() < needCell)
            {
                response.Error = ErrorCode.ERR_BagIsFull;
                reply();
                return;
            }

            bool ret =  unit.GetComponent<BagComponent>().OnAddItemData(rewardConfig.RewardItems, $"{ItemGetWay.PetFubenReward}_{TimeHelper.ServerNow()}");
            if (!ret)
            {
                Log.Debug($"C2M_PetFubenRewardHandler false : {unit.Id}");
            }
            unit.GetComponent<PetComponent>().PetFubeRewardId = rewardId;

            reply();
            await ETTask.CompletedTask;
        }
    }
}
