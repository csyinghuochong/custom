local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local GmVO = mLuaClass("GmVO", mBaseLua);

function GmVO:OnLuaNew(data)
	self.type = data.type;
	self.e_cmd = data.e_cmd;
	self.params = data.params;
	self.z_cmd = data.z_cmd;
end

return GmVO;