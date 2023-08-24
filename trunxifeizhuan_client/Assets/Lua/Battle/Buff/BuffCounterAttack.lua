local LuaClass = require "Core/LuaClass"
local Buff = require "Battle/Buff/Buff"
local BuffCounterAttack = LuaClass("BuffCounterAttack",Buff);

function BuffCounterAttack:OnStart()
	local mNotifyEnum = self:GetNotifyEnum();
	self:RegisterListener(mNotifyEnum.AfterOtherAttack,function (skillHit)
		self:CounterAttack(skillHit);
	end);
end

function BuffCounterAttack:CounterAttack(skillHit)
	local owner = self.mOwner;
	local def = skillHit.def;
	if def ~= owner then
		return;
	end

	local atk = skillHit.atk;
	if def.mTeam == atk.mTeam or atk:HasAction("CounterAttack") then
		return;
	end

	atk:FindAndAddComponent("CounterAttackRequest"):AddCounterAttack(def,1);
end

return BuffCounterAttack;