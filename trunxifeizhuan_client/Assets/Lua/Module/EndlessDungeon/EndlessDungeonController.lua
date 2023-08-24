local mLuaClass = require "Core/LuaClass"
local mBaseController = require "Core/BaseController"
local mGameModelManager = require "Manager/GameModelManager"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mEventEnum = require "Enum/EventEnum"
local mCommonRewardVO = require "Module/CommonUI/CommonRewardVO"
local mCombatModelManager = require "Module/Combat/CombatModelManager"
local CombatResultEnum = require "Module/Combat/CombatResultEnum"
local EndlessController = mLuaClass("EndlessController",mBaseController);

function EndlessController:OnLuaNew()
	local super = self:GetSuper(mBaseController.LuaClassName);
	super.OnLuaNew(self);
end

function EndlessController:AddNetListeners()
	self.mS2C:CLIMB_TOWERS(function(pbClimbTowers)
		for i,v in ipairs(pbClimbTowers.list) do
			mGameModelManager.EndlessDungeonModel:RecvEndlessData(v);
		end
        self:Dispatch(mEventEnum.ON_GET_ENDLESS_DATA);
	end);
	self.mS2C:CLIMB_TOWER_ENTER(function(pbEnterResult)
		local chapter = pbEnterResult.chapter;
		local chapterEnum = mGameModelManager.EndlessDungeonModel.mChapterEnum;
		self.mDungeonReward = pbEnterResult.reward;
		if chapter == chapterEnum.Meiren then
		   local levelID = mGameModelManager.EndlessDungeonModel.mMeirenxinjiData.mBattleID;
		   self.mLevelID = levelID;
		   local data = mGameModelManager.EndlessDungeonModel.mMeirenxinjiData;
           self.mDefeatData = {name = data.mTargetName,model = data.mTargetSex};
           mCombatModelManager:CreateMeirenxinjiCombatModel(levelID, 1);
        elseif chapter == chapterEnum.Gongshen then
           local levelID = mGameModelManager.EndlessDungeonModel.mGongshensihaiData.mBattleID;
		   self.mLevelID = levelID;
		   mCombatModelManager:CreateGongshensihaiCombatModel(levelID, 1);

		elseif chapter == chapterEnum.ShengongNormal or chapter == chapterEnum.ShengongHard then
		   local levelID = mGameModelManager.EndlessDungeonModel.mShengongmeiyingData.mBattleID;
		   self.mLevelID = levelID;
		   mCombatModelManager:CreateShengongmeiyingCombatModel(levelID);
		end
	end);
	self.mS2C:CLIMB_TOWER_RESULT(function (pbClimbTowerResult)
		if pbClimbTowerResult.result ~= CombatResultEnum.CombatFail then
		   local chapterEnum = mGameModelManager.EndlessDungeonModel.mChapterEnum;
           local enterChapter = self.mEnterChapter;
           if enterChapter == chapterEnum.Gongshen then
              mGameModelManager.EndlessDungeonModel:RefreshGongshensihaiData();
           elseif enterChapter == chapterEnum.ShengongNormal or enterChapter == chapterEnum.ShengongHard then
              --mGameModelManager.EndlessDungeonModel:RefreshShengongmeiyingData();
           end
		end
		self.mDungeonReward = pbClimbTowerResult.reward;
		self.mDungeonRewardTalents = pbClimbTowerResult.talent_reward;
	end)
end

function EndlessController:EnterDungeon(chapter)
	local chapterEnum = mGameModelManager.EndlessDungeonModel.mChapterEnum;
	if chapter == chapterEnum.Meiren then
        mUIManager:HandleUI(mViewEnum.EndlessMeirenxinjiView,1);
    elseif chapter == chapterEnum.Gongshen then
        mUIManager:HandleUI(mViewEnum.EndlessGongshensihaiView,1);
    elseif chapter == chapterEnum.ShengongNormal or chapter == chapterEnum.ShengongHard then
        mUIManager:HandleUI(mViewEnum.EndlessShengongmeiyingView,1);
	end
end

function EndlessController:SendGetEndlessInfo(chapters)
	self.mC2S:CLIMB_TOWERS(chapters,true);
end

function EndlessController:SendChallengeEndless(chapter,buffs)
    self.mEnterChapter = chapter;
	self.mC2S:CLIMB_TOWER_ENTER(chapter,buffs);
end

function EndlessController:SendPlayStory(statrId,EndId)
	self.mC2S:CLIMB_TOWER_UPDATE_STORY(statrId,EndId);
end

function EndlessController:SendChallengeEndlessResult(result,noHp)
    if noHp then
       self.mC2S:CLIMB_TOWER_RESULT(result,nil,self.mDungeonReward);
    else
       self.mC2S:CLIMB_TOWER_RESULT(result,self.mHpList,self.mDungeonReward);
    end
	
end

function EndlessController:OnOpenCombatView()
	mUIManager:HandleUI(mViewEnum.CombatView,1);
end

function EndlessController:GetDungeonWinReward(  )
	local reward = mCommonRewardVO.LuaNew();
	reward:InitDungeonReward(self.mDungeonReward);
	reward:InitDungeonRewardTalents(self.mDungeonRewardTalents);
	return reward;
end

function EndlessController:SetMeirenxinjiRemainHpList(list)
	self.mHpList = list;
end

return EndlessController.LuaNew();