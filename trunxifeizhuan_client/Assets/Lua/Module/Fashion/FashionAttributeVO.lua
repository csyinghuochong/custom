local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mLanguage = require "Utils/LanguageUtil"
local FashionAttributeVO = mLuaClass("FashionAttributeVO", mBaseLua);

local mAttributeNames = 
{
	[1] = mLanguage.attribute_health,
	[2] = mLanguage.attribute_attack,
	[3] = mLanguage.attribute_defense,
	[4] = mLanguage.attribute_crit_rate,
	[5] = mLanguage.attribute_crit_hurt,
	[6] = mLanguage.attribute_effect_hit_rate,
	[7] = mLanguage.attribute_effect_resist_rate,
	[8] = mLanguage.attribute_attack_speed,
	[9] = mLanguage.attribute_health..mLanguage.attribute_add,
	[10] = mLanguage.attribute_attack..mLanguage.attribute_add,
	[11] = mLanguage.attribute_defense..mLanguage.attribute_add,

	[1001] = mLanguage.attribute_health,
	[1002] = mLanguage.attribute_attack,
	[1003] = mLanguage.attribute_defense,
	[1004] = mLanguage.attribute_attack_speed,
};
local mValueToString = 
{
	[1] = function (v) return string.format("%d",v) end;
	[2] = function (v) return string.format("%d",v) end;
	[3] = function (v) return string.format("%d",v) end;
	[4] = function (v) return string.format("%d",v*100).."%" end;
	[5] = function (v) return string.format("%d",v*100).."%" end;
	[6] = function (v) return string.format("%d",v*100).."%" end;
	[7] = function (v) return string.format("%d",v*100).."%" end;
	[8] = function (v) return string.format("%d",v) end;
	[9] = function (v) return string.format("%d",v*100).."%" end;
	[10] = function (v) return string.format("%d",v*100).."%" end;
	[11] = function (v) return string.format("%d",v*100).."%" end;

	[1001] = function (v) return string.format("%d",v).."%" end;
	[1002] = function (v) return string.format("%d",v).."%" end;
	[1003] = function (v) return string.format("%d",v).."%" end;
	[1004] = function (v) return string.format("%d",v).."%" end;
}
function FashionAttributeVO:OnLuaNew(type,value)
	self.type = type;
	self.value = value;
end

function FashionAttributeVO:GetName()
	return mAttributeNames[self.type];
end

function FashionAttributeVO:ValueToString()
	local func = mValueToString[self.type];
	if func then
		return func(self.value);
	end
	return self.value;
end

function FashionAttributeVO:Copy(src)
	self.type = src.type;
	self.value = src.value;
end

function FashionAttributeVO:UpdateData(k,v)
	self.type = k;
	self.value = v;
end

return FashionAttributeVO;