local LuaClass = require "Core/LuaClass"
local SkillHit = require "Battle/Skill/SkillHit/SkillHit"
local ReduceHealthHit = LuaClass("ReduceHealthHit",SkillHit);
local mSkillResultEnum = require "Enum/SkillResultEnum"

function ReduceHealthHit:OnLuaNew(skill,ratio)
	self.mBaseRatio = ratio or 0;
	self.mSkill = skill;
	self.mActor = skill.mOwner;
end

function ReduceHealthHit:CalculateBaseHurt(atk,def,extraBaseValue)
	if extraBaseValue then
		return extraBaseValue * self.mBaseRatio;
	end
	return def:GetHealthLimit() * self.mBaseRatio;
end

function ReduceHealthHit:CalculateFinalHurt(atk,def)
	return self.hurt;
end

function ReduceHealthHit:Calculate(atk,def,extraBaseValue)
	local hurt = self:CalculateBaseHurt(atk,def,extraBaseValue);
	self.hit = true;
	self.hurt = hurt;
	self.effect_hit_rate = 1;
end

function ReduceHealthHit:ResetTempAttribute(atk,def)
end

function ReduceHealthHit:ApplyResult(atk,def)

	local nohurt = def:IsInStateNoHurt();
	local hurt = nohurt and 0 or self:CalculateFinalHurt(atk,def);
	local result = {};
	result.atk = atk;
	result.def = def;
	result.nohurt = nohurt;
	result.hurt = self:ShieldReduceHurt(def,hurt);
	result.type = mSkillResultEnum.Hurt;

	self:AddResult(result);

	--消耗自己的生命对敌人造成伤害需要保存所消耗的生命值
	if atk == def then
		def:SaveLastBeAttackResult(result);
	end
end

return ReduceHealthHit;