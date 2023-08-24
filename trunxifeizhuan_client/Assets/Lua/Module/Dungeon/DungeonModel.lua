local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mEventEnum = require "Enum/EventEnum"
local mEventDispatcher = require "Events/EventDispatcher"
local mGameModelManager = require "Manager/GameModelManager"
local mDungeonLevelVO = require "Module/Dungeon/DungeonLevelVO"
local mDungeonChapterVO = require "Module/Dungeon/DungeonChapterVO"
local mConfigSysdungeon_chapter = require "ConfigFiles/ConfigSysdungeon_chapter"
local DungeonModel = mLuaClass("DungeonModel",mBaseModel);
local mIpairs = ipairs;

function DungeonModel:OnLuaNew()
	
end

function DungeonModel:InitDungeonConfig(  )
	local sex = mGameModelManager.RoleModel.mPlayerBase.sex;
	local mConfigSysstory = nil;
	local mConfigSysdungeon = nil;
	if sex == 1 then
		mConfigSysstory = require "ConfigFiles/ConfigSysstory_man"
		mConfigSysdungeon = require "ConfigFiles/ConfigSysstory_dungeon_man";
	else
		mConfigSysstory = require "ConfigFiles/ConfigSysstory_woman"
		mConfigSysdungeon = require "ConfigFiles/ConfigSysstory_dungeon_woman"
	end
	self.mConfigSysstory = mConfigSysstory;
	self.mConfigSysdungeon = mConfigSysdungeon;
end

--data
function DungeonModel:InitChapterToDungeonData()
	local mConfigSysdungeon = self.mConfigSysdungeon;

	local chapter_list = {};
	local chapter_by_index = {};
	local min_chapter_id = 0;
	local max_chapter_id = 0;
	for k, v in pairs(mConfigSysdungeon_chapter) do
		if v.play_type == 1 then
			if k > max_chapter_id then
				max_chapter_id = k;
			end
			if k < min_chapter_id or min_chapter_id == 0 then
				min_chapter_id = k;
			end

			local chapter_data = chapter_list[k];
			if chapter_data == nil then
				chapter_data = mDungeonChapterVO.LuaNew(k, v);
				local chapter_index = chapter_data.mSysVO.chapter_index;
				chapter_list[k] = chapter_data;
				chapter_by_index[chapter_index] = chapter_data;
			end

			for index = 1, 7 do
				local dungeon_id = k * 1000 + index;
				local dungeon_vo = mConfigSysdungeon[dungeon_id];
				if dungeon_vo ~= nil then
					local dungeon_item = mDungeonLevelVO.LuaNew(dungeon_id, dungeon_vo);
					chapter_data.mDungeonList[dungeon_id] = dungeon_item;
					local dungeon_index = dungeon_vo.index;
					chapter_data.mDungeonByIndex[dungeon_index] = dungeon_item;
				end
			end

		end
	end

	self.mChapterList = chapter_list;
	self.mChapterByIndex = chapter_by_index;
	self.mMinChapterId = min_chapter_id;
	self.mMaxChapterId = max_chapter_id;
end

function DungeonModel:GetChapterVO(id)
	local chapterVo = self.mChapterList[id];
	if chapterVo == nil then
		print('无效的章节..'..id);
	end
	return chapterVo;
end

function DungeonModel:GetDungeonVO(id)
	local chapter_id = self.mConfigSysdungeon[id].chapter_id;
	return self:GetDungeonVOBy2ID(chapter_id, id);
end

function DungeonModel:GetDungeonVOBy2ID(chapter_id, dungeon_id)
	local dungeon_vo = self.mChapterList[chapter_id].mDungeonList[dungeon_id];
	if dungeon_vo == nil then
		print('无效的关卡...', dungeon_id)
	end
	return dungeon_vo;
end

function DungeonModel:GetNewOpenStoryId( last_story )
	local new_story = 0;
	if last_story == 0 then
		new_story = 1101;
	else
		new_story = self.mConfigSysstory[ last_story ].next_story;
	end
	return new_story;
end

function DungeonModel:IsAllStoryPass(  )
	return self:GetNewOpenStoryId( self.mLastPlayStory ) == 0;
end

function DungeonModel:IsStoryNeedCombat( story_id )
	local dungeonId = self:GetStoryCombatId( story_id );
	return dungeonId ~= 0 and dungeonId > self:GetLastPassLevel( );
end

function DungeonModel:GetLastPassStory(  )
	return self.mLastPlayStory;
end

function DungeonModel:GetLastPassLevel(  )
	return self.mLastPassLevel;
end

function DungeonModel:GetStoryCombatId( story_id )
	return self.mConfigSysstory[ story_id ].dungeon_id;
end

function DungeonModel:GetChapterVOByStory( story_id )
	local chapter_data = self.mChapterByIndex;
	for k, v in pairs( chapter_data ) do
		if v:IsThisChapterStory( story_id ) then
			return v;
		end
	end
	print( '找不到对应的章节, story_id: ',  story_id);
end

function DungeonModel:GetStoryNameById( story_id )
	return self.mConfigSysstory[ story_id ].story_name;
end

function DungeonModel:RefreshChapterState()
	local last_story = self.mLastPlayStory;
	local last_level = self.mLastPassLevel;
	local new_level = self.mNewOpenLevel;
	local chapter_data = self.mChapterByIndex;
	for i = 1, #chapter_data do
		chapter_data[i]:OnUpdateChapterStory( last_story , last_level, new_level ) ;
	end
end

--update
function DungeonModel:OnRecvDungeonSweep( dungeon_id )
	mEventDispatcher:Dispatch(mEventEnum.ON_DUNGEON_SWEEP);
end

--剧情结束
function DungeonModel:OnRecvMainStoryEnd( story_id )
	self.mLastPlayStory = story_id;
	self:SetNewOpenLevel( story_id );
	self:RefreshChapterState();
	mEventDispatcher:Dispatch(mEventEnum.ON_MAIN_STORY_END, story_id);
end

--副本结束
function DungeonModel:OnRecvDungeonOver( dungeon_id )
	local last_level = self.mLastPassLevel;
	if dungeon_id > last_level then
		self.mLastPassLevel = dungeon_id;
		self:RefreshChapterState();
		self:GetDungeonVO(dungeon_id):OnRecvDungeonOver( );
		mEventDispatcher:Dispatch(mEventEnum.ON_NEW_DUNGEON_PASS, dungeon_id);
	end
end

--根据后端返回的数据更新副本数据--
function DungeonModel:OnRecvDungeonData(pbPlotDungeonInfo)
	self:InitDungeonConfig( );
	self:InitChapterToDungeonData();

	local level_id = pbPlotDungeonInfo.top_id;  --通关的最高副本id
	local story_id = pbPlotDungeonInfo.dun_id;  --剧情播放的最新id
	for k, v in ipairs( self.mChapterByIndex ) do
		for index, dungeon_vo in pairs( v.mDungeonByIndex) do
			if dungeon_vo.mID <= level_id then
				dungeon_vo:SetLevelPass( );
			else
				break;
			end
		end
	end

	self.mLastPassLevel = level_id;
	self.mLastPlayStory = story_id;
	self.mNewOpenLevel =  level_id;
	self:SetNewOpenLevel( story_id );
	self:RefreshChapterState();
	mEventDispatcher:Dispatch(mEventEnum.ON_GET_DUNGEON_DATA);
end

function DungeonModel:SetNewOpenLevel( story_id )
	if story_id ~= 0 then
		local dungeonId = self:GetStoryCombatId( story_id );
		if dungeonId ~= 0 then
			self.mNewOpenLevel = dungeonId;
			self:GetDungeonVO( dungeonId ):SetLevelOpen( );
		end
	end
end
--data

return DungeonModel;