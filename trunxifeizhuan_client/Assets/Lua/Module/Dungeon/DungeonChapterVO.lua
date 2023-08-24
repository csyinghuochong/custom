local mLuaClass = require "Core/LuaClass"
local DungeonChapterVO = mLuaClass("DungeonChapterVO");
local mLanguageUtil = require "Utils/LanguageUtil"
local mChapterName = mLanguageUtil.chater_name;

--章节数据--
function DungeonChapterVO:OnLuaNew(id, sysVO)
	self.mID = id;
	self.mDungeonList = {};
	self.mDungeonByIndex = {};
	self.mSysVO = sysVO;
	self.mChapterIndex = string.format(mChapterName, sysVO.chapter_index);
end

function DungeonChapterVO:OnUpdateChapterStory( last_story , last_level, new_level )
	local dungeonIndex = self.mDungeonByIndex;
	local number = #dungeonIndex;
	self.mOpen = new_level >= dungeonIndex[ 1 ].mID;
	self.mPass = last_level >= dungeonIndex[ number ].mID;
	self.mStoryEnd = last_story >= self.mSysVO.story_region[ 2 ];
end

function DungeonChapterVO:GetChapterSweepCost(  )
	local cost = 0;
	for k, v in pairs ( self.mDungeonList ) do
		cost = cost + v.mSysVO.strength_w[ 2 ];
	end
	return cost;
end

function DungeonChapterVO:IsThisChapterStory( story_id )
	local story_region = self.mSysVO.story_region;
	return story_id >= story_region[1] and story_id <= story_region[2];
end

function DungeonChapterVO:IsOpen(  )
	return self.mOpen;
end

function DungeonChapterVO:IsPass()
	return self.mPass and self.mStoryEnd;
end

return DungeonChapterVO;