local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local EffectNode = LuaClass("EffectNode",BaseLua);

function EffectNode:OnLuaNew(transform,target)
	self.mTransform = transform;
	self.mTarget = target;
	self.mName = transform.name;
end

function EffectNode:Update()
	
	local target = self.mTarget;

	if not target or target:Equals(nil) then
		return;
	end

	local transform = self.mTransform;
	if transform then
		transform.position = target.position;
		transform.rotation = target.rotation;
	end
end

function EffectNode:Bind(target)
	self.mTarget = target;
	self:Update();
end

return EffectNode;