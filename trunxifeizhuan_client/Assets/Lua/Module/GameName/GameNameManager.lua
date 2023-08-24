local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mMath = require "math"

local mSensitiveWordUtil = require "Utils/SensitiveWordUtil"
local mLanguage = require "Utils/LanguageUtil"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mConfigSysecode = require "ConfigFiles/ConfigSysecode"
local mConfigSysecodeConst = require "ConfigFiles/ConfigSysecodeConst"

--主角姓
local role_surname = nil;
--主角男名
local man_name = nil;
--主角女名
local woman_name = nil;
--子女姓
local child_surname = nil;
--子女男名
local boy_name = nil;
--子女女名
local girl_name = nil;
--机器人名
local robot_name = nil;

local GameNameManager = mLuaClass("GameNameManager",mBaseLua);

function GameNameManager:OnLuaNew()
	
end

--1男性 2女性--
function GameNameManager:GetRoleName(sex)
	if role_surname == nil then
		role_surname = require "Module/GameName/RoleSurname"
	end

	local name = nil;

	if sex == 1 then
		if man_name == nil then
			man_name = require "Module/GameName/ManName"
		end
		name = man_name;
	else
		if woman_name == nil then
			woman_name = require "Module/GameName/WomanName"
		end
		name = woman_name;
	end

	return role_surname[mMath.random(1, #role_surname)] .. name[mMath.random(1, #name)];
end

--1男性 2女性--
function GameNameManager:GetChildName(sex)
	if child_surname == nil then
		child_surname = require "Module/GameName/ChildSurname"
	end

	local name = nil;

	if sex == 1 then
		if boy_name == nil then
			boy_name = require "Module/GameName/BoyName"
		end
		name = boy_name;
	else
		if girl_name == nil then
			girl_name = require "Module/GameName/GirlName"
		end
		name = girl_name;
	end

	return child_surname[mMath.random(1, #child_surname)] .. name[mMath.random(1, #name)];
end

--检测机器人名
function GameNameManager:CheckIsRobotName( name )
	if robot_name == nil then
		robot_name = require "ConfigFiles/ConfigSysrobot";
	end
	for k , v in pairs(robot_name) do
		if v.name == name then
			return true;
		end
	end
	return false;
end

--检测机器人名，检测敏感词
function GameNameManager:CheckName( name )
	
	if  name == "" then
		mCommonTipsView.Show(mLanguage.invalid_name_tip);
	elseif self:CheckIsRobotName(name) then
		mCommonTipsView.Show(mConfigSysecode[mConfigSysecodeConst.ERROR_ROLE_EXIST].error_tips);
		return false;
	elseif mSensitiveWordUtil:CheckSensitiveWord(name) then
		mCommonTipsView.Show(mLanguage.invalid_name_tip);
		return false;
	elseif string.len(name) > 15 then
		mCommonTipsView.Show(mLanguage.exceed_limit_tips);
		return false;
	end

	return true;
end

return GameNameManager.LuaNew();