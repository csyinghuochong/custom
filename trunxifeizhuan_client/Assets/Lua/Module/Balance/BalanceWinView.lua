local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBaseWindow = require "Core/BaseWindow"
local mUIManager = require "Manager/UIManager"
local mSceneManager = require "Module/Scene/SceneManager"
local mSoundConst = require "ConfigFiles/ConfigSyssoundConst"
local BalanceMoneyView = require "Module/Balance/BalanceMoneyView";
local mCombatModelManager = require "Module/Combat/CombatModelManager"
local BalancePlayerExpView = require "Module/Balance/BalancePlayerExpView";
local BalanceWinView = mLuaClass("BalanceWinView", mBaseWindow);

function BalanceWinView:InitViewParam()
	return {
		["viewPath"] = "ui/balance/",
		["viewName"] = "balance_win_view",
		["ParentLayer"] = mBattleLayer1,
	};
end

function BalanceWinView:Init()
	self:FindAndAddClickListener('button_1', function() self:OnClickBg() end);
	self:FindAndAddClickListener('object2/box_1', function() self:OnClickBox() end);
	self.mBox1 = self:Find("object2/box_1").gameObject;
	self.mBox2 = self:Find("object2/box_2").gameObject;
	self.mTextPlayName = self:FindComponent( 'object2/Text_1', 'Text' );
	self.mPlayerExpView = BalancePlayerExpView.LuaNew( self:Find("object3").gameObject );
	self:InitBaseRewardView();
end

function BalanceWinView:ShowBaseReward()
	local view = self.mBaseRewardView;
	local list = view:GetItemList(self.mLogicParams);
	view:ForceShowView(list);
end

function BalanceWinView:InitBaseRewardView()
	local view = BalanceMoneyView.LuaNew(self:Find('object2/item_list').gameObject);
	view.mItemType = 1;
	self.mBaseRewardView = view;
end

function BalanceWinView:ShowRewardView()
	local data = self.mLogicParams;
	mUIManager:HandleUI(mViewEnum.BalanceRewardView, 1, data);
end

function BalanceWinView:CheckHaveGoods(  )
	local data = self.mLogicParams;
	local item = data.mItems;
	local talent = data.mTalents;
	return (item ~= nil and item[2] ~= nil and item[2].mCount > 0) or talent ~= nil ;
end

function BalanceWinView:OnClickBg()
	if self.mBoxState == 1 then
		self:OnClickBox( );
	else
		self:OnClickClose( );
	end
end

function BalanceWinView:OnClickClose()
	mCombatModelManager.mCurrentModel:OnCombatReturn();
end

function BalanceWinView:OnClickBox(  )
	self:ShowRewardView();
	self:ShowBoxButton( 2 );
end

function BalanceWinView:ShowBoxButton( box )
	self.mBoxState = box;
	self.mBox1:SetActive( box == 1 );
	self.mBox2:SetActive( box == 2 );
end

function BalanceWinView:ShowPlayName( )
	self.mTextPlayName.text = mCombatModelManager.mCurrentModel:GetDungeonPlayVO().play_name;
end

function BalanceWinView:OnViewShow(logicParams)
	mSceneManager:GetCurScene():StopSound();
	self:Dispatch(self.mEventEnum.PLAY_SOUND,mSoundConst.ty_0012);
	self:ShowPlayName( );
	self:ShowBaseReward();
	self:ShowBoxButton( self:CheckHaveGoods( ) and 1 or 0 );
	self.mPlayerExpView:ForceShowView( );
end

function BalanceWinView:OnViewHide()
	self.mPlayerExpView:HideView( );
	self:Dispatch(self.mEventEnum.STOP_SOUND,mSoundConst.ty_0012);
end

function BalanceWinView:Dispose()
	self.mPlayerExpView:CloseView( );
	self.mBaseRewardView:CloseView();
end

return BalanceWinView;