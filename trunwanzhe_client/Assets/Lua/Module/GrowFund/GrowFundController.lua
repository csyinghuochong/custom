local mLuaClass = require "Core/LuaClass"
local mC2S = require "ProtolManager/C2S"
local mS2C = require "ProtolManager/S2C"
local mBaseController = require "Core/BaseController"
local mGrowFundModel = require "Module/GrowFund/GrowFundModel"
local mConfigSysactive_grow_fund = require "ConfigFiles/ConfigSysactive_grow_fund"
local ViewEnum = Assets.Scripts.Com.Game.Enum.ViewEnum;
local UIManager = Com.Game.Manager.CSharpToLuaInterface.GetUIManager();
local ItemRewardInfo = Assets.Scripts.Com.Game.Module.Reward.ItemRewardInfo;
local CommonGoodsVo = Assets.Scripts.Com.Game.Module.CommonComponent.CommonGoodsVo;
local GrowFundController = mLuaClass("GrowFundController",mBaseController);

function GrowFundController:OnLuaNew()
	local super = self:GetSuper(mBaseController.LuaClassName);
	super.OnLuaNew(self);
end

function GrowFundController:AddNetListeners()
	mS2C:ACTIVE_BUY_GROW_FUND(function(pbResult)
		if pbResult.result == 1 then
			self:RecvBuyGrowFund();
		end
	end);

	mS2C:ACTIVE_GROW_FUND_INFO(function(pbActiveGrowFund)
		mGrowFundModel:OnRecvGetGrowFundInfo(pbActiveGrowFund);
	end);

	mS2C:ACTIVE_GET_GROW_FUND(function(pbResult)
		if pbResult.result == 1 then
			self:RecvGetGrowFund();
		end
	end);
end

function GrowFundController:AddEventListeners()

end

function GrowFundController:SendBuyGrowFund()
	mC2S:ACTIVE_BUY_GROW_FUND();
end
function GrowFundController:RecvBuyGrowFund()
	self:SendGetGrowFundInfo();
end

function GrowFundController:SendGetGrowFundInfo()
	mC2S:ACTIVE_GROW_FUND_INFO();
end

function GrowFundController:SendGetGrowFund(level)
	self.mGrowFundLevel = level;
	mC2S:ACTIVE_GET_GROW_FUND(level);
end
function GrowFundController:RecvGetGrowFund()
	local mGrowFundLevel = self.mGrowFundLevel;
	local fund = mConfigSysactive_grow_fund[mGrowFundLevel];
	if fund ~= nil then
		local info = ItemRewardInfo.New();
		info:AddGoodsVO(CommonGoodsVo.New(100001, fund.gold_num, true, 1, false));
		UIManager:OpenUIWithParamFromLua(ViewEnum.ItemRewardViewBase, info);
	end

	self:SendGetGrowFundInfo();  
end

local mGrowFundController = GrowFundController.LuaNew();
return mGrowFundController;