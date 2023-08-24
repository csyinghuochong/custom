local mLuaClass = require "Core/LuaClass"
local ConfigSysmansion_feast_guest = require "ConfigFiles/ConfigSysmansion_feast_guest"
local MansionFeastCostItemVO = mLuaClass("MansionFeastCostItemVO");

function MansionFeastCostItemVO:OnLuaNew( index,  id )
	self.mID = id;
	self.mIndex = index;
	self.mSysVO = ConfigSysmansion_feast_guest[ id ];
end

function MansionFeastCostItemVO:GetCostItemVo(  )
	local sysVo = self.mSysVO;
	return  1000000 + sysVo.type, sysVo.price, nil, true;
end

function MansionFeastCostItemVO:GetRewardVoList(  )
	return self.mSysVO.reward;
end

return MansionFeastCostItemVO;