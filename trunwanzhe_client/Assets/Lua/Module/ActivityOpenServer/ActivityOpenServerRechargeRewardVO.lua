local mLuaClass = require "Core/LuaClass"
local mConfigSysactive_charge = require 'ConfigFiles/ConfigSysactive_charge'
local mCommonGoodsVo = Assets.Scripts.Com.Game.Module.CommonComponent.CommonGoodsVo;
local mActivityOpenServerType = require "Module/ActivityOpenServer/ActivityOpenServerType"
local ActivityOpenServerRechargeRewardVO = mLuaClass("ActivityOpenServerRechargeRewardVO");

function ActivityOpenServerRechargeRewardVO:OnLuaNew(index, recharge, receive, id)
	self.mType = index;
    self.mRechargeNumber = recharge;
    self.mReceiveReward = receive;
    local sys_vo = mConfigSysactive_charge[id];
    self.mSysVO = sys_vo;

    self.mNeedRecharge = recharge < sys_vo.charge;
    local get_reward = recharge >= sys_vo.charge and not receive;
    self.mCanGetReward = get_reward;
    self.mTextDesc = string.format('%s充值达', index == mActivityOpenServerType.TODAY_RECHARGE and '今日' or '累计');
    self.mTextButton = recharge < sys_vo.charge and '充值' or (get_reward and '领取' or '已领取');
end

function ActivityOpenServerRechargeRewardVO:GetReward()
    local mActivityOpenServerController = require "Module/ActivityOpenServer/ActivityOpenServerController"
    local sys_vo = self.mSysVO;
	if self.mType == mActivityOpenServerType.TODAY_RECHARGE then
        mActivityOpenServerController:SendGetActiveChargeToDayReward(sys_vo.charge);
    else
        mActivityOpenServerController:SendGetActiveChargeTotalReward(sys_vo.charge);
    end
end

function ActivityOpenServerRechargeRewardVO:GetGoodsList()
	local list = {};
	local sys_vo = self.mSysVO;
	local reward = self.mType == mActivityOpenServerType.TODAY_RECHARGE and sys_vo.day1 or sys_vo.day7;
	for k, v in pairs(reward) do
		list[k] = mCommonGoodsVo.New(v.goods_id, v.goods_num, true, 1, false);
	end
	return list;
end

return ActivityOpenServerRechargeRewardVO;