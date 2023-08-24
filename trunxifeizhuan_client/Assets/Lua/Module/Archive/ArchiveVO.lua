local mLuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local mConfigSysactor = require "ConfigFiles/ConfigSysactor"
local ArchiveVO = mLuaClass("ArchiveVO", BaseLua);

function ArchiveVO:OnLuaNew(id,num)
	self.id = id;
	self.mConfig = mConfigSysactor[id];
	self.num = num;
end

function ArchiveVO:OnAdd()
	self.num = self.num + 1;
end

function ArchiveVO:OnMinus()
	self.num = self.num - 1;
end

return ArchiveVO;