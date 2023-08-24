local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mLayoutController = require "Core/Layout/LayoutController"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local mVector2 = Vector2
local mGameTimer = require "Core/Timer/GameTimer"
local mGameModelManager = require "Manager/GameModelManager"
local ChatSysView = mLuaClass("ChatSysView",mCommonTabBaseView);

function ChatSysView:InitViewParam()
	return {
		["viewPath"] = "ui/chat/",
		["viewName"] = "chat_sys_view",
	};
end

function ChatSysView:Init()
	local parent = self:Find("scrollView/Grid");
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Chat/ChatSysItem");
	self.mRectTrance = self:FindComponent("scrollView/Grid","RectTransform");
	local mEvent = self.mEventEnum;
	self:RegisterEventListener(mEvent.ON_REFRESH_SYSTEM_CHAT,function(data)self:RefreshList(data);end,true);
end

function ChatSysView:RefreshList(data)
	mGameTimer.SetTimeout(0.1,function()self:Refresh();end);
end

function ChatSysView:Refresh()
	local height = self.mRectTrance.sizeDelta.y;
	if height > 444 then
		self.mRectTrance.pivot = mVector2(0.5,0);
	else
		self.mRectTrance.pivot = mVector2(0.5,1);
	end
end

function ChatSysView:OnUpdateUI(data)
	local model = mGameModelManager.ChatModel;
	self.mGridEx:UpdateDataSource(model.mSystemDataSoure);
	self:RefreshList(nil);
end

function ChatSysView:Dispose( )
	self.mGridEx:Dispose();
end

return ChatSysView;