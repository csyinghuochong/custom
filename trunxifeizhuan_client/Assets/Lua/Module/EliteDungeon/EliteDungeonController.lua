local mLuaClass = require "Core/LuaClass"
local mBaseController = require "Core/BaseController"
local mGameModelManager = require "Manager/GameModelManager"
local mCombatModelManager = require "Module/Combat/CombatModelManager"
local mCommonRewardVO = require "Module/CommonUI/CommonRewardVO"
local CombatResultEnum = require "Module/Combat/CombatResultEnum"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local EliteDungeonController = mLuaClass("EliteDungeonController",mBaseController);

--协议处理--
function EliteDungeonController:AddNetListeners()
	local s2c = self.mS2C;
	s2c:ELITE_DUNGEON_LIST(function(pbEliteDungeonList)
		mGameModelManager.EliteDungeonModel:OnRecvEliteDungeonList(pbEliteDungeonList);
	end);

	s2c:ELITE_DUNGEON_BATTLE(function(pbEliteDungeonBattleResult)
		mGameModelManager.EliteDungeonModel:OnRecvEliteDungeonBattle(pbEliteDungeonBattleResult);
		local dungeon_id = pbEliteDungeonBattleResult.dungeon_id;
		mCombatModelManager:CreateEliteDungeonCombatModel(dungeon_id);
		self.mDungeonReward = pbEliteDungeonBattleResult.reward;
	end);

	s2c:ELITE_DUNGEON_BATTLE_RESULT(function(pbEliteDungeonBattleResult)
		if self.mWin ~= CombatResultEnum.CombatFail then
			mGameModelManager.EliteDungeonModel:OnRecvEliteDungeonBattleResult(pbEliteDungeonBattleResult);
		end
		self.mDungeonReward = pbEliteDungeonBattleResult.reward;
		self.mDungeonRewardTalents = pbEliteDungeonBattleResult.talent_reward;
	end);

	s2c:ELITE_DUNGEON_REBORN(function(pbResult)
		-- 复活
        mCombatModelManager.mCurrentModel:RecvReliveResult();
	end);
end

--事件处理--
function EliteDungeonController:AddEventListeners()
	
end

function EliteDungeonController:OnOpenCombatView( )
	mUIManager:HandleUI(mViewEnum.CombatView,1);
end

function EliteDungeonController:GetDungeonWinReward(  )
	local reward = mCommonRewardVO.LuaNew();
	reward:InitDungeonReward(self.mDungeonReward);
	reward:InitDungeonRewardTalents(self.mDungeonRewardTalents);
	return reward;
end

function EliteDungeonController:GetEliteDungeonList()
	self.mC2S:ELITE_DUNGEON_LIST(true);
end

function EliteDungeonController:FightEliteDungeon(id)
	self.mC2S:ELITE_DUNGEON_BATTLE(id,true);
end

function EliteDungeonController:FightEliteDungeonResult(win)
	self.mWin = win;
	local model = mGameModelManager.EliteDungeonModel;
	local dungeonID = model.mSelectDungeonID;
	self.mC2S:ELITE_DUNGEON_BATTLE_RESULT(dungeonID,win,self.mDungeonReward,true);
end

function EliteDungeonController:SendResurgence()
	local model = mGameModelManager.EliteDungeonModel;
	self.mC2S:ELITE_DUNGEON_REBORN(model.mSelectDungeonID,true);
end

function EliteDungeonController:OpenResurgenceView(callBack)
	mUIManager:HandleUI(mViewEnum.CampDungeonResurgenceView,1,callBack);
end

local mEliteDungeonControllerInstance = EliteDungeonController.LuaNew();
return mEliteDungeonControllerInstance;