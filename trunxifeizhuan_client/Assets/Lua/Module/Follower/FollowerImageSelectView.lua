local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mSortTable = require "Common/SortTable"
local mLayoutController = require "Core/Layout/LayoutController"
local mFollowerImageVO = require "Module/Follower/FollowerImageVO"
local GameCenterOnChild = require "Module/CommonUI/GameCenterOnChild";
local mFollowerController = require "Module/Follower/FollowerController"
local mConfigSysfollower_office_up = require "ConfigFiles/ConfigSysfollower_office_up"
local FollowerImageSelectView = mLuaClass("FollowerImageSelectView", mBaseWindow);
local mString = require 'string'

function FollowerImageSelectView:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_image_select_view",
		["ParentLayer"] = mFollowerSelectLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function FollowerImageSelectView:Init()
	self.mScrollRect = self:Find('ScrollView').gameObject;
	local parent = self:Find('ScrollView/Grid');
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Follower/FollowerImageItem",true);

	self:FindAndAddClickListener("Button_close", function() self:HideView() end);
	self:FindAndAddClickListener("Button_right", function() self:OnClickNext() end);
	self:FindAndAddClickListener("Button_left", function() self:OnClickPrev() end);

	self.mCenterOnChild = GameCenterOnChild.LuaNew(self.mScrollRect);
end

function FollowerImageSelectView:OnViewShow(logicParams)
	if logicParams == nil then
		return;
	end
	self.mData = logicParams;
	local actor_id = logicParams:GetActorID();
	local cur_office = logicParams:GetOffice();
	local data_source = mSortTable.LuaNew(function(a, b) return a.mID < b.mID end, nil, true);
	
	local loop = true;
	local office_lv = 1;
	while loop do
		key = mString.format('%d_%d', actor_id, office_lv);
		office_vo = mConfigSysfollower_office_up[key];
		if office_vo ~= nil then
			data_source:AddOrUpdate(office_lv, mFollowerImageVO.LuaNew(office_vo, cur_office, function(id) self:OnClickImageItem(id) end));
		else
			loop = false;
		end
		office_lv = office_lv + 1;
	end

	self.mCenterOnChild:BeginLoad()
	self.mGridEx:UpdateDataSource(data_source, function( )
		self.mCenterOnChild:EndLoad();
	end);
	self.mGridEx:Reset();
end

function FollowerImageSelectView:OnViewHide(logicParams)
	self.mGridEx:ClearAllViews();
end

function FollowerImageSelectView:OnClickNext()
	self.mCenterOnChild:MoveToNextPage();
end

function FollowerImageSelectView:OnClickPrev()
	self.mCenterOnChild:MoveToPrevPage();
end

function FollowerImageSelectView:OnClickImageItem(id)
	mFollowerController:SendFollowerModelChange(self.mData.mUID, id);
	self:HideView();
end

function FollowerImageSelectView:Dispose()
	self.mGridEx:Dispose();
end

return FollowerImageSelectView;