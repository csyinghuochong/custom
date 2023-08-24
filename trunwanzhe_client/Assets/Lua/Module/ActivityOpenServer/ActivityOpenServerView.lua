local mLuaClass = require "Core/LuaClass"
local StringUtil = require 'Utils/StringUtil'
local mBaseProxyWindow = require "Core/BaseProxyWindow"
local mActivityOpenModel = require "Module/ActivityOpenServer/ActivityOpenServerModel"
local mActivityOpenServerType = require "Module/ActivityOpenServer/ActivityOpenServerType"
local mActivityOpenServerRankRewardView = require "Module/ActivityOpenServer/ActivityOpenServerRankRewardView"
local mActivityOpenServerRechargeRewardView = require "Module/ActivityOpenServer/ActivityOpenServerRechargeRewardView"
local BgEnum = Assets.Scripts.Com.Game.Enum.BgEnum;
local CSharpInterface = Com.Game.Manager.CSharpToLuaInterface;
local SysSoundConst = Assets.Scripts.Com.Game.Config.SysSoundConst;
local ServerDateTime = Assets.Scripts.Com.Game.Utils.ServerDateTime;
local BaseViewParam = Assets.Scripts.Com.Game.Core.BaseViewParam;
local UIManager = Com.Game.Manager.CSharpToLuaInterface.GetUIManager();
local ActivityOpenServerView = mLuaClass("ActivityOpenServerView",mBaseProxyWindow);
local mString = require 'string'
local DateTime = System.DateTime;
local mColor = Color;
local mVector3 = Vector3;
local instance;

function ActivityOpenServerView:OnLuaNew()
	local baseViewParam = BaseViewParam.New();
	baseViewParam.url = "UI/Activity/ActivityOpenServerView";
	baseViewParam.viewName = "ActivityOpenServerView";
	baseViewParam.ParentLayer = UIManager.mNormalLayer1;
    baseViewParam.bgEnum = BgEnum.GRAY;
    baseViewParam.hideAllActors = true;

	self.mGameProxyWindow = UIManager:RegisterViewFromLua("ActivityOpenServerView",baseViewParam,ActivityOpenServerView.Init,ActivityOpenServerView.Show,ActivityOpenServerView.Hide,ActivityOpenServerView.Dispose);
end

function ActivityOpenServerView.Init()
	instance.mTransform = instance.mGameProxyWindow.transform;
	instance.mGameObject = instance.mGameProxyWindow.gameObject;

	instance.mTransActicityTime = instance:FindChild("activity_time").transform;
	instance.mTextRemainTime = instance:FindComponent('activity_time/txt_lasttime', 'UILabel');
	instance.mTextEndTime = instance:FindComponent('activity_time/txt_endtime', 'UILabel');

	local btn_number = 5;
	local btn_back = {};
	local btn_notify = {};
	local btn_name = {};
	for i = 1, btn_number do
		local btn_path = mString.format('Button/Button%d', i - 1);

        btn_back[i] = instance:FindComponent(mString.format('%s/background', btn_path), 'UISprite')
        btn_notify[i] = instance:FindChild(mString.format('%s/Notify', btn_path));
        btn_name[i] = instance:FindComponent(mString.format('%s/Label', btn_path), 'UILabel');

        CSharpInterface.GameUIEventListenerGet(instance:FindChild(btn_path), function ()
			instance:OnClickButton(i);
		end, SysSoundConst.S_UI_OPEN_VIEW);
	end
	instance.mButtonNumber = btn_number;
	instance.mButtonBack = btn_back;
	instance.mButtonNotify = btn_notify;
	instance.mButtonName = btn_name;

	local btn_close = instance:FindChild("Button_Close");
	CSharpInterface.GameUIEventListenerGet(btn_close,function ()
		instance.mGameProxyWindow:HideView();
	end);

	instance.mGetActiveChargeRewardBack = function(index, id)
		instance:OnGetActiveChargeReward(index, id);
	end

	instance.mRecvGetActiveOpenServerReward = function ( )
		instance:OnRecvActiveOpenServerReward();
	end

	instance:ShowEndTime();
end

function ActivityOpenServerView:OnClickButton(index)
	self:OnSwitchTab(index);
end

function ActivityOpenServerView:OnSwitchTab(index)
	if index == instance.mLastType then
		return;
	end

    instance:SetButton(index);
    instance:HideLastView(instance.mLastType);
    instance:ShowCurrentView(index);
    instance.mLastType = index;
end

function ActivityOpenServerView:HideLastView(index)
	local reward_view = instance.mRankRewardView;
	local recharge_view = instance.mRechargeRewardView;

	if self:IsRankView(index) then
		if reward_view ~= nil then
			reward_view:HideView();
		end
	elseif self:IsRechargeView(index) then
		if  recharge_view~= nil then
			recharge_view:HideView()
		end
	end
end

function ActivityOpenServerView:IsRankView(index)
	return index == mActivityOpenServerType.DUNGRON_RANK 
		or index == mActivityOpenServerType.COMBAT_RANK
		or index == mActivityOpenServerType.ARENA_RANK;
end

function ActivityOpenServerView:IsRechargeView(index)
	return index == mActivityOpenServerType.TODAY_RECHARGE 
		or index == mActivityOpenServerType.All_RECHARGE
end

function ActivityOpenServerView:ShowCurrentView(index)
	local trans_time = instance.mTransActicityTime;
	local reward_view = instance.mRankRewardView;
	local recharge_view = instance.mRechargeRewardView;

	if self:IsRankView(index) then
		if reward_view == nil then
			reward_view = mActivityOpenServerRankRewardView.LuaNew();
			instance.mRankRewardView = reward_view;
		end
		reward_view:SetData(index);
		reward_view:ShowView();
		trans_time.localPosition = mVector3.New(0, -3.5, 0);
	elseif self:IsRechargeView(index) then
		if  recharge_view == nil then
			recharge_view = mActivityOpenServerRechargeRewardView.LuaNew();
			instance.mRechargeRewardView = recharge_view;
		end
		recharge_view:SetData(index);
		recharge_view:ShowView();
		trans_time.localPosition = mVector3.New(0, -25, 0);
	end
end

function ActivityOpenServerView:CheckButtonNotify()
	local btn_notify = self.mButtonNotify;
	for i = 1, self.mButtonNumber do
		btn_notify[i]:SetActive(mActivityOpenModel:CheckActivityOpenServerNotitfyByType(i));
	end
end

function ActivityOpenServerView.Show()
	instance:OnSwitchTab(1);
	instance:ShowLastTime();
	instance:CheckButtonNotify();

	mActivityOpenModel.mGetActiveChargeRewardBack = instance.mGetActiveChargeRewardBack;
	mActivityOpenModel.mRecvGetActiveOpenServerReward = instance.mRecvGetActiveOpenServerReward;
end

function ActivityOpenServerView.Hide()
	instance:HideLastView(instance.mLastType);
    instance.mLastType = -1;

    mActivityOpenModel.mGetActiveChargeRewardBack = nil;
    mActivityOpenModel.mRecvGetActiveOpenServerReward = nil;
end

function ActivityOpenServerView.Dispose()
	local reward_view = instance.mRankRewardView;
	local recharge_view = instance.mRechargeRewardView;
	if reward_view ~= nil then
		reward_view:CloseView();
	end

	if recharge_view ~= nil then
		recharge_view:CloseView();
	end
	instance.mRankRewardView = nil;
	instance.mRechargeRewardView = nil;
end

function ActivityOpenServerView:OnGetActiveChargeReward(index, id)
	instance:CheckButtonNotify();
	
	local recharge_view = instance.mRechargeRewardView;
	if recharge_view ~= nil then
		recharge_view:OnGetActiveChargeReward(index, id);
	end
end

function ActivityOpenServerView:OnRecvActiveOpenServerReward()
	instance:CheckButtonNotify();
	local reward_view = instance.mRankRewardView;
	if reward_view ~= nil then
		reward_view:UpdateButton();
	end
end

function ActivityOpenServerView:ShowEndTime()
	local end_time = mActivityOpenModel.mActiveOpenInfo.end_time;
    local date = ServerDateTime.GetDateTime(end_time);
    self.mTextEndTime.text = mString.format("%d年%d月%d日", date.Year, date.Month, date.Day);
end

function ActivityOpenServerView:ShowLastTime()
	local mActivityLastTime = mActivityOpenModel:GetActiveOpenServerLastTime();
	self.mTextRemainTime.text = StringUtil:SecondsToDHM(mActivityLastTime);
end

local mNormaSprite = 'public_tab_2';
local mDisableSprite = 'public_tab_1';
local mDisableColor = mColor.New(172 / 255,  173 / 255, 196 / 255);
function ActivityOpenServerView:SetButton(index)
     for i = 1, instance.mButtonNumber do
     	instance.mButtonBack[i].spriteName = i == index and mDisableSprite or mNormaSprite;
     	instance.mButtonName[i].color = i == index and mColor.white or mDisableColor;
     end
end

function ActivityOpenServerView:OpenUI()
	UIManager:OpenUIFromLua("ActivityOpenServerView");
end

instance = ActivityOpenServerView.LuaNew();
return instance;