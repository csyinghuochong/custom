local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mBaseProxyWindow = require "Core/BaseProxyWindow"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mLayoutController = require "Core/Layout/LayoutController"
local mGrowFundModel = require "Module/GrowFund/GrowFundModel"
local mGrowFundControl = require "Module/GrowFund/GrowFundController"
local mGrowFundVO = require "Module/GrowFund/GrowFundVO"
local mConfigSysvip = require "ConfigFiles/ConfigSysvip";
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigSysactive_grow_fund = require "ConfigFiles/ConfigSysactive_grow_fund";
local BgEnum = Assets.Scripts.Com.Game.Enum.BgEnum;
local ActionGameObject = System.Action_UnityEngine_GameObject
local CSharpInterface = Com.Game.Manager.CSharpToLuaInterface;
local BaseViewParam = Assets.Scripts.Com.Game.Core.BaseViewParam;
local SysSoundConst = Assets.Scripts.Com.Game.Config.SysSoundConst;
local SpecialButton = Assets.Scripts.Com.Game.Mono.UI.SpecialButton;
local RenderQueueEnum = Assets.Scripts.Com.Game.Enum.RenderQueueEnum;
local UIManager = Com.Game.Manager.CSharpToLuaInterface.GetUIManager();
local Alert = Assets.Scripts.Com.Game.Module.Prompt.Alert;
local GrowFundView = mLuaClass("GrowFundView",mBaseProxyWindow);
local GameObject = UnityEngine.GameObject;
local ArrayUtil = require "Utils/ArrayUtil"
local mString = require 'string'
local mColor = Color;
local instance;

function GrowFundView:OnLuaNew()
	local baseViewParam = BaseViewParam.New();
	baseViewParam.url = "UI/Activity/GrowFundView";
	baseViewParam.viewName = "GrowFundView";
	baseViewParam.ParentLayer = UIManager.mNormalLayer2;
    baseViewParam.bgEnum = BgEnum.GRAY;
    baseViewParam.hideAllActors = true;

	self.mGameProxyWindow = UIManager:RegisterViewFromLua("GrowFundView",baseViewParam,GrowFundView.Init,GrowFundView.Show,GrowFundView.Hide,GrowFundView.Dispose);
end

function GrowFundView.Init()
	instance.mTransform = instance.mGameProxyWindow.transform;
	instance.mGameObject = instance.mGameProxyWindow.gameObject;

	instance.mTxtVip = instance:FindComponent("txt_vip", 'UILabel');
        
    local parent = instance:FindComponent('scrollview/grid', 'UIGrid');
	instance.mGridEx = mLayoutController.LuaNew(parent, require "Module/GrowFund/GrowFundItem");

    local btn_buy = instance:FindChild("btn_buy");
    instance.mBuyButton = btn_buy;
    instance.mButtonEffectNode = instance:FindChild("btn_effect");
    local btn_get = SpecialButton.New(instance:FindComponent("btn_get", 'UISprite'), instance:FindComponent("btn_get/Label", 'UILabel'), "vip_anniu2",
                 mColor.New(227 / 255, 227 / 255, 227 / 255), mColor.black);
    instance.mGetButton = btn_get;
    CSharpInterface.GameUIEventListenerGet(btn_buy.gameObject, function ()
			instance:OnClickBuyGrowFund();
		end, SysSoundConst.S_UI_OPEN_VIEW);
    CSharpInterface.GameUIEventListenerGet(btn_get.gameObject, function ()
			instance:OnClickGetReward();
		end, SysSoundConst.S_UI_OPEN_VIEW);

    instance.mRecvGrowFundInfoBack = function( )
    	instance:OnRecvGrowFundInfoBack();
    end

    instance:ShowVIP();
	instance:SetData();
    instance:AddEffect();
end

local sButtonEffect = "UI_VIP_tequan";
function GrowFundView:AddEffect()
	self.mLoadEffectBack = function( go )
		if self.mGameObject == nil then
			GameObject.Destroy(go);
			return;
		end

		local btn_effect_node = self.mButtonEffectNode.transform;
        mGameObjectUtil:SetParent(go.transform, btn_effect_node);
        btn_effect_node.localPosition = self.mBuyButton.transform.localPosition;
        go:SetActive(true);
	end

	local callBack = ActionGameObject(self.mLoadEffectBack);
	self.mGameProxyWindow:AddUIEffect(15,RenderQueueEnum.NormalLayer2, self.mButtonEffectNode, sButtonEffect, callBack, true,true,false);
end

function GrowFundView:ShowVIP()
	local need_vip = self:GetVIPLevel();
	self.mNeedVip = need_vip;
	self.mTxtVip.text = mString.format("[89a3c4]达到[ffd200]贵族%d[-]可购买[-]", need_vip);
end

function GrowFundView:SetData()
	local mGrowFundData = mSortTable.LuaNew(function(a, b) return a.Level < b.Level; end, nil, true);
	for k, v in pairs(mConfigSysactive_grow_fund) do
		mGrowFundData:AddOrUpdate(v.lv, mGrowFundVO.LuaNew(v));
	end
	self.mGridEx:UpdateDataSource(mGrowFundData);
end

function GrowFundView:IsReceGrowFund(lv)
	local list = mGrowFundModel.mGrowFund.lv_list;
    return ArrayUtil:ContainsValue(lv, list);
end

function GrowFundView:FreshItem()
	local lv = self:GetRoleModel():GetPlayerLV();
	local buy = mGrowFundModel.mGrowFund.buy_flag == 1;
	for k, v in pairs(self.mGridEx.mViews) do
		v:ExternalSetData(self:IsReceGrowFund(k), lv, buy);
	end
end

function GrowFundView:OnClickBuyGrowFund()
	local vip = self:GetRoleModel():GetPlayerVIP();
	if vip < self.mNeedVip then
		self.mGameProxyWindow:HideView();
		UIManager:OpenUIFromLua("VipView");
		return;
	end

	Alert.ShowMessage("您是否愿意消耗3000钻石购买成长基金?", function()
        mGrowFundControl:SendBuyGrowFund();
    end, nil, nil, nil);
end

function GrowFundView:GetVIPLevel()
	local level = -1;
	for k, v in pairs(mConfigSysvip) do
		if v.buy_grow_fund == 1 and (level == -1 or v.lv < level) then
			level = v.lv
		end
	end
	return level;
end

function GrowFundView:GetBuyGrowFundCost()
    return mConfigSysglobal_value[118];
end

function GrowFundView:OnClickGetReward()
	local lv = mGrowFundModel:GetLastGrowFundLv();
	if lv > 0 then
		mGrowFundControl:SendGetGrowFund(lv);
	end
end

function GrowFundView:GetRoleModel()
    return CSharpInterface.GetRoleModel();
end

function GrowFundView.Show()
	instance:OnRecvGrowFundInfoBack();
    mGrowFundModel.mRecvGrowFundInfoBack = instance.mRecvGrowFundInfoBack;
    mGrowFundControl:SendGetGrowFundInfo();
end

function GrowFundView:OnRecvGrowFundInfoBack()
	self:FreshItem();
    self:FreshButton();
end

function GrowFundView.Hide()
	mGrowFundModel.mRecvGrowFundInfoBack = nil;
end

function GrowFundView.Dispose()
	local grid_ex = instance.mGridEx;
	if grid_ex ~= nil then
		grid_ex:Dispose();
	end
end

function GrowFundView:FreshButton()
	local buy_flag = mGrowFundModel.mGrowFund.buy_flag == 1;
	self.mBuyButton:SetActive(not buy_flag);

    local next_lv = mGrowFundModel:GetLastGrowFundLv();
    local btn_get = self.mGetButton;
    btn_get:SetActive(buy_flag);
    btn_get.isEnabled = next_lv > 0;
    self.mButtonEffectNode:SetActive(buy_flag or (not buy_flag and next_lv > 0));
end

function GrowFundView:OpenUI()
	UIManager:OpenUIFromLua("GrowFundView");
end

instance = GrowFundView.LuaNew();
return instance;