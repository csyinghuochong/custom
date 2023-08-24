local BaseLua = require "Core/BaseLua"
local mLuaClass = require "Core/LuaClass"
local mLanguageUtil = require "Utils/LanguageUtil"
local FollowerPowerVO = mLuaClass("FollowerPowerVO", BaseLua);
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local mLgName1 = mLanguageUtil.power_huangqin;
local mLgName2 = mLanguageUtil.power_waiqi;
local mLgName3 = mLanguageUtil.power_quancheng;
local mLgName4 = mLanguageUtil.power_donggong;
local mLgName5 = mLanguageUtil.power_xigong;

function FollowerPowerVO:OnLuaNew()
	local power_param = {};
	power_param.hp = mConfigSysglobal_value[mConfigGlobalConst.COMBAT_HP] / 100;
	power_param.attack = mConfigSysglobal_value[mConfigGlobalConst.COMBAT_ATTACK] / 100;
	power_param.defense = mConfigSysglobal_value[mConfigGlobalConst.COMBAT_DEFENSE] / 100;
	power_param.hit = mConfigSysglobal_value[mConfigGlobalConst.COMBAT_HIT] / 100;
	power_param.resist = mConfigSysglobal_value[mConfigGlobalConst.COMBAT_RESIST] / 100;
	self.mPowerParam = power_param;
end

function FollowerPowerVO:GetPowerInfo(power_id)
	if power_id == 1 then
		return mLgName1;
	elseif power_id == 2 then
		return mLgName2;
	elseif power_id == 3 then
		return mLgName3;
	elseif power_id == 4 then
		return mLgName4;
	elseif power_id == 5 then
		return mLgName5;
	else
		return mLgName1;
	end
end

local instance = FollowerPowerVO.LuaNew();
return instance;