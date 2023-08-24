local mLuaClass = require "Core/LuaClass"
local mBaseController = require "Core/BaseController"
local mGameModelManager = require "Manager/GameModelManager"
local CheckController = mLuaClass("CheckController",mBaseController);

--协议处理--
function CheckController:AddNetListeners()
	local s2c = self.mS2C;
	s2c:PLAYER_FRIEND_OTHER_PLAYER_INFO(function(pbOtherPlayer)
		mGameModelManager.CheckModel:OnRecvOtherPlayer(pbOtherPlayer);
	end);
end

--事件处理--
function CheckController:AddEventListeners()
	
end

--查看玩家--
function CheckController:SendGetOtherPlayer(playerId)
	-- local selfID = mGameModelManager.RoleModel.mPlayerBase.player_id;
	-- if selfID ~= playerId then
	-- 	self.mC2S:PLAYER_FRIEND_OTHER_PLAYER_INFO(playerId,true);
	-- end
end

local mCheckControllerInstance = CheckController.LuaNew();
return mCheckControllerInstance;