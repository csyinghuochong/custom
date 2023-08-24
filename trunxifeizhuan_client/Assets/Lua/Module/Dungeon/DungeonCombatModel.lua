local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mSceneManager = require "Module/Scene/SceneManager"
local mGameModelManager = require "Manager/GameModelManager"
local mCombatModelBase = require "Module/Combat/CombatModelBase"
local mDungeonController = require "Module/Dungeon/DungeonController"
local DungeonCombatModel = mLuaClass("DungeonCombatModel", mCombatModelBase);
local mGameTimer = require "Core/Timer/GameTimer"
local mSuper;

function DungeonCombatModel:OnLuaNew(dungeon)
	mSuper = self:GetSuper(mCombatModelBase.LuaClassName);
	mSuper.OnLuaNew(self, dungeon);

	self.mShowReliveView = true;
	self.mDungeonVO = mGameModelManager.DungeonModel.mConfigSysdungeon[ dungeon ];
end

function DungeonCombatModel:InitComponent(  )
	self:InitActorManger(1);
	self:InitResultComponent();
end

function DungeonCombatModel:OnCombatStart()
	mSuper.OnCombatStart(self);
	self.mCombatActorManager:BeginCombat();
end

function DungeonCombatModel:GetBattleActors()
	local heros = self:GetDungeonBattleHero();
	local heroList = { heros  };
	return heroList,nil;
end

--需要根据剩余总血量计算星级(规则未定)--
function DungeonCombatModel:OnCombatOver(result)
	self.mResult = result;
	mDungeonController:SendDungeonResult( result );
	mSuper.OnCombatOver(self, self.mResult);
end

function DungeonCombatModel:OpenResurgenceView( result )
	local resurgenceback = function (result)
   	   self:ResurgenceResult(result);
   end
   mGameTimer.SetTimeout(2, function()mDungeonController:OpenResurgenceView(resurgenceback);end);
end

function DungeonCombatModel:ResurgenceResult(result)
	if result == 1 then
       mDungeonController:SendRebornBattle();
	else
       self:OnCombatOver(0);
	end
end

function DungeonCombatModel:RecvReliveResult()
	self.mCombatActorManager:ReliveTeam(1);
	self.mCombatResultContrl:SetResult(nil);
end

function DungeonCombatModel:ShowResultView( result )
	if result == 1 then
		mUIManager:HandleUI(mViewEnum.BalanceWinView, 1, mDungeonController:GetDungeonWinReward());
	else
		mUIManager:HandleUI(mViewEnum.BalanceFailView, 1,mDungeonController:GetDungeonFailReward());
	end
end

function DungeonCombatModel:OnCombatAgain(  )
	local dungeon_id = mDungeonController.mDungeonId;
	mDungeonController:SendChallengeDungeon(dungeon_id, mDungeonController.mEnterType);
end

function DungeonCombatModel:OnCombatReturn( )
	local callBack = function()
		mDungeonController:OnCombatOpenDungeon();
	end
	mSceneManager:AddEnterSceneCallBack(callBack);
	mSceneManager:AskForEnterScene(1);
end

return DungeonCombatModel;