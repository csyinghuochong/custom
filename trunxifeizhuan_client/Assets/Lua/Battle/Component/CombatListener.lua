local LuaClass = require "Core/LuaClass"
local ActorObserver = require "Battle/Component/ActorObserver"
local CombatObserver = require"Battle/Combat/CombatObserver"
local CombatListener = LuaClass("CombatListener",ActorObserver);
local mNotifyEnum = require"Enum/NotifyEnum"
local mBattleEventEnum = require "Enum/BattleEventEnum"

function CombatListener:Awake()

	self:RegisterListener(mNotifyEnum.OnBeKilled,function ()
		self:RemoveCombatListeners();
	end);
	self:RegisterListener(mNotifyEnum.OnRelive,function ()
		self:AddCombatListeners();
	end);

	self.mCombatObserver = CombatObserver.LuaNew(self:GetActor().mCombat);
	self:AddCombatListeners();
end

function CombatListener:AddCombatListeners()
	local combatObserver = self.mCombatObserver;
	combatObserver:RegisterListener(mBattleEventEnum.ON_ACTOR_SELECT_SKILL,function (skill)
		self:GetActor():Notify(mNotifyEnum.OnOtherSelectSkill,skill);
	end);
	combatObserver:RegisterListener(mBattleEventEnum.ON_ACTOR_USE_SKILL,function (skill)
		self:GetActor():Notify(mNotifyEnum.OnOtherUseSkill,skill);
	end);
	combatObserver:RegisterListener(mBattleEventEnum.COMBAT_START,function ()
		self:GetActor():OnCombatStart();
	end);
	combatObserver:RegisterListener(mBattleEventEnum.COMBAT_CLEAR_STAGE,function (params)
		self:GetActor():Notify(mNotifyEnum.OnClearStage,params);
	end);

	combatObserver:RegisterListener(mBattleEventEnum.BEFORE_ACTOR_ATTACK,function (skillHit)
		self:GetActor():Notify(mNotifyEnum.BeforeOtherAttack,skillHit);
	end);

	combatObserver:RegisterListener(mBattleEventEnum.AFTER_ACTOR_ATTACK,function (skillHit)
		self:GetActor():Notify(mNotifyEnum.AfterOtherAttack,skillHit);
	end);

	combatObserver:RegisterListener(mBattleEventEnum.BEFORE_ACTOR_TREAT,function (skillHit)
		self:GetActor():Notify(mNotifyEnum.BeforeOtherTreat,skillHit);
	end);
	
	combatObserver:RegisterListener(mBattleEventEnum.BEFORE_ACTOR_POISON,function (skillHit)
		self:GetActor():Notify(mNotifyEnum.BeforeOtherPoison,skillHit);
	end);

	combatObserver:RegisterListener(mBattleEventEnum.BEFORE_ACTOR_RECOVER_ATTACK_BAR,function (skillHit)
		self:GetActor():Notify(mNotifyEnum.BeforeOtherRecoverAttackBar,skillHit);
	end);

	combatObserver:RegisterListener(mBattleEventEnum.ON_ACTOR_CHECK_COMBAT_KILL,function (skillHit)
		self:GetActor():Notify(mNotifyEnum.OnOtherCheckCombatKill,skillHit);
	end);

	combatObserver:RegisterListener(mBattleEventEnum.ON_ACTOR_DEAD,function (actor)
		self:GetActor():Notify(mNotifyEnum.OnOtherDie,actor);
	end);
end

function CombatListener:RemoveCombatListeners()
	local combatObserver = self.mCombatObserver;
	if combatObserver then
		combatObserver:RemoveCombatListeners();
	end
end

function CombatListener:Dispose()
	self:RemoveCombatListeners();
end

return CombatListener;