local mLuaClass = require "Core/LuaClass"
local mC2S = require "ProtolManager/C2S"
local mS2C = require "ProtolManager/S2C"
local mBaseController = require "Core/BaseController"
local mLandRewardModel = require "Module/LandReward/LandRewardModel"
local mConfigSyssign_always = require "ConfigFiles/ConfigSyssign_always"
local ViewEnum = Assets.Scripts.Com.Game.Enum.ViewEnum;
local EventConst = Assets.Scripts.Com.Game.Events.EventConstant;
local CSharpInterface = Com.Game.Manager.CSharpToLuaInterface;
local UIManager = Com.Game.Manager.CSharpToLuaInterface.GetUIManager();
local ItemRewardInfo = Assets.Scripts.Com.Game.Module.Reward.ItemRewardInfo;
local CommonGoodsVo = Assets.Scripts.Com.Game.Module.CommonComponent.CommonGoodsVo;
local LandRewardController = mLuaClass("LandRewardController",mBaseController);

function LandRewardController:OnLuaNew()
	local super = self:GetSuper(mBaseController.LuaClassName);
	super.OnLuaNew(self);
end

function LandRewardController:AddNetListeners()
	mS2C:SIGN_7_INFO(function(pbSignPlayerSign)
		mLandRewardModel:OnRecvGetLandRewardInfo(pbSignPlayerSign);
	end);

	mS2C:SIGN_7_GET_AWARD(function(pbSignPlayerSign)
		self:RecvGetLandReward(pbSignPlayerSign);
	end);
end

function LandRewardController:AddEventListeners()
	self.mRefreshGameData = function(  )
		self:SendGetLandRewardInfo();
	end
	CSharpInterface.AddEventListener(EventConst.REFRESH_GAME_DATA, self.mRefreshGameData);
end

--获得七天登陆信息
function LandRewardController:SendGetLandRewardInfo()

	mC2S:SIGN_7_INFO();
end

function LandRewardController:SendGetLandReward(day)
	self.mLandRewardDay = day;
	mC2S:SIGN_7_GET_AWARD(day);
end
function LandRewardController:RecvGetLandReward(value)
	local mLandRewardDay = self.mLandRewardDay;
	local sys_reward = mConfigSyssign_always[mLandRewardDay];
    if sys_reward ~= null then
        local reward = CommonGoodsVo.New(sys_reward.land_goods[1].goods_id, sys_reward.land_goods[1].goods_num, true, 1, false);
        local info = ItemRewardInfo.New();
        info:AddGoodsVO(reward);
        UIManager:OpenUIWithParamFromLua(ViewEnum.ItemRewardViewBase, info);
    end
    mLandRewardModel:OnRecvGetLandReward(value);
end

local mLandRewardController = LandRewardController.LuaNew();
return mLandRewardController;