local LuaClass = require "Core/LuaClass"
local SkillHit = require "Battle/Skill/SkillHit/SkillHit"
local RecoverHealthHit = LuaClass("RecoverHealthHit",SkillHit);
local mAttributeEnum = require "Enum/AttributeEnum"
local mSkillResultEnum = require "Enum/SkillResultEnum"

function RecoverHealthHit:OnLuaNew(skill,ratio)
	self.mBaseRatio = ratio or 0;
	self.mSkill = skill;
	self.mActor = skill.mOwner;
end

function RecoverHealthHit:DispatchBeforeCaculate()
	self:GetBattleController():BeforeActorTreat(self);
end

function RecoverHealthHit:DispatchAfterCaculate()
	self:GetBattleController():AfterActorTreat(self);
end

function RecoverHealthHit:CalculateBaseHurt(atk,def,extraBaseValue)
	if extraBaseValue then
		return extraBaseValue * self.mBaseRatio;
	end
	return def:GetHealthLimit() * self.mBaseRatio;
end

function RecoverHealthHit:CalculateFinalHurt(atk,def)
	return self.hurt * (1 + def:GetModifyAttribute(mAttributeEnum.RecoverRate,true));
end

function RecoverHealthHit:Calculate(atk,def,extraBaseValue)

	local hurt = self:CalculateBaseHurt(atk,def,extraBaseValue);
	self.hit = true;
	self.hurt = hurt;
	self.effect_hit_rate = 1;
end

function RecoverHealthHit:ResetTempAttribute(atk,def)
end

function RecoverHealthHit:ApplyResult(atk,def)

	local norecover = def:IsInStateNoRecover();
	local result = {};
	
	result.atk = atk;
	result.def = def;
	result.norecover = norecover;
	result.hurt = norecover and 0 or self:CalculateFinalHurt(atk,def);
	result.type = mSkillResultEnum.Recover;

	self:AddResult(result);
	self.mSkill:ShowRecoverEffect(def);
end

return RecoverHealthHit;