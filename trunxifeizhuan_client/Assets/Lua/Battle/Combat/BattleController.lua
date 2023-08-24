local mLuaClass = require "Core/LuaClass"
local mBaseController = require "Core/BaseController"
local BattleController = mLuaClass("BattleController",mBaseController);
local mEventEnum = require "Enum/EventEnum"
local mBattleEventEnum = require "Enum/BattleEventEnum"
local Combat = require "Battle/Combat/Combat"
local mTestBattle = require "Battle/Test/TestBattle";

function BattleController:AddEventListeners()
end

function BattleController:CreateCombat(combatId)
	local combat = Combat.LuaNew(combatId);
	combat:Init();
	self.mCombat = combat;
	self:Dispatch(mEventEnum.ON_CREATE_COMBAT,combat);
	return combat;
end

function BattleController:DestroyCombat(combat)
	local combat = self.mCombat;
	if combat then
		combat:Dispose();
		self.mCombat = nil;
		self:Dispatch(mEventEnum.ON_DESTROY_COMBAT,combat);
	end
end

function BattleController:BeforeActorAttack(skillHit)
	self.mCombat:Notify(mBattleEventEnum.BEFORE_ACTOR_ATTACK,skillHit);
end

function BattleController:AfterActorAttack(skillHit)
	self.mCombat:Notify(mBattleEventEnum.AFTER_ACTOR_ATTACK,skillHit);
end

function BattleController:BeforeActorTreat(skillHit)
	self.mCombat:Notify(mBattleEventEnum.BEFORE_ACTOR_TREAT,skillHit);
end

function BattleController:AfterActorTreat(skillHit)
	self.mCombat:Notify(mBattleEventEnum.AFTER_ACTOR_TREAT,skillHit);
end

function BattleController:BeforeActorPoison(skillHit)
	self.mCombat:Notify(mBattleEventEnum.BEFORE_ACTOR_POISON,skillHit);
end

function BattleController:BeforeActorRecoverAttackBar(skillHit)
	self.mCombat:Notify(mBattleEventEnum.BEFORE_ACTOR_RECOVER_ATTACK_BAR,skillHit);
end

function BattleController:OnCheckCombatKill(skillHit)
	self.mCombat:Notify(mBattleEventEnum.ON_ACTOR_CHECK_COMBAT_KILL,skillHit);
end

function BattleController:SendHitResults()
    self.mCombat:SendHitResults();
end

function BattleController:AddSkillResult(result)
	self.mCombat:AddSkillResult(result);
end

return BattleController.LuaNew();