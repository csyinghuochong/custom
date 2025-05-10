﻿using System;

namespace ET
{

    [ActorMessageHandler]
    public class C2M_ItemQiangHuaHandler : AMActorLocationRpcHandler<Unit, C2M_ItemQiangHuaRequest, M2C_ItemQiangHuaResponse>
    {
        protected override async ETTask Run(Unit unit, C2M_ItemQiangHuaRequest request, M2C_ItemQiangHuaResponse response, Action reply)
        {
            int maxLevel = QiangHuaHelper.GetQiangHuaMaxLevel(request.WeiZhi);
            BagComponent bagComponent = unit.GetComponent<BagComponent>();
            if (bagComponent.QiangHuaLevel[request.WeiZhi] >= maxLevel - 1)
            {
                reply();
                return;
            }
            
            EquipQiangHuaConfig equipQiangHuaConfig =QiangHuaHelper.GetQiangHuaConfig(request.WeiZhi, bagComponent.QiangHuaLevel[request.WeiZhi]);
            string costItems = equipQiangHuaConfig.CostItem;
            costItems += $"@1;{equipQiangHuaConfig.CostGold}";
            if (!bagComponent.OnCostItemData(costItems, ItemLocType.ItemLocBag, ItemGetWay.CostItem ))
            {
                response.Error = ErrorCode.ERR_ItemNotExist;
                reply();
                return;
            }

            double addPro = equipQiangHuaConfig.AdditionPro * bagComponent.QiangHuaFails[request.WeiZhi];
            if ((float)equipQiangHuaConfig.SuccessPro + addPro >= RandomHelper.RandFloat01())
            {
                bagComponent.QiangHuaLevel[request.WeiZhi]++;
                bagComponent.QiangHuaFails[request.WeiZhi]=0;
            }
            else
            {
                bagComponent.QiangHuaFails[request.WeiZhi]++;
            }
            response.QiangHuaLevel = bagComponent.QiangHuaLevel[request.WeiZhi];
            unit.GetComponent<TaskComponent>().TriggerTaskEvent(TaskTargetType.QiangHuaLevel_17, 0, response.QiangHuaLevel);
            unit.GetComponent<TaskComponent>().TriggerTaskCountryEvent(TaskTargetType.QiangHuaLevel_17, 0, response.QiangHuaLevel);
            Function_Fight.GetInstance().UnitUpdateProperty_Base(unit, true, true);
            reply();
            await ETTask.CompletedTask;
        }
    }
}
