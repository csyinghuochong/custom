local LuaClass = require "Core/LuaClass"
local SkillHit = require "Battle/Skill/SkillHit/SkillHit"
local AttackHit = LuaClass("AttackHit",SkillHit);
local mAttributeEnum = require "Enum/AttributeEnum"
local mSkillResultEnum = require "Enum/SkillResultEnum"
local mSoundManager = require "Module/Sound/SoundManager"
local mConfigSyscamp_restriction = require"ConfigFiles/ConfigSyscamp_restriction"
local DebugHelper = DebugHelper;

function AttackHit:DispatchBeforeCaculate()
	self:GetBattleController():BeforeActorAttack(self);
end

function AttackHit:DispatchAfterCaculate()
	self:GetBattleController():AfterActorAttack(self);
end

function AttackHit:DispatchHitCompleted()
	self:GetBattleController():OnCheckCombatKill(self);
end

function AttackHit:CalculateFinalHurt(atk,def)
	local hurt_rate = atk:GetModifyAttribute(mAttributeEnum.HurtRate,true);
	local reduce_rate = def:GetModifyAttribute(mAttributeEnum.ReduceHurt,true,self:IgnoreBuffType(atk));
	local hurtLimit = atk:GetHitAttribute(mAttributeEnum.HurtLimit);

	local hurt = self.hurt * (1 + hurt_rate - reduce_rate) + atk:GetHitAttribute(mAttributeEnum.ExtraHurt);

	return hurtLimit and math.min(hurt,hurtLimit) or hurt;
end

function AttackHit:Calculate(atk,def,extraBaseValue)

	local config = self.mConfig;
	local actor = config.base_attribute == 0 and atk or def;

	local attribute1 = atk:GetModifyAttribute(config.attribute1,true);
	local attribute2 = actor:GetModifyAttribute(config.attribute2,true,actor == def and self:IgnoreBuffType(atk) or nil)

	local restriction = self:GetRestriction(atk,def);
	local weakness = def:GetModifyAttribute(mAttributeEnum.Weakness,true);

	local hit = self:CheckHit(atk,def,restriction.hit_rate);
	local crit = hit and self:CheckCrit(atk,def,restriction.crit_rate);
	local crit_hurt = crit and atk:GetModifyAttribute(mAttributeEnum.CritHurt,true) or 0;

	local defense = self:GetDefense(atk,def) * config.defense_ratio;
	local a = attribute1 * config.attribute_ratio1;
	local b = attribute2 * config.attribute_ratio2;
	local skill_ratio = config.skill_ratio + atk:GetHitAttribute(mAttributeEnum.ExtraSkillRatio);
	local attack_hurt = a*a*config.attack_ratio/(a+defense);
	local skill_hurt = b*b*skill_ratio/(b+defense);

	local hurt = (attack_hurt + skill_hurt) * (1 + restriction.skill_ratio ) * ( 1 + weakness) * (1 + crit_hurt);
	hurt = hurt*math.random(95,105)/100;

	--print(string.format("defense = %s a = %s b = %s skill_ratio = %s,attack_hurt = %s,skill_hurt = %s,hurt = %s",defense,a,b,skill_ratio,attack_hurt,skill_hurt,hurt));

	self.hit = hit;
	self.crit = crit;
	self.restrain = restriction.restrain;
	self.hurt = hurt;
	self.effect_hit_rate = self:GetEffectHitRate(atk,def);
end

function AttackHit:IgnoreBuffType(actor)
	return actor:GetHitAttribute(mAttributeEnum.IgnoreBuffType);
end

function AttackHit:GetDefense(atk,def)
	if atk:GetHitAttribute(mAttributeEnum.IgnoreDefense) then
		return 0;
	end
	return def:GetModifyAttribute(mAttributeEnum.Defense,true,self:IgnoreBuffType(atk));
end

function AttackHit:GetAlwaysRestriction()
	local restriction = self.mAlwaysRestriction;
	if not restriction then
		local vo = mConfigSyscamp_restriction["-1_-1"];
		restriction = {};
		restriction.restrain = true;
		restriction.skill_ratio = vo.skill_ratio;
		restriction.crit_rate = vo.crit_rate;
		restriction.hit_rate = 0;
		self.mAlwaysRestriction = restriction;
	end
	return restriction;
end

function AttackHit:GetRestriction(atk,def)

	if atk:GetHitAttribute(mAttributeEnum.IgnoreDefense) then
		return self:GetAlwaysRestriction();
	end

	local atkCamp = atk.mCamp;
	local defCamp = def.mCamp;
	local restriction = {};

	local atkRestriction = mConfigSyscamp_restriction[atkCamp.."_"..defCamp];
	local defRestriction = mConfigSyscamp_restriction[defCamp.."_"..atkCamp];

	restriction.restrain = atkRestriction ~= nil;
	restriction.skill_ratio = atkRestriction and atkRestriction.skill_ratio or 0;
	restriction.crit_rate = atkRestriction and atkRestriction.crit_rate or 0;
	restriction.hit_rate = defRestriction and defRestriction.hit_rate or 0;

	return restriction;
end

function AttackHit:GetEffectHitRate(atk,def)
	local effect_hit_rate = atk:GetModifyAttribute(mAttributeEnum.EffectHitRate,true);
	local effect_resist_rate = def:GetModifyAttribute(mAttributeEnum.EffectResistRate,true,self:IgnoreBuffType(atk));
	return (1+ effect_hit_rate) / (1 + effect_resist_rate);
end

function AttackHit:CheckHit(atk,def,restriction_hit_rate)
	local hit_rate = atk:GetModifyAttribute(mAttributeEnum.HitRate,true) - restriction_hit_rate;
	return math.random(1,100) < hit_rate * 100;
end

function AttackHit:CheckCrit(atk,def,restriction_crit_rate)
	if atk:GetHitAttribute(mAttributeEnum.MakeSureCrit) or DebugHelper.sMakeSureCrit then
		return true;
	end
	local crit_rate = atk:GetModifyAttribute(mAttributeEnum.CritRate,true) + restriction_crit_rate;
	local crit_resist_rate = def:GetModifyAttribute(mAttributeEnum.CritResistRate,true,self:IgnoreBuffType(atk));
	return math.random(0,100) < (crit_rate - crit_resist_rate) * 100;
end

function AttackHit:ReverseHurt(atk,def,hurt)
	local reverse_rate = def:GetModifyAttribute(mAttributeEnum.ReverseHurt,true,self:IgnoreBuffType(atk));
	if reverse_rate > 0 and hurt > 0 then

		local result = {};
		result.atk = def;
		result.def = atk;
		result.hurt = self:ShieldReduceHurt(atk,reverse_rate*hurt);
		result.nohurt = atk:IsInStateNoHurt();
		result.type = mSkillResultEnum.Reverse;
		self:AddResult(result);
	end
end

function AttackHit:TransferHurt(atk,def,hurt)

	local transferComponent = def:GetComponent("TransferHurt");
	if not transferComponent then
		return hurt;
	end
	local transfer = transferComponent:GetTransfer();
	if not transfer then
		return hurt;
	end

	local result = {};
	result.atk = atk;
	result.def = transfer;
	result.hurt = self:ShieldReduceHurt(transfer,hurt * (1 - transferComponent:GetReduceRate()));
	result.nohurt = transfer:IsInStateNoHurt();
	result.type = mSkillResultEnum.Transfer;
	self:AddResult(result);

	return 0;
end

function AttackHit:DestroyHealthLimit(atk,def,hurt)
	local ratio = atk:GetHitAttribute(mAttributeEnum.DestroyHealthLimit);
	if ratio then
		local limit = def:GetHealthLimit() - def:GetBaseAttribute(mAttributeEnum.HealthLimit) * 0.6;
		if limit > 0 then
			return math.min(limit,ratio*hurt)
		end
	end
end

function AttackHit:ApplyResult(atk,def)

	local nohurt = def:IsInStateNoHurt() and not self:IgnoreBuffType(atk);
	local crit = self.crit;
	local hurt = nohurt and 0 or self:CalculateFinalHurt(atk,def);
	hurt = self:ShieldReduceHurt(def,hurt);
	hurt = self:TransferHurt(atk,def,hurt);

	local result = {};
	result.atk = atk;
	result.def = def;
	result.nohurt = nohurt;
	result.hurt = hurt;
	result.destroyHealthLimit = self:DestroyHealthLimit(atk,def,hurt);
	result.type = crit and mSkillResultEnum.Crit or mSkillResultEnum.Hurt;

	self:ReverseHurt(atk,def,hurt);
	self:AddResult(result);

	atk:SaveLastAttackResult(result);
	def:SaveLastBeAttackResult(result);

	local skill = self.mSkill;
	skill:Shake(crit);
	skill:ShowHitEffect(self.mIndex,def,atk~=def);
	mSoundManager:PlayHitEffectSound(self);
end

return AttackHit;