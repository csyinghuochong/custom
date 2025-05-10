﻿using System;

namespace ET
{
    [ActorMessageHandler]
    public class C2M_RandomTowerRewardHandler : AMActorLocationRpcHandler<Unit, C2M_RandomTowerRewardRequest, M2C_RandomTowerRewardResponse>
    {
        protected override async ETTask Run(Unit unit, C2M_RandomTowerRewardRequest request, M2C_RandomTowerRewardResponse response, Action reply)
        {
            if (!TowerConfigCategory.Instance.Contain(request.RewardId))
            {
                Log.Error($"C2M_RandomTowerRewardRequest 1");
                response.Error = ErrorCode.ERR_ModifyData;
                reply();
                return;
            }


            UserInfoComponent userInfoComponent = unit.GetComponent<UserInfoComponent>();
            if (userInfoComponent.UserInfo.TowerRewardIds.Contains(request.RewardId))
            {
                response.Error = ErrorCode.ERR_AlreadyReceived;
                reply();
                return;
            }

            int sceneType = request.SceneType;  

            if (sceneType == SceneTypeEnum.TrialDungeon)
            {
                int passId = unit.GetComponent<NumericComponent>().GetAsInt(NumericType.TrialDungeonId);
                if (passId < request.RewardId )
                {
                    Log.Error($"C2M_RandomTowerRewardRequest 2");
                    response.Error = ErrorCode.ERR_ModifyData;
                    reply();
                    return;
                }
            }

            if (sceneType != SceneTypeEnum.TrialDungeon)
            {
                Log.Error($"C2M_RandomTowerRewardRequest 3");
                response.Error = ErrorCode.ERR_ModifyData;
                reply();
                return;
            }

            TowerConfig towerRewardConfig = TowerConfigCategory.Instance.Get(request.RewardId);

            string userName = unit.GetComponent<UserInfoComponent>().UserInfo.Name;
            Log.Warning($"试炼之地领取奖励： 区:{unit.DomainZone()}   {unit.Id}   {request.RewardId}  {userName}  {unit.GetComponent<UserInfoComponent>().UserInfo.Lv}");

            if (unit.GetComponent<BagComponent>().OnAddItemData(towerRewardConfig.DropShow, $"{ItemGetWay.RandomTowerReward}_{TimeHelper.ServerNow()}"))
            {
                userInfoComponent.UserInfo.TowerRewardIds.Add(request.RewardId);
            }
            else
            {
                response.Error = ErrorCode.ERR_BagIsFull;
                reply();
                return;
            }

            reply();
            await ETTask.CompletedTask;
        }
    }
}
