local mLuaClass = require "Core/LuaClass"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum";
local mSceneManager = require "Module/Scene/SceneManager"
local ArenaController = require "Module/Arena/ArenaController"
local mCombatModelBase = require "Module/Combat/CombatModelBase"
local mCombatActorManager = require "Module/Combat/CombatActorManager"
local ArenaCombatModel = mLuaClass("ArenaCombatModel", mCombatModelBase);
local mSuper;

function ArenaCombatModel:OnLuaNew(dungeon, teamVO)
	self.mTeamVO = teamVO;

	mSuper = self:GetSuper(mCombatModelBase.LuaClassName);
	mSuper.OnLuaNew(self, dungeon);
end

function ArenaCombatModel:InitComponent(  )
	self:InitActorManger(1);
	self:InitResultComponent();
end

function ArenaCombatModel:OnCombatStart()
	mSuper.OnCombatStart(self);

	self.mCombatActorManager:BeginCombat();
end

function ArenaCombatModel:GetBattleActors()
	local teamVO = self.mTeamVO;
	local SelfHeros = {teamVO.mSelfHeros};
	local EnemyHeros = {teamVO.mEnemyHeros};
	return SelfHeros,EnemyHeros;
end

function ArenaCombatModel:OnCombatOver(result)
	mSuper.OnCombatOver(self, result);
end

function ArenaCombatModel:ShowResultView(result)
	ArenaController:SendArenaBattleResult(result, result == 1 and 1 or 0, result == 1 and 0 or 1);
end

function ArenaCombatModel:OnCombatReturn(  )
	local callBack = function()
		mUIManager:HandleUI(mViewEnum.ArenaMainView,1)
	end
	mSceneManager:AddEnterSceneCallBack(callBack);
	mSceneManager:AskForEnterScene(1);
end

return ArenaCombatModel;