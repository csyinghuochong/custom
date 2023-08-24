local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum";
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBaseWindow = require "Core/BaseWindow"
local mUIManager = require "Manager/UIManager"
local mGameTimer = require "Core/Timer/GameTimer"
local mSceneManager = require "Module/Scene/SceneManager"
local mSoundConst = require "ConfigFiles/ConfigSyssoundConst"
local BalanceMoneyView = require "Module/Balance/BalanceMoneyView";
local mCombatModelManager = require "Module/Combat/CombatModelManager"
local BalancePlayerExpView = require "Module/Balance/BalancePlayerExpView";
local BalanceFailView = mLuaClass("BalanceFailView", mBaseWindow);
local Vector3 = Vector3;

function BalanceFailView:InitViewParam()
	return {
		["viewPath"] = "ui/balance/",
		["viewName"] = "balance_fail_view",
		["ParentLayer"] = mBattleLayer1,
		["viewBgEnum"] =  mViewBgEnum.transparent_clickable,
	};
end

function BalanceFailView:Init()
	self.mTextPlayName = self:FindComponent( 'object2/Text_1', 'Text' );
	self:FindAndAddClickListener('button_1', function() self:OnClickClose() end);
	self.mPlayerExpView = BalancePlayerExpView.LuaNew(  self:Find("object3").gameObject );
	self:InitBaseRewardView();
end

function BalanceFailView:InitBaseRewardView()
	local view = BalanceMoneyView.LuaNew(self:Find('object2/reward').gameObject);
	view.mItemType = 1;
	self.mBaseRewardView = view;
end

function BalanceFailView:OnClickClose()
	mCombatModelManager.mCurrentModel:OnCombatReturn(2);
end

function BalanceFailView:ShowPlayName( )
	self.mTextPlayName.text = mCombatModelManager.mCurrentModel:GetDungeonPlayVO().play_name;
end

function BalanceFailView:OnViewShow()
	mSceneManager:GetCurScene():StopSound();
	self:Dispatch(self.mEventEnum.PLAY_SOUND,mSoundConst.ty_0013);
	self.mPlayerExpView:ForceShowView( );
	self:ShowReward();
	self:ShowPlayName( );
end

function BalanceFailView:OnViewHide()
	self.mPlayerExpView:HideView( );
	self:Dispatch(self.mEventEnum.STOP_SOUND,mSoundConst.ty_0013);
end

function BalanceFailView:ShowReward()
	local data = self.mLogicParams;
	if data == nil then
		return;
	end
	local view = self.mBaseRewardView;
	local list = view:GetItemList(self.mLogicParams);
	if list then
		view:ForceShowView(list);
	end
end

function BalanceFailView:Dispose()
	self.mPlayerExpView:CloseView( );
	self.mBaseRewardView:CloseView();
end
return BalanceFailView;