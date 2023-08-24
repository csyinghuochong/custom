local mLuaClass = require "Core/LuaClass"
local mConfigSysdungeon = require "ConfigFiles/ConfigSysendless_dungeon"
local mConfigSysdungeonChapter = require "ConfigFiles/ConfigSysdungeon_chapter"
local EndlessShengongmeiyingVO = mLuaClass("EndlessShengongmeiyingVO");

function EndlessShengongmeiyingVO:OnLuaNew(battleID,storyID,storyEndID,status,chapterID,wave)
   self.mBattleID = battleID;
   self.mStoryID = storyID;
   self.mStoryEndID = storyEndID;
   self.mStatus = status;
   self.mChapterID = chapterID;
   self.mClimbTowerMonsters = wave;
end

function EndlessShengongmeiyingVO:GetConfig()
	return mConfigSysdungeon[self.mBattleID];
end

-- function EndlessShengongmeiyingVO:GetBuffID()
-- 	local config = mConfigSysdungeonChapter[self.mChapterID];
-- 	local index = self:GetConfig().index;
-- 	local num1,num2 = math.modf(index/5);
-- 	local count = num2 == 0 and num1 or num1 + 1;
-- 	return config.effects[count];
-- end

function EndlessShengongmeiyingVO:GetMaxLevel()
	return mConfigSysdungeonChapter[self.mChapterID].dungeon_count;
end

return EndlessShengongmeiyingVO;