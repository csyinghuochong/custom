local mLuaClass = require "Core/LuaClass"
local mChatPlayerItem = require "Module/Chat/ChatPlayerItem"
local ChatAddItem = mLuaClass("ChatAddItem",mChatPlayerItem);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgOnline = mLanguageUtil.friend_online;

function ChatAddItem:InitViewParam()
	return {
		["viewPath"] = "ui/chat/",
		["viewName"] = "chat_player_item_view",
	};
end

function ChatAddItem:Init( )
	mSuper = self:GetSuper(mChatPlayerItem.LuaClassName);
	mSuper.Init(self);
end

function ChatAddItem:ClickItem()
	local data = self.mData;
	self:Dispatch(self.mEventEnum.ON_ADD_CHATER,data);
end

function ChatAddItem:OnUpdateData()
	local data = self.mData;
	self.mTextName.text = data.name;
	self.mGoPointRed:SetActive(false);
	if data.online == 1 then
		self.mTextTime.text = mLgOnline;
	else
		self.mTextTime.text = self:GetTime(data.last_online_time);
	end
	self.mPlayer:SetInfo(data.sex,data.position,data.level,self.mGoodsBgSprites,self.mGoodsKuangSprites);

	local sex = self.mSex;
	if sex ~= data.sex then
		self.mGameObjectUtil:SetImageSprite(self.mImgSex,"common_icon_sex"..data.sex);
		self.mSex = data.sex;
	end
end

return ChatAddItem;