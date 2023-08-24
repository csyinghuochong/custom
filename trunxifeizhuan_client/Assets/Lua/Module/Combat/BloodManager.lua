local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local PoolManager = require "Common/PoolManager"
local mBaseViewPool = PoolManager.mBaseViewPool;
local BloodManager = mLuaClass("BloodPool",mBaseLua);

function BloodManager:CreateBlood(params)
	local child = mBaseViewPool:Get('Module/Combat/BloodView');
	child:SetData(params);
	child:ShowView();

	return child;
end

function BloodManager:OnRemove(blood)
	blood:HideView();
	mBaseViewPool:Put(blood, 'Module/Combat/BloodView');
end

return BloodManager;
