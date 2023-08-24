local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local NotifyDef = require "Module/CommonUI/NotifyDef"
local NotifyManager = require "Module/CommonUI/NotifyManager"
local ActivityType = require "Module/Activity/ActivityType";
local FunctionType = Assets.Scripts.Com.Game.Manager.FunctionType;
local CSharpInterface = Com.Game.Manager.CSharpToLuaInterface;
local EventConstant = Assets.Scripts.Com.Game.Events.EventConstant;
local mConfigSysactive_lv = require "ConfigFiles/ConfigSysactive_lv"
local mConfigSysactive_combat = require "ConfigFiles/ConfigSysactive_combat"
local mConfigSysactive_phase = require "ConfigFiles/ConfigSysactive_phase"
local mGrowFundModel = require "Module/GrowFund/GrowFundModel"
local mLandRewardModel = require "Module/LandReward/LandRewardModel"
local mActivityOpenServerModel = require "Module/ActivityOpenServer/ActivityOpenServerModel";
local ActivityModel = mLuaClass("ActivityModel",mBaseModel);
local ArrayUtil = require "Utils/ArrayUtil"
local mTable = require 'table'

function ActivityModel:OnLuaNew()
	local mArenaInfoInit = function()
		self:OnArenaInfoInit()
	end
	local mUpdatePhase = function(phase)
		self:OnUpdatePhase(phase);
	end
	local mUpdatePlayerPower = function(power)
		self:OnUpdatePlayerPower(power);
	end
	local mUpdatePlayerBaseLevel = function(level)
		self:OnUpdatePlayerLevel(level);
	end

	CSharpInterface.mCheckFunctionIsValid = function (function_type)
		return self:CheckFunctionIsValid(function_type);
	end

	self.mOpenFirstCharge = true;
	CSharpInterface.AddEventListener(EventConstant.ARENA_INFO_INIT, mArenaInfoInit);
    CSharpInterface.AddEventListenerInt(EventConstant.PVP_PHASE_UPDATE, mUpdatePhase);
    CSharpInterface.AddEventListenerInt(EventConstant.UPDATE_PLAYER_BASE_POWER, mUpdatePlayerPower);
    CSharpInterface.AddEventListenerInt(EventConstant.UPDATE_PLAYER_BASE_LEVEL, mUpdatePlayerBaseLevel);
end

function ActivityModel:CheckFunctionIsValid(function_type)
	if function_type == FunctionType.LandReward then
		return mLandRewardModel:IsLandRewardValid();
	elseif function_type == FunctionType.GrowFund then
		return mGrowFundModel:GetLastGrowFundLv() ~= 0;
	elseif function_type == FunctionType.ActivityOpenServer then
		return mActivityOpenServerModel:GetActiveOpenServerLastTime() > 0;
	else
		return true;
	end
end

function ActivityModel:CheckNotify( )
	self:CheckFirstRechargeNotify();
	mGrowFundModel:CheckGrowFundNotify();
	mLandRewardModel:CheckLandRewardNotify();
    mActivityOpenServerModel:CheckActivityOpenServerValid();
    mActivityOpenServerModel:CheckActivityOpenServerNotitfy();
    NotifyManager:OnShowNotify(NotifyDef.NEW_ACTIVITY_NOTIFY, self:CheckActivityNotify());
end

function ActivityModel:OnArenaInfoInit()
	mActivityOpenServerModel:CheckActivityOpenServerNotitfy();
end      

function ActivityModel:OnUpdatePlayerLevel(level)
	mGrowFundModel:CheckGrowFundNotify();

	NotifyManager:OnShowNotify(NotifyDef.NEW_ACTIVITY_NOTIFY, self:CheckActivityNotify());
end  

function ActivityModel:OnUpdatePlayerPower(power)
	mActivityOpenServerModel:CheckActivityOpenServerNotitfy();

	NotifyManager:OnShowNotify(NotifyDef.NEW_ACTIVITY_NOTIFY, self:CheckActivityNotify());
end 

function ActivityModel:OnUpdatePhase(phase)
	self.mPhase = phase;
	NotifyManager:OnShowNotify(NotifyDef.NEW_ACTIVITY_NOTIFY, self:CheckActivityNotify());
end 

function ActivityModel:OnRecvExchangeActivationCode(  )
	local callBack = self.mRecvExchangeActivationCode;
	if callBack ~= nil then
        callBack();
    end
end

function ActivityModel:GetPhase()
	return self.mPhase;
end      

function ActivityModel:SetLoginInfo(info)
	self.mPhase = nil;
	self.mActivityLoginInfo = info;
end

function ActivityModel:GetActivityLoginInfo()
	return self.mActivityLoginInfo;
end

function ActivityModel:SetPhaseInfo(phase)
	local mPhase = self.mPhase;
	if mPhase ~= nil then
		local get_phase_back = self.mGetPhaseInfoBack;
		if get_phase_back ~= nil then
			get_phase_back();
		end
	end
	self.mPhase = phase;
end

function ActivityModel:GetRoleModel()
    return CSharpInterface.GetRoleModel();
end

function ActivityModel:CheckLevelNotify()
	local login_info = self.mActivityLoginInfo;
	if login_info == nil then
		return false;
	end
	local level = self:GetRoleModel():GetPlayerLV();
	for k, v in pairs(mConfigSysactive_lv) do
		local lv = v.lv;
		if level >= lv and not ArrayUtil:ContainsValue(lv, login_info.lv_list) then
			return true;
		end
	end
	return false;
end

function ActivityModel:CheckPowerNotify()
	local login_info = self.mActivityLoginInfo;
	if login_info == nil then
		return false;
	end
	local power = self:GetRoleModel().mPlayerBase.all_combat;
	for k, v in pairs(mConfigSysactive_combat) do
		local combat = v.combat;
		if power >= combat and not ArrayUtil:ContainsValue(k, login_info.combat_list) then
			return true;
		end
	end
	return false;
end

function ActivityModel:CheckPhaseNotify()
	local login_info = self.mActivityLoginInfo;
	if login_info == nil then
		return false;
	end
	local mPhase = self.mPhase;
	for k, v in pairs(mConfigSysactive_phase) do
		local phase = v.phase;
		if mPhase >= phase and not ArrayUtil:ContainsValue(phase, login_info.phase_list) then
			return true;
		end
	end
	return false;
end

function ActivityModel:CheckActivityNotify()
	local notify = self:CheckLevelNotify()
				or self:CheckPowerNotify()
				or self:CheckPhaseNotify();
	return notify;
end

function ActivityModel:GetGetState(mType, id)
	local loginInfo = self.mActivityLoginInfo;
	if loginInfo == nil then
		return false;
	end

	if mType == ActivityType.Level then
		return ArrayUtil:ContainsValue(id, loginInfo.lv_list);
	elseif mType == ActivityType.Power then
		return ArrayUtil:ContainsValue(id, loginInfo.combat_list);
	elseif mType == ActivityType.Stage then
		return ArrayUtil:ContainsValue(id, loginInfo.phase_list);
	else
		return false;
	end
end

function ActivityModel:RecvActiveOperateBack(mType, mOperateParam)
	local activityLoginInfo = self.mActivityLoginInfo;
	if mType == ActivityType.Level then
		mTable.insert(activityLoginInfo.lv_list, mOperateParam);
	elseif mType == ActivityType.Power then
		mTable.insert(activityLoginInfo.combat_list, mOperateParam);
	elseif mType == ActivityType.Stage then
		mTable.insert(activityLoginInfo.phase_list, mOperateParam);
	end

	local get_operate_back = self.mGetActiveOperateBack;
	if get_operate_back ~= nil then
		get_operate_back(mType, mOperateParam);
	end
end

function ActivityModel:CheckFirstRechargeNotify()
	if self.mOpenFirstCharge then
		local state = self:GetRoleModel().mPlayerBase.first_charge == 1;
		NotifyManager:OnShowNotify(NotifyDef.NEW_FIRST_RECHARGE_REWARD, state);
	end
end 

local instance = ActivityModel.LuaNew();
return instance;