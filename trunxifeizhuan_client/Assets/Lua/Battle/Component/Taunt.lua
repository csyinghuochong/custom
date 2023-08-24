local LuaClass = require "Core/LuaClass"
local ActorObserver = require "Battle/Component/ActorObserver"
local Taunt = LuaClass("Taunt",ActorObserver);

function Taunt:SetTarget(buff)
	self.mBuff = buff;
	self.mTarget = buff.mSkill.mOwner;
end

function Taunt:RemoveTarget(buff)
	if self.mBuff == buff then
		self.mBuff = nil;
		self.mTarget = nil;
	end
end

function Taunt:GetTarget()
	return self.mTarget;
end

return Taunt;