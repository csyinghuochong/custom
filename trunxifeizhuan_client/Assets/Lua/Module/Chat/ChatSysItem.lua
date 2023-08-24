local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mVector2 = Vector2;
local mGameModelManager = require "Manager/GameModelManager"
require "Module/Face/FaceConfig"
local ChatSysItem = mLuaClass("ChatSysItem",mLayoutItem);

function ChatSysItem:InitViewParam()
	return {
		["viewPath"] = "ui/chat/",
		["viewName"] = "chat_sys_item_view",
	};
end

function ChatSysItem:Init( )
	self.mRectTrance = self.mGameObject:GetComponent('RectTransform');
	self.mRectTranceText = self:FindComponent('faceText','RectTransform');
	self.mTextChat = self:FindComponent('faceText','GameEmojiText');
	self.mTextChat.mClickHref = function(link) self:OnClickHref(link)end

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function ChatSysItem:OnClickHref(link)
	local linkData = {linkStr = link,data = self.mData};
	self:Dispatch(self.mEventEnum.ON_CHAT_CLICK_LINK,linkData);
end

function ChatSysItem:OnUpdateData()
	local data = self.mData;
	self.mTextChat:SetEmojiText(data.msg);

	local height = self.mTextChat.preferredHeight + 5;
	local vector2 = mVector2(790,height);
	self.mRectTrance.sizeDelta = vector2;
	self.mRectTranceText.sizeDelta = vector2;
end

return ChatSysItem;