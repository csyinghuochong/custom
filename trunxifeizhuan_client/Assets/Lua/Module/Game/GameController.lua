local mNetInterface = NetInterface;
local mLuaClass = require "Core/LuaClass"
local mGameTimer = require "Core/Timer/GameTimer"
local mBaseController = require "Core/BaseController"
local mBagController = require "Module/Bag/BagController"
local mGameModelManager = require "Manager/GameModelManager"
local mTalentController = require "Module/Talent/TalentController"
local mDungeonController = require "Module/Dungeon/DungeonController"
local mFollowerController = require "Module/Follower/FollowerController"
local mCampDungeonController = require "Module/CampDungeon/CampDungeonController"
local mEndlessDungeonController = require "Module/EndlessDungeon/EndlessDungeonController"
local mTaskController = require "Module/Task/TaskController"
local mChatController = require "Module/Chat/ChatController"
local mFriendController = require "Module/Friend/FriendController"
local mMailController = require "Module/Mail/MailController"
local mFashionController =  require"Module/Fashion/FashionController"
local GameController = mLuaClass("GameController",mBaseController);
local mTime = UnityEngine.Time;
local mIsEditor = UnityEngine.Application.isEditor;

function GameController:OnLuaNew()
	local super = self:GetSuper(mBaseController.LuaClassName);
	super.OnLuaNew(self);

	self.mReceiveHeartFrameCount = mTime.frameCount;
	
	mGameTimer.SetInterval(2, function()
		if mNetInterface.Connected() then
			if mIsEditor == false then
				local receiveHeartFrameCount = self.mReceiveHeartFrameCount;
				if receiveHeartFrameCount == 0 then
					receiveHeartFrameCount = mTime.frameCount;
					self.mReceiveHeartFrameCount = receiveHeartFrameCount;
				end

				if mTime.frameCount - receiveHeartFrameCount >= 120 then
					self.mReceiveHeartFrameCount = 0;
					mNetInterface.SendTimeout();
					return;
				end
			end
			self.mC2S:KEEP_HEART(0);
		else
			self.mReceiveHeartFrameCount = 0;
		end
	end);
	
end

function GameController:AddNetListeners()
	self.mS2C:KEEP_HEART(function(pbResult)
		self.mReceiveHeartFrameCount = mTime.frameCount;
	end);
end

function GameController:AddEventListeners()
	self:AddEventListener(self.mEventEnum.LOGIN_SUCCESS,function(loginID)

		--第一次登录才请求
		if loginID <= 0 then
			self:FirstGetServerData();
		end

		--每次登录都需要请求
		self:GetServerData();
		
	end);
end

function GameController:FirstGetServerData()
	mTalentController:SendGetTalentList( );
	mFollowerController:SendGetFollowerList();
	mBagController:SendGetBagGoodsList();
	mDungeonController:SendReqDungeonInfo();
	mFashionController:RequestFashionList();
end

function GameController:GetServerData()
	
end

return GameController.LuaNew();