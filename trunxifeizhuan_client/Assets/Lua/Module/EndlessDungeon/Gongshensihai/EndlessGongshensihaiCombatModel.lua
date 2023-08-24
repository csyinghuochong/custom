local mLuaClass = require "Core/LuaClass"
local mGameModelManager = require "Manager/GameModelManager"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mCombatModelBase = require "Module/Combat/CombatModelBase"
local mConfigSysdungeon = require "ConfigFiles/ConfigSysendless_dungeon"
local mSceneManager = require "Module/Scene/SceneManager"
local mCombatActorGroup = require "Module/Combat/CombatActorGroup"
local mEndlessDungeonController = require "Module/EndlessDungeon/EndlessDungeonController"
local mBuffManager = require "Battle/Manager/BuffManager";
local EndlessGongshensihaiCombatModel = mLuaClass("EndlessGongshensihaiCombatModel", mCombatModelBase);
local mSuper;


function EndlessGongshensihaiCombatModel:OnLuaNew(dungeon)
	self.mDungeonId = dungeon;
	self.mDungeonVO = mConfigSysdungeon[dungeon];
	mSuper = self:GetSuper(mCombatModelBase.LuaClassName);
end

function EndlessGongshensihaiCombatModel:InitComponent()
	self:InitActorManger(1);
	self:InitResultComponent();
end

function EndlessGongshensihaiCombatModel:OnCombatStart()
    mSuper.OnCombatStart(self);
	self.mCombatActorManager:BeginCombat();
end

function EndlessGongshensihaiCombatModel:GetBattleActors()
	local heros = self:GetDungeonBattleHero();
	local heroList = { heros  };
	return heroList,nil;
end

function EndlessGongshensihaiCombatModel:OnMonsterBorn(actor)
    if actor.mTeam == 2 then
       local data = mGameModelManager.EndlessDungeonModel.mGongshensihaiData;
       local buffs = {data:GetPalaceBuffID(),data:GetLevelBuffID()};
       mBuffManager:AddBuffsToActor(actor,buffs);
    end
end

function EndlessGongshensihaiCombatModel:OnCombatOver(result)
    mEndlessDungeonController:SendChallengeEndlessResult(result,true);
	mSuper.OnCombatOver(self,result);
end

function EndlessGongshensihaiCombatModel:ShowResultView( result )
	if result == 1 then
		mUIManager:HandleUI(mViewEnum.BalanceWinView, 1,self:GetCombatReward());
	else
		mUIManager:HandleUI(mViewEnum.BalanceFailView, 1);
	end
end

function EndlessGongshensihaiCombatModel:GetCombatReward()
	return mEndlessDungeonController:GetDungeonWinReward();
end

function EndlessGongshensihaiCombatModel:OnCombatReturn(result)
	local callBack = function()
	    mUIManager:HandleUI(mViewEnum.EndlessDungeonMainView,1);
	    mUIManager:HandleUI(mViewEnum.EndlessGongshensihaiView,1);
	end
	mSceneManager:AddEnterSceneCallBack(callBack);
	mSceneManager:AskForEnterScene(1);
end

return EndlessGongshensihaiCombatModel;