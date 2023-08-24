local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mGameTimer = require "Core/Timer/GameTimer"
local mGameModelManager = require "Manager/GameModelManager"
require "Module/Face/FaceConfig"
local mSensitiveWordUtil = require "Utils/SensitiveWordUtil"
local CommonChatButton = mLuaClass("CommonChatButton",mBaseView);
local mVector3 = Vector3;
local mLanguageUtil = require "Utils/LanguageUtil"
local mLgSystem = mLanguageUtil.chat_system;

function CommonChatButton:OnLuaNew(go,isAlpha)
	mSuper = self:GetSuper(mBaseView.LuaClassName);
	mSuper.OnLuaNew(self, go);

	self.mIsAlpha = isAlpha;
end

function CommonChatButton:Init()
	self.mTextChat = self:FindComponent('Back/faceText', 'GameEmojiText');
	self.mTextChat.enabled = true;
	self.mGoChat = self:Find("Back").gameObject;
	self.mTransText = self:Find("Back");
	self:FindAndAddClickListener('Button_bubble',function() self:OnClickChat() end);

	local mEventEnum =self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_REFRESH_WORLD_CHAT,function(value) self:ShowWorldMsg(value); end,false);
	self:RegisterEventListener(mEventEnum.ON_REFRESH_SYSTEM_CHAT,function(value) self:ShowWorldMsg(value); end,false);
end

--聊天
function CommonChatButton:OnClickChat()
	local model = mGameModelManager.ChatModel;
	if self.mIsAlpha then
		model.mIsOpenByBattle = true;
		mUIManager:HandleUIWithParent(mBattleChatLayer,mViewEnum.ChatView,1);
	else
		model.mIsOpenByBattle = false;
		mUIManager:HandleUIWithParent(mMainLayer,mViewEnum.ChatView,1);
	end
end

function CommonChatButton:ShowWorldMsg(chat)
	local msg;
	local name;
	if chat.channel == 1 then
		name = chat.player_name.."：";
	elseif chat.channel == 2 then
		name = mLgSystem;
	end
	if not chat.ReplaceSensitiveWord then
		msg = mSensitiveWordUtil:ReplaceSensitiveWord(chat.msg);
		chat.ReplaceSensitiveWord = true;
	else
		msg = chat.msg;
	end
	self.mTextChat:SetEmojiText(name..msg);
	chat.msg = msg;

	if self.mTimerOut ~= nil then
		self.mTimerOut:Stop();
	end
	self.mTimerOut = mGameTimer.HandSetTimeout(2.5,function(state)self:SetScaleAnimate(false)end);

	self.mTransText.localScale = mVector3.New(1,0,1);
	self.mScaleY = 0;
	self:SetScaleAnimate(true);
end

function CommonChatButton:SetScaleAnimate(isAdd)
	if self.mTimerOutScale ~= nil then
		self.mTimerOutScale:Stop();
	end
	self.mTimerOutScale = mGameTimer.SetInterval(0.03, function(state) self:OnTimerInterval(isAdd) end);
end

function CommonChatButton:OnTimerInterval(isAdd)
	local scaleY = self.mScaleY;
	if isAdd then
		scaleY = scaleY + 0.1;
	else
		scaleY = scaleY - 0.1;
	end
	if scaleY >= 1 or scaleY <= 0 then
		self.mTimerOutScale:Stop();
	else
		self.mTransText.localScale = mVector3.New(1,scaleY,1)
	end
	self.mScaleY = scaleY;
end

function CommonChatButton:Dispose()
	if self.mTimerOut ~= nil then
		self.mTimerOut:Dispose();
		self.mTimerOut = nil;
	end
end

return CommonChatButton;