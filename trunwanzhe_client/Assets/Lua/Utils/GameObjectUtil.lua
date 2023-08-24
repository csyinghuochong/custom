local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"

local GameObjectUtil = mLuaClass(GameObjectUtil,mBaseLua);
local mVector3 = Vector3;

function GameObjectUtil:SetParent(childTransform,parentTransform)
	if not childTransform then
		return
	end

	childTransform:SetParent(parentTransform);
	childTransform.localPosition = mVector3.zero;
	childTransform.localScale = mVector3.one;
end

local instance = GameObjectUtil.LuaNew();
return instance;