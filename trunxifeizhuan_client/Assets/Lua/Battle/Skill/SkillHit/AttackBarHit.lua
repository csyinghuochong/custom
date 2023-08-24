local LuaClass = require "Core/LuaClass"
local SkillHit = require "Battle/Skill/SkillHit/SkillHit"
local AttackBarHit = LuaClass("AttackBarHit",SkillHit);
local mAttributeEnum = require "Enum/AttributeEnum"
local mSkillResultEnum = require "Enum/SkillResultEnum"

function AttackBarHit:OnLuaNew(skill,ratio)
	self.mBaseRatio = ratio or 0;
	self.mSkill = skill;
end

function AttackBarHit:DispatchBeforeCaculate()
	local value = self.mBaseRatio;
	if value > 0 and value < 1 then
		self:GetBattleController():BeforeActorRecoverAttackBar(self);
	end
end

function AttackBarHit:Excute(def,extraBaseValue)
	local atk = self.mSkill.mOwner;
	self:SetParams(atk,def);
	self:DispatchBeforeCaculate();
	self:ApplyResult(atk,def);
	self:DispatchHitResults();
end

function AttackBarHit:ApplyResult(atk,def)
	local value = self.mBaseRatio;
	if value > 0 and value < 1 then
		value = value * (1 + def:GetModifyAttribute(mAttributeEnum.RecoverAttackBarRate,true));
	end
	local result = {};
	result.atk = atk;
	result.def = def;
	result.value = value;
	result.type = mSkillResultEnum.ModifyAttackBar;
	self:AddResult(result);
end

return AttackBarHit;