local NotifyEnum = {
	Position = "Position";
	Rotation = "Rotation";
	AttackBar = "AttackBarPersent";
	AddBuff = "AddBuff";
	RemoveBuff = "RemoveBuff";
	OnAddBuff = "OnAddBuff";
	OnRemoveBuff = "OnRemoveBuff";
	OnBuffUpdate = "OnBuffUpdate";
	Health = "HealthPersent";
	Animation = "Animation";
	LerpToRotation="LerpToRotation";
	OnToggleModel="OnToggleModel";
	OnOtherSelectSkill = "OnOtherSelectSkill";
	OnOtherUseSkill = "OnOtherUseSkill";
	OnSelectSkill = "OnSelectSkill";
	OnUseSkill = "OnUseSkill";
	OnBeKilled = "OnBeKilled";
	OnRelive = "OnRelive";
	OnClearStage = "OnClearStage";
	OnUpdateHealth = "OnUpdateHealth";
	OnUpdateHealthLimit = "OnUpdateHealthLimit";
	OnUpdateAttackBar = "OnUpdateAttackBar";
	OnModifyBuffTime = "OnModifyBuffTime";
	OnModifySkillCD = "OnModifySkillCD";
	OnAssist = "OnAssist";
	OnAssistCompleted = "OnAssistCompleted";
	OnAssistRequest = "OnAssistRequest";
	OnCounterAttack = "OnCounterAttack";
	OnSetCounterAttack = "SetCounterAttack";
	OnCounterAttackCompleted = "OnCounterAttackCompleted";
	OnCounterAttackRequest = "OnCounterAttackRequest";
	OnShowHitEffect = "OnShowHitEffect";
	AddExtraAttribute = "AddExtraAttribute";
	RemoveExtraAttribute = "RemoveExtraAttribute";
	OnEndRound = "OnEndRound";
	OnShieldReduceHurt = "OnShieldReduceHurt";
	OnOtherDie = "OnOtherDie";
-- attributes
    Attr_HealthLimit = 1;
	Attr_Attack = 2;
	Attr_Defense = 3;
	Attr_CritRate = 4;
	Attr_CritHurt = 5;
	Attr_EffectHitRate = 6;
	Attr_EffectResistRate = 7;
	Attr_AttackSpeed = 8;
	--特殊属
	Attr_AttackBar = 10100;
	Attr_Health = 20100;
	Attr_RecoverRate = 20101;
	Attr_Reverse = 20102;
	Attr_Reduce = 20103;
	Attr_Weakness = 20104;
	Attr_HitRate = 20105;
	Attr_CritResistRate = 20106;
	Attr_PoisonHurtRate = 20107;
-- combat event

 OnRemoveTargetState = 105;--消除敌人的正面状态时

 OnEnterCombat = 201;--加入战斗时
 OnCombatStart = 202;--战斗开始时
 OnStartRound = 203;--回合开始时

 BeforeOtherAttack =   204;--其他技能 攻击时，计算基础伤害前
 AfterOtherAttack = 205;--其他技能 攻击时，计算基础伤害后
 OnOtherReduceHealth =  206;--其他技能 攻击扣血时
 OnOtherCheckCombatKill = 207;--其他技能 判断击杀时

 BeforeOtherTreat = 208; -- 其他技能 治疗时，计算基础伤害前
 BeforeOtherPoison = 209;--其他技能 中毒时，计算基础伤害前
 BeforeOtherRecoverAttackBar = 210; -- 其他技能 恢复攻击条时

 OnReduceHealth = 301;--掉血时候
 OnAssistKill = 302;--联合击杀时
 OnCheckRelive = 303;--当判断自己死亡复活时
}

return NotifyEnum;