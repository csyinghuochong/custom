local mLuaClass = require "Core/LuaClass"
local CombatResultEnum = require "Module/Combat/CombatResultEnum"
local CombatResultControl = mLuaClass("CombatResultControl");

--胜负检测
function CombatResultControl:OnLuaNew(win_vo, combat_model)
	self.mResult = nil;
	self.mWinRules = win_vo;
	self.mCombatModel = combat_model;
end

function CombatResultControl:GetResult(  )
	return self.mResult;
end

function CombatResultControl:SetResult(result )
	self.mResult = result;
end
--[[胜利规则
1 击杀所有怪
2 击杀id怪多少个
--]]
--[[失败规则
1 己方全死
--]]
function CombatResultControl:OnWaveAllDie(team)
	local result = self.mResult;
	if result == nil then	
		local win_vo = self.mWinRules;
		local win = false;
		for k, v in pairs(win_vo) do
			if v.rule_type == 1 then
				win = self:CheckKillAllEnemys();
			elseif v.rule_type == 2 then
				win = self:CheckKillIDMonsters(v.rule_target, v.rule_target);
			end

			if win then
				break;
			end
		end
		if win then
			result = CombatResultEnum.CombatWin;
		end
	end

	if result == nil then
		local fail = self:CheckKillAllTeamer();
		if fail then
			result = CombatResultEnum.CombatFail;
		end
	end
	
	self.mResult = result;
	return result;
end

function CombatResultControl:CheckKillAllEnemys()
	return self.mCombatModel.mCombatActorManager:IsAllTeamDead(2);
end

function CombatResultControl:CheckKillAllTeamer(  )
	return self.mCombatModel.mCombatActorManager:IsAllTeamDead(1);
end

function CombatResultControl:CheckKillIDMonsters(rule_target, rule_condition)
	return self.mCombatModel.mCombatActorManager:CheckKillIDMonsters(rule_target, rule_condition == 0 and 1 or rule_condition);
end

return CombatResultControl;