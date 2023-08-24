local LuaClass = require "Core/LuaClass"
local Buff = require "Battle/Buff/Buff"
local BuffTransferHurt = LuaClass("BuffTransferHurt",Buff);

function BuffTransferHurt:OnStart()
	local mNotifyEnum = self:GetNotifyEnum();
	self:RegisterListener(mNotifyEnum.OnOtherDie,function (actor)
		if actor == self.mSkill.mOwner then
			self:SendFinish();
		end
	end);

	local component = self.mOwner:FindAndAddComponent("TransferHurt");
	component:SetTransfer(self.mSkill.mOwner,self.mConfig.value);
end

function BuffTransferHurt:OnFinish()
	local component = self.mOwner:GetComponent("TransferHurt");
	if component then
		component:RemoveTransfer();
	end
end

return BuffTransferHurt;