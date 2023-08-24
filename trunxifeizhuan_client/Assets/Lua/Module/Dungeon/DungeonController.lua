local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mSortTable = require "Common/SortTable"
local mUIManager = require "Manager/UIManager"
local mBaseController = require "Core/BaseController"
local mGameModelManager = require "Manager/GameModelManager"
local CombatResultEnum = require "Module/Combat/CombatResultEnum"
local mCommonRewardVO = require "Module/CommonUI/CommonRewardVO"
local mCommonAllAwardVO = require "Module/CommonUI/CommonAllAwardVO"
local mCombatModelManager = require "Module/Combat/CombatModelManager"
local mBattleArrayViewVO = require "Module/BattleArray/BattleArrayViewVO"
local DungeonController = mLuaClass("DungeonController",mBaseController);

--协议处理--
function DungeonController:AddNetListeners()
	self.mTypeEnum = {CombatLevel = 1; StoryLevel = 2};

	local mS2C = self.mS2C;
	mS2C:DUNGEON_PLOT_LIST(function(pbPlotDungeonInfo)
		mGameModelManager.DungeonModel:OnRecvDungeonData(pbPlotDungeonInfo);
	end);

	mS2C:DUNGEON_PLOT_BATTLE(function(pbPlotDungeonBattleResult)
		mCombatModelManager:CreateDungeonCombatModel(self.mDungeonId);
		self.mDungeonReward = pbPlotDungeonBattleResult.reward;
	end);

	mS2C:DUNGEON_PLOT_BATTLE_OVER(function(pbPlotDungeonBattleResult)
		local dungeon_id = self.mDungeonId;
		local DungeonModel = mGameModelManager.DungeonModel;
		self.mDungeonReward = pbPlotDungeonBattleResult.reward;
		self.mDungeonRewardTalents = pbPlotDungeonBattleResult.talent_reward;

		if self.mCombatResult ~= CombatResultEnum.CombatFail then
		 DungeonModel:OnRecvDungeonOver( pbPlotDungeonBattleResult.dungeon_id );
		end
	end);

	mS2C:DUNGEON_PLOT_PLAY(function(pbResult)
		mGameModelManager.DungeonModel:OnRecvMainStoryEnd( self.mStoryId ); 
	end);

	mS2C:DUNGEON_PLOT_SWEEP(function(pbPlotDungeonSweepResult)
		mUIManager:HandleUI(mViewEnum.CommonGetAwardView, 1, self:GetSweepReward( pbPlotDungeonSweepResult ));
	end);

	mS2C:DUNGEON_PLOT_REBORN(function(pbResult)
		 mCombatModelManager.mCurrentModel:RecvReliveResult();
	end);
end

function DungeonController:GetSweepReward( pbPlotDungeonSweepResult )
	local data_soure = mSortTable.LuaNew(nil,nil,true);
	local index = 1;

	for key, reward in ipairs ( pbPlotDungeonSweepResult.reward ) do

		if reward.talent_reward then
			for k,v in ipairs(reward.talent_reward) do
				local talentData = mCommonAllAwardVO.LuaNew(k,0,true,v,append_status==2)
				data_soure:AddOrUpdate(index,talentData);
				index = index + 1;
			end
		end

		if reward.reward then
			for k,v in ipairs(reward.reward) do
				local goods_id = v.goods_id;
				local goods_data = data_soure:GetValue( goods_id );
				if goods_data then
					local number = v.goods_num + goods_data.mGoodsData.mNumber;
					goods_data.mGoodsData.mNumber = number;
					data_soure:AddOrUpdate(goods_id, goods_data);
				else
					local awardData = mCommonAllAwardVO.LuaNew(v.goods_id,v.goods_num,false,nil,append_status==2);
					data_soure:AddOrUpdate(goods_id, awardData);
				end
			end
		end
	end 
	return data_soure;
end

function DungeonController:GetDungeonWinReward(  )
	local reward = mCommonRewardVO.LuaNew();
	reward:InitDungeonReward(self.mDungeonReward);
	reward:InitDungeonRewardTalents(self.mDungeonRewardTalents);
	return reward;
end

--失败奖励
function DungeonController:GetDungeonFailReward(  )
	local reward = mCommonRewardVO.LuaNew();
	reward:InitDungeonReward(self.mDungeonReward);
	return reward;
end

--事件处理--
function DungeonController:AddEventListeners()

end

function DungeonController:OnOpenCombatView()
	mUIManager:HandleUI(mViewEnum.CombatView,1);
end

function DungeonController:OpenResurgenceView(callBack)
	mUIManager:HandleUI(mViewEnum.CampDungeonResurgenceView,1,callBack);
end

--请求挑战副本   op_type == 1 剧情界面 op_type == 2 挑战界面 
function DungeonController:SendChallengeDungeon(dungeon_id, op_type)
	self.mEnterType = op_type;
	self.mDungeonId = dungeon_id;
	self.mC2S:DUNGEON_PLOT_BATTLE(dungeon_id);
end

function DungeonController:SendCombatStoryEnd( story_id )
	self.mStoryId = story_id;
	self.mC2S:DUNGEON_PLOT_PLAY(story_id, 1);
end

function DungeonController:OnCombatOpenDungeon()
	local op_type = self.mEnterType;
	if op_type == 1 then
		mUIManager:HandleUI(mViewEnum.DungeonStoryEntryView, 1);
	elseif op_type == 2 then
		mUIManager:HandleUI(mViewEnum.DungeonChapterListView, 1);
		mUIManager:HandleUI(mViewEnum.DungeonLevelListView, 1, { dungeon_id = self.mDungeonId });
	end
end

function DungeonController:OnCombatOpenTeamView(  )
	local dataVO = mBattleArrayViewVO.LuaNew();
	dataVO:InitPVETeam(self.mDungeonId, function (  )
		self:SendChallengeDungeon( self.mDungeonId , self.mEnterType);
	end, 6, 6);
	mUIManager:HandleUI(mViewEnum.BattleArrayView, 1, dataVO);
end

--请求副本信息
function DungeonController:SendReqDungeonInfo(  )
	self.mC2S:DUNGEON_PLOT_LIST(true);
end

--挑战副本结果--
function DungeonController:SendDungeonResult( result )
	self.mCombatResult = result;
	local rewards = self.mDungeonReward;
	if result == CombatResultEnum.CombatFail then
		rewards = mCombatModelManager.mCurrentModel:GetFaildReward( rewards );
	end
	self.mC2S:DUNGEON_PLOT_BATTLE_OVER(self.mDungeonId, result, rewards);
end

--扫荡
function DungeonController:SendDungeonSweep(chapter_id )
	self.mC2S:DUNGEON_PLOT_SWEEP( chapter_id );
end

--复活再战
function DungeonController:SendRebornBattle(  )
	self.mC2S:DUNGEON_PLOT_REBORN(self.mDungeonId,true);
end

local mDungeonControllerInstance = DungeonController.LuaNew();
return mDungeonControllerInstance;