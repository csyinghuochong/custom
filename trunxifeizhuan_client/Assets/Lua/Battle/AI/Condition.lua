local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local Condition = LuaClass("Condition",BaseLua);
local mCompares = require "Battle/Compares";
local mGetTargetForAffectTrigger = require "Battle/Skill/GetTargetForAffectTrigger";
local mConfigSyscondition = require"ConfigFiles/ConfigSyscondition"

function Condition.GetCondition(id)
	return mConfigSyscondition[id];
end

function Condition.Compare(condition,value1,value2)	
	return mCompares[condition.compare](value1,value2);
end

function Condition.HaveBuffState(condition,target)
	return Condition.Compare(condition,target:ContainsState(condition.parameters) and 1 or -1,condition.compare_value);
end

function Condition.HaveBuffType(condition,target)
	return Condition.Compare(condition,target:HaveBuffType(condition.parameters[1]) and 1 or -1,condition.compare_value);
end

function Condition.CompareTargetDie(condition,target)
	return Condition.Compare(condition,target:IsAlive() and -1 or 1,condition.compare_value);
end

function Condition.CompareRestrain(condition,target1,target2)
	return false;
end

function Condition.CompareTargetHealth(condition,target)
	return Condition.Compare(condition,target:GetHealthPersent(),condition.compare_value/100);
end

function Condition.CompareTargetAttackBar(condition,target)
	return Condition.Compare(condition,target:GetAttackBarPersent(),condition.compare_value/100);
end

function Condition.CompareTargetCamp(condition,target)
	return Condition.Compare(condition,condition.parameters[target.mCamp] or -1,condition.compare_value);
end

function Condition.CompareBothAttribute(condition,target1,target2)
	return Condition.Compare(condition,target1:GetAttribute(attribute),target2:GetAttribute(condition.parameters[1])*condition.compare_value/100);
end

function Condition.CompareBeAttackCount(condition,target)
	return Condition.Compare(condition,target:GetBeAttackCount(),condition.compare_value);
end

function Condition.CompareBeRandomAttackCount(condition,target)
	return Condition.Compare(condition,target:GetBeRandomAttackCount(),condition.compare_value);
end

function Condition.CompareTarget(condition,target1,target2)
	local value = 2;
	if target1 == target2 then
		value = 0;
		elseif target1.mTeam == target2.mTeam then
			value = 1;
		end
	return Condition.Compare(condition,value,condition.compare_value);
end

function Condition:OnLuaNew()
	self:InitAffectConditions();
end

function Condition:InitAffectConditions()

	self.mAffectConditions = {

	    [100] = function (condition,skillHit) return self:AssertTargetBeforeExcute(condition,skillHit,Condition.HaveBuffState) end;
	    
		[102] = function (condition,skillHit) return self:AssertTargetBeforeExcute(condition,skillHit,Condition.HaveBuffType) end;

		[103] = function (condition,skillHit) return self:CompareCrit(condition,skillHit) end;

		[104] = function (condition,skillHit) return self:AssertTargetBeforeExcute(condition,skillHit,Condition.CompareTargetDie) end;

		[105] = function (condition,skillHit) return self:CurrentLessThanAndLastMoreThan(condition,skillHit) end;

		[106] = function (condition,skillHit) return self:AssertTargetBeforeExcute(condition,skillHit,Condition.CompareTargetHealth) end;

		[107] = function (condition,skillHit) return self:AssertTargetBeforeExcute(condition,skillHit,Condition.CompareTargetAttackBar) end;

		[108] = function (condition,skillHit) return self:AssertTargetBeforeExcute(condition,skillHit,Condition.CompareTargetCamp) end;

		[109] = function (condition,skillHit) return self:AssertTargetBeforeExcute(condition,skillHit,Condition.CompareTarget) end;

		[110] = function (condition,skillHit) return self:AssertTargetBeforeExcute(condition,skillHit,Condition.CompareRestrain) end;

		[111] = function (condition,skillHit) return self:AssertTargetBeforeExcute(condition,skillHit,Condition.CompareBothAttribute) end;

		[113] = function (condition,skillHit) return self:CompareHurtWithTargetHealthLimit(condition,skillHit) end;

		[115] = function (condition,skillHit) return self:AssertTargetBeforeExcute(condition,skillHit,Condition.CompareBeRandomAttackCount) end;

		[116] = function (condition,skillHit) return self:AssertTargetBeforeExcute(condition,skillHit,Condition.CompareBeAttackCount) end;

	};
end

function Condition:GetAffectCondition(type)
	return self.mAffectConditions[type];
end
-----------------------------------------------Conditions-----------------------------------------------------

function Condition:AssertTargetBeforeExcute(condition,skillHit,callback)
	local target = mGetTargetForAffectTrigger:GetTarget(condition.target,skillHit);
	if not target then
		Debugger.LogError(string.format("技能 = [%s] 的条件 [%s] 需要的目标不存在，条件类型=[%s] 目标类型=[%s]",skillHit.mSkill.mName,condition.key,condition.type,condition.target));
		return false;
	end
	return callback(condition.vo,target,skillHit.mSkill.mOwner);
end

function Condition:CompareCrit(condition,skillHit)
	local vo = condition.vo;
	return Condition.Compare(vo,skillHit.crit and 1 or -1,vo.compare_value);
end

function Condition:CurrentLessThanAndLastMoreThan(condition,skillHit)
	local reduceHealth = skillHit.reduceHealth or 0;
	local target = skillHit.mSkill.mOwner;

	local lastHealthPersent = (target:GetHealth() + reduceHealth)/target:GetHealthLimit();
	local healthPersent = target:GetHealthPersent();

	local vo = condition.vo;
	local x = vo.parameters[1]/100;
	local value = -1;
	if healthPersent < x and lastHealthPersent > x then
		value = 1;
	end

	return Condition.Compare(vo,value,vo.compare_value);
end 

function Condition:CompareHurtWithTargetHealthLimit(condition,skillHit)
	return self:AssertTargetBeforeExcute(condition,skillHit,function (vo,target)
		return Condition.Compare(vo,skillHit.hurt or 0,target:GetHealthLimit()*vo.compare_value/100);
	end);
end

return Condition.LuaNew();