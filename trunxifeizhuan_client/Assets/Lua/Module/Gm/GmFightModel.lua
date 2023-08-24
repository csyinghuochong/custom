local mLuaClass = require "Core/LuaClass"
local mCombatModelBase = require "Module/Combat/CombatModelBase"
local mGameModelManager = require "Manager/GameModelManager"
local mConfigSysdungeon = require "ConfigFiles/ConfigSysdungeon"
local GmFightModel = mLuaClass("GmFightModel", mCombatModelBase)
local mUIManager = require "Manager/UIManager"
local mSceneManager = require "Module/Scene/SceneManager"
local mViewEnum = require "Enum/ViewEnum";

function GmFightModel:OnLuaNew(dungeonId, params)
	self.mDungeonId = dungeonId;
	mSuper = self:GetSuper(mCombatModelBase.LuaClassName);
	mSuper.OnLuaNew(self, dungeonId);
end

function GmFightModel:InitComponent()
	self.mDungeonVO = mConfigSysdungeon[self.mDungeonId];
	self:InitActorManger();
	self:InitResultComponent();
end

function GmFightModel:OnCombatStart()
	mSuper.OnCombatStart(self);
	local mFollowerModel = mGameModelManager.FollowerModel;
	local heros = mFollowerModel:GetDungeonBattleHero();
	local heroList = { heros };

	local actorManager = self.mCombatActorManager;
	actorManager:OnInitActors(heroList, nil);
	actorManager:BeginCombat();
end

function GmFightModel:ShowResultView( result )
	if result == 1 then
		mUIManager:HandleUI(mViewEnum.BalanceWinView, 1,self:GetCombatReward());
	else
		mUIManager:HandleUI(mViewEnum.BalanceFailView, 1);
	end
end

function GmFightModel:OnCombatReturn(result)
	local callBack = function()
	    mUIManager:HandleUI(mViewEnum.GmView,1);
	end
	mSceneManager:AddEnterSceneCallBack(callBack);
	mSceneManager:AskForEnterScene(1);
end


return GmFightModel;