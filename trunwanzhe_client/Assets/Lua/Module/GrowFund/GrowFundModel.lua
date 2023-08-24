local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local NotifyDef = require "Module/CommonUI/NotifyDef"
local NotifyManager = require "Module/CommonUI/NotifyManager"
local mConfigSysactive_grow_fund = require "ConfigFiles/ConfigSysactive_grow_fund"
local CSharpInterface = Com.Game.Manager.CSharpToLuaInterface;
local EventConst = Assets.Scripts.Com.Game.Events.EventConstant;
local GrowFundModel = mLuaClass("GrowFundModel",mBaseModel);
local mTable = require 'table'

function GrowFundModel:OnLuaNew()
	
end

function GrowFundModel:OnRecvGetGrowFundInfo(value)
    self.mGrowFund = value;
    local recv_grow_back = self.mRecvGrowFundInfoBack;
    if recv_grow_back ~= nil then
        recv_grow_back();
    end

    self:CheckGrowFundNotify();
    CSharpInterface.Dispatch(EventConst.ACTIVITY_CHECK_FUNCTION_OPEN);
end

function GrowFundModel:GetRoleModel()
    return CSharpInterface.GetRoleModel();
end

function GrowFundModel:GetLastGrowFundLv()
    local mGrowFund = self.mGrowFund;
    if mGrowFund == nil or mGrowFund.buy_flag == 0 then
        return -1;
    end

    local lv_list = {};
    for k, v in pairs(mConfigSysactive_grow_fund) do
        mTable.insert(lv_list, k);
    end

    mTable.sort(lv_list, function(a, b) return a < b; end);
    local reward_count = mTable.getn(mGrowFund.lv_list);

    if reward_count < mTable.getn(lv_list) then
        local lv = lv_list[reward_count + 1];
        
        if  lv <= self:GetRoleModel():GetPlayerLV() then
            return lv;
        else
            return -1;
        end
    else
        return 0; 
    end
end

function GrowFundModel:CheckGrowFundNotify()
    local state = self:GetLastGrowFundLv() > 0;
    NotifyManager:OnShowNotify(NotifyDef.NEW_GROW_FUND_NOTICE, state);
    return state;
end

local mGrowFundModel = GrowFundModel.LuaNew();
return mGrowFundModel;