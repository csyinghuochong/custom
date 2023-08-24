local mLuaClass = require "Core/LuaClass"

local AreaItemVO = mLuaClass("AreaItemVO");

function AreaItemVO:OnLuaNew(id, name, callback)
	self.mID = id;
	self.mArenaName = name;
	self.mCallBack = callback;
end

return AreaItemVO;