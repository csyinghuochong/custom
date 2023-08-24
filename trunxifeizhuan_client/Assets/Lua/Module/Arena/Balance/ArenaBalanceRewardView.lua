local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mCombatModelManager = require "Module/Combat/CombatModelManager"
local ArenaBalanceScoreView = require "Module/Arena/Balance/ArenaBalanceScoreView"
local ArenaBalanceRewardView = mLuaClass("ArenaBalanceRewardView", mBaseWindow);

function ArenaBalanceRewardView:InitViewParam()
	return {
		["viewPath"] = "ui/arena/",
		["viewName"] = "arena_balance_reward_view",
		["ParentLayer"] = mBattleLayer1,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
	};
end

function ArenaBalanceRewardView:Init()
	self.mTextPlayName = self:FindComponent( 'object2/Text_1', 'Text' );
	
	self.mPlayerItem1 = ArenaBalanceScoreView.LuaNew( self:Find( 'player1' ).gameObject );
	self.mPlayerItem2 = ArenaBalanceScoreView.LuaNew( self:Find( 'player2' ).gameObject );
end

function ArenaBalanceRewardView:ShowPlayName( )
	self.mTextPlayName.text = mCombatModelManager.mCurrentModel:GetDungeonPlayVO().play_name;
end

function ArenaBalanceRewardView:OnViewShow(data)
	self:ShowPlayName( );
	self:ShowPlayerInfo( data );
end

function ArenaBalanceRewardView:ShowPlayerInfo( data )
	local player1 = self.mPlayerItem1;
	local player2 = self.mPlayerItem2;
	player1:ShowPlayerHead( data:GetSelfPlayerVO( ) );
	player1:ShowPlayerScore(data:GetSelfScoreVO(  ) );
	player1:ShowPlayerMoney(data:GetSelfMoneyVO( ) );
	player2:ShowPlayerHead( data:GetEnemyPlayerVO( ) );
	player2:ShowPlayerScore(data:GetEnemyScoreVO( ) );
end

function ArenaBalanceRewardView:OnClickHideView()
	self:HideView( );
	mCombatModelManager.mCurrentModel:OnCombatReturn();
end

function ArenaBalanceRewardView:Dispose( )
	self.mPlayerItem1:CloseView( );
	self.mPlayerItem2:CloseView( );
end

return ArenaBalanceRewardView;