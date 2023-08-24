local mLuaClass = require "Core/LuaClass"
local mConfigSysFunction = require "ConfigFiles/ConfigSysfunction_open"
local ItemPathVO = mLuaClass("ItemPathVO");

function ItemPathVO:OnLuaNew(id)
	self.id = id;
	self.mSysVO = mConfigSysFunction[id];
end

return ItemPathVO;