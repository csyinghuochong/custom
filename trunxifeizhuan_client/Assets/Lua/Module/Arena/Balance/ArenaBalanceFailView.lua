local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBaseWindow = require "Core/BaseWindow"
local mSceneManager = require "Module/Scene/SceneManager"
local mSoundConst = require "ConfigFiles/ConfigSyssoundConst"
local mCombatModelManager = require "Module/Combat/CombatModelManager"
local ArenaBalanceScoreView = require "Module/Arena/Balance/ArenaBalanceScoreView"
local ArenaBalanceFailView = mLuaClass("ArenaBalanceFailView", mBaseWindow);
local Vector3 = Vector3;

function ArenaBalanceFailView:InitViewParam()
	return {
		["viewPath"] = "ui/arena/",
		["viewName"] = "arena_balance_fail_view",
		["ParentLayer"] = mBattleLayer1,
		["viewBgEnum"] =  mViewBgEnum.gray_clickable,
	};
end

function ArenaBalanceFailView:Init()
	self.mTextPlayName = self:FindComponent( 'object2/Text_1', 'Text' );
	self.mPlayerItem1 = ArenaBalanceScoreView.LuaNew( self:Find( 'player1' ).gameObject );
	self.mPlayerItem2 = ArenaBalanceScoreView.LuaNew( self:Find( 'player2' ).gameObject );
end

function ArenaBalanceFailView:OnClickClose()
	mCombatModelManager.mCurrentModel:OnCombatReturn(2);
	self:CloseView();
end

function ArenaBalanceFailView:ShowPlayName( )
	self.mTextPlayName.text = mCombatModelManager.mCurrentModel:GetDungeonPlayVO().play_name;
end

function ArenaBalanceFailView:OnViewShow( data )
	mSceneManager:GetCurScene():StopSound();
	self:Dispatch(self.mEventEnum.PLAY_SOUND,mSoundConst.ty_0013);
	self:ShowPlayName( );
	self:ShowPlayerInfo( data );
end

function ArenaBalanceFailView:ShowPlayerInfo( data )
	local player1 = self.mPlayerItem1;
	local player2 = self.mPlayerItem2;
	player1:ShowPlayerHead( data:GetSelfPlayerVO( ) );
	player1:ShowPlayerScore(data:GetSelfScoreVO(  ) );
	player1:ShowPlayerMoney(data:GetSelfMoneyVO( ) );
	player2:ShowPlayerHead( data:GetEnemyPlayerVO( ) );
	player2:ShowPlayerScore(data:GetEnemyScoreVO( ) );
end

function ArenaBalanceFailView:OnClickHideView()
	self:HideView( );
	mCombatModelManager.mCurrentModel:OnCombatReturn();
end

function ArenaBalanceFailView:OnViewHide()
	
end

function ArenaBalanceFailView:Dispose(  )
	self.mPlayerItem1:CloseView( );
	self.mPlayerItem2:CloseView( );
end

return ArenaBalanceFailView;