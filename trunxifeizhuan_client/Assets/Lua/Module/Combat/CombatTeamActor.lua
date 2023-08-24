local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mActorVO = require "Battle/ActorVO"
local mEventEnum = require "Enum/EventEnum"
local mEventDispatcher = require "Events/EventDispatcher"
local mCombatActorGroup = require "Module/Combat/CombatActorGroup"
local CombatTeamActor = mLuaClass("CombatTeamActor",mBaseLua);
local mTable = require 'table'

function CombatTeamActor:OnLuaNew(team)
	self.mTeam = team;
	self.mAllActorVOList = {};
	self.mDeadActroList = {};

	self.mTotalDieCount = 0;
	self.mWinTimes = 0;
	self.mFailTimes = 0;
	self.mWave = 1;
	self.mWaveAllDie = {};
end

function CombatTeamActor:GetWave()
	return self.mWave;
end

function CombatTeamActor:OnWinWave(  )
	self.mWinTimes = self.mWinTimes + 1;
end

function CombatTeamActor:OnFailWave(  )
	self.mFailTimes = self.mFailTimes + 1;
end

function CombatTeamActor:OnReliveWave()
	self.mWaveAllDie[self.mWave] = nil;
end

function CombatTeamActor:OnWaveAllDie()
	local wave = self.mWave;
	self.mWaveAllDie[wave] = true;
	if wave < self:GetTeamWaves() then
		wave = wave + 1;
		self.mWave = wave;
	end
	return wave;
end

function CombatTeamActor:OnActorDie(actor)
	self.mTotalDieCount = self.mTotalDieCount + 1;
	self.mDeadActroList[actor.mUniqueId] = actor.mActorVo.mActorID;
end

function CombatTeamActor:OnActorRelive(actor)
	local deadActors = self.mDeadActroList;
	local uniqueId = actor.mUniqueId;
	if deadActors[uniqueId] then
		self.mTotalDieCount = self.mTotalDieCount - 1;
		deadActors[uniqueId] = nil;
	end
end

function CombatTeamActor:GetTeamWaves( )
	return self.mWaveCount or 0;
end

function CombatTeamActor:IsAllTeamDead( )
	local wave = self.mWave;
	return wave == self:GetTeamWaves() and self.mWaveAllDie[wave];
end

function CombatTeamActor:GetTeamAliveNumber( )
	return self:GetTeamAllNumber() - self.mTotalDieCount;
end

function CombatTeamActor:GetKillMonsterRate(  )
	return self.mTotalDieCount / self:GetTeamAllNumber();
end

function CombatTeamActor:CheckKillIDMonsters(target, number)
	local cnt = 0;
	for k, v in pairs(self.mDeadActroList) do
		cnt = cnt + ( v == target and 1 or 0 );
	end
	return cnt >= number;
end

function CombatTeamActor:GetTeamAllNumber()
	local totalNumber = self.mTotalNumber;
	if totalNumber == nil then
		totalNumber = 0;
		local allActor = self.mAllActorVOList;
		for k , v in pairs(allActor) do
			totalNumber = totalNumber + mTable.getn(v);
		end
		self.mTotalNumber = totalNumber;
	end
	return totalNumber;
end

function CombatTeamActor:GetWavesActorNumber( wave )
	local wave = self.mAllActorVOList[wave];
	return wave and mTable.getn(wave) or 0;
end

function CombatTeamActor:AddCombatActor( combat, wave )
	local actorVO = self.mAllActorVOList[wave];
	for k, v in pairs(actorVO) do
		v.mWave = wave;
		combat:CreateActor(v);
	end
end

function CombatTeamActor:OnInitActors(actor_list)
	self.mAllActorVOList = actor_list;
	if actor_list then
		self.mWaveCount = mTable.getn(actor_list);
	end
end


return CombatTeamActor;