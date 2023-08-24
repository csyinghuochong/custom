local LuaClass = require "Core/LuaClass"
local BaseAttribute = LuaClass("BaseAttribute");
local mAttributeEnum = require "Enum/AttributeEnum"

local math = math;
--[[local mBlender = 
{
	[10101] = MAX; --增加固定值，取最大
	[10102] = SUM; --增加固定值，累加
	[10201] = MAX; --增加百分比，取最大
	[10202] = SUM; --增加百分比，累加
	[20101] = MAX; --降低固定值，取最大
	[20102] = SUM; --降低固定值，累加
	[20201] = MAX; --降低百分比，取最大
	[20202] = SUM; --降低百分比，累加
}]]

function BaseAttribute:OnLuaNew(config)
	for k,v in pairs(config) do
		self[k] = v;
	end
	self[mAttributeEnum.HitRate] = 1;
	self[mAttributeEnum.Health] = self[mAttributeEnum.HealthLimit];
	self[mAttributeEnum.AttackBar] = 0;
end

function BaseAttribute:GetModifyResult(baseValue,modifier)
	local increase_max = math.max(modifier:INCREASE_MAX(),baseValue*modifier:INCREASE_MAX_PER());
	local decrease_max = math.max(modifier:DECREASE_MAX(),baseValue*modifier:DECREASE_MAX_PER());
	local increase_sum = modifier:INCREASE_SUM() + baseValue * modifier:INCREASE_SUM_PER();
	local decrease_sum = modifier:DECREASE_SUM() + baseValue * modifier:DECREASE_SUM_PER();
	return increase_max + increase_sum - decrease_max - decrease_sum ;
end

function BaseAttribute:GetModifyAttribute(modifier,valueType)
	local baseValue = self[valueType] or 0;
	return baseValue + self:GetModifyResult(baseValue,modifier);
end

return BaseAttribute;