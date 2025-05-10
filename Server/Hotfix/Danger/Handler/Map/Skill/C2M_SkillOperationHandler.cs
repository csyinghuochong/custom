﻿using System;

namespace ET
{
	//技能通用操作
    [ActorMessageHandler]
    public class C2M_SkillOperationHandler : AMActorLocationRpcHandler<Unit, C2M_SkillOperation, M2C_SkillOperation>
    {
		protected override async ETTask Run(Unit unit, C2M_SkillOperation request, M2C_SkillOperation response, Action reply)
		{
            //request.OperationType  = 1 重置技能点
            //request.OperationType  = 2 重置职业
            UserInfoComponent userInfoComponent = unit.GetComponent<UserInfoComponent>();
            int level = userInfoComponent.UserInfo.Lv;
			int sp = userInfoComponent.UserInfo.Sp;
			switch (request.OperationType)
			{
				case 1:
                    GlobalValueConfig globalValueConfig = GlobalValueConfigCategory.Instance.Get(20);
                    int needGold = int.Parse(globalValueConfig.Value);
                    userInfoComponent = unit.GetComponent<UserInfoComponent>();
                    if (userInfoComponent.UserInfo.Gold < needGold)
                    {
                        response.Error = ErrorCode.ERR_GoldNotEnoughError;
                        reply();
                        return;
                    }

                    userInfoComponent.UpdateRoleMoneySub(UserDataType.Gold, (needGold * -1).ToString());
					userInfoComponent.UpdateRoleData(UserDataType.Sp, (level - sp - 1).ToString());
					unit.GetComponent<SkillSetComponent>().OnSkillReset(true);
					break;
				case 2:

                    int toOcc = 0;
                    try
                    {
                        toOcc = int.Parse(request.OperationValue);
                    }
                    catch (Exception ex)
                    { 
                        Log.Error(ex);
                        response.Error = ErrorCode.ERR_Parameter;
                        reply();
                        return;
                    }

                    if (!OccupationTwoConfigCategory.Instance.Contain(toOcc))
                    {
                        Log.Error($"C2M_ChangeOccTwoRequest.1");
                        response.Error = ErrorCode.ERR_ModifyData;
                        reply();
                        return;
                    }


                    string ChangeOccItem = "10000178;1";
                    BagComponent bagComponent = unit.GetComponent<BagComponent>();  
                    if (!bagComponent.CheckCostItem(ChangeOccItem))
                    {
                        response.Error = ErrorCode.ERR_ItemNotEnoughError;
                        reply();
                        return;
                    }

                    if (userInfoComponent.UserInfo.OccTwo != 0)
                    {
                        unit.GetComponent<SkillSetComponent>().OnChangeJueXing(userInfoComponent.UserInfo.OccTwo, toOcc);
                        userInfoComponent.UserInfo.OccTwoOld.Add(userInfoComponent.UserInfo.OccTwo);
                    }

                    sp = unit.GetComponent<SkillSetComponent>().OnOccReset();
					userInfoComponent.UpdateRoleData(UserDataType.Sp, sp.ToString());
                    bagComponent.OnCostItemData(ChangeOccItem, ItemLocType.ItemLocBag, ItemGetWay.SkillMake);
                    
                    unit.GetComponent<SkillSetComponent>().OnChangeOccTwoRequest(toOcc);
                    unit.GetComponent<SkillSetComponent>().AsyncUpdateSkillSet().Coroutine();
                    break;
                case 3:
                    unit.GetComponent<NumericComponent>().ApplyValue(NumericType.SkillMakePlan2, 1);
                    break;
                case 4:
                    unit.GetComponent<NumericComponent>().ApplyValue(NumericType.GemWarehouseOpen, 1);
                    break;
			}

			reply();
			await ETTask.CompletedTask;
		}
	}
}
