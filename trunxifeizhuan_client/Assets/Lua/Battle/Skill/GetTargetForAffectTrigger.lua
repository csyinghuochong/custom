
local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local GetTargetForAffectTrigger = LuaClass("GetTargetForAffectTrigger",BaseLua);

function GetTargetForAffectTrigger:GetAttacker(skillHit)
	return skillHit and skillHit.atk or nil;
end

function GetTargetForAffectTrigger:GetDefender(skillHit)
    return skillHit and skillHit.def or nil;
end

function GetTargetForAffectTrigger:GetOwner(skillHit)
	return skillHit and skillHit.mSkill.mOwner or nil;
end

function GetTargetForAffectTrigger:GetTarget(targetType,skillHit)
	local target = nil;
	if targetType == 1 then
		target = self:GetOwner(skillHit);
		elseif targetType == 2 then
			target = self:GetDefender(skillHit);
			elseif targetType == 3 then
				target = self:GetAttacker(skillHit);
				elseif targetType == 4 then
					target = self:GetLowestHealth(self:GetOwner(skillHit));
					elseif targetType == 5 then
						target = self:GetLowestAttackBar(self:GetOwner(skillHit));
					end
	return target;
end

function GetTargetForAffectTrigger:GetLowestHealth(actor)
	local combat = actor:GetCombat();
	local getValueFunc = function (target,lastValue)
		local value = target:GetHealthPersent();
		if not lastValue or value < lastValue then
			return value;
		end
	end
	return combat:GetActorOfTeamByFunc(actor.mTeam,getValueFunc);
end

function GetTargetForAffectTrigger:GetLowestAttackBar(actor)
	local combat = actor:GetCombat();
	local getValueFunc = function (target,lastValue)
		local value = target:GetAttackBarPersent();
		if not lastValue or value < lastValue then
			return value;
		end
	end
	return combat:GetActorOfTeamByFunc(actor.mTeam,getValueFunc);
end

return GetTargetForAffectTrigger.LuaNew();