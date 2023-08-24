local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local Search = LuaClass("Search",BaseLua);
local ipairs = ipairs;
local pairs = pairs;
local mCompares = require "Battle/Compares";
local mBuffStateEnum = require"Enum/BuffStateEnum";
local Condition = require"Battle/AI/Condition"

local mConditions = {
	[10101] = Condition.HaveBuffType;
	[10201] = Condition.HaveBuffState;
	[10601] = Condition.CompareTargetHealth;
}

function Search:ExcuteCondition(condition,target)
	if not condition then
		return true;
	end
	
	local func = mConditions[condition.type];
	return not func or func(condition,target);
end

function Search:ExcuteConditions(conditions,target)

	for k,v in ipairs(conditions) do
		if self:ExcuteCondition(Condition.GetCondition(v),target) == false then
			return false;
		end
	end

	return true;
end

function Search:SearchTarget(targets,conditions)

	if not conditions then
		return true;
	end

	for k,v in pairs(targets) do
		if self:ExcuteConditions(conditions,v) then
			return true;
		end
	end

	return false;
end

function Search:Search(targets,ai)
	if not targets then
		return false;
	end

	local searches = nil;
	if ai then
		searches = ai.searches;
	end

	if not searches then
		return targets[1];
	end

	for k,v in ipairs(searches) do
		if self:SearchTarget(targets,v.conditions) then
			return true;
		end
	end

	return false;
end

--状态分 1 = 友方， 2 = 敌方
local mStateScores = {
	[mBuffStateEnum.State2002] = {20,4};
	[mBuffStateEnum.State2024] = {20,4};
}
local mHealthScores1 = {{0.25,20};{0.50,10};{0.85,6};{1.00,2}};--友方
local mHealthScores2 = {{0.25,16};{0.50,8};{0.85,4};{1.00,2}};--敌方
local mRestrainScores = {8,2};--克制分，1 = 克制，2 = 被克制

--克制关系
local function CalculateScore_100(skill,target)
	local restrain = skill:Restrain(target);
	return mRestrainScores[restrain] or 0;
end

local function CalculateScoreByState(skill,target,state)
	local scores = mStateScores[state];
	if scores then
		if target:ContainsState(state) then
			if target.mTeam == skill.mOwner.mTeam then
				return scores[1];
			else
				return scores[2];
			end
		end
	end
	return 0;
end
--破甲
local function CalculateScore_110(skill,target)
	return CalculateScoreByState(skill,target,mBuffStateEnum.State2002);
end
--弱点
local function CalculateScore_111(skill,target)
	return CalculateScoreByState(skill,target,mBuffStateEnum.State2024);
end

local function CalculateScoreByHealth(hp,values)
	for i,v in ipairs(values) do
		if hp < v[1] then
			return v[2];
		end
	end
	return 0;
end

--体力
local function CalculateScore_120(skill,target)
	local hp = target:GetHealthPersent();
	if target.mTeam == skill.mOwner.mTeam then
		return CalculateScoreByHealth(hp,mHealthScores1);
	else
		return CalculateScoreByHealth(hp,mHealthScores2);
	end
	return 0;
end

local mScoreCalculators = {
	[100] = CalculateScore_100;
	[110] = CalculateScore_110;
	[111] = CalculateScore_111;
	[120] = CalculateScore_120;
}

function Search:CalculateScore(target,skill,items)
	local score = 0;
	for k,v in ipairs(items) do
		local func = mScoreCalculators[v];
		if func then
			score = score + func(skill,target);
		end
	end

	return score;
end

function Search:SearchTargetBySkillAI(targets,skill)
	if not targets then
		return nil;
	end

	local ai = skill.mAI;
	local items = nil;
	if ai then
		items = ai.items;
	end

	if not items then
		return targets[1];
	end

	local maxScore = 0;
	local target = nil;
	for k,v in pairs(targets) do
		if skill:CanSelectTarget(v) then
			local score = self:CalculateScore(v,skill,items);
			if score > maxScore or not target then
				maxScore = score;
				target = v;
			end
		end
	end

	return target;
end

return Search.LuaNew();