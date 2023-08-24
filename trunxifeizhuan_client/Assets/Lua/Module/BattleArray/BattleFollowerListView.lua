local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mSortTable = require "Common/SortTable"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mGameModelManager = require "Manager/GameModelManager"
local mLayoutController = require "Core/Layout/LayoutController"
local BattleFollowerListView = mLuaClass("BattleFollowerListView", mBaseView);
local mTable = require 'table'

function BattleFollowerListView:InitViewParam()
	return {
		["viewPath"] = "ui/battle_array/",
		["viewName"] = "battle_follower_list_view",
	};
end

function BattleFollowerListView:Init()
	self:SetParent(self.mGoParent);
	self.mSelectList = {};

	local parent = self:Find('scrollView/Guide_Array_Grid');
	local gridEx = mLayoutController.LuaNew(parent, require "Module/BattleArray/BattleFollowerItemView");
	self.mGridEx = gridEx;

	self:FindAndAddClickListener('Btn', function() self:OnClickTeam() end);
end

function BattleFollowerListView:OnClickTeam()
	local data = mGameModelManager.FollowerModel.mFolloweList1;
	mUIManager:HandleUI(mViewEnum.FollowerListArrayView,1,{data_souce = data,follower_list = self.mSelectFollower,TeamMaxNumber = self.mTeamMaxNumber,callBack = self.mCallBack});
	local callBack = self.mCallBack;
	if callBack ~= nil then
		callBack(false);
	end
end

function BattleFollowerListView:OnViewShow( selfHeros )
	self.mSelectFollower = selfHeros;

	self:UpdateFollowerList();
	self:ShowSelectList();
end

function BattleFollowerListView:UpdateFollowerList()
	local data = mGameModelManager.FollowerModel.mFolloweList1;
	data:SetDatasDirty();
	self.mGridEx:UpdateDataSource(data);
end

function BattleFollowerListView:ShowSelectList( )
	local follower_list = self.mSelectFollower;
	for k, v in pairs(follower_list) do
		local child = self.mGridEx:GetChild(v.mUID);
		if child ~= nil  then
			child:ShowSelectedFlag(true);
		end
	end
end

function BattleFollowerListView:OnViewHide(  )
	for index, view in pairs(self.mGridEx.mViews) do
		view:ShowSelectedFlag(false);
	end
end

function BattleFollowerListView:OnSelectBattleFollower( id, selected )
	local child = self.mGridEx:GetChild(id);
	if child ~= nil  then
		child:ShowSelectedFlag(selected);
	end
end

function BattleFollowerListView:IsSurplusFollower(num)
	local FollowerNum = num - 1;
	local count = self.mGridEx:GetChildCount();
	local teamMax = self.mTeamMaxNumber;
	if FollowerNum < teamMax and count > FollowerNum then	
		return true;	
	end
	return false;
end

function BattleFollowerListView:Dispose(  )

	self.mGridEx:Dispose();
	self.mGridEx = nil;
end

return BattleFollowerListView;