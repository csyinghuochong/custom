local mLuaClass = require "Core/LuaClass"
local mBaseController = require "Core/BaseController"
local mGameModelManager = require "Manager/GameModelManager"
local FriendController = mLuaClass("FriendController",mBaseController);

--协议处理--
function FriendController:AddNetListeners()
	local s2c = self.mS2C;
	s2c:PLAYER_FRIENDS_LIST(function(pbFriendList)
		mGameModelManager.FriendModel:OnRecvFriendList(pbFriendList);
	end);

	s2c:PLAYER_RECEIVE_ENERGY(function(pbResult)
		mGameModelManager.FriendModel:OnRecvGetEnergy(pbResult);
	end);

	s2c:PLAYER_SEND_ENERGY(function(pbResult)
		mGameModelManager.FriendModel:OnRecvSendEnergy(pbResult);
	end);

	s2c:PLAYER_DELETE_FRIEND(function(pbResult)
		mGameModelManager.FriendModel:OnRecvFriendDelete(pbResult);
	end);

	s2c:PLAYER_SEARCH_FRIEND(function(pbFriendList)
		mGameModelManager.FriendModel:OnRecvSearchList(pbFriendList);
	end);

	s2c:PLAYER_ADD_FRIEND(function(pbResult)
		mGameModelManager.FriendModel:OnRecvAddFriend(pbResult);
	end);

	s2c:PLAYER_FRIEND_REQUEST_LIST(function(pbFriendList)
		mGameModelManager.FriendModel:OnRecvRequestList(pbFriendList);
	end);

	s2c:PLAYER_FRIEND_REQUEST_HANDLE(function(pbResult)
		mGameModelManager.FriendModel:OnRecvRequestHandle(pbResult);
	end);

	s2c:PLAYER_FRIEND_BLACK_LIST(function(pbFriendList)
		mGameModelManager.FriendModel:OnRecvBlackList(pbFriendList);
	end);

	s2c:PLAYER_FRIEND_UNBLOCK_BLACK(function(pbResult)
		mGameModelManager.FriendModel:OnRecvBlackListDelete(pbResult);
	end);

	s2c:PLAYER_FRIEND_ENEMY_LIST(function(pbFriendList)
		mGameModelManager.FriendModel:OnRecvEnemyList(pbFriendList);
	end);

	s2c:PLAYER_FRIEND_DELETE_ENEMY(function(pbResult)
		mGameModelManager.FriendModel:OnRecvEnemyListDelete(pbResult);
	end);

	s2c:PLAYER_FRIEND_RECOMMEND_LIST(function(pbFriendList)
		mGameModelManager.FriendModel:OnRecvRecommendList(pbFriendList);
	end);
end

--事件处理--
function FriendController:AddEventListeners()
	
end

--获取好友列表--
function FriendController:SendGetFriendList()
	self.mC2S:PLAYER_FRIENDS_LIST(true);
end

--获取体力--
function FriendController:SendGetFriendEnergy(playerId)
	self.mC2S:PLAYER_RECEIVE_ENERGY(playerId);
end

--赠送体力--
function FriendController:SendFriendEnergy(playerId)
	self.mC2S:PLAYER_SEND_ENERGY(playerId);
end

--删除好友--
function FriendController:SendDeleteFriend(playerId)
	self.mC2S:PLAYER_DELETE_FRIEND(playerId,true);
end

--查找--
function FriendController:SendFindFriend(name)
	self.mC2S:PLAYER_SEARCH_FRIEND(name,true);
end

--添加好友--
function FriendController:SendAddFriend(playerId)
	self.mC2S:PLAYER_ADD_FRIEND(playerId);
end

--获取申请列表--
function FriendController:SendGetRequestList()
	self.mC2S:PLAYER_FRIEND_REQUEST_LIST(true);
end

--申请列表(接受/拒接)--
function FriendController:SendRequestHandle(playerId,flag)
	self.mC2S:PLAYER_FRIEND_REQUEST_HANDLE(playerId,flag,true);
end

--黑名单列表--
function FriendController:SendGetBlackList()
	self.mC2S:PLAYER_FRIEND_BLACK_LIST(true);
end

--黑名单删除--
function FriendController:SendDeleteBlackList(playerId)
	self.mC2S:PLAYER_FRIEND_UNBLOCK_BLACK(playerId,true);
end

--黑名单增加--
function FriendController:SendAddBlackList(playerId)
	self.mC2S:PLAYER_FRIEND_ADD_TO_BLACK(playerId,true);
end

--仇敌列表--
function FriendController:SendGetEnemyList()
	self.mC2S:PLAYER_FRIEND_ENEMY_LIST(true);
end

--仇敌删除--
function FriendController:SendDeleteEnemyList(playerId)
	self.mC2S:PLAYER_FRIEND_DELETE_ENEMY(playerId,true);
end

--推荐列表--
function FriendController:SendGetRecommendList()
	self.mC2S:PLAYER_FRIEND_RECOMMEND_LIST(true);
end

local mFriendControllerInstance = FriendController.LuaNew();
return mFriendControllerInstance;