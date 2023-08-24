local LuaClass = require "Core/LuaClass"
local CombatObserver = require"Battle/Combat/CombatObserver"
local AIController = LuaClass("AIController",CombatObserver);
local mSearch = require "Battle/AI/Search"
local mBattleEventEnum = require "Enum/BattleEventEnum"
local mGameTimer = require "Core/Timer/GameTimer"

local pairs = pairs;
local ipairs = ipairs;
local math = math;
local table = table;

function AIController:AddCombatListeners()
	self:RegisterListener(mBattleEventEnum.ON_AI_DOROUND,function (actor)
		self:DoRound(actor);
	end);
end

function AIController:Awake()
	self:AddCombatListeners();
end

function AIController:Dispose()
	self:RemoveCombatListeners();
end

function AIController:GetListData(list)
	if list then
		return list.mData;
	end
end

function AIController:GetTargetsOfType(targetType,actor)
	if targetType == 0 then
		return self:GetListData(actor:GetTeamMates());
	end
	
	if targetType == 1 then
		local selectedTarget = actor:GetSelectedTarget();
		if selectedTarget and selectedTarget:IsInState1015() == false then
			return {selectedTarget};
		else
			return self:GetListData(actor:GetEnemies());
		end
	end

	if targetType == 2 then
		return {actor};
	end

	if targetType == 3 then
		return self:GetListData(actor:GetDeadTeamMates());
	end

	if targetType == 4 then
		return self:GetListData(actor:GetTotalTeamMates());
	end
	
	return nil;
end

function AIController:GetTargets(skill)
	local targetType = skill.mTargetType;
	local targets = self.mTargets[targetType];
	if not targets then
		targets = self:GetTargetsOfType(targetType,skill.mOwner);
		self.mTargets[targetType] = targets;
	end

	return targets;
end
--被混乱时
function AIController:GetTargetWhenInState2022(owner)
	local actors = self:GetCombat():GetAliveActors();
	if actors:GetLen() > 1 then
		local target = actors:GetRandomValue();
		while( target == owner )do
			target = actors:GetRandomValue();
		end
		return target;
	end
end
-- 被嘲讽时
function AIController:GetTargetWhenInState2012(owner)
	return owner:GetComponent("Taunt"):GetTarget();
end

function AIController:WillSelectSkill(skill)
	if not skill then
		return false;
	end
	local ai = skill.mAI;
	local probability = ai and ai.probability or 50;
	if math.random(0,99) < probability then
		return skill:CanUse() and mSearch:Search(self:GetTargets(skill),ai);
	end
	return false;
end

local mSkillCount = 3;

function AIController:SelectSkill(actor)
	if actor:IsInState2022() then
		return 1;
	end
	if actor:IsInState2012() then
		return 1;
	end

	local skills = actor:GetSkills();
	self.mTargets = {};
	for i = mSkillCount,2,-1 do
		if self:WillSelectSkill(skills[i]) then
			return i;
		end
	end

	return 1;
end

function AIController:SelectTarget(skill)
	
	local actor = skill.mOwner;

	if actor:IsInState2022() then
		return self:GetTargetWhenInState2022(actor);
	end

	if actor:IsInState2012() then
		return self:GetTargetWhenInState2012(actor);
	end

	return mSearch:SearchTargetBySkillAI(self:GetTargets(skill),skill);
end

-------------------Log Message-------------------------------------------------------
local mLogMessage = "AI使用技能 [%s] 找不到有效目标,攻击者状态->(%s),目标状态->(%s),开始重启AI";

local function GetAtkState(atk)
	if atk then
		return string.format("攻击者=[%s],是否处于嘲讽状态=[%s] 是否处于混乱状态 = [%s]",atk.mName,atk:IsInState2012(),atk:IsInState2022());
	else
		return "不存在的攻击者";
	end
end

local function GetTargetState(target)
	if target then
		return string.format("目标=[%s],是否活着=[%s] 是否处于隐身状态 = [%s]",target.mName,target:IsAlive(),target:IsInState1015());
	else
		return "不存在的目标";
	end
end

function AIController:TryDoRoundAgain(actor)
	local doRound = function ()
		self:DoRound(actor,true);
	end
	mGameTimer.SetTimeout(0.5,doRound,false,true);
end

function AIController:DoRound(actor,checkTurn)
	local combat = self:GetCombat();

	if checkTurn and combat:GetCurrentActor() ~= actor then
		return;
	end

	combat:Notify(mBattleEventEnum.ON_AI_SELECT_SKILL,self:SelectSkill(actor));

	local skill = actor:GetSelectedSkill();
	local target = self:SelectTarget(skill);

	if actor:CanSelectTarget(target) then
		combat:Notify(mBattleEventEnum.ON_AI_SELECT_TARGET,target);
	else
		Debugger.LogError(string.format(mLogMessage,skill.mName,GetAtkState(actor),GetTargetState(target)));
		self:TryDoRoundAgain(actor);
	end
end

return AIController;