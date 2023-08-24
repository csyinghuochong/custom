local mLuaClass = require "Core/LuaClass"
local mBaseController = require "Core/BaseController"
local mGameModelManager= require "Manager/GameModelManager"
local RankController = mLuaClass("RankController",mBaseController);

--协议处理--
function RankController:AddNetListeners()
	local s2c = self.mS2C;
	s2c:PLAYER_RANK(function(pbRankData)
		mGameModelManager.RankModel:OnRecvRankList(pbRankData);
	end);
end

--事件处理--
function RankController:AddEventListeners()
	
end

--获取排名列表--
function RankController:SendGetRankList(type,page,num)
	self.mC2S:PLAYER_RANK(type,page,num,true);
end

local mRankControllerInstance = RankController.LuaNew();
return mRankControllerInstance;