local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mSortTable = require "Common/SortTable"
local mConfigSysdungeon = require "ConfigFiles/ConfigSysdungeon"
local mPlayerPrefs = UnityEngine.PlayerPrefs;
local mGameModelManager = require "Manager/GameModelManager"
local EliteDungeonModel = mLuaClass("EliteDungeonModel",mBaseModel);

local ELITE_DUNGEON_FIRST = 1901001;
local ELITE_DUNGEON_LAST = 1912005;
local ELITE_DUNGEON_CHAPTER_FIRST = 1901;

function EliteDungeonModel:OnLuaNew()
	self.mIsEverGetDungeonID = false;
	self.mSelectDungeonID = 0;
	self.mSelectBuildID = 0;
	self.mIsOpenAwardWindow = false;
end

function EliteDungeonModel:OnRecvEliteDungeonList(pbEliteDungeonList)
	local dungeonID = pbEliteDungeonList.dungeon_id;
	if dungeonID == 0 then
		self.mNowDungeonID = ELITE_DUNGEON_FIRST;
	else
		local dungeonID2 = mConfigSysdungeon[dungeonID].next_dungeon;
		if dungeonID2 ~= 0 then
			dungeonID = dungeonID2;
		else
			dungeonID = ELITE_DUNGEON_LAST;
		end
		self.mNowDungeonID = dungeonID;
	end
	self:RefreshMaxChapterID(self.mNowDungeonID,false);
	self:Dispatch(self.mEventEnum.ON_ELITE_DUNGEON_REFRESH_ALL);
end

function EliteDungeonModel:OnRefreshToNextDungeon(dungeon_id)
	local nextDungeon = mConfigSysdungeon[dungeon_id].next_dungeon;
	if nextDungeon ~= 0 then
		if nextDungeon > self.mNowDungeonID then
			self.mNowDungeonID = nextDungeon;
			self:RefreshMaxChapterID(nextDungeon,true);
			self:Dispatch(self.mEventEnum.ON_ELITE_DUNGEON_REFRESH_ID,nextDungeon);
			self:Dispatch(self.mEventEnum.ON_ELITE_DUNGEON_REFRESH_ID,dungeon_id);
		end
	else
		self.mNowDungeonID = ELITE_DUNGEON_LAST;
		self:Dispatch(self.mEventEnum.ON_ELITE_DUNGEON_REFRESH_ID,ELITE_DUNGEON_LAST);
		self:Dispatch(self.mEventEnum.ON_ELITE_DUNGEON_SHOW_DIALOG,self.mNowMaxChapterID);
	end
end

function EliteDungeonModel:RefreshMaxChapterID(dungeon_id,isShow)
	local nowMaxChapterID = self.mNowMaxChapterID;
	local chapterID = mConfigSysdungeon[dungeon_id].chapter_id;
	if nowMaxChapterID ~= chapterID then
		self.mNowMaxChapterID = chapterID;
		if isShow then
			self:Dispatch(self.mEventEnum.ON_ELITE_DUNGEON_SHOW_DIALOG,nowMaxChapterID);
		end
	end
end

function EliteDungeonModel:OnRecvEliteDungeonBattle(pbEliteDungeonBattleResult)
	
end

function EliteDungeonModel:OnRecvEliteDungeonBattleResult(pbEliteDungeonBattleResult)
	self:OnRefreshToNextDungeon(pbEliteDungeonBattleResult.dungeon_id);
end

function EliteDungeonModel:OnRecvEliteDungeonReborn(pbResult)
	
end

return EliteDungeonModel;