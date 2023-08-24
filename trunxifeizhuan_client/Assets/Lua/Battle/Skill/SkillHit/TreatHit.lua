local LuaClass = require "Core/LuaClass"
local SkillHit = require "Battle/Skill/SkillHit/SkillHit"
local TreatHit = LuaClass("TreatHit",SkillHit);
local mNotifyEnum = require "Enum/NotifyEnum"
local mAttributeEnum = require "Enum/AttributeEnum"
local mSkillResultEnum = require "Enum/SkillResultEnum"

function TreatHit:DispatchBeforeCaculate()
	self:GetBattleController():BeforeActorTreat(self);
end

function TreatHit:DispatchAfterCaculate()
	self:GetBattleController():AfterActorTreat(self);
end

function TreatHit:CalculateFinalHurt(atk,def)
	local hurt = self.hurt;
	if hurt > 0 then
		local recover_rate = def:GetModifyAttribute(mAttributeEnum.RecoverRate,true);
		hurt = hurt * (1+recover_rate);
	end
	return hurt;
end

function TreatHit:Calculate(atk,def,extraBaseValue)

	local config = self.mConfig;
	local actor = config.base_attribute == 0 and atk or def;
	local attribute1 = atk:GetModifyAttribute(config.attribute1,true);
	local attribute2 = actor:GetModifyAttribute(config.attribute2,true);

	local a = attribute1 * config.attribute_ratio1;
	local b = attribute2 * config.attribute_ratio2;
	local r = math.random(95,105)/100;
	local hurt = a*config.attack_ratio + b*config.skill_ratio;
	hurt = hurt * r;

	self.hit = true;
	self.hurt = hurt;
	self.effect_hit_rate = 1;
end

function TreatHit:ApplyResult(atk,def)

	local norecover = def:IsInStateNoRecover();
	local result = {};

	result.atk = atk;
	result.def = def;
	result.norecover = norecover;
	result.hurt =  norecover and 0 or self:CalculateFinalHurt(atk,def);
	result.type = mSkillResultEnum.Recover;
	self:AddResult(result);
	self.mSkill:ShowHitEffect(self.mIndex,def,false);
end

return TreatHit;