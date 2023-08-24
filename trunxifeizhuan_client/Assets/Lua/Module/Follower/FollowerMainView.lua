local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum";
local mViewBgEnum = require "Enum/ViewBgEnum"
local mQueueWindow = require "Core/QueueWindow"
local mUIManager = require "Manager/UIManager"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mGameModelManager = require "Manager/GameModelManager"
local mModelShowView = require "Module/Story/ModelRenderTexture"
local mFollowerListView = require "Module/Follower/FollowerListView"
local mFollowerFeatureView = require "Module/Follower/FollowerFeatureView"
local mCommonTabView = require "Module/CommonUI/TabView/CommonTabView"
local FollowerMainView = mLuaClass("FollowerMainView", mQueueWindow);
local mString = require 'string'
local mVector3 = Vector3;

function FollowerMainView:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_main_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
		["PlayAnimation"] = true,
		["cost"] = {"gold","silver", 'experience'},
	};
end

local view_vo_list = {
		{luaClass="Module/Follower/FollowerInfoView"},
		{luaClass="Module/Follower/FollowerBreakInterface", childPath = 'breakView'},
		{luaClass="Module/Follower/FollowerOfficeInterface", childPath = 'officeView'},
		{luaClass="Module/Follower/FollowerSkillView"},
		{luaClass="Module/Follower/FollowerTalentView"},
	}

function FollowerMainView:StartPreloadAsset()
	for i,v in ipairs(view_vo_list) do
		self:PreLoadViewModule(v.luaClass);
	end
end

function FollowerMainView:Init()
	self:InitSubView();
	self:AddListener();
end

function FollowerMainView:AddListener( )
	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_SELECT_FOLLOWER, function(vo)
		self:OnClickFollowerItem(vo);
	end, true);

	self:RegisterEventListener(mEventEnum.ON_SELECT_TALENT_ITEM, function( vo )
		self:OnSelectTalentItem( vo );
	end, true);

	self:RegisterEventListener(mEventEnum.ON_SELECT_EQUIP_ITEM, function( vo )
		self:OnSelectEquipItem( vo );
	end, true);

	self:RegisterEventListener(mEventEnum.ON_FOLLOWER_MODEL_CHANE, function(vo)
		self:OnUpdateFollower(vo);
	end, true);

	self:RegisterEventListener(mEventEnum.ON_FOLLOWER_DELETE, function(id)
		self:OnDeleteFollower(id);
	end, true);
	
	self:RegisterEventListener(mEventEnum.ON_CLICK_STRENGTH_TALENT, function(talent_vo)
		self:OnClickStrenghtTalent(talent_vo);
	end, true);

	self:RegisterEventListener(mEventEnum.ON_FOLLOWER_OFFICE_UP, function(vo)
		self:OnOfficeUp(vo);
	end, true);

	self:RegisterEventListener(mEventEnum.ON_FOLLOWER_BREAK, function(vo)
		self:OnStarUp(vo);
	end, true);
end

function FollowerMainView:GetFollowerList( )
	return mGameModelManager.FollowerModel.mFolloweList1;
end

function FollowerMainView:InitSubView()
	self.mFollowerData = self:GetFollowerList().mSortTable[1];
	local getDataBack = function()
		return self.mFollowerData;
	end
	local clickButtonBack = function ( index )
		self:OnClickButtonItem(index);
	end
	self.mModelShowView = mModelShowView.LuaNew(self:Find('model/texture'),true);
	self.mFollowerFeatureView =  mFollowerFeatureView.LuaNew(self:Find('featureView').gameObject);
	self.mFollowerListView = mFollowerListView.LuaNew(self:Find('followerList/listView').gameObject, self:GetFollowerList(), nil);
	self:FindAndAddClickListener("c_bg/Button_close",function() self:ReturnPrevQueueWindow() end);

	self.mTabView = mCommonTabView.LuaNew(self:Find('tabView'), view_vo_list, clickButtonBack, getDataBack);
	self.mTabView:OnClickToggleButton( 1, true );
end

function FollowerMainView:CheckWaitWashTalent(  )
	local wash_talent = mGameModelManager.FollowerModel:GetWaitWashTalent();
	if wash_talent then
		mUIManager:HandleUI(mViewEnum.TalentWashPopView, 1, wash_talent);
	end
end

function FollowerMainView:OnViewShow(logicParams)
	if self.mExternalForceShow then
		self:ResetSubView(  );
		self:SetFollowerData(  );
	else
		self:CheckWaitWashTalent( );
	end

	self.mTabView:ShowView();
	self.mModelShowView:ShowView();
	self.mFollowerFeatureView:ShowView( );
	self.mFollowerListView:ShowView( self:GetFollowerList() );
	if logicParams ~= nil and logicParams.jumpParams ~= nil then
       self.mTabView:OnClickToggleButton(tonumber(logicParams.jumpParams), false);
	end
end

function FollowerMainView:SetFollowerData(  )
	local uid = self.mFollowerListView.mUID;
	local data = mGameModelManager.FollowerModel:GetFollowerByID( uid );
	self.mFollowerData = data;
	self:OnUpdateFollower( data );
end

function FollowerMainView:ResetSubView(  )
	local list_object = self.mFollowerListView.mGameObject;
	mGameObjectUtil:SetParent( list_object.transform, self.mTransform );
	local talent_view = self.mTabView:GetViewByIndex( 5 );
	if talent_view then
		local talent_object = talent_view.mGameObject;
		mGameObjectUtil:SetParent( talent_object.transform, self:Find( 'tabView' ) );
	end
end

function FollowerMainView:OnViewHide()
	self.mTabView:HideView();
	self.mModelShowView:HideView();
	self.mFollowerListView:HideView();
	self.mFollowerFeatureView:HideView(); 
end

function FollowerMainView:Dispose()
	self.mTabView:CloseView();
	self.mModelShowView:Dispose();
	self.mFollowerListView:CloseView();
	self.mFollowerFeatureView:CloseView( );
end

function FollowerMainView:OnClickButtonItem(index)
	self.mFollowerFeatureView:OnClickButtonItem(index);
end

function FollowerMainView:OnUpdateFollower(data)
	self.mFollowerData = data;
	self.mFollowerFeatureView:OnUpdateUI(data);
	self.mModelShowView:OnUpdateVO(data );
end

function FollowerMainView:OnClickFollowerItem(data)
	self:OnUpdateFollower(data);
	self.mTabView:UpdateSubView(true);
	self.mFollowerListView:OnClickFollowerItem(data);
end

function FollowerMainView:OnSelectTalentItem( data )
	self.mTabView:GetCurrentView():OnFollowerSelectTalentItem( data );
end

--选中背包的才艺2
function FollowerMainView:OnSelectEquipItem( data )
	self.mTabView:GetCurrentView():OnFollowerSelectEquipItem( data );
end

function FollowerMainView:OnOfficeUp( data )
	self:OnUpdateFollower(data);
	self.mTabView:GetCurrentView():OnOfficeUp( data );
end

function FollowerMainView:OnStarUp( data )
	self.mFollowerData = data;
	self.mTabView:UpdateSubView(true);
	self.mFollowerFeatureView:OnUpdateUI(data);
end

function FollowerMainView:OnDeleteFollower( id )
	if id == self.mFollowerData.mUID then
		local data = self:GetFollowerList().mSortTable[1];
		self:OnClickFollowerItem(data);
	end
end

function FollowerMainView:OnClickStrenghtTalent( talent_vo )
	local list_view = self.mFollowerListView;
	local talent_view = self.mTabView:GetCurrentView( );
	mUIManager:HandleUI(mViewEnum.TalentView, 1, { followerVO = self.mFollowerData, talentVO = talent_vo, 
		listView = list_view, talentView = talent_view }); 
end

return FollowerMainView;