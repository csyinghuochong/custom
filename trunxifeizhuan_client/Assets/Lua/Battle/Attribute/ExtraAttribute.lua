local LuaClass = require "Core/LuaClass"
local ExtraAttribute = LuaClass("ExtraAttribute");
local mNotifyEnum = require"Enum/NotifyEnum"

function ExtraAttribute:OnLuaNew(blendType,valueType,value)
	self.mBlendType = blendType;
	self.mValueType = valueType;
	self.mValue = value;
	self.mPlusOrMinus = 0;
end

function ExtraAttribute:SetForbidType(forbidType)
	self.mForbidType = forbidType;
end

function ExtraAttribute:SetPlusOrMinus(value)
	self.mPlusOrMinus = value;
end

function ExtraAttribute:GetPlusOrMinus()
	return self.mPlusOrMinus;
end

function ExtraAttribute:SetSkill(skill)
	-- body
end

function ExtraAttribute:Dispose()
	-- body
end

function ExtraAttribute:GetValue()
	return self.mValue;
end

function ExtraAttribute:GetBlendType()
	return self.mBlendType;
end

function ExtraAttribute:GetValueType()
	return self.mValueType;
end

return ExtraAttribute;