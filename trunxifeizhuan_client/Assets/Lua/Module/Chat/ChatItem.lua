local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mVector2 = Vector2;
local mTimeUtil = require "Utils/TimeUtil"
require "Module/Face/FaceConfig"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local mGameModelManager = require "Manager/GameModelManager"
local mChatPlayerAlertView = require "Module/Chat/ChatPlayerAlertView"
local ChatItem = mLuaClass("ChatItem",mLayoutItem);

local mUIManager = require "Manager/UIManager"
local mSensitiveWordUtil = require "Utils/SensitiveWordUtil"

local mGlobalUtil = require "Utils/GlobalUtil"
local mChatColorTable = mGlobalUtil.ChatColorTable;

function ChatItem:InitViewParam()
	return {
		["viewPath"] = "ui/chat/",
		["viewName"] = "chat_world_item_view",
	};
end

function ChatItem:Init( )
	self.mRectTranceItem = self.mGameObject:GetComponent('RectTransform');
	self.mRectTranceName = self:FindComponent('Name/Text','RectTransform');
	self.mRectTranceChat = self:FindComponent('Chat','RectTransform');
	self.mRectTranceChatBack = self:FindComponent('Chat/Back','RectTransform');
	self.mRectTranceChatText = self:FindComponent('Chat/faceText','RectTransform');
	self.mTextTime = self:FindComponent('Time','Text');
	self.mGoTime = self:Find('Time').gameObject;
	self.mTextName = self:FindComponent('Name/Text','GameUnderlineText');
	self.mTextChat = self:FindComponent('Chat/faceText','GameEmojiText');
	self.mTextChat.mClickHref = function(link) self:OnClickHref(link)end

	self:FindAndAddClickListener('Name',function()self:OnClickName();end);
	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function ChatItem:OnClickHref(link)
	local linkData = {linkStr = link,data = self.mData};
	self:Dispatch(self.mEventEnum.ON_CHAT_CLICK_LINK,linkData);
end

function ChatItem:OnClickName()
	local data = self.mData;
	local isOpenByBattle = mGameModelManager.ChatModel.mIsOpenByBattle;
	if isOpenByBattle then
		return;
	end
	if data.player_id ~= nil then
		if data.player_id ~= mGameModelManager.RoleModel.mPlayerBase.player_id then
			mChatPlayerAlertView.Show(data);
		end
	end
end

function ChatItem:OnUpdateData()
	local data = self.mData;
	if data.mSortTableIndex > 1 then
		local chatLastVO = self.mLayoutController.mSortTable.mSortTable[data.mSortTableIndex - 1];
		data.isShowTime = data.create_time - chatLastVO.create_time > mConfigSysglobal_value[mConfigGlobalConst.CHAT_TIME];
	else
		data.isShowTime = true;
	end
	self.mGoTime:SetActive(data.isShowTime);
	self.mTextTime.text = mTimeUtil:TransToYearMonthDayHMS(data.create_time);
	local selfChat = data.player_id == mGameModelManager.RoleModel.mPlayerBase.player_id;
	local offset = 0;
	if selfChat then
		self.mTextName.text = data.player_name;
		self.mTextName.showUnderline = false;
	else
		self.mTextName:SetUnderLineColor(mChatColorTable[data.channel]);
		self.mTextName.text = data.player_name .. "_";
		self.mTextName.showUnderline = true;
		offset = -12;
	end

	if not data.ReplaceSensitiveWord then
		data.msg = mSensitiveWordUtil:ReplaceSensitiveWord(data.msg);
		data.ReplaceSensitiveWord = true;
	end

	self.mTextChat:SetEmojiText(data.msg);
	self.mTextName.color = mChatColorTable[data.channel];
	self.mTextChat.color = mChatColorTable[data.channel];
	self:SetPos(data,offset);
end

function ChatItem:SetPos(data,offset)
	local itemHeight = 35;
	local nameWidth = self.mTextName.preferredWidth + 5;
	local namePosX = 0;
	local namePosY = 0;
	local backWidth = self.mTextChat:GetPreferredWidth(mUIManager.mScaleFactor) + 30;
	local backHeight;
	local chatMaxWidth = 720 - nameWidth;
	self.mRectTranceChatText.sizeDelta = mVector2(chatMaxWidth - 20,24);
	if self.mTextChat:GetPreferredWidth(mUIManager.mScaleFactor) > chatMaxWidth - 20 then
		backWidth = chatMaxWidth;
		backHeight = self.mTextChat.preferredHeight + 15;
		itemHeight = itemHeight + backHeight - 30;
	else
		backHeight = 33;
	end
	local chatPosX = nameWidth;
	local chatPosY = -40; 
	if data.isShowTime then
		itemHeight = itemHeight + 25;
	else
		namePosY = namePosY + 25;
		chatPosY = chatPosY + 25;
	end
	-- local isSelf = data.player_id == mGameModelManager.RoleModel.mPlayerBase.player_id;
	-- if isSelf then
	-- 	namePosX = 725 - nameWidth;
	-- 	chatPosX = 735 - backWidth;
	-- end

	self.mRectTranceItem.sizeDelta = mVector2(790,itemHeight);
	self.mRectTranceName.sizeDelta = mVector2(nameWidth,28);
	self.mRectTranceName.anchoredPosition = mVector2(namePosX,namePosY);
	self.mRectTranceChat.anchoredPosition = mVector2(chatPosX + offset,chatPosY);
	self.mRectTranceChatBack.sizeDelta = mVector2(backWidth,backHeight);
end

return ChatItem;