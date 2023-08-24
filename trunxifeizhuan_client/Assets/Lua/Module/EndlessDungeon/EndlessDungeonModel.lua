local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mEndlessMeirenxinjiVO = require "Module/EndlessDungeon/Meirenxinji/EndlessMeirenxinjiVO"
local mEndlessGongshensihaiVO = require "Module/EndlessDungeon/Gongshensihai/EndlessGongshensihaiVO"
local mEndlessShengongmeiyingVO = require "Module/EndlessDungeon/Shengongmeiying/EndlessShengongmeiyingVO"
local mConfigChapter = require "ConfigFiles/ConfigSysdungeon_chapter"
local mConfigSysendless_dungeon = require "ConfigFiles/ConfigSysendless_dungeon"
local mGameModelManager = require "Manager/GameModelManager"
local EndlessDungeonModel = mLuaClass("EndlessDungeonModel",mBaseModel);

local TYPE_MEIREN = 6;
function EndlessDungeonModel:OnLuaNew()
    self.mChapterEnum = {ShengongNormal = 1401;ShengongHard = 1402,Gongshen = 1501,Meiren = 1601};
    self.mMeirenxinjiMaxLevel = mConfigChapter[self.mChapterEnum.Meiren].dungeon_count;
    self.mNowPosX = 0;
end

function EndlessDungeonModel:RecvEndlessData(pbClimbTower)
	local chapter = pbClimbTower.chapter;
  local chapterEnum = self.mChapterEnum;
	if chapter == chapterEnum.Meiren then
       self:InitMeirenxinjiData(pbClimbTower);
	elseif chapter == chapterEnum.ShengongNormal or chapter == chapterEnum.ShengongHard then
       self:InitShengongmeiyingData(pbClimbTower);
	elseif chapter == chapterEnum.Gongshen then
       self:InitGongshensihaiData(pbClimbTower);
	end
end

function EndlessDungeonModel:RecvEndLessTeamMemberData(pbTeamMemberList)
       local followerList = mGameModelManager.FollowerModel.mFolloweList2;
       for i,v in ipairs(pbTeamMemberList) do
       	   local follower = followerList:GetValue(v.id);
       	   if follower ~= nil then
       	   	  local hp = v.hp;
       	   	  if hp == 0 and v.status == 1 then
                 hp = follower:GetTotalAttr()[1];
       	   	  end 
              follower:SetMeirenCurrentHp(hp);
              followerList:AddOrUpdate(v.id,follower);
       	   end
       end
end

function EndlessDungeonModel:InitMeirenxinjiData(params)
	local meirenxinjiData = self.mMeirenxinjiData;
	self:RecvEndLessTeamMemberData(params.member_list);
	if meirenxinjiData == nil then
       meirenxinjiData = mEndlessMeirenxinjiVO.LuaNew(params.id,params.buffs,params.target,params.status);
       self.mMeirenxinjiData = meirenxinjiData;
	else
       meirenxinjiData.mBattleID = params.id;
       meirenxinjiData.mBuffs = params.buffs;
       meirenxinjiData:SetTargetInfo(params.target);
       meirenxinjiData.mStatus = params.status;
	end
  meirenxinjiData:CreateDefense();
end

function EndlessDungeonModel:InitGongshensihaiData(params)
	local gongshensihaiData = self.mGongshensihaiData;
	if gongshensihaiData == nil then
     gongshensihaiData = mEndlessGongshensihaiVO.LuaNew(params.id,params.status);
     self.mGongshensihaiData = gongshensihaiData;
  else
     gongshensihaiData.mBattleID = params.id;
     gongshensihaiData.mStatus = params.status;
     --gongshensihaiData.mClimbTowerMonsters = params.pbClimbTowerMonsters;
	end
end

function EndlessDungeonModel:RefreshGongshensihaiData()
   local gongshensihaiData = self.mGongshensihaiData;
   local conifg = gongshensihaiData:GetConfig();
   local nextLevel = conifg.next_dungeon;
   if nextLevel ~= 0 then
      gongshensihaiData.mBattleID = nextLevel;
   else
      gongshensihaiData.mStatus = 1;
   end
end

function EndlessDungeonModel:InitShengongmeiyingData(params)
    local shengongmeiyingData = self.mShengongmeiyingData;
	  if shengongmeiyingData == nil then
       shengongmeiyingData = mEndlessShengongmeiyingVO.LuaNew(params.id,params.story_start,params.story_end,params.status,params.chapter,params.wave);
       self.mShengongmeiyingData = shengongmeiyingData;
    else
       shengongmeiyingData.mBattleID = params.id;
       shengongmeiyingData.mStoryID = params.story_start;
       shengongmeiyingData.mStoryEndID = params.story_end;
       shengongmeiyingData.mStatus = params.status;
       shengongmeiyingData.mChapterID = params.chapter;
       shengongmeiyingData.mClimbTowerMonsters = params.wave;
	  end
end

function EndlessDungeonModel:RefreshShengongmeiyingData()
   local shengongmeiyingData = self.mShengongmeiyingData;
   local conifg = shengongmeiyingData:GetConfig();
   local nextLevel = conifg.next_dungeon;
   if nextLevel ~= 0 then
      shengongmeiyingData.mBattleID = nextLevel;
   else
      shengongmeiyingData.mStatus = 1;
   end
end

function EndlessDungeonModel:SetMeirenFightInfo(enemyHeros,buffs)
  self.mMeirenFightEnemyHeros = enemyHeros;
	self.mMeirenBuffs = buffs;
end

function EndlessDungeonModel:SetSelectBuff(buffList)
  self.mBuffList = buffList;
end

function EndlessDungeonModel:GetMeirenBattleHero()
  for i, v in ipairs(mGameModelManager.FollowerModel.mFolloweList2.mSortTable) do
    if v:GetMeirenCurrentHp() > 0 then
       return v;
    end
  end
  return nil;
end

return EndlessDungeonModel;