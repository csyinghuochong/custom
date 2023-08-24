local mLuaClass = require "Core/LuaClass"
local mGameModelManager = require "Manager/GameModelManager"
local mCombatModelBase = require "Module/Combat/CombatModelBase"
local mEndlessDungeonController = require "Module/EndlessDungeon/EndlessDungeonController"
local mGameModelManager = require "Manager/GameModelManager"
local mCombatActorManager = require "Module/Combat/CombatActorManager"
local mConfigSysdungeon = require "ConfigFiles/ConfigSysendless_dungeon"
local mSceneManager = require "Module/Scene/SceneManager"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mBuffManager = require "Battle/Manager/BuffManager";
local mNotifyEnum = require"Enum/NotifyEnum"
local EndlessMeirenxinjiCombatModel = mLuaClass("EndlessMeirenxinjiCombatModel", mCombatModelBase);
local mSuper;

function EndlessMeirenxinjiCombatModel:OnLuaNew(dungeon)
	self.mDungeonId = dungeon;
	self.mDungeonVO = mConfigSysdungeon[dungeon];
	mSuper = self:GetSuper(mCombatModelBase.LuaClassName);
end

function EndlessMeirenxinjiCombatModel:InitComponent()
	self:InitActorManger(1);
	self:InitResultComponent();
end

function EndlessMeirenxinjiCombatModel:OnMonsterBorn(actor)
	if actor.mTeam == 2 then
       mBuffManager:AddBuffsToActor(actor,mGameModelManager.EndlessDungeonModel.mMeirenBuffs);
	else
	   local followerList = mGameModelManager.FollowerModel.mFolloweList2;
       local followerVO = followerList:GetValue(actor.mActorVo.mFollowerUid);
       if followerVO ~= nil then
          actor:Notify(mNotifyEnum.OnUpdateHealth,followerVO:GetMeirenCurrentHp());
       end
	end
end

function EndlessMeirenxinjiCombatModel:GetRemainHp(list,dataList,team)
	if dataList then
       for i,v in ipairs(dataList) do
       		if v.mTeam == team then
			   local remainHp = {};
			   remainHp.id = tonumber(v.mActorVo.mFollowerUid);
			   remainHp.hp = v:GetHealth();
			   remainHp.status = v:GetHealth() <= 0 and 0 or 1;
			   table.insert(list, remainHp);
			end
       end
    end 
end

function EndlessMeirenxinjiCombatModel:OnCombatStart()
    mSuper.OnCombatStart(self);
	self.mCombatActorManager:BeginCombat();
end

function EndlessMeirenxinjiCombatModel:GetBattleActors()
	local heros = self:GetDungeonBattleHero();
	local heroList = { heros  };
	local enemyList = {mGameModelManager.EndlessDungeonModel.mMeirenFightEnemyHeros};
	return heroList,enemyList;
end

function EndlessMeirenxinjiCombatModel:OnCombatOver(result)
	local remainHpList = {};
	local combat = self.mCombatActorManager.mCombat;
	self:GetRemainHp(remainHpList,combat.mAliveActors.mData,1);
	self:GetRemainHp(remainHpList,combat.mDeadActors.mData,1);
	mEndlessDungeonController:SetMeirenxinjiRemainHpList(remainHpList);
    mEndlessDungeonController:SendChallengeEndlessResult(result);
	mSuper.OnCombatOver(self,result);
end

function EndlessMeirenxinjiCombatModel:ShowResultView( result )
	if result == 1 then
		mUIManager:HandleUI(mViewEnum.BalanceWinView, 1,self:GetCombatReward());
	else
		mUIManager:HandleUI(mViewEnum.BalanceFailView, 1);
	end
end

function EndlessMeirenxinjiCombatModel:GetCombatReward()
	return mEndlessDungeonController:GetDungeonWinReward();
end

function EndlessMeirenxinjiCombatModel:OnCombatReturn(result)
	local callBack = function()
	    mUIManager:HandleUI(mViewEnum.EndlessDungeonMainView,1);
	    if result == 2 then
           mUIManager:HandleUI(mViewEnum.EndlessMeirenxinjiView,1);
	    else
           mUIManager:HandleUI(mViewEnum.EndlessMeirenxinjiView,1,mEndlessDungeonController.mDefeatData);
	    end
	end
	mSceneManager:AddEnterSceneCallBack(callBack);
	mSceneManager:AskForEnterScene(1);
end

return EndlessMeirenxinjiCombatModel;