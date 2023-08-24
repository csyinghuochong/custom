local mLuaClass = require "Core/LuaClass"
local ArrayUtil = require "Core/BaseLua"

function ArrayUtil:ContainsValue(value, array)
	if not array then
		return false;
	end

	for k, v in pairs(array) do
		if v == value then
			return true;
		end
	end
	return false;
end

local instance = ArrayUtil.LuaNew();
return instance;