local LuaClass = require "Core/LuaClass"
local Buff = require "Battle/Buff/Buff"
local BuffUnyielding = LuaClass("BuffUnyielding",Buff);
local mNotifyEnum = require"Enum/NotifyEnum"
function BuffUnyielding:OnStart()
	self:RegisterListener(mNotifyEnum.OnReduceHealth,function (health)
		self:OnReduceHealth();
	end);
	local owner = self.mOwner;
	if owner:IsAlive() == false then
		owner:Notify(mNotifyEnum.OnUpdateHealth,1);
	end
end

function BuffUnyielding:OnReduceHealth()
	local owner = self.mOwner;
	if owner:IsAlive() == false then
		owner:Notify(mNotifyEnum.OnUpdateHealth,1);
	end
end

return BuffUnyielding;