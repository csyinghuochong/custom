local mLuaClass = require "Core/LuaClass"
local mBaseController = require "Core/BaseController"
local mC2S = require "ProtolManager/C2S"
local mS2C = require "ProtolManager/S2C"
local ViewEnum = Assets.Scripts.Com.Game.Enum.ViewEnum;
local UIManager = Com.Game.Manager.CSharpToLuaInterface.GetUIManager();
local ItemRewardInfo = Assets.Scripts.Com.Game.Module.Reward.ItemRewardInfo;
local mActivityOpenServerVO = require "Module/ActivityOpenServer/ActivityOpenServerVO";
local mActivityOpenServerType = require "Module/ActivityOpenServer/ActivityOpenServerType"
local mActivityOpenServerModel = require "Module/ActivityOpenServer/ActivityOpenServerModel"
local mActivityOpenServerRechargeRewardVO = require "Module/ActivityOpenServer/ActivityOpenServerRechargeRewardVO"
local ActivityOpenServerController = mLuaClass("ActivityOpenServerController",mBaseController);

function ActivityOpenServerController:OnLuaNew()
	local super = self:GetSuper(mBaseController.LuaClassName);
	super.OnLuaNew(self);
end

function ActivityOpenServerController:AddNetListeners()
	--排行榜奖励
	mS2C:ACTIVE_OPEN_SERV_INFO(function(pbActiveOpen)
		mActivityOpenServerModel:OnRecvGetActiveOpenServerInfo(pbActiveOpen);
	end);
	mS2C:ACTIVE_OPEN_REWARD(function(pbResult)
		if pbResult.result == 1 then
			self:RecvGetActiveOpenServerReward();
		end
	end);

	--充值奖励
	mS2C:ACTIVE_CHARGE_REWARD_LIST(function(pbActiveChargeList)
	 	mActivityOpenServerModel:OnRecvActiveChargeList(pbActiveChargeList);
	end);
	mS2C:ACTIVE_CHARGE_REWARD_TODAY(function(pbResult)
		self:RecvGetActiveChargeToDayReward(pbResult.result);
	end);
	
	mS2C:ACTIVE_CHARGE_REWARD_7DAY(function(pbResult)
		self:RecvGetActiveChargeTotalReward(pbResult.result);
	end);
end

function ActivityOpenServerController:AddEventListeners()

end

function ActivityOpenServerController:SendGetActiveOpenServerInfo()
	mC2S:ACTIVE_OPEN_SERV_INFO();
	mC2S.ACTIVE_CHARGE_REWARD_LIST();
end

 --领取开服七天活动奖励 1闯关2战力3竞技场 
 function ActivityOpenServerController:SendGetActiveOpenServerReward(id)
 	self.mActivityRewardId = id;
	mC2S:ACTIVE_OPEN_REWARD(id);
end
function ActivityOpenServerController:RecvGetActiveOpenServerReward()
	local id = self.mActivityRewardId;
	local list = mActivityOpenServerVO:GetWelfareReward(id);
	local info = ItemRewardInfo.New();
	for k, v in pairs(list) do
		info:AddGoodsVO(v);
	end
	UIManager:OpenUIWithParamFromLua(ViewEnum.ItemRewardViewBase, info);
	mActivityOpenServerModel:OnRecvGetActiveOpenServerReward(id);
end

--领取当天充值奖励
function ActivityOpenServerController:SendGetActiveChargeToDayReward(id)
 	 mC2S:ACTIVE_CHARGE_REWARD_TODAY(id);
end
function ActivityOpenServerController:RecvGetActiveChargeToDayReward(id)
	self:ShowActiveChargeReward(mActivityOpenServerType.TODAY_RECHARGE, id);
 	mActivityOpenServerModel:OnGetActiveChargeReward(mActivityOpenServerType.TODAY_RECHARGE, id);
end
function ActivityOpenServerController:ShowActiveChargeReward(index, id)
    local list = mActivityOpenServerRechargeRewardVO.LuaNew(index, 0, false, id):GetGoodsList();
	local info = ItemRewardInfo.New();
	for k, v in pairs(list) do
		info:AddGoodsVO(v);
	end
	UIManager:OpenUIWithParamFromLua(ViewEnum.ItemRewardViewBase, info);
end

--领取累计充值奖励
function ActivityOpenServerController:SendGetActiveChargeTotalReward(id)
	mC2S:ACTIVE_CHARGE_REWARD_7DAY(id);
end
function ActivityOpenServerController:RecvGetActiveChargeTotalReward(id)
	self:ShowActiveChargeReward(mActivityOpenServerType.All_RECHARGE, id);
 	mActivityOpenServerModel:OnGetActiveChargeReward(mActivityOpenServerType.All_RECHARGE, id);
end

local mActivityOpenServerController = ActivityOpenServerController.LuaNew();
return mActivityOpenServerController;