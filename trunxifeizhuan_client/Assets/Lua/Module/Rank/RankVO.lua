local mLuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local mConfigSysrank = require "ConfigFiles/ConfigSysrank"
local RankVO = mLuaClass("RankVO", BaseLua);

function RankVO:OnLuaNew(data,type)
	self.rank = data.rank;
	self.id = data.id;
	self.name = data.name;
	self.sex = data.sex;
	self.lv = data.lv;
	self.value = data.value;
	self.position = data.position;
	self.head = data.head;
	self.type = type;
end

return RankVO;