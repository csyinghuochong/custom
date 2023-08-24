local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mSceneManager = require "Module/Scene/SceneManager"
local mGameModelManager = require "Manager/GameModelManager"
local mCombatModelBase = require "Module/Combat/CombatModelBase"
local FollowerController = require "Module/Follower/FollowerController"
local mCombatActorManager = require "Module/Combat/CombatActorManager"
local FollowerDungeonCombatModel = mLuaClass("FollowerDungeonCombatModel", mCombatModelBase);
local mSuper;

function FollowerDungeonCombatModel:OnLuaNew(dungeon)
	mSuper = self:GetSuper(mCombatModelBase.LuaClassName);
	mSuper.OnLuaNew(self, dungeon);
end

function FollowerDungeonCombatModel:InitComponent(  )
	self:InitActorManger(1);
	self:InitResultComponent();
end

function FollowerDungeonCombatModel:OnCombatStart()
	mSuper.OnCombatStart(self);
	
	self.mCombatActorManager:BeginCombat();
end

function FollowerDungeonCombatModel:GetBattleActors()
	local mFollowerModel = mGameModelManager.FollowerModel;
	local heros = mFollowerModel:GetDungeonBattleHero();
	local heroList = { heros  };

	return heroList,nil;
end

function FollowerDungeonCombatModel:OnCombatOver(result)
	if result == 1 then
		FollowerController:SendFollowerPassBiography();
	end

	mSuper.OnCombatOver(self, result);
end

function FollowerDungeonCombatModel:ShowResultView(result)
	if result == 1 then
		mUIManager:HandleUI(mViewEnum.BalanceWinView, 1, self:GetCombatReward());
	else
		mUIManager:HandleUI(mViewEnum.BalanceFailView, 1);
	end
end

function FollowerDungeonCombatModel:OnCombatReturn()
	local callBack = function()
		FollowerController:OnCombatOpenDungeon();
	end
	mSceneManager:AddEnterSceneCallBack(callBack);
	mSceneManager:AskForEnterScene(1);
end

function FollowerDungeonCombatModel:GetCombatReward()
	return FollowerController:GetDungeonWinReward();
end

return FollowerDungeonCombatModel;