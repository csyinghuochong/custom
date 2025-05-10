﻿using System;
using System.Collections.Generic;

namespace ET
{
    [ActorMessageHandler]
    public class C2M_PetHeXinChouKaHandler: AMActorLocationRpcHandler<Unit, C2M_PetHeXinChouKaRequest, M2C_PetHeXinChouKaResponse>
    {
        protected override async ETTask Run(Unit unit, C2M_PetHeXinChouKaRequest request, M2C_PetHeXinChouKaResponse response, Action reply)
        {
            if (unit.GetComponent<BagComponent>().GetBagLeftCell() < request.ChouKaType)
            {
                response.Error = ErrorCode.ERR_BagIsFull;
                reply();
                return;
            }

            int dropId = 0;
            int exlporeNumber = unit.GetComponent<NumericComponent>().GetAsInt(NumericType.PetHeXinExploreNumber);
            string[] set = GlobalValueConfigCategory.Instance.Get(112).Value.Split(';');
            float discount;
            if (exlporeNumber < int.Parse(set[0])) // 超过300次打8折
            {
                discount = 1;
            }
            else
            {
                discount = float.Parse(set[1]);
            }

            if (request.ChouKaType == 1)
            {
                string needItems = GlobalValueConfigCategory.Instance.Get(110).Value.Split('@')[0];
                dropId = int.Parse(GlobalValueConfigCategory.Instance.Get(110).Value.Split('@')[1]);
                bool sucess = unit.GetComponent<BagComponent>().OnCostItemData(needItems, ItemLocType.ItemLocBag, ItemGetWay.PetHeXinExplore);
                if (!sucess)
                {
                    response.Error = ErrorCode.ERR_ItemNotEnoughError;
                    reply();
                    return;
                }

                //unit.GetComponent<NumericComponent>().ApplyChange(null, NumericType.PetExploreNumber, 1, 0);
            }
            else if (request.ChouKaType == 10)
            {
                string[] itemInfo10 = GlobalValueConfigCategory.Instance.Get(111).Value.Split('@')[0].Split(';');
                dropId = int.Parse(GlobalValueConfigCategory.Instance.Get(111).Value.Split('@')[1]);
                bool sucess = unit.GetComponent<BagComponent>().OnCostItemData(new List<RewardItem>()
                {
                    new RewardItem() { ItemID = int.Parse(itemInfo10[0]), ItemNum = (int)(int.Parse(itemInfo10[1]) * discount) }
                }, ItemLocType.ItemLocBag, ItemGetWay.PetChouKa);
                if (!sucess)
                {
                    response.Error = ErrorCode.ERR_ItemNotEnoughError;
                    reply();
                    return;
                }
                unit.GetComponent<NumericComponent>().ApplyChange(null, NumericType.PetHeXinExploreNumber, 10, 0);
            }
            else
            {
                Log.Error($"C2M_PetHeXinChouKaRequest 1");
                response.Error = ErrorCode.ERR_ModifyData;
                reply();
                return;
            }

            List<RewardItem> rewardItems = new List<RewardItem>();
            for (int i = 0; i < request.ChouKaType; i++)
            {
                DropHelper.DropIDToDropItem_2(dropId, rewardItems);
            }
            
            unit.GetComponent<BagComponent>()
                    .OnAddItemData(rewardItems, string.Empty, $"{ItemGetWay.PetExplore}_{TimeHelper.ServerNow()}");
            response.ReardList = rewardItems;
            reply();
            await ETTask.CompletedTask;
        }
    }
}