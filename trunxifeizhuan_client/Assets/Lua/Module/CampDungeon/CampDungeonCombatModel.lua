local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum";
local mUIManager = require "Manager/UIManager"
local mSceneManager = require "Module/Scene/SceneManager"
local mGameModelManager = require "Manager/GameModelManager"
local mCombatModelBase = require "Module/Combat/CombatModelBase"
local mCampDungeonController = require "Module/CampDungeon/CampDungeonController"
local CampDungeonCombatModel = mLuaClass("CampDungeonCombatModel", mCombatModelBase);
local mSuper;

function CampDungeonCombatModel:OnLuaNew(dungeon)

	mSuper = self:GetSuper(mCombatModelBase.LuaClassName);
	mSuper.OnLuaNew(self, dungeon);

	self.mShowReliveView = true;
end

function CampDungeonCombatModel:InitComponent()
	self:InitActorManger(1);
	self:InitResultComponent();
end

function CampDungeonCombatModel:OnCombatStart()
    mSuper.OnCombatStart(self);

	self.mCombatActorManager:BeginCombat();
end

function CampDungeonCombatModel:GetBattleActors()
	local heros = self:GetDungeonBattleHero();
	local heroList = { heros  };

	return heroList,nil;
end

function CampDungeonCombatModel:RecvReliveResult()
	self.mCombatActorManager:ReliveTeam(1);
	self.mCombatResultContrl:SetResult(nil);
end

function CampDungeonCombatModel:OpenResurgenceView( result )
	local resurgenceback = function (result)
   	   self:ResurgenceResult(result);
   end
   mCampDungeonController:OpenResurgenceView(resurgenceback);
end

function CampDungeonCombatModel:ResurgenceResult(result)
	if result == 1 then
       mCampDungeonController:SendResurgence();
	else
       self:OnCombatOver(0);
	end
end

function CampDungeonCombatModel:OnCombatOver(result)
	self.mOpenLV = mGameModelManager.CampDungeonModel:GetOpenLevel(mCampDungeonController.mCampID,mCampDungeonController.mLevelID);
    mCampDungeonController:SendBattleOver(result);
	mSuper.OnCombatOver(self,result);
end

function CampDungeonCombatModel:ShowResultView( result )
	self.mResult = result;
	if result == 1 then
		mUIManager:HandleUI(mViewEnum.BalanceWinView, 1, self:GetCombatReward());
	else
		mUIManager:HandleUI(mViewEnum.BalanceFailView, 1);
	end
end

function CampDungeonCombatModel:OnCombatAgain()
	local dungeon_id = mCampDungeonController.mLevelID;
	local camp_id = mCampDungeonController.mCampID;
	mCampDungeonController:SendChallengeCampDungeon(camp_id, dungeon_id);
end

function CampDungeonCombatModel:OnCombatReturn()
	local callBack = function()
	    local params = {openLevel = self.mOpenLV};
		mUIManager:HandleUI(mViewEnum.CampDungeonView,1,params);
	end
	mSceneManager:AddEnterSceneCallBack(callBack);
	mSceneManager:AskForEnterScene(1);
end

function CampDungeonCombatModel:GetCombatReward()
	return mCampDungeonController:GetDungeonWinReward();
end

return CampDungeonCombatModel;