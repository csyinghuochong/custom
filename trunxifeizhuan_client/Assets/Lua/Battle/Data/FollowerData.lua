local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local mConfigSysactor = require"ConfigFiles/ConfigSysactor"
local mConfigSysfollower_office_up = require"ConfigFiles/ConfigSysfollower_office_up"

local FollowerData = LuaClass("FollowerData",BaseLua);

local SkillData = require "Battle/Data/SkillData";
local pairs = pairs;
function FollowerData:OnLuaNew(id)
	self.mId = id;
	self.mConfig = mConfigSysactor[id];
	self:SetLevel(1);
	self:SetStar(1);
	self:SetOffice(1);
end

function FollowerData:SetLevel(lv)
	self.mLevel = lv;
end

function FollowerData:SetStar(star)
	self.mStar = star;
end

function FollowerData:SetOffice(office)
	self.mOffice = mConfigSysfollower_office_up[self.mId.."_"..office];
	local total_skills = self.mConfig.skills;
	local skill_indeices = self.mOffice.skills;
	local skills = {};
	local skill = nil;
	for i,v in pairs(skill_indeices) do

		skill = SkillData.LuaNew(total_skills[v]);
		skills[i] = skill;

	end
	self.mSkills = skills;
end

function FollowerData:GetModel()
	return self.mOffice.model or 1;
end

function FollowerData:GetSkills()
	return self.mSkills;
end

function FollowerData:CalculateAttributes()
end

return FollowerData;