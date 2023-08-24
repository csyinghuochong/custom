local LuaClass = require "Core/LuaClass"
local mLanguageUtil = require "Utils/LanguageUtil"
local AttributeTypeToVO = LuaClass("AttributeTypeToVO");
local AttributeEnum = require "Module/Talent/AttributeEnum"
local mLgHealth = mLanguageUtil.attribute_health;
local mLgAttack = mLanguageUtil.attribute_attack;
local mLgDefense = mLanguageUtil.attribute_defense;
local mLgAttackSpeed = mLanguageUtil.attribute_attack_speed;
local mLgCritRate = mLanguageUtil.attribute_crit_rate;
local mLgCritHurt = mLanguageUtil.attribute_crit_hurt;
local mLgEffectHitRate = mLanguageUtil.attribute_effect_hit_rate;
local mLgEffectResistRate = mLanguageUtil.attribute_effect_resist_rate;
local mLgHealthRate = mLanguageUtil.attribute_health;
local mLgAttackRate = mLanguageUtil.attribute_attack;
local mLgDefenseRate = mLanguageUtil.attribute_defense;
local mLgAttackHurt = mLanguageUtil.attribute_attack_hurt;

function AttributeTypeToVO:OnLuaNew()
	local type_vo = {};
	type_vo[AttributeEnum.AttributeHealth] = { name = mLgHealth, rate = 0, icon = 'common_icon_1' };
	type_vo[AttributeEnum.AttributeAttack] = { name = mLgAttack, rate = 0, icon = 'common_icon_2' };
	type_vo[AttributeEnum.AttributeDefense] = { name = mLgDefense, rate = 0, icon = 'common_icon_3' };
	type_vo[AttributeEnum.AttributeCritRate] = { name = mLgCritRate, rate = 1, icon = 'common_icon_5' };
	type_vo[AttributeEnum.AttributeCritHurt] = { name = mLgCritHurt, rate = 1, icon = 'common_icon_6' };
	type_vo[AttributeEnum.AttributeEffectHitRate] = { name = mLgEffectHitRate, rate = 1, icon = 'common_icon_7' };
	type_vo[AttributeEnum.AttributeEffectResistRate] = { name = mLgEffectResistRate, rate = 1, icon = 'common_icon_8' };
	type_vo[AttributeEnum.AttributeAttackSpeed] = { name = mLgAttackSpeed, rate = 0, icon = 'common_icon_4' };
	type_vo[AttributeEnum.AttributeHealthRate] = { name = mLgHealthRate, rate = 1, icon = 'common_icon_1' };
	type_vo[AttributeEnum.AttributeAttackRate] = { name = mLgAttackRate, rate = 1, icon = 'common_icon_2' };
	type_vo[AttributeEnum.AttributeDefenseRate] = { name = mLgDefenseRate, rate = 1, icon = 'common_icon_3' };
	type_vo[AttributeEnum.AttributeAttackHurt] = { name = mLgAttackHurt, rate = 1, icon = 'common_icon_2' };
	self.mAttriteTypeVO = type_vo;
end

local instance = AttributeTypeToVO.LuaNew();
return instance;