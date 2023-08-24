local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum";
local mUIManager = require "Manager/UIManager"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mQueueWindow = require "Core/QueueWindow"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonTabView = require "Module/CommonUI/TabView/CommonTabView"
local TalentView = mLuaClass("TalentView", mQueueWindow);
local mString = require 'string'
local mVector3 = Vector3;

function TalentView:InitViewParam()
	return {
		["viewPath"] = "ui/talent/",
		["viewName"] = "talent_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
		["cost"] = {"gold","silver", 'experience'},
	};
end

function TalentView:Init()
	self:InitSubView();
	self:AddListener();
end

function TalentView:AddListener( )
	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_SELECT_FOLLOWER, function(vo)
		self:OnClickFollowerItem(vo);
	end, true);

	self:RegisterEventListener(mEventEnum.ON_UP_TALENT_SUCCEED, function( vo )
     	self:OnStrengthTalent( vo );
    end, true);

	self:RegisterEventListener(mEventEnum.ON_SELECT_TALENT_ITEM, function( vo )
		self:OnSelectTalentItem( vo );
	end, true);

	self:RegisterEventListener(mEventEnum.ON_SELECT_EQUIP_ITEM, function( vo )
		self:OnSelectEquipItem( vo );
	end, true);

	self:RegisterEventListener(mEventEnum.ON_FOLLOWER_DELETE, function(id)
		self:OnDeleteFollower(id);
	end, true);

	self:RegisterEventListener(mEventEnum.ON_RECV_TALENT_UPDATE, function( )
		self:OnRecvTalentUpdate( );
	end, true);
end

function TalentView:GetFollowerList( )
	return mGameModelManager.FollowerModel.mFolloweList1;
end

function TalentView:InitSubView()
	local view_vo_list = {
		{luaClass="Module/Talent/TalentStrengthInterface", childPath = 'strengthView'},
		{luaClass="Module/Talent/TalentStudyView"},
		{luaClass="Module/Talent/TalentWashView"},
		{luaClass="Module/Talent/TalentSellView"},
	}

	local clickButtonBack = function ( index )
		self:OnClickButtonItem(index);
	end
	local getDataBack = function()
		return self.mTalentData;
	end

	self.mNoEquipTip = self:Find( 'Text_no' ).gameObject;
	self.mTabView = mCommonTabView.LuaNew(self:Find('tabView'), view_vo_list, clickButtonBack, getDataBack);
	self:FindAndAddClickListener("c_bg/Button_close",function() self:ReturnPrevQueueWindow() end);
end

function TalentView:OnViewShow(logicParams)
	if logicParams ~= nil then
		local talentVO = logicParams.talentVO;
		self.mTalentData = talentVO;
		self.mFollowerData = logicParams.followerVO;
		local listView = logicParams.listView;
		local list_object = listView.mGameObject;
		local equipView = logicParams.talentView;
		local talent_object = equipView.mGameObject
		self.mFollowerListView = listView;
		self.mFollowerTalentView = equipView;
		self.mFollowerTalentView:ResetTalentSubView( talentVO );
		listView:ShowView( );
		equipView:ShowView( );
		mGameObjectUtil:SetParent( list_object.transform, self:Find( 'followerList' ) );
		mGameObjectUtil:SetParent( talent_object.transform, self:Find( 'talentView' ) );
		self.mTabView:OnClickToggleButton( 1, false );
	end

	self.mTabView:ShowView();
	self:CheckSubViewValid();
end

function TalentView:OnViewHide()
	self.mTabView:HideView();
end

function TalentView:Dispose()
	self.mTabView:CloseView();
end

function TalentView:OnClickButtonItem(index)
	self:CheckSubViewValid( );

	local equipView = self.mFollowerTalentView;
	if index == 4 then
		equipView:HideView( );
	else
		equipView:ShowView( );
	end
end

function TalentView:OnSelectTalentItem( vo )
	self.mTalentData = vo;
	self.mFollowerTalentView:OnTalentSelectTalentItem( vo );
	if vo:GetGoodsType() == 1 then
		self:CheckSubViewValid( );
	else
		mUIManager:HandleUI(mViewEnum.TalentSellSingelView, 1, vo);
	end
end

function TalentView:OnSelectEquipItem( vo )
	self.mTalentData = vo;
	self.mTabView:UpdateSubView(true);
	self.mFollowerTalentView:OnTalentSelectEquipItem( vo );
end

function TalentView:CheckSubViewValid(  )
	local selectIndex = self.mTabView.mSelectIndex;
	local valid = self.mTalentData or selectIndex == 4;
	self.mTabView:UpdateSubView(valid);
	self.mNoEquipTip:SetActive(not valid);
end

function TalentView:OnClickFollowerItem(data)
	self.mFollowerData = data;
	local talentData = data:GetFirstValidTalent( );
	self.mTalentData = talentData;
	self.mFollowerTalentView:OnTalentClickFollowerItem( data, talentData );
	self.mFollowerListView:OnClickFollowerItem( data );
	self:CheckSubViewValid( );
end

function TalentView:OnRecvTalentUpdate(  )
	local talentData = self.mTalentData;
	if talentData and talentData:GetFollowerUID( ) == 0 then
		if mGameModelManager.FollowerModel.mTalentListByUID[ talentData.mID ] == nil then
			self.mTalentData = nil;
		end
	end
end

function TalentView:OnDeleteFollower( id )
	if id == self.mFollowerData.mUID then
		local data = self:GetFollowerList().mSortTable[1];
		self:OnClickFollowerItem(data);
	end
end

function TalentView:OnStrengthTalent (  data )
	self.mTalentData = data;
	if data:GetFollowerUID( ) ~= 0 then
		self.mFollowerTalentView:OnTalentStrengthEquip( data );
	end
end

return TalentView;