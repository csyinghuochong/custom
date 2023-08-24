local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mLayoutController = require "Core/Layout/LayoutController"
local mFriendVO = require "Module/Friend/FriendVO"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local mEventDispatcher = require "Events/EventDispatcher"
local mTable = require "table"
local mAlertView = require "Module/CommonUI/AlertView"
local mGameModelManager = require "Manager/GameModelManager"
local mFriendController = require "Module/Friend/FriendController"
local mGameTimer = require "Core/Timer/GameTimer"
local FriendInfoView = mLuaClass("FriendInfoView",mCommonTabBaseView);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgOK = mLanguageUtil.friend_info_delete_ok;

local mLgDeleteTitle = mLanguageUtil.friend_info_delete_title;
local mLgDeleteDesc1 = mLanguageUtil.friend_info_delete_desc1;
local mLgDeleteDesc2 = mLanguageUtil.friend_info_delete_desc2;

function FriendInfoView:InitViewParam()
	return {
		["viewPath"] = "ui/friend/",
		["viewName"] = "friend_info_view",
	};
end

function FriendInfoView:Init()
	local parent = self:Find("scrollView/Grid");
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Friend/FriendItem");
	self.mGridEx:SetSelectedViewTop(true);
	self.mIsDelete = false;
	self:FindAndAddClickListener("buttonDelete",function() self:OnClickDeleteBtn(); end);
	self.mTextNum = self:FindComponent("num","Text");
	self.mGoLight = self:Find("scrollView/Grid/light").gameObject;
	local mEvent = self.mEventEnum;
	self:RegisterEventListener(mEvent.ON_RECIVE_FRIEND_LIST,function(data)self:OnUpdateUI(data);end,true);
	self:RegisterEventListener(mEvent.ON_RECIVE_DELETE_FRIEND,function(result)self:ReciveDeleteFriend(result);end,true);
	self:RegisterEventListener(mEvent.ON_GET_ENERGY,function(enegyData)self:GetEnergy(enegyData);end,true);
	self:RegisterEventListener(mEvent.ON_GIVE_ENERGY,function(enegyData)self:GiveEnergy(enegyData);end,true);
	self:RegisterEventListener(mEvent.ON_OPEN_FRIEND_DELETE_POPUP,function(deleteData)self:OpenDeleteFriendPopup(deleteData);end,true);
	self:RegisterEventListener(mEvent.ON_CALL_CHANGE_FRIENDLIST_STATE,function(state)self:ResetFriendState(state);end,true);
	self:RegisterEventListener(mEvent.ON_SELECT_FRIEND,function(data)self:OnSelectFriend(data);end,true);
end

function FriendInfoView:OnSelectFriend(data)
	local model = mGameModelManager.FriendModel;
	model.mDataTable[1] = data;
end

function FriendInfoView:ReciveDeleteFriend(result)
	self:ResetFriendNum();
	self:CheckFriendNum(true);
end

function FriendInfoView:ResetFriendState(state)
	if self.mIsDelete == state then
		return;
	end
	self.mIsDelete = state;
	local mEvent = self.mEventEnum;
	self:Dispatch(mEvent.ON_CHANGE_FRIENDLIST_STATE,self.mIsDelete);
end

function FriendInfoView:OnClickDeleteBtn()
	self:ResetFriendState(not self.mIsDelete);
end

function FriendInfoView:GetEnergy(enegyData)
	local model = mGameModelManager.FriendModel;
	model.mFriendData = enegyData;
	mFriendController:SendGetFriendEnergy(enegyData.id);
end

function FriendInfoView:GiveEnergy(enegyData)
	local model = mGameModelManager.FriendModel;
	model.mFriendData = enegyData;
	mFriendController:SendFriendEnergy(enegyData.id);
end

function FriendInfoView:OpenDeleteFriendPopup(deleteData)
	local model = mGameModelManager.FriendModel;
	model.mFriendData = deleteData;
	mAlertView.Show({title=mLgDeleteTitle,desc1=mLgDeleteDesc1,desc2=deleteData.name,btnName=mLgOK,showMidLine = true,CallBack=function(data)self:DeleteFriend(deleteData);end});
end

function FriendInfoView:DeleteFriend(deleteData)
	mFriendController:SendDeleteFriend(deleteData.id);
end

function FriendInfoView:OnUpdateUI(data)
	self.mGridEx:ToggleAllView(true);
	local model = mGameModelManager.FriendModel;
	if model.mIsEverGetInfo then
		self.mGridEx:UpdateDataSource(model.mDataSoureInfo);
		self:CheckFriendNum(false);
		self:ResetFriendNum();
		if not self.mIsEverOpen then
			mGameTimer.SetTimeout(0.2,function()self:SetSelectTopItem();end);
			self.mIsEverOpen = true;
		end
	else
		self.mGameObject:SetActive(false);
		model.mIsEverGetInfo = true;
		mFriendController:SendGetFriendList();
	end
end

function FriendInfoView:SetSelectTopItem()
	local friendTable = mGameModelManager.FriendModel.mDataSoureInfo.mSortTable;
	local data = friendTable[1];
	if data ~= nil then
		local model = mGameModelManager.FriendModel
		model.mDataTable[1] = data;
		self.mGridEx:SetViewSelectedByKey(data.id,true);
	end
end

function FriendInfoView:CheckFriendNum(isDelete)
	local model = mGameModelManager.FriendModel;
	local friendTable = model.mDataSoureInfo.mSortTable;
	local num = mTable.getn(friendTable);
	local data = {};
	if num > 0 then
		self.mGameObject:SetActive(true);
		data = {state = true};
		self:Dispatch(self.mEventEnum.ON_SET_FRIEND_EMPTY,data);
		local data = model.mFriendData;
		local selectData = model.mDataTable[1];
		if isDelete and selectData ~= nil and data ~= nil and data.id == selectData.id then
			model.mDataTable[1] = nil;
			self.mGoLight:SetActive(false);
			self:Dispatch(self.mEventEnum.ON_SET_PLAYER_MODEL_STATE,false);
		end
	else
		self.mGoLight:SetActive(false);
		model.mDataTable[1] = nil;
		self.mGameObject:SetActive(false);
		data = {state = false,strIndex = 1};
		self:Dispatch(self.mEventEnum.ON_SET_FRIEND_EMPTY,data);
	end
end

function FriendInfoView:OnViewHide()
	self:ResetFriendState(false);
	self.mGridEx:ToggleAllView(false);
end

function FriendInfoView:ResetFriendNum()
	local friendTable = mGameModelManager.FriendModel.mDataSoureInfo.mSortTable;
	local num = mTable.getn(friendTable);
	self.mTextNum.text = num.."/25";
end

function FriendInfoView:Dispose( )
	self.mGridEx:Dispose();
end

return FriendInfoView;