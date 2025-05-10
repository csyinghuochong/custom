﻿using System;


namespace ET
{

    [ActorMessageHandler]
    public class C2M_SkillJueXingHandler : AMActorLocationRpcHandler<Unit, C2M_SkillJueXingRequest, M2C_SkillJueXingResponse>
    {
        protected override async ETTask Run(Unit unit, C2M_SkillJueXingRequest request, M2C_SkillJueXingResponse response, Action reply)
        {
            //判断条件
            OccupationJueXingConfig occupationJueXingConfig = OccupationJueXingConfigCategory.Instance.Get(request.JueXingId);
            if (occupationJueXingConfig == null)
            {
                Log.Error($"C2M_SkillJueXingRequest 1");
                response.Error = ErrorCode.ERR_ModifyData;
                reply();
                return;
            }

            NumericComponent numericComponent = unit.GetComponent<NumericComponent>();
            if (numericComponent.GetAsLong(NumericType.JueXingExp) < occupationJueXingConfig.costExp)
            {
                response.Error = ErrorCode.ERR_ExpNoEnough;
                reply();
                return;
            }

            UserInfoComponent userInfoComponent = unit.GetComponent<UserInfoComponent>();
            if (userInfoComponent.UserInfo.Gold < occupationJueXingConfig.costGold)
            {
                response.Error = ErrorCode.ERR_GoldNotEnoughError;
                reply();
                return;
            }

            BagComponent bagComponent = unit.GetComponent<BagComponent>();
            if (!bagComponent.CheckCostItem(occupationJueXingConfig.costItem))
            {
                response.Error = ErrorCode.ERR_ItemNotEnoughError;
                reply();
                return;
            }

            SkillSetComponent skillSetComponent = unit.GetComponent<SkillSetComponent>();

            bool preerror = false;
            if (occupationJueXingConfig.Pre_Condition != null)
            {
                for (int i = 0; i < occupationJueXingConfig.Pre_Condition.Length; i++)
                {
                    SkillPro skillPro = skillSetComponent.GetBySkillID(occupationJueXingConfig.Pre_Condition[i]);
                    if (skillPro == null)
                    {
                        preerror = true;
                        break;
                    }
                }
            }
            if (preerror)
            {
                response.Error = ErrorCode.Pre_Condition_Error;
                reply();
                return;
            }

            numericComponent.ApplyChange(null, NumericType.JueXingExp, occupationJueXingConfig.costExp * -1, 0);

            userInfoComponent.UpdateRoleMoneySub(UserDataType.Gold, (occupationJueXingConfig.costGold * -1).ToString(), true, ItemGetWay.JueXing);

            bagComponent.OnCostItemData(occupationJueXingConfig.costItem, ItemLocType.ItemLocBag, ItemGetWay.JueXing);

            //增加技能
            skillSetComponent.OnJueXing(request.JueXingId);


            Function_Fight.GetInstance().UnitUpdateProperty_Base(unit, true, true);

            reply();
            await ETTask.CompletedTask;
        }
    }
}
