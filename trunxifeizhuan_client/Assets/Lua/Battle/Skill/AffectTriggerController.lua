local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local AffectTriggerController = LuaClass("AffectTriggerController",BaseLua);
local mAffectTrigger = require"Battle/Skill/AffectTrigger"
local mCondition = require"Battle/AI/Condition"
local mTestBattle = require "Battle/Test/TestBattle";
local math = math;

function AffectTriggerController:GetCondition(index,condition)
	if not condition.vo then
		local vo = mCondition.GetCondition(condition.key);
		assert(vo,string.format("skill_trigger表配置错误，id = %d的condition不存在",condition.key));
		condition.vo = vo;
		condition.type = vo.type;
		condition.index = index;
	end
	return condition;
end

function AffectTriggerController:ExcuteAffect(affect,skillHit,trigger)
	local func = mAffectTrigger:GetAffect(affect.type);
	if func then
		func(affect,skillHit);
	end
	if mTestBattle:ShowDebugTips() then
		local msg = string.format("[%s] 触发效果[%s] -> 触发时机=[%s] 效果类型=[%s] 效果目标=[%s]",
			skillHit.mSkill.mName,trigger.describe,trigger.type,affect.type,affect.target);
		Debugger.LogWarning(msg);
	end
end

function AffectTriggerController:ExcuteAffects(trigger,skillHit)
	local affects = trigger.effects;
	local r = math.random(0,100);
	local p = trigger.probability * mAffectTrigger:GetEffectHitRate(skillHit,trigger.resistance < 1) + mTestBattle:GetAddAffectProbability();
	if r < p then
		for k,v in ipairs(affects) do
			self:ExcuteAffect(v,skillHit,trigger);
		end
		mAffectTrigger:Done();
	end
end

function AffectTriggerController:ExcuteCondition(condition,skillHit,trigger)
	local func = mCondition:GetAffectCondition(condition.type);
	if not func then
		return true;
	end

	local result = func(condition,skillHit);

	if mTestBattle:ShowDebugTips() then
		local msg = string.format("[%s] 在[%s]时 判断效果[%s]的第[%s]个触发条件 -> 条件=[%s] 条件类型=[%s] 条件目标=[%s] 结果=[%s]",
			skillHit.mSkill.mName,trigger.type,trigger.describe,condition.index,condition.key,condition.type,condition.target,result);
		Debugger.LogWarning(msg);
	end

	return result;
end

function AffectTriggerController:ExcuteConditions(trigger,skillHit)
	local conditions = trigger.conditions;
	if conditions then
		for k,v in ipairs(conditions) do
			local condition = self:GetCondition(k,v);
			if self:ExcuteCondition(condition,skillHit,trigger) == false then
				return false;
			end
		end
	end
	return true;
end

function AffectTriggerController:Excute(trigger,skillHit)
	mAffectTrigger:SetParams(skillHit);
	if self:ExcuteConditions(trigger,skillHit) then
		self:ExcuteAffects(trigger,skillHit);
	end
end

return AffectTriggerController.LuaNew();