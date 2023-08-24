local LuaClass = require "Core/LuaClass"
local AttributeModifier = LuaClass("AttributeModifier");
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


function AttributeModifier:OnLuaNew()
	self.mBlenders = {};
end

function AttributeModifier:Dispose()
	local blenders = self.mBlenders;
	for k,v in pairs(blenders) do
	   blenders[k] = nil;
	end
end

function AttributeModifier:Add(blendType,value)
    --assert(mBlendFunctions[blendType],string.format("blendType = %s ",blendType));
	self.mBlenders[blendType] = mBlendFunctions[blendType](self:GetBlender(blendType),value);
end

function AttributeModifier:AddModifier(modifier)
	if modifier then
		local blenders = modifier.mBlenders;
		for k,v in pairs(blenders) do
		   self:Add(k,v);
		end
	end 
end

function AttributeModifier:GetBlender(blendType)
	return self.mBlenders[blendType] or 0;
end

function AttributeModifier:INCREASE_MAX()
	return self:GetBlender(mAttributeBlendEnum.INCREASE_MAX);
end

function AttributeModifier:INCREASE_MAX_PER()
	return self:GetBlender(mAttributeBlendEnum.INCREASE_MAX_PER);
end

function AttributeModifier:DECREASE_MAX()
	return self:GetBlender(mAttributeBlendEnum.DECREASE_MAX);
end

function AttributeModifier:DECREASE_MAX_PER()
	return self:GetBlender(mAttributeBlendEnum.DECREASE_MAX_PER);
end

function AttributeModifier:INCREASE_SUM()
	return self:GetBlender(mAttributeBlendEnum.INCREASE_SUM);
end

function AttributeModifier:INCREASE_SUM_PER()
	return self:GetBlender(mAttributeBlendEnum.INCREASE_SUM_PER);
end

function AttributeModifier:DECREASE_SUM()
	return self:GetBlender(mAttributeBlendEnum.DECREASE_SUM);
end

function AttributeModifier:DECREASE_SUM_PER()
	return self:GetBlender(mAttributeBlendEnum.DECREASE_SUM_PER);
end

return AttributeModifier;