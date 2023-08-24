local mLuaClass = require "Core/LuaClass"
local mConfigSysgraceSkill = require "ConfigFiles/ConfigSysgrace_skill"
local mConfigSysgraceSkillLevel = require "ConfigFiles/ConfigSysgrace_skill_level"
local GraceSkillVO = mLuaClass("GraceSkillVO");

function GraceSkillVO:OnLuaNew(skillId,level,exp)
   self.mSkillID = skillId;
   self.mLevel = level;  --等级0未开启
   self.mExp = exp;
   self.mSys_vo = mConfigSysgraceSkill[skillId];
end

function GraceSkillVO:GetLevelConfig(level)
	if level == nil then
		level = self.mLevel;
	end
	local key = string.format("%d_%d", self.mSkillID, level);
	return mConfigSysgraceSkillLevel[key];
end

function GraceSkillVO:GetNextLevelConfig()
	local key = string.format("%d_%d", self.mSkillID, self.mLevel+1);
	return mConfigSysgraceSkillLevel[key];
end

return GraceSkillVO;