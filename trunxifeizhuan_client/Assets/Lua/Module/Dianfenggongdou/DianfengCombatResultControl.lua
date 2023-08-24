local mLuaClass = require "Core/LuaClass"
local CombatResultEnum = require "Module/Combat/CombatResultEnum"
local DianfengCombatResultControl = mLuaClass("DianfengCombatResultControl");

--胜负检测
function DianfengCombatResultControl:OnLuaNew(combat_model)
	self.mResult = nil;
	self.mCombatModel = combat_model;
end

--[[胜利规则
三局两胜
--]]
--[[失败规则
--]]
function DianfengCombatResultControl:GetResult(  )
	return self.mResult;
end

function DianfengCombatResultControl:SetResult(result )
	self.mResult = result;
end

function DianfengCombatResultControl:OnWaveAllDie(info)
	local result = self.mResult;
	if result == nil then	
		local combatResult = self.mCombatModel.mCombatActorManager:CheckDianfengResult();
		if combatResult ~= nil then
			result = combatResult and CombatResultEnum.CombatWin or CombatResultEnum.CombatFail;
			self.mResult = result;
		end
	end
	
	return result;
end

return DianfengCombatResultControl;