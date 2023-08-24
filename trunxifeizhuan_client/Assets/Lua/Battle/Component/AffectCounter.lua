local LuaClass = require "Core/LuaClass"
local ActorObserver = require "Battle/Component/ActorObserver"
local AffectCounter = LuaClass("AffectCounter",ActorObserver);
local mNotifyEnum = require"Enum/NotifyEnum"

function AffectCounter:Awake()
	self:RegisterListener(mNotifyEnum.OnBeKilled,function ()
		self.mCounters = nil;
		self.mLastReduceHealth = nil;
	end);
end

function AffectCounter:GetAffectCount(affect)
	local counters = self.mCounters;
	if not counters then
		return 0;
	end

	return counters[affect] or 0;
end

function AffectCounter:AddAffectCount(affect)
	local counters = self.mCounters;
	if not counters then
		counters = {};
		self.mCounters = counters;
	end

	local counter = counters[affect] or 0;

	counters[affect] = counter + 1;
end

function AffectCounter:GetLastRedcueHealth(affect)
	local lastReduceHealth = self.mLastReduceHealth;
	if not lastReduceHealth then
		return 0;
	end

	return lastReduceHealth[affect] or 0;
end

function AffectCounter:ResetLastReduceHealth(affect)
	local lastReduceHealth = self.mLastReduceHealth;
	if not lastReduceHealth then
		return 0;
	end

	lastReduceHealth[affect] = nil;
end

function AffectCounter:AddLastReduceHealth(affect,health)
	local lastReduceHealth = self.mLastReduceHealth;
	if not lastReduceHealth then
		lastReduceHealth = {};
		self.mLastReduceHealth = lastReduceHealth;
	end

	local last = lastReduceHealth[affect] or 0;

	lastReduceHealth[affect] = last + health;
end

return AffectCounter;