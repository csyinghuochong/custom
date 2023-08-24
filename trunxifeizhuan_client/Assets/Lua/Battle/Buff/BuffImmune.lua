local LuaClass = require "Core/LuaClass"
local Buff = require "Battle/Buff/Buff"
local BuffImmune = LuaClass("BuffImmune",Buff);
local ipairs = ipairs;

function BuffImmune:OnStart()
	local otherParams = self.mOtherParams;
	if otherParams then
		local owner = self.mOwner;
		self.mHaveImmuneStates = true;
		local immuneStateTypes = owner:GetImmuneStateTypes();
		local immuneStates = owner:GetImmuneStates();
		for i,v in ipairs(otherParams) do
			self:AddImmune((v > 2) and immuneStates or immuneStateTypes,v);
		end
	end
end

function BuffImmune:AddImmune(immunes,key)
	local count = immunes[key] or 0;
	immunes[key] = count + 1;
end

function BuffImmune:RemoveImmune(immunes,key)
	local count = immunes[key] or 0;
	if count > 1 then
		immunes[key] = count - 1;
	else
		immunes[key] = nil;
	end
end

function BuffImmune:OnFinish()
	local otherParams = self.mOtherParams;
	if otherParams and self.mHaveImmuneStates then
		self.mHaveImmuneStates = nil;
		local owner = self.mOwner;
		local immuneStateTypes = owner:GetImmuneStateTypes();
		local immuneStates = owner:GetImmuneStates();
		for i,v in ipairs(otherParams) do
			self:RemoveImmune((v > 2) and immuneStates or immuneStateTypes,v);
		end
	end
end

return BuffImmune;