local LuaClass = require "Core/LuaClass"
local Effect = require "Battle/Effect/Effect"
local BuffEffect = LuaClass("BuffEffect",Effect);

function BuffEffect:CheckExit()
	return self:GetRefCount() < 1;
end

function BuffEffect:GetRefCount()
	return self.mRefCount or 0;
end

function BuffEffect:ResetRef()
	self.mRefCount = 0;
end

function BuffEffect:AddRef()
	local refCount = self:GetRefCount() + 1;
	self.mRefCount = refCount;
	return refCount;
end

function BuffEffect:ReduceRef()
	local refCount = self:GetRefCount() - 1;
	self.mRefCount = refCount;
	return refCount;
end

return BuffEffect;