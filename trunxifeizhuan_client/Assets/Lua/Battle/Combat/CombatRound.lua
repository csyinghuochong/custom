local LuaClass = require "Core/LuaClass"
local GameTimer = require "Core/Timer/GameTimer"
local CombatObserver = require"Battle/Combat/CombatObserver"
local CombatRound = LuaClass("CombatRound",CombatObserver);
local mBattleEventEnum = require "Enum/BattleEventEnum"
local mAttributeEnum = require "Enum/AttributeEnum"
local pairs = pairs;

function CombatRound:AddCombatListeners()

	self:RegisterListener(mBattleEventEnum.ON_START_ROUND,function ()
		self:OnRoundStart();
	end);

	self:RegisterListener(mBattleEventEnum.ON_FINISH_ROUND,function ()
		self:OnRoundFinish();
	end);

	self:RegisterListener(mBattleEventEnum.ON_PLAYER_SET_AUTO_COMBAT,function (autoAttack)
		self:HandleAutoAttack(autoAttack);
	end);

	self:RegisterListener(mBattleEventEnum.ON_PLAYER_SELECT_SKILL,function (skill)
		self:OnSelectSkill(skill.mOwner,skill.mIndex);
	end);

	self:RegisterListener(mBattleEventEnum.COMBAT_START,function ()
		self:Start();
	end);

	self:RegisterListener(mBattleEventEnum.COMBAT_STOP,function ()
		self:Stop();
	end);

	self:RegisterListener(mBattleEventEnum.ON_PLAYER_PICK_ACTOR,function (actor)
		self:HandlePickActor(actor);
	end);

	self:RegisterListener(mBattleEventEnum.ON_AI_SELECT_SKILL,function (index)
		self:OnSelectSkill(self.mCurrent,index);
	end);
	self:RegisterListener(mBattleEventEnum.ON_AI_SELECT_TARGET,function (target)
		self:OnSelectTarget(self.mCurrent,target);
	end);
end

function CombatRound:Awake()
	self:AddCombatListeners();
end

function CombatRound:Dispose()
	self:Stop();
	self:RemoveCombatListeners();
end

function CombatRound:HandleAutoAttack(autoAttack)
	if autoAttack then
		local current = self.mCurrent;
		if self:IsPlayerTurn(current) then
			self:BeginAIDoRound(current);
		end
	end
end

function CombatRound:HandlePickActor(actor)
	local current = self.mCurrent;
	if self:IsPlayerTurn(current) then
		self:OnActorUseSkill(current,actor);
	end
end

function CombatRound:IsPlayerTurn(current)
	if not current then
		return false;
	end
	if current.mIsRoundDone then
		return false;
	end
	return current:IsPlayerControl();
end

function CombatRound:IsActorTurn(actor)
	local current = self.mCurrent;
	if not current or actor ~= current then
		return false;
	end
	if current.mIsRoundDone then
		return false;
	end
	return true;
end

function CombatRound:OnSelectSkill(actor,index)
	if self:IsActorTurn(actor) then
		actor:OnSelectSkill(index);
	end
end

function CombatRound:OnSelectTarget(actor,target)
	if self:IsActorTurn(actor) then
		self:OnActorUseSkill(actor,target);
	end
end
-------------------Log Message-------------------------------------------------------
local mLogMessage = "[%s]选择的目标无效,攻击者状态->(%s),目标状态->(%s)";

local function GetAtkState(atk)
	if atk then
		return string.format("攻击者=[%s],是否处于嘲讽状态=[%s] 是否处于混乱状态 = [%s]",atk.mName,atk:IsInState2012(),atk:IsInState2022());
	else
		return "不存在的攻击者";
	end
end

local function GetTargetState(target)
	if target then
		return string.format("目标=[%s],是否活着=[%s] 是否处于隐身状态 = [%s]",target.mName,target:IsAlive(),target:IsInState1015());
	else
		return "不存在的目标";
	end
end
--------------------------------------------------------------------------

function CombatRound:OnActorUseSkill(actor,target)
	if actor:CanSelectTarget(target) then
		actor:OnUseSkill(target);
	else
		Debugger.LogError(string.format(mLogMessage,actor:GetSelectedSkill().mName,GetAtkState(actor),GetTargetState(target)));
	end
end

function CombatRound:Start()
	self:TurnRound();
	self:DisposeWaitForTurnRound();
end

function CombatRound:DisposeWaitForTurnRound()
	local wait = self.mWaitForTurnRound;
	if wait then
		wait:Dispose();
		self.mWaitForTurnRound = nil;
	end
end

function CombatRound:Stop()
	self.mCurrent = nil;
	self:DisposeWaitForTurnRound();
end

function CombatRound:GetTimeToFullAttackBar(actor)
	return (actor:GetAttackBarLimit() - actor:GetAttackBar())/actor:GetAttribute(mAttributeEnum.AttackSpeed);
end

function CombatRound:AddAttackBarByTime(actor,t)
	local addValue = actor:GetAttribute(mAttributeEnum.AttackSpeed) * t;
	actor:Notify(actor:GetNotifyEnum().OnUpdateAttackBar,actor:GetAttackBar() + addValue);
end

function CombatRound:TurnRound()

	local combat = self:GetCombat();
	if combat:IsTeamAllDie(1) or combat:IsTeamAllDie(2) then
		return;
	end

	local current = nil;
	local time = 100000;
	local actors = combat:GetAliveActors();
	local unrealActors = combat:GetUnrealActors();

	local getCurrent = function (actor)
		local temp = self:GetTimeToFullAttackBar(actor);
		if temp < time then
			time = temp;
			current = actor;
		end
	end
	actors:Foreach(getCurrent);
	unrealActors:Foreach(getCurrent);

	current = self.mForceTurnToActor or current;
	
	self.mCurrent = current;
	self.mForceTurnToActor = nil;

	if time > 0 then
		local addAttackBar = function (actor)
		   self:AddAttackBarByTime(actor,time)
		end
		actors:Foreach(addAttackBar);
		unrealActors:Foreach(addAttackBar);
	end

	if current then
		current:StartRound();
	end
	
end

function CombatRound:BeginAIDoRound(current)
	self:GetCombat():Notify(mBattleEventEnum.ON_AI_DOROUND,current);
end

function CombatRound:OnRoundStart()
	local current = self.mCurrent;
	if current:IsDisableDoRound() then
		current:EndRound();
		elseif current:IsPlayerControl() == false then
			self:BeginAIDoRound(current);
		end
end

function CombatRound:OnRoundFinish()
	self.mCurrent = nil;
	local callback = function ()
		self:TurnRound();
		self.mWaitForTurnRound = nil;
	end 

	local delay = self.mForceTurnToActor and 0 or 0.5;
	self.mWaitForTurnRound = GameTimer.HandSetTimeout(delay,callback,false,true);
end

function CombatRound:ForceTurnToActor(actor)
	self.mForceTurnToActor = actor;
	local current = self.mCurrent;
	if current then
		current:EndRound();
	end
end

return CombatRound;