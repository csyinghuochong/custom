local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mArrayUtil = require 'Utils/ArrayUtil'
local mSortTable = require "Common/SortTable"
local mLayoutController = require "Core/Layout/LayoutController"
local mConfigSysactive_charge = require 'ConfigFiles/ConfigSysactive_charge'
local mActivityOpenServerType = require "Module/ActivityOpenServer/ActivityOpenServerType"
local mActivityOpenServerModel = require 'Module/ActivityOpenServer/ActivityOpenServerModel';
local mActivityOpenServerRechargeRewardVO = require "Module/ActivityOpenServer/ActivityOpenServerRechargeRewardVO"
local ActivityOpenServerRechargeRewardView = mLuaClass("ActivityOpenServerRechargeRewardView",mBaseView);
local UIManager = Com.Game.Manager.CSharpToLuaInterface.GetUIManager();
local mTable = require 'table'

function ActivityOpenServerRechargeRewardView:InitViewParam()
	return {
		["viewPath"] = "UI/Activity/ActivityOpenServerRechargeRewardView",
		["viewName"] = "ActivityOpenServerRechargeRewardView",
		["ParentLayer"] = UIManager.mNormalLayer1.transform,
	};
end

function ActivityOpenServerRechargeRewardView:Init()
	local parent = self:FindComponent('scrollview/grid', 'UIGrid');
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/ActivityOpenServer/ActivityOpenServerRechargeRewardItem");
end

function ActivityOpenServerRechargeRewardView:SetData(index)
	self.mIndex = index;
end

function ActivityOpenServerRechargeRewardView:OnViewShow()
	     
	self:OnRecvActiveChargeList();
end

function ActivityOpenServerRechargeRewardView:OnViewHide()
	 
end

function ActivityOpenServerRechargeRewardView:Dispose()
	 local grid_ex = self.mGridEx;
	 if grid_ex ~= nil then
	 	grid_ex:Dispose();
	 end
	 self.mGridEx = nil;
end

function ActivityOpenServerRechargeRewardView:GetRechargeNumber(index)
	if index== mActivityOpenServerType.TODAY_RECHARGE then
        return mActivityOpenServerModel.mActiveChargeList.day1;
    else
    	return mActivityOpenServerModel.mActiveChargeList.day7;
    end
end

function ActivityOpenServerRechargeRewardView:GetReceiveReward(index, id)
	if index== mActivityOpenServerType.TODAY_RECHARGE then
        return mArrayUtil:ContainsValue(id, mActivityOpenServerModel.mActiveChargeList.list_today);
    else
        return mArrayUtil:ContainsValue(id, mActivityOpenServerModel.mActiveChargeList.list7day);
    end
end

function ActivityOpenServerRechargeRewardView:OnGetActiveChargeReward(index, id)
	local mType = self.mIndex;
	if index ~= mType then
		return;
	end
	local data = self.mData.mRawTable[id];
	if data ~= nil then
		data.mReceiveReward = true;
		self.mData:AddOrUpdate(id, data);
	end
end

function ActivityOpenServerRechargeRewardView:OnRecvActiveChargeList()
	local data = self.mData;
	local mType = self.mIndex;
	data = mSortTable.LuaNew(function(a, b) return self:Sort(a, b) end, nil, true);

	for k, v in pairs(mConfigSysactive_charge) do
		if ( mType == mActivityOpenServerType.TODAY_RECHARGE and v.day1 ~= nil )
		or ( mType == mActivityOpenServerType.All_RECHARGE and v.day7 ~= nil ) then
			data:AddOrUpdate(v.charge, mActivityOpenServerRechargeRewardVO.LuaNew(mType, self:GetRechargeNumber(mType), 
				self:GetReceiveReward(mType, k), k));
		end
	end

	self.mData = data;
	self.mGridEx:UpdateDataSource(data);
end

function ActivityOpenServerRechargeRewardView:Sort(a, b)
    local r;
    local a_getreward = a.mCanGetReward;
    local b_getreward = b.mCanGetReward;
    local a_needrecharge = a.mNeedRecharge;
    local b_needrecharge = b.mNeedRecharge;
    local a_charge = a.mSysVO.charge;
    local b_charge = b.mSysVO.charge;

    if a_getreward == b_getreward then
    	if a_needrecharge == b_needrecharge then
    		r = a_charge < b_charge;
    	else
    		r = a_needrecharge;
    	end
    else
    	r = a_getreward;
    end

    return r;
end

return ActivityOpenServerRechargeRewardView;