local mLuaClass = require "Core/LuaClass"
local mC2S = require "ProtolManager/C2S"
local mS2C = require "ProtolManager/S2C"
local mBaseController = require "Core/BaseController"
local mActivityModel = require "Module/Activity/ActivityModel"
local mConfigSysrecharge = require 'ConfigFiles/ConfigSysrecharge'
local ViewEnum = Assets.Scripts.Com.Game.Enum.ViewEnum;
local CSharpInterface = Com.Game.Manager.CSharpToLuaInterface;
local FunctionType = Assets.Scripts.Com.Game.Manager.FunctionType;
local ItemRewardInfo = Assets.Scripts.Com.Game.Module.Reward.ItemRewardInfo;
local UIManager = Com.Game.Manager.CSharpToLuaInterface.GetUIManager();
local mCommonGoodsVo = Assets.Scripts.Com.Game.Module.CommonComponent.CommonGoodsVo;
local ActivityController = mLuaClass("ActivityController",mBaseController);

function ActivityController:OnLuaNew()
	local super = self:GetSuper(mBaseController.LuaClassName);
	super.OnLuaNew(self);
end

function ActivityController:AddNetListeners()
	mS2C:ACTIVE_LOGIN_INFO(function(pbActiveLogin)
		mActivityModel:SetLoginInfo(pbActiveLogin);
	end);

	mS2C:ACTIVE_PHASE_INFO(function(pbId32)
		mActivityModel:SetPhaseInfo(pbId32.id);
	end);

	mS2C:ACTIVE_OPREATE(function(pbResult)
		if pbResult.result == 1 then
			mActivityModel:RecvActiveOperateBack(self.mOperateType, self.mOperateId);
		end
	end);

	mS2C:FIRST_CHARGE(function(pbPayFirst)
		self:RecvGetFirstRechargeReward();
	end);

	mS2C:GET_CODE_AWARD(function(pbCodeGoods)
		print('激活码兑换成功')

        local info = ItemRewardInfo.New();
        for k, v in ipairs(pbCodeGoods.goods) do
         	 local reward = mCommonGoodsVo.New(v.goods_id, v.goods_num, true, 1, false);
         	 info:AddGoodsVO(reward);
        end

        UIManager:OpenUIWithParamFromLua(ViewEnum.ItemRewardViewBase, info);
        mActivityModel:OnRecvExchangeActivationCode();
	end);
end

function ActivityController:AddEventListeners()

end

function ActivityController:SendActivityLoginInfo()
	mC2S:ACTIVE_LOGIN_INFO();
	self:SendActivityPhaseInfo();
end

function ActivityController:SendActivityPhaseInfo()
	mC2S:ACTIVE_PHASE_INFO();
end

function ActivityController:SendActivityOperate(op_type, params)
	self.mOperateType = op_type;
	self.mOperateId = params;
	mC2S:ACTIVE_OPREATE(op_type, params);
end

function ActivityController:SendGetFirstRechargeReward()
	mC2S:FIRST_CHARGE(0);
end

function ActivityController:GetFirstRechareRewardList( )
	return mConfigSysrecharge[6].recharge_award;
end

function ActivityController:RecvGetFirstRechargeReward(value)
	local info = ItemRewardInfo.New();
	local sys_reward = self:GetFirstRechareRewardList();
	for k, v in pairs(sys_reward) do
		info:AddGoodsVO(mCommonGoodsVo.New(v.goods_id, v.goods_num, true, 1, false));
	end
	
	UIManager:OpenUIWithParamFromLua(ViewEnum.ItemRewardViewBase, info);
end

--兑换激活码
function ActivityController:SendExchangeActivationCode( code )
	code = string.upper(code);
	print('激活码:'..code..':end');

	mC2S:GET_CODE_AWARD(code);
end

local mActivityController = ActivityController.LuaNew();
return mActivityController;