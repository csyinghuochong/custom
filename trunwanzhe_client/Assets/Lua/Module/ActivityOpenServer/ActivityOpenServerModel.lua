local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mGameTimer = require "Core/Timer/GameTimer"
local NotifyDef = require "Module/CommonUI/NotifyDef"
local NotifyManager = require "Module/CommonUI/NotifyManager"
local CSharpInterface = Com.Game.Manager.CSharpToLuaInterface;
local EventConst = Assets.Scripts.Com.Game.Events.EventConstant;
local ServerDateTime = Assets.Scripts.Com.Game.Utils.ServerDateTime;
local LevelStatus= Assets.Scripts.Com.Game.Module.Dungeon.LevelStatus;
local mConfigSysactive_welfare = require 'ConfigFiles/ConfigSysactive_welfare'
local mConfigSysactive_charge = require 'ConfigFiles/ConfigSysactive_charge'
local mActivityOpenServerType = require "Module/ActivityOpenServer/ActivityOpenServerType"
local ActivityOpenServerModel = mLuaClass("ActivityOpenServerModel",mBaseModel);
local mTable = require 'table'

function ActivityOpenServerModel:OnLuaNew()
	
end

function ActivityOpenServerModel:OnRecvGetActiveOpenServerInfo(value)
	self.mActiveOpenInfo = value;

    self:CheckActivityOpenServerValid();
    self:CheckActivityOpenServerNotitfy();
    CSharpInterface.Dispatch(EventConst.ACTIVITY_CHECK_FUNCTION_OPEN);
end

function ActivityOpenServerModel:OnRecvGetActiveOpenServerReward(id)
	local activity_info = self.mActiveOpenInfo;
	if id == 1 then
        activity_info.dungeon_flag = 1;
    elseif id == 2 then
        activity_info.combat_flag = 1;
    elseif id == 3 then
        activity_info.arena_flag = 1;
    end

    local get_reward_back = self.mRecvGetActiveOpenServerReward;
    if get_reward_back ~= nil then
        get_reward_back();
    end

    self:CheckActivityOpenServerNotitfy();
end

function ActivityOpenServerModel:OnRecvActiveChargeList(value)
    self.mActiveChargeList = value;
    self:CheckActivityOpenServerNotitfy();
end
function ActivityOpenServerModel:OnGetActiveChargeReward(index, id)
    local activity_info = self.mActiveChargeList;
    if index == mActivityOpenServerType.TODAY_RECHARGE then
        mTable.insert(activity_info.list_today, id);
    else
        mTable.insert(activity_info.list7day, id);
    end
    self:CheckActivityOpenServerNotitfy();
    local get_reward_back = self.mGetActiveChargeRewardBack;
    if get_reward_back ~= nil then
        get_reward_back(index, id);
    end
end

function ActivityOpenServerModel:CheckActivityOpenServerValid()
    local time = self:GetActiveOpenServerLastTime();
    local activeOpenGameTimer = self.mActiveOpenGameTimer;

    if time > 0 then
        if activeOpenGameTimer ~= nil then
            activeOpenGameTimer:Dispose();
        end

        activeOpenGameTimer = mGameTimer.SetTimeout(time, function ( )
            CSharpInterface.Dispatch(EventConst.ACTIVITY_CHECK_FUNCTION_OPEN);
        end, true);
        self.mActiveOpenGameTimer = activeOpenGameTimer;
    end
end

function ActivityOpenServerModel:GetActiveOpenServerLastTime()
    local activeOpen = self.mActiveOpenInfo;
    if activeOpen == nil then
        return 0;
    end
               
    local time = activeOpen.end_time - ServerDateTime.GetServerTime();
    time = time > 0 and time or 0;
    return time;
end

--开服活动红点
function ActivityOpenServerModel:CheckActivityOpenServerNotitfy()
    local state = self:CheckActivityOpenServerDungeonNotitfy()
            or self:CheckActivityOpenServerCombatNotitfy()
            or self:CheckActivityOpenServerArenaNotitfy()
            or self:CheckActivityTodayRechargeNotify()
            or self:CheckActivityAllRechargeNotify();

    NotifyManager:OnShowNotify(NotifyDef.NEW_ACTIVITY_OPEN_SERVER_REWARD, state);
    return state;
end

function ActivityOpenServerModel:GetRoleModel()
    return CSharpInterface.GetRoleModel();
end

function ActivityOpenServerModel:GetArenaModel()
    return CSharpInterface.GetArenaModel();
end

function ActivityOpenServerModel:GetDungeonDataManager()
    return CSharpInterface.GetDungeonDataManager();
end

--闯关榜红点
function ActivityOpenServerModel:CheckActivityOpenServerDungeonNotitfy()
    local activeOpen = self.mActiveOpenInfo;
    if activeOpen == nil then
        return false;
    end

    local id = mConfigSysactive_welfare[1].finish_limit;
    return self:GetDungeonDataManager():GetLevelVO(id).mStatus == LevelStatus.HasPass and activeOpen.dungeon_flag == 0;
end

function ActivityOpenServerModel:CheckActivityOpenServerCombatNotitfy()
    local activeOpen = self.mActiveOpenInfo;
    if activeOpen == nil then
        return false;
    end

    local id = mConfigSysactive_welfare[2].finish_limit;
    return self:GetRoleModel().mPlayerBase.all_combat >= id and activeOpen.combat_flag == 0;
end

function ActivityOpenServerModel:CheckActivityOpenServerArenaNotitfy()
    local activeOpen = self.mActiveOpenInfo;
    local arena_info = self:GetArenaModel().mArenaInfo;
    if arena_info == nil or activeOpen == nil then
        return false;
    end

    local id = mConfigSysactive_welfare[3].finish_limit;
    return arena_info.rank_id <= id and activeOpen.arena_flag == 0;
end

function ActivityOpenServerModel:CheckActivityTodayRechargeNotify()
    local recharge_list = self.mActiveChargeList;
    if recharge_list == nil then
        return false;
    end

    local reward_number = 0;
    local recharge_number = recharge_list.day1;

    for k, v in pairs(mConfigSysactive_charge) do
        if v.day1 ~= nil then
             reward_number = reward_number + ((v.charge <= recharge_number and mTable.getn(v.day1) > 0) and 1 or 0);
        end
    end

    return mTable.getn(recharge_list.list_today) < reward_number;
end

function ActivityOpenServerModel:CheckActivityAllRechargeNotify()
    local recharge_list = self.mActiveChargeList;
    if recharge_list == nil then
        return false;
    end

    local reward_number = 0;
    local recharge_number = recharge_list.day7;
    for k, v in pairs(mConfigSysactive_charge) do
        if v.day7 ~= nil then
            reward_number = reward_number + ((v.charge <= recharge_number and mTable.getn(v.day7) > 0) and 1 or 0);
        end
    end

    return mTable.getn(recharge_list.list7day) < reward_number;
end

function ActivityOpenServerModel:CheckActivityOpenServerNotitfyByType(index)
    if index == mActivityOpenServerType.DUNGRON_RANK then
        return self:CheckActivityOpenServerDungeonNotitfy();
    elseif index == mActivityOpenServerType.COMBAT_RANK then
        return self:CheckActivityOpenServerCombatNotitfy();
    elseif index == mActivityOpenServerType.ARENA_RANK then
        return self:CheckActivityOpenServerArenaNotitfy();
    elseif index == mActivityOpenServerType.TODAY_RECHARGE then
        return self:CheckActivityTodayRechargeNotify();
    elseif index == mActivityOpenServerType.All_RECHARGE then
        return self:CheckActivityAllRechargeNotify();
    else
        return false;
    end
end

function ActivityOpenServerModel:CheckActivityOpenServerRewardIsGet(index)
    local activeOpen = self.mActiveOpenInfo;
    if activeOpen == nil then
        return false;
    end

    if index == mActivityOpenServerType.DUNGRON_RANK then
        return activeOpen.dungeon_flag == 1;
    elseif index == mActivityOpenServerType.COMBAT_RANK then
        return activeOpen.combat_flag == 1;
    elseif index == mActivityOpenServerType.ARENA_RANK then
        return activeOpen.arena_flag == 1;
    else
        return false;
    end
end

return ActivityOpenServerModel;