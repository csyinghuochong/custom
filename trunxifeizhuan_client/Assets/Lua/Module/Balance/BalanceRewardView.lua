local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mSortTable = require "Common/SortTable"
local mUpdateManager = require "Manager/UpdateManager"
local mLayoutController = require "Core/Layout/LayoutController"
local mCommonAllAwardVO = require "Module/CommonUI/CommonAllAwardVO"
local BalanceRewardView = mLuaClass("BalanceRewardView", mBaseWindow);
local ROUND = 360;
local SCALE = 1.5;

function BalanceRewardView:InitViewParam()
	return {
		["viewPath"] = "ui/balance/",
		["viewName"] = "balance_reward_view",
		["ParentLayer"] = mBattlePop,
	};
end

function BalanceRewardView:Init()
	self.mLight = self:Find("Light");
	local parent = self:Find("scrollView/Grid");
	self.mGrid = mLayoutController.LuaNew(parent,require "Module/CommonUI/CommonGetAwardItemView");
end

function BalanceRewardView:OnViewShow(data)
	self.mEuler = ROUND;
	local talents = data.mTalents;
	local items = data.mItems[2];
	local data_soure = mSortTable.LuaNew(nil,nil,true);
	if items ~= nil then
		for k,v in ipairs(items) do
			local itemVO = mCommonAllAwardVO.LuaNew(v.mGoodsId,v.mNumber,false);
			data_soure:AddOrUpdate(v.mGoodsId,itemVO);
		end
	end
	if talents ~= nil then
		for k,v in ipairs(talents) do
			local talentVO = mCommonAllAwardVO.LuaNew(v.id,1,true,v)
			data_soure:AddOrUpdate(v.id,talentVO);
		end
	end
	self.mGrid:UpdateDataSource(data_soure);
	mUpdateManager:AddUpdate(self);
end

function BalanceRewardView:OnUpdate()
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

function BalanceRewardView:GetFormations()

	local mGoodsFormations = {{},{},{},{},{},{}};
	mGoodsFormations[1] = {{x = 0,y = -50,z = 0};}
	mGoodsFormations[2] = {{x = -100,y = -50,z = 0};{x = 100,y = -50,z = 0};}
	mGoodsFormations[3] = {{x = -100,y = -50,z = 0};{x = 0,y = -50,z = 0};{x = 100,y = -50,z = 0};}
	mGoodsFormations[4] = {{x = 0,y = 0,z = 0};{x = 0,y = 0,z = 0};{x = 0,y = 0,z = 0};{x = 0,y = 0,z = 0};}
	mGoodsFormations[5] = {{x = 0,y = 0,z = 0};{x = 0,y = 0,z = 0};{x = 0,y = 0,z = 0};{x = 0,y = 0,z = 0};{x = 0,y = 0,z = 0};}

	return mGoodsFormations;
end

function BalanceRewardView:OnViewHide()
	mUpdateManager:RemoveUpdate(self);
end

function BalanceRewardView:Dispose( )
	self.mGrid:Dispose();
	self.mGrid= nil;
end

return BalanceRewardView;