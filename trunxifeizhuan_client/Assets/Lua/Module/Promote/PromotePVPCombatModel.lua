local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum";
local mUIManager = require "Manager/UIManager"
local mSceneManager = require "Module/Scene/SceneManager"
local mCommonRewardVO = require "Module/CommonUI/CommonRewardVO"
local mCombatModelBase = require "Module/Combat/CombatModelBase"
local PromoteController = require "Module/Promote/PromoteController"
local mCombatActorManager = require "Module/Combat/CombatActorManager"
local PromotePVPCombatModel = mLuaClass("PromotePVPCombatModel", mCombatModelBase);
local mSuper;

function PromotePVPCombatModel:OnLuaNew(dungeon, teamVO)
	self.mTeamVO = teamVO;

	mSuper = self:GetSuper(mCombatModelBase.LuaClassName);
	mSuper.OnLuaNew(self, dungeon);
end

function PromotePVPCombatModel:InitComponent(  )
	self:InitActorManger(1);
	self:InitResultComponent();
end

function PromotePVPCombatModel:OnCombatStart()
	mSuper.OnCombatStart(self);

	self.mCombatActorManager:BeginCombat();
end

function PromotePVPCombatModel:GetBattleActors()
	local SelfHeros = {self.mTeamVO.mSelfHeros};
	local EnemyHeros = {self.mTeamVO.mEnemyHeros};
	return SelfHeros,EnemyHeros;
end

function PromotePVPCombatModel:OnCombatOver(result)
	local actorMgr = self.mCombatActorManager;
	local left_num = actorMgr:GetTeamAliveNumber(1);
	local total_num = actorMgr:GetTeamAllNumber(1);
	PromoteController:SendPVPBattleResult(result, left_num, total_num);

	mSuper.OnCombatOver(self, result);
end

function PromotePVPCombatModel:ShowResultView(result)
	if result == 1 then
		mUIManager:HandleUI(mViewEnum.BalanceWinView, 1, self:GetCombatReward());
	else
		mUIManager:HandleUI(mViewEnum.BalanceFailView, 1);
	end
end

function PromotePVPCombatModel:GetCombatReward()
	local reward = mCommonRewardVO.LuaNew();
	reward:InitConfigReward(self.mDungeonVO.drop_fragments)
	return reward;
end

function PromotePVPCombatModel:OnCombatReturn(  )
	local callBack = function()
		mUIManager:HandleUI(mViewEnum.PromoteEntryView,1)
		
		mUIManager:HandleUI(mViewEnum.PromoteExamView,1)
	end
	mSceneManager:AddEnterSceneCallBack(callBack);
	mSceneManager:AskForEnterScene(1);
end

return PromotePVPCombatModel;