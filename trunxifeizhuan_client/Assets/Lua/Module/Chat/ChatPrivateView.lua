local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mLayoutController = require "Core/Layout/LayoutController"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local mGameModelManager = require "Manager/GameModelManager"
local mVector2 = Vector2
local mGameTimer = require "Core/Timer/GameTimer"
local mChatController = require "Module/Chat/ChatController"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mFriendController = require "Module/Friend/FriendController"
local mCommonToggleGroup = require "Module/CommonUI/TabView/CommonToggleGroup"
local ChatPrivateView = mLuaClass("ChatPrivateView",mCommonTabBaseView);

function ChatPrivateView:InitViewParam()
	return {
		["viewPath"] = "ui/chat/",
		["viewName"] = "chat_private_view",
	};
end

function ChatPrivateView:Init()
	local parentChat = self:Find("scrollChat/Grid");
	self.mGridChat = mLayoutController.LuaNew(parentChat, require "Module/Chat/ChatPrivateItem");
	self.mGridChat:RefreshUpdateSortIndex(true);
	local parentPlayer = self:Find("scrollPlayer/Grid");
	self.mGridPlayer = mLayoutController.LuaNew(parentPlayer, require "Module/Chat/ChatPlayerItem");
	self.mGridPlayer:SetSelectedViewTop(true);
	local parentFriend = self:Find("scrollFriend/Grid");
	self.mGridFriend = mLayoutController.LuaNew(parentFriend, require "Module/Chat/ChatAddItem");

	self.mRectTrance = self:FindComponent("scrollChat/Grid","RectTransform");
	self.mGoToggle = self:Find("Toggle").gameObject;
	self.mGoPlayerScroll = self:Find("scrollPlayer").gameObject;
	self.mGoFriendScroll = self:Find("scrollFriend").gameObject;
	self.mRectTranceBack = self:Find("PlayerBack");
	self.mGoBtnAdd = self:Find("BtnAdd").gameObject;
	self.mGoBtnCancel = self:Find("BtnCancel").gameObject;
	self.mShowFriend = false;

	local callBack = function( index )
		self:OnClickTypeButton(index);
	end
	local go = self:Find('Toggle');
	self.mToggleGroup = mCommonToggleGroup.LuaNew(go,callBack,1);
	self:OnClickTypeButton(1);

	self:FindAndAddClickListener("BtnAdd",function()self:OnClickAdd(true);end);
	self:FindAndAddClickListener("BtnCancel",function()self:OnClickAdd(false);end);

	local mEvent = self.mEventEnum;
	self:RegisterEventListener(mEvent.ON_REFRESH_PRIVATE_CHAT,function(data)self:RefreshList(data);end,true);
	self:RegisterEventListener(mEvent.ON_RECIVE_CHAT_PLAYER,function(data)self:OnUpdateUI(data);end,true);
	self:RegisterEventListener(mEvent.ON_ITEM_SELECT_PRIVATE_PLAYER,function(data)self:OnSelectPlayer(data);end,true);
	self:RegisterEventListener(mEvent.ON_CHANGE_PRIVATE_LIST_SELECT,function(data)self:OnChangeSelect(data);end,true);
	self:RegisterEventListener(mEvent.ON_CHANGE_PRIVATE_LIST_SELECT_NOTREAL,function(data)self:OnChangeSelectNotReal(data);end,true);
	self:RegisterEventListener(mEvent.ON_RECIVE_FRIEND_LIST,function(data) self:OnRecvFriendList(data);end,true);
	self:RegisterEventListener(mEvent.ON_ADD_CHATER,function(data) self:OnAddChater(data);end,true);
end

function ChatPrivateView:OnAddChater(data)
	local model = mGameModelManager.ChatModel;
	local selfID = mGameModelManager.RoleModel.mPlayerBase.player_id;
	local Data = {player_id = data.id,target_id = selfID,player_name = data.name,sex = data.sex,position = data.position,level = data.level};
	model:ChatToPlayer(Data);
	self:OnClickAdd(false);
end

function ChatPrivateView:OnClickTypeButton(index)
	self.mNowIndex = index;
	if index == 1 then
		local friendModel = mGameModelManager.FriendModel;
		if friendModel.mIsEverGetInfo then
			self.mGridFriend:UpdateDataSource(friendModel.mDataSoureInfo);
		else
			friendModel.mIsEverGetInfo = true;
			mFriendController:SendGetFriendList();
		end
	else
		local data_soure = mSortTable.LuaNew(nil,nil,true);
		self.mGridFriend:UpdateDataSource(data_soure);
	end
end

function ChatPrivateView:OnRecvFriendList(data)
	if self.mNowIndex == 1 then
		self:OnClickTypeButton(1);
	end
end

function ChatPrivateView:OnClickAdd(state)
	self.mShowFriend = state;
	self:ChangeFriendState(state);
end

function ChatPrivateView:ChangeFriendState(state)
	self.mGoToggle:SetActive(state);
	self.mGoPlayerScroll:SetActive(not state);
	self.mGoFriendScroll:SetActive(state);
	self.mGoBtnAdd:SetActive(not state);
	self.mGoBtnCancel:SetActive(state);
	if state then
		self.mRectTranceBack.sizeDelta = mVector2(300,418);
	else
		self.mRectTranceBack.sizeDelta = mVector2(300,455);
	end
end

function ChatPrivateView:RefreshList(data)
	mGameTimer.SetTimeout(0.1,function()self:Refresh();end);
	local model = mGameModelManager.ChatModel;
	self.mGridChat:UpdateDataSource(model.mPrivateDataSoure);
end

function ChatPrivateView:Refresh()
	local height = self.mRectTrance.sizeDelta.y;
	if height > 444 then
		self.mRectTrance.pivot = mVector2(0.5,0);
	else
		self.mRectTrance.pivot = mVector2(0.5,1);
	end
end

function ChatPrivateView:OnSelectPlayer(data)
	local model = mGameModelManager.ChatModel;
	model:ChangeSelect(data);
end

function ChatPrivateView:OnChangeSelect(data)
	mGameTimer.SetTimeout(0.5,function(id)self:SelectPlayer(data.base.player_id);end);
	self:OnSelectPlayer(data);
end

function ChatPrivateView:OnChangeSelectNotReal(data)
	local model = mGameModelManager.ChatModel;
	mGameTimer.SetTimeout(0.5,function(id)self:SelectPlayer(data.base.player_id);end);
	self:OnSelectPlayer(data);
end

function ChatPrivateView:SelectPlayer(id)
	self.mGridPlayer:SetViewSelectedByKey(id,true);
end

function ChatPrivateView:OnUpdateUI(data)
	local model = mGameModelManager.ChatModel;
	self.mGridChat:UpdateDataSource(model.mPrivateDataSoure);
	self:RefreshList(nil);
	if model.mIsEverGetPlayer then
		self.mGridPlayer:UpdateDataSource(model.mPrivatePlayerDataSoure);
	else
		mChatController:SendGetContactPerson();
	end
end

function ChatPrivateView:Dispose( )
	self.mGridChat:Dispose();
	self.mGridPlayer:Dispose();
end

return ChatPrivateView;