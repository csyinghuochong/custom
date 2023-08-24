local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mSortTable = require "Common/SortTable"
local mEventDispatcher = require "Events/EventDispatcher"
local mEventEnum = require "Enum/EventEnum"
local ReceivePowerModel = mLuaClass("ReceivePowerModel",mBaseModel);

function ReceivePowerModel:OnLuaNew()
	self.mReceiveTable = {0,0,0};
	self.mRestoreSpTime = 0;
	self.mRestoreEnergyTime = 0;
end

function ReceivePowerModel:GetEveryDayPower(pbGetPower)	
	for k,v in ipairs(pbGetPower.id) do
		self.mReceiveTable[k] = v;
	end
	mEventDispatcher:Dispatch(mEventEnum.ON_GET_EVERY_DAY_POWER,self.mReceiveTable);
end

function ReceivePowerModel:ReceiveEveryDayPower(pbReceivePower)
	if pbReceivePower.result == 1 then
		mEventDispatcher:Dispatch(mEventEnum.ON_RECEIVE_POWER,self.mReceiveTable);
	end
end

function ReceivePowerModel:GetRestoreTime(pbTimeSpEnergy)
	self.mRestoreSpTime = pbTimeSpEnergy.time_sp;
	self.mRestoreEnergyTime = pbTimeSpEnergy.time_energy;
	mEventDispatcher:Dispatch(mEventEnum.ON_RESTORE_TIME);
end

return ReceivePowerModel;