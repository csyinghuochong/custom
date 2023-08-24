local mLuaClass = require "Core/LuaClass"
local mVector2 = Vector2;
local mTimeUtil = require "Utils/TimeUtil"
require "Module/Face/FaceConfig"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local mGameModelManager = require "Manager/GameModelManager"
local mChatPlayerAlertView = require "Module/Chat/ChatPlayerAlertView"
local mUIManager = require "Manager/UIManager"
local mChatItem = require "Module/Chat/ChatItem"
local ChatPrivateItem = mLuaClass("ChatPrivateItem",mChatItem);

local mSensitiveWordUtil = require "Utils/SensitiveWordUtil"

local mGlobalUtil = require "Utils/GlobalUtil"
local mChatColorTable = mGlobalUtil.ChatColorTable;

function ChatPrivateItem:InitViewParam()
	return {
		["viewPath"] = "ui/chat/",
		["viewName"] = "chat_private_item_view",
	};
end

function ChatPrivateItem:OnUpdateData()
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

function ChatPrivateItem:SetPos(data,offset)
	local itemHeight = 35;
	local nameWidth = self.mTextName.preferredWidth + 5;
	local namePosX = 0;
	local namePosY = 0;
	local backWidth = self.mTextChat:GetPreferredWidth(mUIManager.mScaleFactor) + 30;
	local backHeight;
	local chatMaxWidth = 430 - nameWidth;
	self.mRectTranceChatText.sizeDelta = mVector2(chatMaxWidth - 30,24);
	if self.mTextChat:GetPreferredWidth(mUIManager.mScaleFactor) > chatMaxWidth - 30 then
		backWidth = chatMaxWidth;
		backHeight = 50;
		itemHeight = itemHeight + backHeight - 30;
	else
		backHeight = 33;
	end
	local chatPosX = nameWidth + 5;
	local chatPosY = -40; 
	if data.isShowTime then
		itemHeight = itemHeight + 25;
	else
		namePosY = namePosY + 25;
		chatPosY = chatPosY + 25;
	end
	-- local isSelf = data.player_id == mGameModelManager.RoleModel.mPlayerBase.player_id;
	-- if isSelf then
	-- 	namePosX = 510 - nameWidth;
	-- 	if self.mTextChat:GetPreferredWidth(mUIManager.mScaleFactor) > chatMaxWidth - 20 then
	-- 		chatPosX = 0;
	-- 	else
	-- 		chatPosX = namePosX - backWidth;
	-- 	end
	-- end

	self.mRectTranceItem.sizeDelta = mVector2(480,itemHeight);
	self.mRectTranceName.sizeDelta = mVector2(nameWidth,28);
	self.mRectTranceName.anchoredPosition = mVector2(namePosX,namePosY);
	self.mRectTranceChat.anchoredPosition = mVector2(chatPosX + offset,chatPosY);
	self.mRectTranceChatBack.sizeDelta = mVector2(backWidth,backHeight);
end

return ChatPrivateItem;