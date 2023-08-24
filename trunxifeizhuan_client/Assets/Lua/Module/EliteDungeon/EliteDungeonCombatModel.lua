local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum";
local mUIManager = require "Manager/UIManager"
local mSceneManager = require "Module/Scene/SceneManager"
local mGameModelManager = require "Manager/GameModelManager"
local mCombatModelBase = require "Module/Combat/CombatModelBase"
local mEliteDungeonController = require "Module/EliteDungeon/EliteDungeonController"
local EliteDungeonCombatModel = mLuaClass("EliteDungeonCombatModel", mCombatModelBase);
local mSuper;

function EliteDungeonCombatModel:OnLuaNew(dungeon, params)
	self.mCombatParams = params;
	mSuper = self:GetSuper(mCombatModelBase.LuaClassName);
	mSuper.OnLuaNew(self, dungeon);

	self.mShowReliveView = true;
end

function EliteDungeonCombatModel:InitComponent()
	self:InitActorManger(1);
	self:InitResultComponent();
end

function EliteDungeonCombatModel:OnCombatStart()
    mSuper.OnCombatStart(self);

	self.mCombatActorManager:BeginCombat();
end

function EliteDungeonCombatModel:GetBattleActors()
	local heros = self:GetDungeonBattleHero();
	local heroList = { heros  };

	return heroList,nil;
end

function EliteDungeonCombatModel:RecvReliveResult()
	self.mCombatActorManager:ReliveTeam(1);
	self.mCombatResultContrl:SetResult(nil);
end

function EliteDungeonCombatModel:OpenResurgenceView( result )
	local resurgenceback = function (result)
   	   self:ResurgenceResult(result);
   end
   mEliteDungeonController:OpenResurgenceView(resurgenceback);
end

function EliteDungeonCombatModel:ResurgenceResult(result)
	if result == 1 then
       mEliteDungeonController:SendResurgence();
	else
       self:OnCombatOver(0);
	end
end

function EliteDungeonCombatModel:OnCombatOver(result)
	mEliteDungeonController:FightEliteDungeonResult(result);
	mSuper.OnCombatOver(self,result);
end

function EliteDungeonCombatModel:ShowResultView( result )
	self.mResult = result;
	if result == 1 then
		mUIManager:HandleUI(mViewEnum.BalanceWinView, 1, self:GetCombatReward());
	else
		mUIManager:HandleUI(mViewEnum.BalanceFailView, 1);
	end
end

function EliteDungeonCombatModel:OnCombatReturn()
	local callBack = function()
	 --    local params = {openLevel = self.mOpenLV};
		-- mUIManager:HandleUI(mViewEnum.CampDungeonView,1,params);
	end
	mSceneManager:AddEnterSceneCallBack(callBack);
	mSceneManager:AskForEnterScene(1);
end

function EliteDungeonCombatModel:GetCombatReward()
	return mEliteDungeonController:GetDungeonWinReward();
end

return EliteDungeonCombatModel;