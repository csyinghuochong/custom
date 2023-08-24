local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local FashionSuitVO = mLuaClass("FashionSuitVO", mBaseLua);
local FashionAttributeVO = require"Module/Fashion/FashionAttributeVO";

function FashionSuitVO:OnLuaNew(id,config)
	self.mId = id;
	self.mConfig = config;
	self.mIcon = config.icon;
end

function FashionSuitVO:GetAttributes()

	local attributes = self.mAttributes;
	if not attributes then
		local config = self.mConfig;
		attributes = {};
		for k,v in pairs(config.modification) do
			attributes[k] = FashionAttributeVO.LuaNew(1000+k,v);
		end
		self.mAttributes = attributes;
	end
	return attributes;
end

return FashionSuitVO;