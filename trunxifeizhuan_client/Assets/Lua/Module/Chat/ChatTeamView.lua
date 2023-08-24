local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mLayoutController = require "Core/Layout/LayoutController"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local mGameTimer = require "Core/Timer/GameTimer"
local mVector2 = Vector2
local mGameModelManager = require "Manager/GameModelManager"
local ChatTeamView = mLuaClass("ChatTeamView",mCommonTabBaseView);

function ChatTeamView:InitViewParam()
	return {
		["viewPath"] = "ui/chat/",
		["viewName"] = "chat_team_view",
	};
end

function ChatTeamView:Init()
	local parent = self:Find("scrollView/Grid");
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Chat/ChatItem");
	self.mGridEx:RefreshUpdateSortIndex(true);
	self.mRectTrance = self:FindComponent("scrollView/Grid","RectTransform");
	self.mRectTranceScroll = self:FindComponent("scrollView","RectTransform");
	local mEvent = self.mEventEnum;
	self:RegisterEventListener(mEvent.ON_REFRESH_TEAM_CHAT,function(data)self:RefreshList(data);end,true);
	self:RegisterEventListener(mEvent.ON_CHANGE_CHAT_SCROLL_POS_AND_HEIGHT,function(data)self:OnChangeScrollPosAndHeight(data);end,true);
end

function ChatWorldView:OnChangeScrollPosAndHeight(data)
	local model = mGameModelManager.ChatModel;
	local height = 444 - model.mMainSystemHeight;
	self.mRectTranceScroll.sizeDelta = mVector2.New(790,height);
	if self.isTop then
		local posY = 222 - model.mMainSystemHeight;
		self.mRectTranceScroll.anchoredPosition = mVector2.New(-20,posY);
	end
end

function ChatTeamView:RefreshList(data)
	mGameTimer.SetTimeout(0.1,function()self:Refresh();end);
end

function ChatTeamView:Refresh()
	local height = self.mRectTrance.sizeDelta.y;
	local model = mGameModelManager.ChatModel;
	if height > 444 - model.mMainSystemHeight then
		self.mRectTrance.pivot = mVector2(0.5,0);
		self.isTop = false;
	else
		self.mRectTrance.pivot = mVector2(0.5,1);
		self.isTop = true;
	end
end

function ChatTeamView:OnUpdateUI(data)
	local model = mGameModelManager.ChatModel;
	self.mGridEx:UpdateDataSource(model.mTeamDataSoure);
	self:RefreshList(nil);
	self:OnChangeScrollPosAndHeight(nil);
end

function ChatTeamView:Dispose( )
	self.mGridEx:Dispose();
end

return ChatTeamView;