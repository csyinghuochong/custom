local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mLayoutController = require "Core/Layout/LayoutController"
local mFriendVO = require "Module/Friend/FriendVO"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mAlertView = require "Module/CommonUI/AlertView"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local mFriendController = require "Module/Friend/FriendController"
local mTable = table
local mGameTimer = require "Core/Timer/GameTimer"
local FriendBlacklistView = mLuaClass("FriendBlacklistView",mCommonTabBaseView);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgOK = mLanguageUtil.friend_blacklist_delete_ok;

local mLgDeleteTitle = mLanguageUtil.friend_blacklist_delete_title;
local mLgDeleteDesc1 = mLanguageUtil.friend_blacklist_delete_desc1;
local mLgDeleteDesc2 = mLanguageUtil.friend_blacklist_delete_desc2;

function FriendBlacklistView:InitViewParam()
	return {
		["viewPath"] = "ui/friend/",
		["viewName"] = "friend_blacklist_view",
	};
end

function FriendBlacklistView:Init()
	local parent = self:Find('scrollView/Grid');
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Friend/FriendBlacklistItem");
	self.mGridEx:SetSelectedViewTop(true);
	self.mGoLight = self:Find("scrollView/Grid/light").gameObject;

	local mEvent = self.mEventEnum;
	self:RegisterEventListener(mEvent.ON_RECIVE_BLACKLIST,function(blackList)self:OnUpdateUI(blackList);end,true);
	self:RegisterEventListener(mEvent.ON_OPEN_BLACKLIST_DELETE_POPUP,function(detail)self:OnOpenBlacklistDeletePopup(detail);end,true);
	self:RegisterEventListener(mEvent.ON_SELECT_FRIEND_BLACKLIST,function(data)self:OnSelectItem(data);end,true);
	self:RegisterEventListener(mEvent.ON_RECIVE_DELETE_BLACKLIST,function(result)self:OnDeleteBlacklist(result);end,true);
end

function FriendBlacklistView:OnDeleteBlacklist(result)
	self:CheckFriendNum(true);
end

function FriendBlacklistView:OnSelectItem(data)
	local model = mGameModelManager.FriendModel;
	model.mDataTable[3] = data;
	self:Dispatch(self.mEventEnum.ON_SELECT_FRIEND,data);
end

function FriendBlacklistView:OnOpenBlacklistDeletePopup(detail)
	local model = mGameModelManager.FriendModel;
	model.mFriendData = detail;
	mAlertView.Show({title=mLgDeleteTitle,desc1=mLgDeleteDesc1,desc2=detail.name,btnName=mLgOK,showMidLine=true,CallBack=function(detailData)self:OnDeletePlayer(detail);end});
end

function FriendBlacklistView:OnDeletePlayer(detail)
	mFriendController:SendDeleteBlackList(detail.id)
end

function FriendBlacklistView:OnUpdateUI(data)
	self.mGridEx:ToggleAllView(true);
	local model = mGameModelManager.FriendModel;
	if model.mIsEverGetBlackList then
		self.mGridEx:UpdateDataSource(model.mDataSoureBlackList);
		self:CheckFriendNum(false);
		if not self.mIsEverOpen then
			mGameTimer.SetTimeout(0.2,function()self:SetSelectTopItem();end);
			self.mIsEverOpen = true;
		end
	else
		self.mGameObject:SetActive(false);
		model.mIsEverGetBlackList = true;
		mFriendController:SendGetBlackList();
	end
end

function FriendBlacklistView:CheckFriendNum(isDelete)
	local model = mGameModelManager.FriendModel;
	local friendTable = model.mDataSoureBlackList.mSortTable;
	local num = mTable.getn(friendTable);
	local data = {};
	if num > 0 then
		self.mGameObject:SetActive(true);
		data = {state = true};
		self:Dispatch(self.mEventEnum.ON_SET_FRIEND_EMPTY,data);
		local data = model.mFriendData;
		local selectData = model.mDataTable[3];
		if isDelete and selectData ~= nil and data ~= nil and data.id == selectData.id then
			model.mDataTable[3] = nil;
			self.mGoLight:SetActive(false);
			self:Dispatch(self.mEventEnum.ON_SET_PLAYER_MODEL_STATE,false);
		end
	else
		self.mGoLight:SetActive(false);
		model.mDataTable[3] = nil;
		self.mGameObject:SetActive(false);
		data = {state = false,strIndex = 2};
		self:Dispatch(self.mEventEnum.ON_SET_FRIEND_EMPTY,data);
	end
end

function FriendBlacklistView:SetSelectTopItem()
	local friendTable = mGameModelManager.FriendModel.mDataSoureBlackList.mSortTable;
	local data = friendTable[1];
	if data ~= nil then
		local model = mGameModelManager.FriendModel
		model.mDataTable[3] = data;
		self.mGridEx:SetViewSelectedByKey(data.id,true);
	end
end

function FriendBlacklistView:OnViewHide()
	self.mGridEx:ToggleAllView(false);
end

function FriendBlacklistView:Dispose( )
	self.mGridEx:Dispose();
end

return FriendBlacklistView;