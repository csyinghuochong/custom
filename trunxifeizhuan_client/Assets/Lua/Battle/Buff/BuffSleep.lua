local LuaClass = require "Core/LuaClass"
local Buff = require "Battle/Buff/Buff"
local BuffSleep = LuaClass("BuffSleep",Buff);
local Time = UnityEngine.Time;

function BuffSleep:OnStart()
	local mNotifyEnum = self:GetNotifyEnum();
	self.mStartFrameCount = Time.frameCount;

	self:RegisterListener(mNotifyEnum.AfterOtherAttack,function (skillHit)
		if self.mStartFrameCount < Time.frameCount and skillHit.def == self.mOwner then
			self:SendFinish();
		end
	end);

end

return BuffSleep;