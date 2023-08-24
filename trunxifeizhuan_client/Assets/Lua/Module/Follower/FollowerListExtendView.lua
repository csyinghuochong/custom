local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mLanguage = require "Utils/LanguageUtil"
local mLanguageUtil = require "Utils/LanguageUtil"
local mGameModelManager = require "Manager/GameModelManager"
local mAlertBaseView = require "Module/CommonUI/AlertBaseView"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mLayoutController = require "Core/Layout/LayoutController"
local FollowerController = require "Module/Follower/FollowerController"
local mCommonToggleGroup = require "Module/CommonUI/TabView/CommonToggleGroup"
local FollowerListExtendView = mLuaClass("FollowerListExtendView", mBaseWindow);

function FollowerListExtendView:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_list_extend_view",
		["ParentLayer"] = mMainLayer2,
		["viewBgEnum"] = mViewBgEnum.transparent_clickable,
	};
end

function FollowerListExtendView:Init()
	local parent = self:Find('scrollView/Grid');
	local gridEx = mLayoutController.LuaNew(parent, require "Module/Follower/FollowerItemView");
	gridEx:SetSelectedViewTop( true );
	self.mGridEx = gridEx;

	local trans = self:Find("sortView");
	self.mSortView = trans.gameObject;
    self.mToggleGroup = mCommonToggleGroup.LuaNew(trans,function(index)self:OnClickToggle(index);end);
    self.mToggleGroup:SetCanAlwaysReturn( );

    self.mButtonText = self:FindComponent( 'Button_sort/Text', 'Text' )
    self:FindAndAddClickListener("Button_sort", function() self:OnClickSortBtn() end);
    self:FindAndAddClickListener("Button_delete", function() self:OnClickDelete() end);
    self:FindAndAddClickListener("Button_team",function() self:HideView(); end);

	self:RegisterEventListener(self.mEventEnum.ON_SELECT_FOLLOWER, function(vo)
		self:OnClickFollowerItem(vo);
	end, true);

	self.mDeleteFollowerBack = function (  )
		self:OnSendDelete( );
	end
end

function FollowerListExtendView:ShowSortView( show )
	self.mShowSort = show;
	self.mSortView:SetActive( show );
end

function FollowerListExtendView:OnClickToggle( index )
	self.mSortView:SetActive( false );
	mGameModelManager.FollowerModel:ChangeSort( index );
	self:UpdateButtonText( );
end

function FollowerListExtendView:UpdateButtonText(  )
	local sortType = mGameModelManager.FollowerModel:GetFollowerSortType( );
	self.mButtonText.text = mLanguage[ 'follower_sort_button_text'..sortType ];
end

function FollowerListExtendView:OnClickSortBtn(  )
	self:ShowSortView(not self.mShowSort);
end

function FollowerListExtendView:OnClickDelete( )
	mAlertBaseView.Show({ desc1=mLanguageUtil.follower_delete_tip2,  CallBack = self.mDeleteFollowerBack, CancelCallBack = nil });
end

function FollowerListExtendView:OnSendDelete(  )
	local FollowerModel = mGameModelManager.FollowerModel;
	local uid = self.mUID;
	local vo = FollowerModel.mFolloweList2.mRawTable[uid];

	if vo.mLockFlag == 1 then
		mCommonTipsView.Show(mLanguage.follower_delete_tip3 );
	elseif vo:GetStar( ) >= 4 then
		mCommonTipsView.Show(mLanguage.follower_delete_tip4 );
	elseif FollowerModel:GetFollowerNumber() <= 3 then
		mCommonTipsView.Show(mLanguage.follower_delete_tip );
	else
		FollowerController:SendDeleteFollower( uid );
	end
end

function FollowerListExtendView:UpdateFollowerList()
	local data = self.mData;
	data:SetDatasDirty();
	
	self.mGridEx:UpdateDataSource(data, function() 
		self:ShowFollowerSelect(self.mUID);
	end);
end

function FollowerListExtendView:OnClickFollowerItem(data)
	self:ShowSortView( false );
	self:ShowFollowerSelect(data.mUID);
end

function FollowerListExtendView:ShowFollowerSelect(id)
	local gridEx = self.mGridEx;
	if gridEx ~= nil then
		gridEx:SetViewSelectedByKey(id,true);
	end
	self.mUID = id;
end

function FollowerListExtendView:OnViewShow(data)
	--self:PlaySoundName("ty_0204");
	self.mUID = data.id;
	self.mData = data.data_souce;
	self.mExtendViewHideHandle = data.callBack;

	self:ShowSortView( );
	self:UpdateButtonText( );
	self:UpdateFollowerList();
end

function FollowerListExtendView:OnViewHide()
	--self:PlaySoundName("ty_0204");
	self.mExtendViewHideHandle();
end

function FollowerListExtendView:Dispose( )
	self.mGridEx:Dispose();
end

return FollowerListExtendView;