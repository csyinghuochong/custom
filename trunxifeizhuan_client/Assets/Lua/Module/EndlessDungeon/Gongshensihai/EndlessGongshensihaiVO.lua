local mLuaClass = require "Core/LuaClass"
local mConfigSysdungeon = require "ConfigFiles/ConfigSysendless_dungeon"
local mConfigSysendlessChapter = require "ConfigFiles/ConfigSysendless_chapter"
local EndlessGongshensihaiVO = mLuaClass("EndlessGongshensihaiVO");

function EndlessGongshensihaiVO:OnLuaNew(battleID,status,climbTowerMonsters)
   self.mBattleID = battleID;
   self.mStatus = status;
   self.mClimbTowerMonsters = climbTowerMonsters;
end

function EndlessGongshensihaiVO:GetConfig()
	return mConfigSysdungeon[self.mBattleID];
end

function EndlessGongshensihaiVO:GetPalaceID()
	local level = self.mBattleID%1000;
	local num1,num2 = math.modf(level/10);
	local num = num2 == 0 and num1 or num1 + 1;
	return num%12 == 0 and 12 or num%12;
end

function EndlessGongshensihaiVO:GetDifficult()
	local level = self.mBattleID%1000;
	local num1,num2 = math.modf(level/120);
	return num2 == 0 and num1 or num1 + 1;
end

function EndlessGongshensihaiVO:GetLevelID()
	local level = self.mBattleID%1000;
	return level%10 == 0 and 10 or level%10;
end

function EndlessGongshensihaiVO:GetPalaceBuffID()
	local config = mConfigSysendlessChapter[self:GetPalaceID()];
	return config.buff_id;
end

function EndlessGongshensihaiVO:GetLevelBuffID()
	local config = mConfigSysendlessChapter[self:GetPalaceID()];
	return config.level_buff[self:GetLevelID()];
end

return EndlessGongshensihaiVO;