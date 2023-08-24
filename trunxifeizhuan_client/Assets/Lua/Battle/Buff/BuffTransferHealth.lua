local LuaClass = require "Core/LuaClass"
local Buff = require "Battle/Buff/Buff"
local BuffTransferHealth = LuaClass("BuffTransferHealth",Buff);

function BuffTransferHealth:OnStart()
	local mNotifyEnum = self:GetNotifyEnum();
	self:RegisterListener(mNotifyEnum.OnReduceHealth,function (health)
		if self.mOwner:IsAlive() == false then
			self:TransferHealth();
		end
	end);

	self:RegisterListener(mNotifyEnum.OnOtherDie,function (actor)
		if actor == self.mSkill.mOwner then
			self:SendFinish();
		end
	end);
end

function BuffTransferHealth:TransferHealth()
	local owner = self.mOwner;
	local actor = self.mSkill.mOwner;

	local transferHealth = self:GetValue() * actor:GetHealthLimit();
	local health = actor:GetHealth();

	if health > transferHealth then
		local mNotifyEnum = self:GetNotifyEnum();
		actor:Notify(mNotifyEnum.OnUpdateHealth,health - transferHealth);
		owner:Notify(mNotifyEnum.OnUpdateHealth,transferHealth);
	end
end

return BuffTransferHealth;