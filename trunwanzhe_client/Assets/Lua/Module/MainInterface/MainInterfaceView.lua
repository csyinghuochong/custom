local mLuaClass = require "Core/LuaClass"
local mBaseProxyWindow = require "Core/BaseProxyWindow"
local NotifyDef = require "Module/CommonUI/NotifyDef"
local NotifyManager = require "Module/CommonUI/NotifyManager"
local RenderQueueEnum = Assets.Scripts.Com.Game.Enum.RenderQueueEnum;
local CSharpInterface = Com.Game.Manager.CSharpToLuaInterface;
local SysSoundConst = Assets.Scripts.Com.Game.Config.SysSoundConst;
local EventConst = Assets.Scripts.Com.Game.Events.EventConstant;
local UIManager = Com.Game.Manager.CSharpToLuaInterface.GetUIManager();
local mActivityView = require "Module/Activity/ActivityView"
local mActivityModel = require "Module/Activity/ActivityModel"
local mLandRewardModel = require "Module/LandReward/LandRewardModel"
local mLandRewardView = require "Module/LandReward/LandRewardView"
local mGrowFundView = require "Module/GrowFund/GrowFundView"
local mFirstRechargeView = require "Module/Activity/FirstRechargeView"
local mActivityOpenServerView = require "Module/ActivityOpenServer/ActivityOpenServerView"
local MainInterfaceView = mLuaClass("MainInterfaceView",mBaseProxyWindow);

function MainInterfaceView:Init(view)
	if view == nil then
		self:Dispose();
		return;
	end

	self.mView = view;
	self.mTransform = view.transform;
	self.mGo = view.gameObject;

	local topright_path = "TopRight/GameObject/Panel/GameObject/";
	local mActivityOpenServer = self:FindChild(topright_path .. "OpenServer");
	--todo:红点逻辑lua完善
	view:AddFunctionOpenFromLua(29,mActivityOpenServer.gameObject);
	view:AddUIEffect(15,RenderQueueEnum.MainInterface,mActivityOpenServer,"UI_MainInterface2_Prompt_Sprite04",nil,true,true,false);
	CSharpInterface.GameUIEventListenerGet(mActivityOpenServer,function ()
		mActivityOpenServerView:OpenUI();
	end,SysSoundConst.S_UI_SYSBUTTON);
	NotifyManager:CreateNotifyView(NotifyDef.NEW_ACTIVITY_OPEN_SERVER_REWARD, mActivityOpenServer.transform:FindChild('newPrivateFlag').gameObject);

	local mActivityObj = self:FindChild(topright_path .. "activity");
	view:AddFunctionOpenFromLua(4, mActivityObj.gameObject);
	CSharpInterface.GameUIEventListenerGet(mActivityObj,function ()
		mActivityView:OpenUI();
	end,SysSoundConst.S_UI_SYSBUTTON);
	NotifyManager:CreateNotifyView(NotifyDef.NEW_ACTIVITY_NOTIFY, mActivityObj.transform:FindChild('newPrivateFlag').gameObject);

	local mLandRewardObj = self:FindChild(topright_path .. "LandReward");
	view:AddFunctionOpenFromLua(27, mLandRewardObj.gameObject);
	CSharpInterface.GameUIEventListenerGet(mLandRewardObj, function ()
		mLandRewardView:OpenUI();
	end,SysSoundConst.S_UI_SYSBUTTON);
	self.mNoticeHide = function( )
		self:OnNoticeHide();
	end
	CSharpInterface.AddEventListener(EventConst.PEERAGE_NOTICE_HIDE, self.mNoticeHide);
	NotifyManager:CreateNotifyView(NotifyDef.NEW_LADN_REWARD_NOTICE, mLandRewardObj.transform:FindChild('newPrivateFlag').gameObject);

	local mGrowFundObj = self:FindChild(topright_path .. "GrowFund");
	view:AddFunctionOpenFromLua(28, mGrowFundObj.gameObject);
	view:AddUIEffect(15,RenderQueueEnum.MainInterface,mGrowFundObj,"UI_MainInterface2_Prompt_Sprite04",nil,true,true,false);
	CSharpInterface.GameUIEventListenerGet(mGrowFundObj, function ()
		mGrowFundView:OpenUI();
	end,SysSoundConst.S_UI_SYSBUTTON);
	NotifyManager:CreateNotifyView(NotifyDef.NEW_GROW_FUND_NOTICE, mGrowFundObj.transform:FindChild('newPrivateFlag').gameObject);

	local mVIPObj = self:FindChild(topright_path .. "vipinfo");
	view:AddFunctionOpenFromLua(7, mVIPObj.gameObject);
	local vip_effect_node= self:FindChild(topright_path .. "vipinfo/effect");
	self.mVipEffect = vip_effect_node;
	self.mSpriteVip = mVIPObj.gameObject:GetComponent("UISprite");
	view:AddUIEffect(15,RenderQueueEnum.MainInterface,vip_effect_node,"UI_MainInterface2_Prompt_Sprite04",nil,true,true,false);
	CSharpInterface.GameUIEventListenerGet(mVIPObj, function ()
		self:OnOpenViewView();
	end,SysSoundConst.S_UI_SYSBUTTON);
	self:FreshVipButton();
	self.mUpdateFirstRecharge = function()
    	self:FreshVipButton();
    	mActivityModel:CheckFirstRechargeNotify();
   	end
    CSharpInterface.AddEventListener(EventConst.UPDATE_PLAYER_FIRST_RECHARGE, self.mUpdateFirstRecharge);
    NotifyManager:CreateNotifyView(NotifyDef.NEW_FIRST_RECHARGE_REWARD, mVIPObj.transform:FindChild('newPrivateFlag').gameObject);

    mActivityModel:CheckNotify();
end

function MainInterfaceView:OnOpenViewView()
	if self:IsShowFirstRechage() then
		mFirstRechargeView:OpenUI();
	else
		UIManager:OpenUIFromLua("VipView");
	end
end

function MainInterfaceView:IsShowFirstRechage()
	local state = self:GetRoleModel().mPlayerBase.first_charge;
	return mActivityModel.mOpenFirstCharge and state ~= 2;
end

function MainInterfaceView:GetRoleModel()
	return CSharpInterface.GetRoleModel();
end

function MainInterfaceView:FreshVipButton()
	local vip_effect_node = self.mVipEffect.gameObject; 
	local vip_spite = self.mSpriteVip;
	if self:IsShowFirstRechage()  then
		vip_effect_node:SetActive(true);
		vip_spite.spriteName = "city_icon_55";
	else
		vip_effect_node:SetActive(false);
		vip_spite.spriteName = "city_icon_23" ;
	end
	vip_spite:MakePixelPerfect();
end

function MainInterfaceView:OnNoticeHide()
	mLandRewardModel:CheckShowLandRewardView();
end

function MainInterfaceView:Dispose()
	NotifyManager:Dispose();
	CSharpInterface.RemoveEventListener(EventConst.PEERAGE_NOTICE_HIDE, self.mNoticeHide);
	CSharpInterface.RemoveEventListener(EventConst.UPDATE_PLAYER_FIRST_RECHARGE, self.mUpdateFirstRecharge);
end

return MainInterfaceView.LuaNew();