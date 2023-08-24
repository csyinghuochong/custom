local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mBattleController = require "Battle/Combat/BattleController"
local mCombatTeamActor = require "Module/Combat/CombatTeamActor"
local CombatActorManager = mLuaClass("CombatActorManager",mBaseLua);
local mString = require 'string'
local mTable = require 'table'
local GameTimer = require "Core/Timer/GameTimer"

--保存战斗单位的所有数据
--auto_mode  1 阵亡方下一波  2 全部下一波
function CombatActorManager:OnLuaNew(dungeonVO, auto_mode)
	self.mAutoMode = auto_mode;
	self.mCallBack = call_back;
	self.mDungeonVO = dungeonVO;
	self.mCombat = mBattleController:CreateCombat(1);
	local teams = {};
	teams[1] = mCombatTeamActor.LuaNew(1);
	teams[2] = mCombatTeamActor.LuaNew(2);
	self.mTeams = teams;
end

function CombatActorManager:OnWaveAllDie(allDieTeam)
	self:OnTeamFail(allDieTeam);
	if self.mAutoMode == 1 then
		return self:DoAutoMode1(allDieTeam);
	else
		return self:DoAutoMode2(allDieTeam);
	end
end

function CombatActorManager:DoAutoMode1(allDieTeam)
	return self.mTeams[allDieTeam]:OnWaveAllDie();
end

function CombatActorManager:DoAutoMode2(allDieTeam)
	
	local teams = self.mTeams;
	local team1 = teams[1];
	local team2 = teams[2];

	local maxWave = self:GetMaxWaveNumber();
	local nextWave = teams[allDieTeam]:GetWave() + 1;

	local TurnNextWave = function()
		team1:OnWaveAllDie();
		team2:OnWaveAllDie();
	end

	TurnNextWave();

	for i = nextWave, maxWave do
		local number1 = team1:GetWavesActorNumber( i );
		local number2 = team2:GetWavesActorNumber( i );
		if number1 == 0 then
			if number2 == 0 then
				TurnNextWave();
			else
				self:OnTeamFail(1);
				TurnNextWave();
			end
		else
			if number2 == 0 then
				self:OnTeamFail(2);
				TurnNextWave();
			else
				return i;
			end
		end
	end
end

function CombatActorManager:GetMaxWaveNumber()
	local number1 = self:GetTeamWaves(1);
	local number2 = self:GetTeamWaves(2);
	return math.max(number1, number2);
end

function CombatActorManager:OnTeamFail( team )
	self.mTeams[team]:OnFailWave();
	self.mTeams[team == 1 and 2 or 1]:OnWinWave();
end

function CombatActorManager:OnActorDie(actor)
	self.mTeams[actor.mTeam]:OnActorDie(actor);
end

function CombatActorManager:OnActorRelive(actor)
	self.mTeams[actor.mTeam]:OnActorRelive(actor);
end

function CombatActorManager:CheckDianfengResult(  )
	local team1 = self.mTeams[1];
	local team2 = self.mTeams[2];
	if team1:IsAllTeamDead() or team2:IsAllTeamDead() then
		return  team1.mWinTimes >= team2.mWinTimes;
	else
		return nil;
	end
end

function CombatActorManager:OnBeginNextWave( team, wave )
	local combat = self.mCombat;
	local auto_mode = self.mAutoMode;
	
	if auto_mode == 1 then
		self.mTeams[team]:AddCombatActor(combat, wave);

	elseif auto_mode == 2 then
		local combat = self.mCombat;
		combat:DisposeTeam(1);
		combat:DisposeTeam(2);
	
		self.mTeams[1]:AddCombatActor(combat, wave);
		self.mTeams[2]:AddCombatActor(combat, wave);
	end
end

function CombatActorManager:GetTeamWavesActorNumber( team, wave )
	return  self.mTeams[team]:GetWavesActorNumber( wave );
end

function CombatActorManager:GetTeamWaves( team )
	return self.mTeams[team]:GetTeamWaves();
end

function CombatActorManager:GetTeamAllNumber(  team )
	return self.mTeams[team]:GetTeamAllNumber();
end

function CombatActorManager:GetTeamAliveNumber( team )
	return self.mTeams[team]:GetTeamAliveNumber();
end

function CombatActorManager:IsAllTeamDead( team )
	return self.mTeams[team]:IsAllTeamDead();
end

function CombatActorManager:GetKillMonsterRate(  )
	return self.mTeams[2]:GetKillMonsterRate();
end

function CombatActorManager:CheckKillIDMonsters( target, number )
	return self.mTeams[2]:CheckKillIDMonsters( target, number );
end

--初始所有战斗单位[有几波英雄都传进来]
function CombatActorManager:OnInitActors(self_list, enemy_list)
	self.mTeams[1]:OnInitActors(self_list);
	self.mTeams[2]:OnInitActors(enemy_list);
end

function CombatActorManager:ReliveTeam(team)
	self.mCombat:ReliveTeam(team);
	self.mTeams[team]:OnReliveWave();
end

function CombatActorManager:BeforeBeginCombat()
	local combat = self.mCombat;
	self.mTeams[1]:AddCombatActor(combat, 1);
	self.mTeams[2]:AddCombatActor(combat, 1);
end

function CombatActorManager:BeginCombat()
	self.mCombat:Start();
end

function CombatActorManager:OnCombatOver()
	self.mCombat:Stop();
end

function CombatActorManager:Dispose( )
	mBattleController:DestroyCombat();
end

return CombatActorManager;