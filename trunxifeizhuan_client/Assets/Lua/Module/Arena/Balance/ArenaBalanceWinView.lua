local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local BalanceWinView = require "Module/Balance/BalanceWinView"
local ArenaBalanceWinView = mLuaClass("ArenaBalanceWinView", BalanceWinView);

function ArenaBalanceWinView:ShowRewardView()
	mUIManager:HandleUI(mViewEnum.ArenaBalanceRewardView, 1, self.mLogicParams);
	self:HideView( );
end

function ArenaBalanceWinView:OnClickBg()
	self:ShowRewardView( );
end

function ArenaBalanceWinView:ShowBoxButton( box )
	self.mBoxState = box;
	self.mBox1:SetActive( false );
	self.mBox2:SetActive( false );
end

return ArenaBalanceWinView;