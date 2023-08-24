local LuaClass = require "Core/LuaClass"
local ReduceHealthHit = require "Battle/Skill/SkillHit/ReduceHealthHit"
local PoisonHit = LuaClass("PoisonHit",ReduceHealthHit);
local mAttributeEnum = require "Enum/AttributeEnum"

function PoisonHit:DispatchBeforeCaculate()
	self:GetBattleController():BeforeActorPoison(self);
end

function PoisonHit:CalculateFinalHurt(atk,def)
	return self.hurt * (1 + atk:GetModifyAttribute(mAttributeEnum.PoisonHurtRate,true)); 
end

return PoisonHit;