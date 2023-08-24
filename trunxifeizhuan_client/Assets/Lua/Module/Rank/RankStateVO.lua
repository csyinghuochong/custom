local mLuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local RankStateVO = mLuaClass("RankStateVO", BaseLua);

function RankStateVO:OnLuaNew(config,isSelected)
	self.config = config;
	self.isSelected = isSelected;
end

return RankStateVO;