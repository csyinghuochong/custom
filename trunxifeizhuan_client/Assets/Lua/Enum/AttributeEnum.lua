
local AttributeEnum = {

    HealthLimit = 1;
	Attack = 2;
	Defense = 3;
	CritRate = 4;
	CritHurt = 5;
	EffectHitRate = 6;
	EffectResistRate = 7;
	AttackSpeed = 8;
	
	--特殊属
	AttackBar = 10100;
	Health = 20100;
	RecoverRate = 20101;--治疗效果
	ReverseHurt = 20102;--反伤
	ReduceHurt = 20103;--减伤
	Weakness = 20104;--弱点
	HitRate = 20105;--精准
	CritResistRate = 20106;--暴击抵抗
	PoisonHurtRate = 20107;--中毒效果
	RecoverAttackBarRate = 20108;--恢复攻击条效果
	HurtRate = 20109;--伤害效果

	--临时Hit属性
	ExtraSkillRatio = "ExtraSkillRatio";
	IgnoreDefense = "IgnoreDefense";
	IgnoreCamp = "IgnoreCamp";
	IgnoreBuffType = "IgnoreBuffType";
	HurtLimit = "HurtLimit";
	DestroyHealthLimit = "DestroyHealthLimit";
	ExtraHurt = "ExtraHurt";

}
	
return AttributeEnum;