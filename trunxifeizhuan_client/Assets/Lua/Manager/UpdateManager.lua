local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"

local UpdateManager = mLuaClass("UpdateManager",mBaseLua);

function UpdateManager:OnLuaNew()
	self.mUpdateList = {};
	self.mFixedUpdateList = {};
	self.mLateUpdate = {};
end

function UpdateManager:AddFixedUpdate(update)
	if not update then
		return;
	end

	self.mFixedUpdateList[update] = update;
end

function UpdateManager:AddLateUpdate(update)
	if not update then
		return;
	end

	self.mLateUpdate[update] = update;
end

function UpdateManager:AddUpdate(update)
	if not update then
		return;
	end

	self.mUpdateList[update] = update;
end

function UpdateManager:RemoveFixedUpdate(update)
	if not update then
		return;
	end

	self.mFixedUpdateList[update] = nil;
end

function UpdateManager:RemoveLateUpdate(update)
	if not update then
		return;
	end

	self.mLateUpdate[update] = nil;
end

function UpdateManager:RemoveUpdate(update)
	if not update then
		return;
	end

	self.mUpdateList[update] = nil;
end

function UpdateManager:OnFixedUpdate()
	for k,v in pairs(self.mFixedUpdateList) do
		k:OnFixedUpdate();
	end
end

function UpdateManager:OnLateUpdate()
	for k,v in pairs(self.mLateUpdate) do
		k:OnLateUpdate();
	end
end

function UpdateManager:OnUpdate()
	for k,v in pairs(self.mUpdateList) do
		k:OnUpdate();
	end
end

return UpdateManager.LuaNew();