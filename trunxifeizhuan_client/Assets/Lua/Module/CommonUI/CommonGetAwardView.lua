local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mLayoutController = require "Core/Layout/LayoutController"
local mSortTable = require "Common/SortTable"
local CommonGetAwardView = mLuaClass("CommonGetAwardView", mBaseWindow);
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mUpdateManager = require "Manager/UpdateManager"
local mVector3 = Vector3;
local mGameTimer = require "Core/Timer/GameTimer"
local mSuper = nil;

local ROUND = 360;
local SCALE = 1.5;

function CommonGetAwardView.Show(table)
	mUIManager:HandleUI(mViewEnum.CommonGetAwardView, 1, table);
end

function CommonGetAwardView:InitViewParam()
	return {
		["viewPath"] = "ui/common/",
		["viewName"] = "common_get_award_view",
		["ParentLayer"] = mCommonPopLayer1,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
		["ForbitSound"] = true,
		["PlayAnimation"] = true,
	};
end

function CommonGetAwardView:Init()
	local parent = self:Find("scrollViewAward/Grid")
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/CommonUI/CommonGetAwardItemView");

	self.mLight = self:Find("Light");
end

function CommonGetAwardView:OnLateUpdate()
	local euler = self.mEuler;
	euler = euler - SCALE;
	if euler <= 0 then
		euler = ROUND;
	end
	local eulerAngles = self.mLight.localEulerAngles;
	eulerAngles.z = euler;
	self.mLight.localEulerAngles = eulerAngles;
	self.mEuler = euler;
end

function CommonGetAwardView:Sort(a,b)
	if a.mSortIndex == b.mSortIndex and a.mSortIndex == 2 then
		return a.mID < b.mID;
	end
	return a.mSortIndex > b.mSortIndex;
end

function CommonGetAwardView:OnViewShow(logicParams)
	local data_soure = mSortTable.LuaNew(function(a,b)return self:Sort(a,b) end,nil,true);
	for k,v in ipairs(logicParams.mSortTable) do
		data_soure:AddOrUpdate(k,v);
	end
	self.mGridEx:UpdateDataSource(data_soure);
	self.mEuler = ROUND;
	self:AddLateUpdate();
	self:SetScrollColumn(logicParams);

	mSuper = self:GetSuper(mBaseWindow.LuaClassName);
	mSuper.OnViewShow(self,logicParams);
end

function CommonGetAwardView:SetScrollColumn(logicParams)
	local count = #logicParams.mSortTable;
	local column = 6;
	if count > 6 and count < 12 then
		if count%2 == 0 then
			column = count/2;
		else
			column = count/2 + 1;
		end
	end
	local layoutGroup = self:FindComponent("scrollViewAward/Grid","GridLayoutGroup");
	layoutGroup.constraintCount = column;
end

function CommonGetAwardView:OnViewHide()
	self:RemoveLateUpdate();
	self.mGridEx:ClearAllViews();
end

function CommonGetAwardView:AddLateUpdate()
	mUpdateManager:AddLateUpdate(self);
end

function CommonGetAwardView:RemoveLateUpdate()
	mUpdateManager:RemoveLateUpdate(self);
end

function CommonGetAwardView:Dispose()
	self.mGridEx:Dispose();
	self:RemoveLateUpdate();
end

return CommonGetAwardView;