local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mLayoutController = require "Core/Layout/LayoutController"
local FollowerListView = mLuaClass("FollowerListView", mBaseView);
local mSuper = nil;

function FollowerListView:OnLuaNew(go, dataSource)
	self.mData = dataSource;
	self.mUID = dataSource.mSortTable[1].mUID;

	mSuper = self:GetSuper(mBaseView.LuaClassName);
    mSuper.OnLuaNew(self,go);
end

function FollowerListView:Init()
	local parent = self:Find('scrollView/Grid');
	local gridEx = mLayoutController.LuaNew(parent, require "Module/Follower/FollowerItemView");
	self.mGridEx = gridEx;

	self:FindAndAddClickListener('Button_team', function() self:OnClickTeam() end);
	self.mExtendViewHideHandle = function ()
		self:UpdateFollowerList();
	end
end

function FollowerListView:OnViewShow( logicParams  )
	if logicParams then
		self.mData = logicParams;
		self.mUID = logicParams.mSortTable[1].mUID;
	end
	self:UpdateFollowerList();
end

function FollowerListView:OnClickTeam()
	mUIManager:HandleUI(mViewEnum.FollowerListExtendView,1, {id = self.mUID, data_souce = self.mData, callBack = self.mExtendViewHideHandle });
end

function FollowerListView:UpdateFollowerList()
	local data = self.mData;
	data:SetDatasDirty();
	
	self.mGridEx:UpdateDataSource(data, function() 
		self:ShowFollowerSelect(self.mUID);
	end);
end

function FollowerListView:OnClickFollowerItem(data)
	self:ShowFollowerSelect(data.mUID);
end

function FollowerListView:ShowFollowerSelect(id)
	local gridEx = self.mGridEx;
	if gridEx ~= nil then
		gridEx:SetViewSelectedByKey(id,true);
	end
	self.mUID = id;
end

function FollowerListView:OnViewHide(  )
	local gridEx = self.mGridEx;
	if gridEx ~= nil then
		gridEx:ForbidRefresh(true);
	end
end

function FollowerListView:Dispose( )
	self.mGridEx:Dispose();
	
end

return FollowerListView;