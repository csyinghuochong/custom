local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mSceneManager = require "Module/Scene/SceneManager"
local mCombatModelBase = require "Module/Combat/CombatModelBase"
local mCombatActorManager = require "Module/Combat/CombatActorManager"
local DianfenggongdouController = require "Module/Dianfenggongdou/DianfenggongdouController"
local DianfengCombatResultControl = require "Module/Dianfenggongdou/DianfengCombatResultControl"
local DianfenggongdouCombatModel = mLuaClass("DianfenggongdouCombatModel", mCombatModelBase);
local mSuper;

function DianfenggongdouCombatModel:OnLuaNew(dungeon, teamVO)
	self.mTeamVO = teamVO;

	mSuper = self:GetSuper(mCombatModelBase.LuaClassName);
	mSuper.OnLuaNew(self, dungeon);
end

function DianfenggongdouCombatModel:InitComponent(  )
	self:InitActorManger(2);
	self:InitResultComponent();
end

function DianfenggongdouCombatModel:InitResultComponent()
	self.mCombatResultContrl = DianfengCombatResultControl.LuaNew(self);
end

function DianfenggongdouCombatModel:OnCombatStart()
	mSuper.OnCombatStart(self);

	self.mCombatActorManager:BeginCombat();
end

function DianfenggongdouCombatModel:GetBattleActors()
	local selfTeam = { };
	local enemyTeam = { };
	for i = 1, 3 do
		selfTeam[ i ] = { }; 
		enemyTeam[ i ] = { };
	end
	for k, v in pairs ( self.mTeamVO.mSelfHeros ) do
		local wave = v.mWave;
		table.insert( selfTeam[ wave ], v );
	end
	for k, v in pairs ( self.mTeamVO.mEnemyHeros ) do
		local wave = v.mWave;
		table.insert( enemyTeam[ wave ], v );
	end
	return selfTeam, enemyTeam;
end

function DianfenggongdouCombatModel:OnCombatOver(result)
	local sefTeam = self.mCombatActorManager.mTeams[1];

	DianfenggongdouController:SendArenaBattleResult(result, sefTeam.mWinTimes, sefTeam.mFailTimes);

	mSuper.OnCombatOver(self, result);
end

function DianfenggongdouCombatModel:OnCombatReturn()
	local callBack = function()
		mUIManager:HandleUI(mViewEnum.PromoteEntryView,1)
		mUIManager:HandleUI(mViewEnum.DianfenggongdouChallengeView,1)
	end
	mSceneManager:AddEnterSceneCallBack(callBack);
	mSceneManager:AskForEnterScene(1);
end

return DianfenggongdouCombatModel;