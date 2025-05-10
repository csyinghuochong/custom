﻿using System;
using System.Collections.Generic;

namespace ET
{
    //技能升级
    [ActorMessageHandler]
    public class C2M_SkillUpHandler : AMActorLocationRpcHandler<Unit, C2M_SkillUp, M2C_SkillUp>
    {

		protected override async ETTask Run(Unit unit, C2M_SkillUp request, M2C_SkillUp response, Action reply)
		{
			SkillSetComponent skillSetComponent = unit.GetComponent<SkillSetComponent>();
			if (skillSetComponent.GetBySkillID(request.SkillID) == null)
            {
                response.Error = ErrorCode.ERR_Parameter;
                reply();
                return;
            }

			List<SkillPro> SkillList = skillSetComponent.SkillList;
			SkillConfig skillconf = SkillConfigCategory.Instance.Get(request.SkillID);
			int nextSkillID = skillconf.NextSkillID;
			if (nextSkillID == 0)
			{
				response.Error = ErrorCode.ERR_GoldNotEnoughError;     //错误码:技能达到最大等级
				reply();
				return;
			}

            if (skillSetComponent.GetBySkillID(nextSkillID) != null)
            {
                response.Error = ErrorCode.ERR_AlreadyLearn;
                reply();
                return;
            }

            UserInfoComponent unitInfoComponent = unit.GetComponent<UserInfoComponent>();
			int costGoldValue = skillconf.CostGoldValue;
			int costSPValue = skillconf.CostSPValue;
			int RoseSP = unitInfoComponent.UserInfo.Sp;
			if (/*unitInfoComponent.UserInfo.Gold < costGoldValue || */RoseSP < costSPValue)
			{
				response.Error = ErrorCode.ERR_GoldNotEnoughError;     //错误码:升级所需金币或者能量值不足
				reply();
				return;
			}

			//替换原有技能
			for (int i = SkillList.Count - 1; i >= 0; i--)
			{
				if (SkillList[i].SkillID == request.SkillID)
				{
					SkillList[i].SkillID = nextSkillID;
					break;
				}
			}
	
			response.NewSkillID = nextSkillID;
			unit.GetComponent<UserInfoComponent>().UpdateRoleMoneySub(UserDataType.Gold, (costGoldValue*-1).ToString(), true, ItemGetWay.CostItem);
			unit.GetComponent<UserInfoComponent>().UpdateRoleData(UserDataType.Sp, (costSPValue * -1).ToString());

			Function_Fight.GetInstance().UnitUpdateProperty_Base( unit,true, true );
			//测试跑马灯
			//string text = "";
			//if (RandomHelper.RandFloat01() < 0.5f)
			//	text = "测试一个长字符串的适配！！测试一个长字符串的适配！！";
			//else
			//	text = "";
			//M2C_HorseNoticeInfo m2C_HorseNoticeInfo = new M2C_HorseNoticeInfo() { NoticeText = skillconf.SkillName + " 升级了. " + text };
			//MessageHelper.Broadcast(unit, m2C_HorseNoticeInfo);

			////测试邮件
			//long mailServerId = StartSceneConfigCategory.Instance.GetBySceneName(unit.DomainZone(), Enum.GetName(SceneType.EMail)).InstanceId;
			//E2M_EMailSendResponse g_SendChatRequest = (E2M_EMailSendResponse)await ActorMessageSenderComponent.Instance.Call
			//	(mailServerId, new M2E_EMailSendRequest() {  Id = unit.GetComponent<UnitInfoComponent>().UserID });

			reply();
			await ETTask.CompletedTask;
		}

	}
}