local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mEventEnum = require "Enum/EventEnum"
local mLanguage = require "Utils/LanguageUtil"
local mTable = require 'table'
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mGameModelManager = require "Manager/GameModelManager"
local mLayoutController = require "Core/Layout/LayoutController"
local FollowerController = require "Module/Follower/FollowerController"
local mCommonToggleGroup = require "Module/CommonUI/TabView/CommonToggleGroup"
local FollowerListArrayView = mLuaClass("FollowerListArrayView", mQueueWindow);

function FollowerListArrayView:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_list_array_view",
		["ParentLayer"] = mMainLayer2,
		["viewBgEnum"] = mViewBgEnum.transparent,
	};
end

function FollowerListArrayView:Init()
	local parent = self:Find('scrollView/Grid');
	local gridEx = mLayoutController.LuaNew(parent, require "Module/BattleArray/BattleFollowerItemView");
	gridEx:SetSelectedViewTop( true );
	self.mGridEx = gridEx;

	local trans = self:Find("sortView");
	self.mSortView = trans.gameObject;
    self.mToggleGroup = mCommonToggleGroup.LuaNew(trans,function(index)self:OnClickToggle(index);end);
    self.mToggleGroup:SetCanAlwaysReturn( );

    self.mButtonText = self:FindComponent( 'Button_sort/Text', 'Text' )
    self.mSelectText = self:FindComponent('SelectText','Text');

    self:FindAndAddClickListener("Button_sort", function() self:OnClickSortBtn() end);
    self:FindAndAddClickListener("BG/Button_close",function() self:ReturnPrevQueueWindow(); self:DoCallBack();end);
    self:RegisterEventListener(mEventEnum.ON_REFRESH_FOLLOWER_SELECT, function(followerData) self:SelectFollowerBack(followerData) end, true);
end

function FollowerListArrayView:DoCallBack()
	local callBack = self.mCallBack;
	if callBack ~= nil then
		callBack(true);
	end
end

function FollowerListArrayView:SelectFollowerBack(followerData)
	local followerVO = followerData.follower;
	local selected = followerData.state;

	self:OnSelectBattleFollower(followerVO.mUID,selected);
	self:UpdateSelectText();
end

function FollowerListArrayView:UpdateButtonText()
	local sortType = mGameModelManager.FollowerModel:GetFollowerSortType( );
	self.mButtonText.text = mLanguage[ 'follower_sort_button_text'..sortType];
end

function FollowerListArrayView:UpdateSelectText()
	local selected = table.getn(self.mSelectFollower);
	self.mSelectText.text = string.format(mLanguage.follower_Select_Text,selected,self.mTeamMaxNumber);
end

function FollowerListArrayView:OnViewShow(data)
	--self:PlaySoundName("ty_0204");
	self.mUID = 0;
	self.mData = data.data_souce;
	self.mSelectFollower = data.follower_list;
    self.mTeamMaxNumber = data.TeamMaxNumber;
    self.mCallBack = data.callBack;

	self:UpdateButtonText( );
	self:UpdateFollowerList();
	self:ShowSelectList();
	self:UpdateSelectText();
end

function FollowerListArrayView:OnViewHide()
	
end

function FollowerListArrayView:OnViewHide(  )
	print(mTable.getn(self.mData));
	for index, view in pairs(self.mGridEx.mViews) do
		view:ShowSelectedFlag(false);
	end
end

function FollowerListArrayView:UpdateFollowerList()
	local data = self.mData;
	data:SetDatasDirty();
	
	self.mGridEx:UpdateDataSource(data, function() 	self:ShowFollowerSelect(self.mUID);	end);
end

function FollowerListArrayView:OnClickFollowerItem(data)
	self:ShowFollowerSelect(data.mUID);
end

function FollowerListArrayView:ShowFollowerSelect(id)
	local gridEx = self.mGridEx;
	if gridEx ~= nil then
		gridEx:SetViewSelectedByKey(id,true);
	end
	self.mUID = id;
end

function FollowerListArrayView:ShowSelectList()
	local follower_list = self.mSelectFollower;
	for k, v in pairs(follower_list) do
		local child = self.mGridEx:GetChild(v.mUID);
		if child ~= nil  then
			child:ShowSelectedFlag(true);
		end
	end
end

function FollowerListArrayView:OnSelectBattleFollower( id, selected )
	local child = self.mGridEx:GetChild(id);
	if child ~= nil  then
		child:ShowSelectedFlag(selected);
	end
end

function FollowerListArrayView:OnClickSortBtn()
	self.mSortView:SetActive(true);
end

function FollowerListArrayView:OnClickToggle(index)
	self.mSortView:SetActive( false );
	mGameModelManager.FollowerModel:ChangeSort( index );
	self:UpdateButtonText( );
end

function FollowerListArrayView:Dispose()	
	self.mGridEx:Dispose();
	self.mGridEx = nil;
end

return FollowerListArrayView;