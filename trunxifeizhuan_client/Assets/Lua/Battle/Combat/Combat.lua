local LuaClass = require "Core/LuaClass"
local EventInterface = require "Events/EventInterface"
local Observable = require "Core/Observable"
local Combat = LuaClass("Combat",Observable);
local CombatRound = require "Battle/Combat/CombatRound";
local BattleView = require "Battle/Combat/BattleView";
local PlayerController = require "Battle/Combat/PlayerController"
local AIController = require "Battle/Combat/AIController"
local Team = require "Battle/Combat/Team"
local Actor = require "Battle/Actor"
local List = require "Common/List"
local Queue = require "Common/Queue"
local mSkillHitResult = require"Battle/Skill/SkillHitResult";

local mEventEnum = require "Enum/EventEnum"
local mBattleEventEnum = require "Enum/BattleEventEnum"
local mNotifyEnum = require"Enum/NotifyEnum"
local pairs = pairs;
local ipairs = ipairs;
local table = table;
local Debugger = Debugger;
local DebugHelper = DebugHelper;
local mIsEditor = UnityEngine.Application.isEditor;

function Combat:OnLuaNew(id)
	self.mId = id;

	self.mUnRealActors = List.LuaNew();
	self.mAliveActors = List.LuaNew();
	self.mDeadActors = List.LuaNew();
	self.mAllDieTeams = List.LuaNew();
	self.mResults = List.LuaNew();

	self.mTeams = {};


	self.mEventInterface = EventInterface.LuaNew();
	self.mCombatRound = CombatRound.LuaNew(self);
	self.mBattleView = BattleView.LuaNew(self);
	self.mPlayerController = PlayerController.LuaNew(self);
	self.mAIController = AIController.LuaNew(self);
end

function Combat:Init()
	self:AddEventListeners();
	self.mCombatRound:Awake();
	self.mBattleView:Awake();
	self.mPlayerController:Awake();
	self.mAIController:Awake();
	self:AddTeam(1);
	self:AddTeam(2);
end

function Combat:Dispose()
	self:RemoveEventListeners();
	self.mCombatRound:Dispose();
	self.mBattleView:Dispose();
	self.mPlayerController:Dispose();
	self.mAIController:Dispose();
	self:DisposeUnRealActors();
	self:DisposeTeam(1);
	self:DisposeTeam(2);
	self.mTeams = nil;
	self.mUnRealActors = nil;
end

function Combat:AddTeam(index)
	self.mTeams[index] = Team.LuaNew(self,index);
end

function Combat:LogEvent(type)
	if mIsEditor and DebugHelper.sLogCombat then
		Debugger.LogWarning("[BATTLE_EVENT]--------------->"..type);
	end
end

function Combat:AddEventListeners()
	local eventInterface = self.mEventInterface;
	eventInterface:RegisterEventListener(mEventEnum.ON_ACTOR_DEAD,function (actor)
		self:OnActorDie(actor);
	end);
	eventInterface:RegisterEventListener(mEventEnum.ON_ACTOR_RELIVE,function (actor)
		self:OnActorRelive(actor);
	end);
	eventInterface:RegisterEventListener(mEventEnum.ON_ACTOR_SELECT_SKILL,function (skill)
		self:Notify(mBattleEventEnum.ON_ACTOR_SELECT_SKILL,skill);
	end);
	eventInterface:RegisterEventListener(mEventEnum.ON_ACTOR_USE_SKILL,function (skill)
		self:Notify(mBattleEventEnum.ON_ACTOR_USE_SKILL,skill);
	end);
	eventInterface:RegisterEventListener(mEventEnum.ON_FINISH_ROUND,function (actor)
		self:OnFinishRound();
	end);
	eventInterface:RegisterEventListener(mEventEnum.ON_START_ROUND,function (actor)
		self:Notify(mBattleEventEnum.ON_START_ROUND,actor);
	end);
	eventInterface:RegisterEventListener(mEventEnum.ON_CLEAR_ROUND,function ()
		self:OnClearRound();
	end);
end

function Combat:RemoveEventListeners()
	self.mEventInterface:RemoveEventListeners();
end

function Combat:Dispatch(eventType,params)
	self.mEventInterface:Dispatch(eventType,params);
end
function Combat:CreateActor(actorVo)
	local actor = Actor.LuaNew();
	actor:Init(actorVo,false);
	actor:EnterCombat(self);
	
	self.mTeams[actor.mTeam]:OnCreateActor(actor);
	self:Dispatch(mEventEnum.ON_ACTOR_BORN,actor);
	return actor;
end

function Combat:CreateUnRealActor(actorVo)
	local actor = Actor.LuaNew();
	actor:Init(actorVo,true);
	actor:EnterCombat(self);

	self.mUnRealActors:Add(actor);
	self:Dispatch(mEventEnum.ON_ACTOR_BORN,actor);
	return actor;
end

function Combat:OnRemoveUnrealActor(actor)
	self.mUnRealActors:Remove(actor);
end

function Combat:OnAddAliveActor(actor)
	self.mAliveActors:Insert(actor);
end

function Combat:OnRemoveAliveActor(actor)
	self.mAliveActors:Remove(actor);
end

function Combat:OnAddDeadActor(actor)
	self.mDeadActors:Insert(actor);
end

function Combat:OnRemoveDeadActor(actor)
	self.mDeadActors:Remove(actor);
end

function Combat:ReliveTeam(team)
	self.mTeams[team]:ReliveAll();
	self:Start();
end

function Combat:OnActorRelive(actor)
	self.mTeams[actor.mTeam]:OnActorRelive(actor);
	self:Notify(mBattleEventEnum.ON_ACTOR_RELIVE,actor);
end

function Combat:OnActorDie(actor)
	self.mTeams[actor.mTeam]:OnActorDie(actor);
	self:Notify(mBattleEventEnum.ON_ACTOR_DEAD,actor);
end

function Combat:IsTeamAllDie(team)
	return self:GetAliveActorsOfTeam(team).mLength == 0;
end

function Combat:Start()
	self.mStart = true;
	self:Notify(mBattleEventEnum.COMBAT_START);
end

function Combat:Stop()
	self.mStart = false;
	self:Notify(mBattleEventEnum.COMBAT_STOP);
end

function Combat:ClearStage(params,wave,aceTeam,autoMode)
	self:Notify(mBattleEventEnum.COMBAT_CLEAR_STAGE,params);
	local teams = self.mTeams;
	if autoMode == 2 then
		teams[1]:DisposeDeadActors();
		teams[2]:DisposeDeadActors();
	else
		teams[aceTeam]:DisposeDeadActors();
	end
end

function Combat:GetActorOfTeamByFunc(team,getValueFunc)
	local teamActors = self:GetAliveActorsOfTeam(team);
	local actor = nil;
	if teamActors then
		local actors = teamActors.mData;
		local lastValue = nil;
		for k,v in ipairs(actors) do
			local temp = getValueFunc(v,lastValue);
			if temp then
				actor = v;
				lastValue = temp;
			end
		end
	end
	return actor;
end

function Combat:DisposeTeam( team )
	self.mTeams[team]:Dispose();
end

function Combat:DisposeUnRealActors()
	local list = self.mUnRealActors;
	if list then
		local callback = function (actor)
		    actor:Dispose();
		    self:OnRemoveUnrealActor(actor);
		end
		list:ReForeach(callback);
	end
end

function Combat:GetAliveActorsOfTeam(team)
	return self.mTeams[team]:GetAliveActors();
end

function Combat:GetDeadActorsOfTeam(team)
	return self.mTeams[team]:GetDeadActors();
end

function Combat:GetTotalActorsOfTeam(team)
	return self.mTeams[team]:GetTotalActors();
end

function Combat:GetAliveActors()
	return self.mAliveActors;
end

function Combat:GetDeadActors()
	return self.mDeadActors;
end

function Combat:GetUnrealActors()
	return self.mUnRealActors;
end

function Combat:GetSelectedTarget()
	return self.mPlayerController:GetSelectedTarget();
end

function Combat:IsAutoAttack()
	return self.mPlayerController:IsAutoAttack();
end

function Combat:GetCurrentActor()
	return self.mCombatRound.mCurrent;
end
--for test
function Combat:ForceTurnToActor(a)
	self.mCombatRound:ForceTurnToActor(a);
end

function Combat:DoKillResult(result)
	local target = result.def;
	local team = target.mTeam;
	target:OnBeKilled();
	target:CheckRelive();
	self:Dispatch(mEventEnum.COMBAT_KILL,result);
	if self:IsTeamAllDie(team) then
		self.mAllDieTeams:Insert(team);
	end
end

function Combat:AddKillResult(result)
	local killResults = self.mKillResults;
	if not killResults then
		killResults = {};
		self.mKillResults = killResults;
	end

	local actor = result.def;
	if not killResults[actor] then
		killResults[actor] = result;
	end
end

function Combat:OnClearRound()
	local killResults = self.mKillResults;
	if killResults then
		for k,v in pairs(killResults) do
		    self:DoKillResult(v);
		end
		self.mKillResults = nil;
	end
end

function Combat:OnFinishRound()
	local allDieTeams = self.mAllDieTeams;
	if allDieTeams:GetLen() > 0 then
		allDieTeams:Foreach(function (team)
			self:Dispatch(mEventEnum.ON_WAVE_ALL_DIE,team);
		end);
		allDieTeams:Clear();
	end
	
	self:Notify(mBattleEventEnum.ON_FINISH_ROUND,actor);
end

function Combat:AddSkillResult(result)
	self.mResults:Add(result);
end

function Combat:SendHitResults()
	local results = self.mResults;
	while (results:GetLen() > 0) do
		local result = results:GetValue(1);
		results:RemoveAt(1);
		mSkillHitResult:ExcuteResult(result);
	end
end

return Combat;