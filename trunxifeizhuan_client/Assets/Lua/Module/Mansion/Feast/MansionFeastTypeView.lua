local mViewEnum = require "Enum/ViewEnum";
local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mQueueWindow = require "Core/QueueWindow"
local mUIManager = require "Manager/UIManager"
local mGameModelManager = require "Manager/GameModelManager"
local MansionController = require "Module/Mansion/MansionController"
local ConfigSysmansion_feast = require "ConfigFiles/ConfigSysmansion_feast"
local MansionFeastTypeVo = require "Module/Mansion/Feast/MansionFeastTypeVo"
local MansionFeastTypeItem = require "Module/Mansion/Feast/MansionFeastTypeItem"
local MansionFeastTypeView = mLuaClass("MansionFeastTypeView", mQueueWindow);
local mPairs = pairs;

function MansionFeastTypeView:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_feast_type_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
	};
end

function MansionFeastTypeView:Init()
	self:InitSubView( );
	self:AddEventListeners( );
end

local mFeastTypeNumber = 3;
function MansionFeastTypeView:InitSubView(  )
	local feastListView = { };
	for i = 1, mFeastTypeNumber do
		feastListView[ i ] = MansionFeastTypeItem.LuaNew( self:Find( 'item'..i ).gameObject );
		feastListView[ i ]:InitFeastVO( MansionFeastTypeVo.LuaNew(  i, ConfigSysmansion_feast[ i ] ) );
	end
	self.mFeastListView = feastListView;

	self:FindAndAddClickListener("button_feast",function() self:OnClickJoinFeast(); end);
	self:FindAndAddClickListener("Button_close",function() self:ReturnPrevQueueWindow(); end);
end

function MansionFeastTypeView:OnClickJoinFeast(  )
	mUIManager:HandleUI(mViewEnum.MansionFeastListView, 1);
end

function MansionFeastTypeView:AddEventListeners(  )
	local mEvent = self.mEventEnum;
	
	self:RegisterEventListener(mEvent.ON_RECV_MANSION_FEAST_INFO,function(data)self:OnRecvFeastInfo(data)end,true);
end

function MansionFeastTypeView:OnViewShow(  )
	self.mData = mGameModelManager.MansionModel.mData;
	MansionController:SendGetFeastInfo( );
end

function MansionFeastTypeView:OnRecvFeastInfo( pv_vo )
	local data = self.mData;
	for k, v in mPairs( self.mFeastListView ) do
		v:ShowView( );
		v:OnUpdateUI( data:GetMansionLevel( ),  pv_vo );
	end
end

function MansionFeastTypeView:OnViewHide( )
	for k, v in mPairs( self.mFeastListView ) do
		v:HideView( );
	end
end

function MansionFeastTypeView:Dispose()
	for k, v in mPairs( self.mFeastListView ) do
		v:CloseView( );
	end
end

return MansionFeastTypeView;