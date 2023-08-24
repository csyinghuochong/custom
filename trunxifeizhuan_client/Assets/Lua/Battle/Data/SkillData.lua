local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"

local SkillData = LuaClass("SkillData",BaseLua);

local mConfigSysskill = require"ConfigFiles/ConfigSysskill"
local mConfigSysskill_info = require"ConfigFiles/ConfigSysskill_info"
local ipairs = ipairs;

function SkillData:OnLuaNew(id)
	self.mId = id;
	self.mLevel = 1;
	local info = mConfigSysskill_info[id];
	
	if info then
		self.mName = info.name;
		self.mIcon = info.icon;
	end

	local config = mConfigSysskill[id];
	self.mConfig = config;
	self.mInfo = info;
	
end

function SkillData:SetLevel(lv, active)
	self.mLevel = lv;
	self.mActive = active;
end

function SkillData:CalculateAttributes()
end

function SkillData:GetDescribe()
	local desc = self.mDescribe;
	local info = self.mInfo;
	if not desc and info then
		desc = info.desc;
		self.mDescribe = desc;
	end

	return desc or self.mName;
end

--[[
	local str = "我了个去你们的<1>,你大爷的<2>";
	for i = 1,5 do
		local hurt = string.format("<%d>",i);
		str = string.gsub(str,hurt,"50"..i);
	end
	print(str);
]]
return SkillData;