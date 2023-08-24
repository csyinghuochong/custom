local mLuaClass = require "Core/LuaClass"
local mBaseController = require "Core/BaseController"
local mGameModelManager= require "Manager/GameModelManager"
local RecievePowerController = mLuaClass("RecievePowerController",mBaseController);


function RecievePowerController:AddNetListeners()
	local s2c = self.mS2C;
	s2c:PLAYER_EVERY_DAY_SP_LIST(function(pbGetPower)
		mGameModelManager.ReceivePowerModel:GetEveryDayPower(pbGetPower);		
	end)
	s2c:PLAYER_EVERY_DAY_SP_GET(function(pbReceivePower)
		mGameModelManager.ReceivePowerModel:ReceiveEveryDayPower(pbReceivePower);
	end)
	s2c:PLAYER_EVERYDAY_SP_ENERGY_TIME(function(pbTimeSpEnergy)
		mGameModelManager.ReceivePowerModel:GetRestoreTime(pbTimeSpEnergy);
	end)
end

function RecievePowerController:GetEveryDayPower()
	self.mC2S:PLAYER_EVERY_DAY_SP_LIST(true);
end

function RecievePowerController:ReceiveEveryDayPower()
	self.mC2S:PLAYER_EVERY_DAY_SP_GET(true);
end

function RecievePowerController:GetRestoreTime()
	self.mC2S:PLAYER_EVERYDAY_SP_ENERGY_TIME(true);
end

local mRecievePowerControllerInstance = RecievePowerController.LuaNew();
return mRecievePowerControllerInstance;