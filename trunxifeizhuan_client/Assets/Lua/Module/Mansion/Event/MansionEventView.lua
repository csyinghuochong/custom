local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mSortTable = require "Common/SortTable"
local mQueueWindow = require "Core/QueueWindow"
local mGameModelManager = require "Manager/GameModelManager"
local mLayoutController = require "Core/Layout/LayoutController"
local MansionController = require "Module/Mansion/MansionController"
local mMansionEventVO = require "Module/Mansion/Event/MansionEventVO"
local mCommonToggleGroup = require "Module/CommonUI/TabView/CommonToggleGroup"
local MansionEventView = mLuaClass("MansionEventView", mQueueWindow);

function MansionEventView:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_event_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function MansionEventView:Init()
	local parent = self:Find("scrollView/Grid");
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Mansion/Event/MansionEventItem");
	self.mDataSource = mSortTable.LuaNew(function(a, b) return self:Sort(a,b) end, nil, true);

	local callBack = function( index )
		self:OnSwitchEventType(index);
	end
	self.mToggleGroup = mCommonToggleGroup.LuaNew(self:Find('toggle'),callBack,1);
	MansionController:RequstMansionEvents(1);

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_RECV_MANSION_EVENT_LIST,function(data) self:OnRecvEventList(data); end,true);
	self:RegisterEventListener(mEventEnum.ON_RECV_VISIT_MANSION_DATA,function(data) self:OnRecvMansionData(data); end,true);
	self:FindAndAddClickListener("c_bg/Button_close",function() self:ReturnPrevQueueWindow(); end);
end

function MansionEventView:Sort( a, b )
	return a.mID < b.mID;
end

function MansionEventView:OnViewShow(logicParams)
	
end

function MansionEventView:OnViewHide(logicParams)
	
end

function MansionEventView:OnSwitchEventType( index )
	MansionController:RequstMansionEvents( index );
end

function MansionEventView:OnRecvEventList( pbMansionEvents )
	local dataSource = self.mDataSource;
	dataSource:ClearDatas(true);

	for k, v in ipairs(pbMansionEvents.list) do
		dataSource:AddOrUpdate(k, mMansionEventVO.LuaNew(v));
	end

	self.mGridEx:UpdateDataSource(dataSource);
end

function MansionEventView:OnRecvMansionData( data )
	self:ReturnPrevQueueWindow();
end

function MansionEventView:Dispose()
	self.mGridEx:Dispose()
end

return MansionEventView;