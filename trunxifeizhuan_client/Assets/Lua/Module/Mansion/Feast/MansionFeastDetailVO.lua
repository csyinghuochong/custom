local mLuaClass = require "Core/LuaClass"
local ConfigSysmansion_feast_guest = require "ConfigFiles/ConfigSysmansion_feast_guest"
local MansionFeastDetailVO = mLuaClass("MansionFeastDetailVO");

function MansionFeastDetailVO:OnLuaNew( pbMansionFeastGuest )
	self.mPlayer = pbMansionFeastGuest.base;
	self.mCostId = pbMansionFeastGuest.id;
	self.mSysVO = ConfigSysmansion_feast_guest[ pbMansionFeastGuest.id ];
end

function MansionFeastDetailVO:GetCostInfo( )
	local sysVo = self.mSysVO;
	return sysVo.type, sysVo.price;
end

return MansionFeastDetailVO;