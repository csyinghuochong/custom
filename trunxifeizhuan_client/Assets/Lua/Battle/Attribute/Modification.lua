local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local AttributeModifier = require "Battle/Attribute/AttributeModifier"
local Modification = LuaClass("Modification",BaseLua);
local mAttributeBlendEnum = require "Enum/AttributeBlendEnum"
local math = math;

local function MAX(src,value)
    return math.max(src,value);
end
local function SUM(src,value)
	return src + value;
end

local mBlendFunctions = 
{
	[10101] = MAX; --增加固定值，取最大
	[10102] = SUM; --增加固定值，累加
	[10201] = MAX; --增加百分比，取最大
	[10202] = SUM; --增加百分比，累加
	[20101] = MAX; --降低固定值，取最大
	[20102] = SUM; --降低固定值，累加
	[20201] = MAX; --降低百分比，取最大
	[20202] = SUM; --降低百分比，累加
}

function Modification:OnLuaNew()
	local modifiers = {};
	modifiers[0] = AttributeModifier.LuaNew();
	modifiers[1] = AttributeModifier.LuaNew();
	modifiers[2] = AttributeModifier.LuaNew();
	self.mModifiers = modifiers;
end

function Modification:Dispose()
	self.mExtraAttributes = nil;
	self.mModifiers = nil;
end

function Modification:AddExtraAttribute(extraAttribute,rebuildCallback)
	local extraAttributes = self.mExtraAttributes;
	if not extraAttributes then
	   extraAttributes = {};
	   self.mExtraAttributes = extraAttributes;
	end
	extraAttributes[extraAttribute] = extraAttribute;

	self:RebuildModifiers(extraAttributes,rebuildCallback);
end

function Modification:RemoveExtraAttribute(extraAttribute,rebuildCallback)
	local extraAttributes = self.mExtraAttributes;
	if not extraAttributes then
		return;
	end

	if extraAttributes[extraAttribute] then
		extraAttributes[extraAttribute] = nil;
		self:RebuildModifiers(extraAttributes,rebuildCallback);
	end
end

function Modification:GetModifier(modifierType)
	local modifiers = self.mModifiers;
	if modifiers then
		return modifiers[modifierType];
	end
end

function Modification:GetModifierIgnoreType(ignoreType)
	ignoreType = ignoreType or -1;
	if ignoreType == 1 then
		return self:GetModifier(2);
		elseif ignoreType == 2 then
			return self:GetModifier(1);
		end
	return self:GetModifier(0);
end

function Modification:RebuildModifiers(extraAttributes,rebuildCallback)

	local modifiers = self.mModifiers;

	for k,v in pairs(modifiers) do
		v:Dispose();
	end

	local modifier = modifiers[0];

	for k,v in pairs(extraAttributes) do
		local blendType = v:GetBlendType();
		local value = v:GetValue();
		local plusOrMinus = v:GetPlusOrMinus();
		modifier:Add(blendType,value);
		modifiers[plusOrMinus]:Add(blendType,value);
	end

	if rebuildCallback then
		rebuildCallback(modifier);
	end
end

return Modification;