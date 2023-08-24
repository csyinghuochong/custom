local mLuaClass = require "Core/LuaClass"
local mGameModelManager = require "Manager/GameModelManager"
local mCombatModelBase = require "Module/Combat/CombatModelBase"
local mConfigSysdungeon = require "ConfigFiles/ConfigSysendless_dungeon"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mSceneManager = require "Module/Scene/SceneManager"
local mCombatActorGroup = require "Module/Combat/CombatActorGroup"
local mEndlessDungeonController = require "Module/EndlessDungeon/EndlessDungeonController"
local EndlessShengongmeiyingCombatModel = mLuaClass("EndlessShengongmeiyingCombatModel", mCombatModelBase);
local mSuper;

function EndlessShengongmeiyingCombatModel:OnLuaNew(dungeon, params)
	self.mCombatParams = params;
	self.mDungeonId = dungeon;
	self.mDungeonVO = mConfigSysdungeon[dungeon];
	mSuper = self:GetSuper(mCombatModelBase.LuaClassName);
end

function EndlessShengongmeiyingCombatModel:InitComponent()
	self:InitActorManger(1);
	self:InitResultComponent();
end

function EndlessShengongmeiyingCombatModel:OnCombatStart()
    mSuper.OnCombatStart(self);
	self.mCombatActorManager:BeginCombat();
end

function EndlessShengongmeiyingCombatModel:GetBattleActors()
	local heros = self:GetDungeonBattleHero();
	local heroList = { heros  };
	return heroList,nil;
end

function EndlessShengongmeiyingCombatModel:OnMonsterBorn(actor)

end

function EndlessShengongmeiyingCombatModel:InitBattleActorVOList()
	local selfList, enemyList = self:GetBattleActors();
	local group = mCombatActorGroup.LuaNew();
	local list1 = group:InitFollowers(selfList, 1);
	local data = mGameModelManager.EndlessDungeonModel.mShengongmeiyingData;
	local list2 = group:InitEndlessDungeonMonsters(data.mClimbTowerMonsters);
	return list1,list2;
end

function EndlessShengongmeiyingCombatModel:OnCombatOver(result)
    mEndlessDungeonController:SendChallengeEndlessResult(result,true);
	mSuper.OnCombatOver(self,result);
end

function EndlessShengongmeiyingCombatModel:ShowResultView( result )
	if result == 1 then
		mUIManager:HandleUI(mViewEnum.BalanceWinView, 1,self:GetCombatReward());
	else
		mUIManager:HandleUI(mViewEnum.BalanceFailView, 1);
	end
end

function EndlessShengongmeiyingCombatModel:GetCombatReward()
	return mEndlessDungeonController:GetDungeonWinReward();
end

function EndlessShengongmeiyingCombatModel:OnCombatReturn(result)
	local callBack = function()
	    mUIManager:HandleUI(mViewEnum.EndlessDungeonMainView,1);
	    mUIManager:HandleUI(mViewEnum.EndlessShengongmeiyingView,1);
	end
	mSceneManager:AddEnterSceneCallBack(callBack);
	mSceneManager:AskForEnterScene(1);
end

return EndlessShengongmeiyingCombatModel;