local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local NotifyDef = require "Module/CommonUI/NotifyDef"
local NotifyManager = require "Module/CommonUI/NotifyManager"
local CSharpInterface = Com.Game.Manager.CSharpToLuaInterface;
local EventConst = Assets.Scripts.Com.Game.Events.EventConstant;
local FunctionType = Assets.Scripts.Com.Game.Manager.FunctionType;
local LandRewardModel = mLuaClass("LandRewardModel",mBaseModel);
local mTable = require 'table'


function LandRewardModel:OnLuaNew()
	self.mCheckLandReward = false;
    self.LADN_REWARD_DAYS = 7;
end

function LandRewardModel:CheckShowLandRewardView()
    local mCheckLandReward = self.mCheckLandReward;
      
    if not mCheckLandReward then
        mCheckLandReward = true;
        self.mCheckLandReward = true;

        if self:IsHaveLandReward() then
            local mLandRewardView = require "Module/LandReward/LandRewardView"
            mLandRewardView:OpenUI();
        end
    end
end

function LandRewardModel:OnRecvGetLandRewardInfo(value)
    self.mCheckLandReward = false;
    self:OnRecvGetLandRewardBack(value);
end

function LandRewardModel:OnRecvGetLandRewardBack(value)
    self.mLandReward = value;
    local RecvLandRewardInfo = self.mRecvLandRewardInfo;
    if RecvLandRewardInfo ~= nil then
        RecvLandRewardInfo();
    end

    self:CheckLandRewardNotify();  
    CSharpInterface.Dispatch(EventConst.ACTIVITY_CHECK_FUNCTION_OPEN);
end

function LandRewardModel:OnRecvGetLandReward(value)
    self:OnRecvGetLandRewardBack(value);
end

function LandRewardModel:IsLandRewardValid()
    local mLandReward = self.mLandReward;
    if mLandReward ~= nil then
        return mLandReward.get_award_day < self.LADN_REWARD_DAYS;
    else
        return false;
    end
end

function LandRewardModel:CheckLandRewardNotify()
    local state = self:IsHaveLandReward();
    NotifyManager:OnShowNotify(NotifyDef.NEW_LADN_REWARD_NOTICE, state);
end

function LandRewardModel:GetFunctionManager()
    return CSharpInterface.GetFunctionManager();
end

function LandRewardModel:IsHaveLandReward()
    local mLandReward = self.mLandReward;
    if mLandReward ~= nil then
        local FunctionManager = self:GetFunctionManager();
        return mLandReward.get_award_day < mLandReward.login_day
            and FunctionManager:GetFunctionOpen(FunctionType.LandReward);
    else
        return false;
    end
end

local mLandRewardModel = LandRewardModel.LuaNew();
return mLandRewardModel;