local LuaClass = require "Core/LuaClass"
local Buff = require "Battle/Buff/Buff"
local BuffTaunt = LuaClass("BuffTaunt",Buff);
local mNotifyEnum = require"Enum/NotifyEnum"

function BuffTaunt:OnStart()
	self:RegisterListener(mNotifyEnum.OnOtherDie,function (actor)
		if actor == self.mSkill.mOwner then
			self:SendFinish();
		end
	end);

	local component = self.mOwner:FindAndAddComponent("Taunt");
	component:SetTarget(self);
end

function BuffTaunt:OnFinish()
	local component = self.mOwner:GetComponent("Taunt");
	if component then
		component:RemoveTarget(self);
	end
end

return BuffTaunt;