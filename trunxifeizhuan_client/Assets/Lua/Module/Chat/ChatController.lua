local mLuaClass = require "Core/LuaClass"
local mBaseController = require "Core/BaseController"
local mGameModelManager= require "Manager/GameModelManager"
local ChatController = mLuaClass("ChatController",mBaseController);

--协议处理--
function ChatController:AddNetListeners()
	local s2c = self.mS2C;
	s2c:CHAT_RECEIVE(function(pbReturnChat)
		mGameModelManager.ChatModel:OnRecvChat(pbReturnChat);
	end);

	s2c:CHAT_CONTACT_PERSONS(function(pbContactPersons)
		mGameModelManager.ChatModel:OnRecvChatContactPerson(pbContactPersons);
	end);

	s2c:CHAT_PRIVATE_MESSAGE(function(pbReturnChats)
		mGameModelManager.ChatModel:OnRecvChatPersonPrivate(pbReturnChats);
	end);

	s2c:CHAT_UPDATE_CONTACT_PERSON(function(pbContactPerson)
		mGameModelManager.ChatModel:OnRecvUpdatePerson(pbContactPerson);
	end);

	s2c:CHAT_NOTICE_MESSAGE(function(pbBroadcastNotice)
		mGameModelManager.ChatModel:OnRecvNotice(pbBroadcastNotice);
	end);
end

--事件处理--
function ChatController:AddEventListeners()
	self:AddEventListener(self.mEventEnum.ON_GET_PLAYER_PRIVATE,function(data)self:SendGetChatPrivateMsg(data);end);
end

--发送聊天--
function ChatController:SendChat(channel,msg,playerId)
	self.mC2S:CHAT_SEND(channel,msg,playerId);
end

--请求最近联系人--
function ChatController:SendGetContactPerson()
	self.mC2S:CHAT_CONTACT_PERSONS();
end

--查询与某人的私聊信息--
function ChatController:SendGetChatPrivateMsg(playerId)
	self.mC2S:CHAT_PRIVATE_MESSAGE(playerId,true);
end

local mChatControllerInstance = ChatController.LuaNew();
return mChatControllerInstance;