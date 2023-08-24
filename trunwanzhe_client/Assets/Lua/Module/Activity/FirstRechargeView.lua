local mLuaClass = require "Core/LuaClass"
local mBaseProxyWindow = require "Core/BaseProxyWindow"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mActivityControl = require "Module/Activity/ActivityController"
local GameObject = UnityEngine.GameObject;
local BgEnum = Assets.Scripts.Com.Game.Enum.BgEnum;
local CSharpInterface = Com.Game.Manager.CSharpToLuaInterface;
local EventConst = Assets.Scripts.Com.Game.Events.EventConstant;
local SysSoundConst = Assets.Scripts.Com.Game.Config.SysSoundConst;
local BaseViewParam = Assets.Scripts.Com.Game.Core.BaseViewParam;
local UIManager = Com.Game.Manager.CSharpToLuaInterface.GetUIManager();
local RenderQueueEnum = Assets.Scripts.Com.Game.Enum.RenderQueueEnum;
local mCommonGoodsVo = Assets.Scripts.Com.Game.Module.CommonComponent.CommonGoodsVo;
local mCommonGoodsItem = Assets.Scripts.Com.Game.Module.CommonComponent.CommonGoodsItem;
local FirstRechargeView = mLuaClass("FirstRechargeView",mBaseProxyWindow);
local instance;

function FirstRechargeView:OnLuaNew()
	local baseViewParam = BaseViewParam.New();
	baseViewParam.url = "UI/Activity/FirstRechargeView";
	baseViewParam.viewName = "FirstRechargeView";
	baseViewParam.ParentLayer = UIManager.mNormalLayer10;
    baseViewParam.bgEnum = BgEnum.GRAY;
    baseViewParam.hideAllActors = true;

	self.mGameProxyWindow = UIManager:RegisterViewFromLua("FirstRechargeView",baseViewParam,FirstRechargeView.Init,FirstRechargeView.Show,FirstRechargeView.Hide,FirstRechargeView.Dispose);
end

function FirstRechargeView.Init()
	instance.mTransform = instance.mGameProxyWindow.transform;
	instance.mGameObject = instance.mGameProxyWindow.gameObject;

	local btn_recharge = instance:FindChild("Panel/btn_recharge");
	instance.mRechargeButton = btn_recharge;
	CSharpInterface.GameUIEventListenerGet(btn_recharge.gameObject, function ()
			instance:OnClickRechargeBtn();
	end, SysSoundConst.S_UI_OPEN_VIEW);

    local btn_get = instance:FindChild("Panel/btn_reward");
    instance.mGetButton = btn_get;
	CSharpInterface.GameUIEventListenerGet(btn_get.gameObject, function ()
			instance:OnClickGetRewardBtn();
	end, SysSoundConst.S_UI_OPEN_VIEW);
     
    instance.mGoodsItem = instance:FindChild("Panel/goods");
    instance.mEffectNode = instance:FindChild("Panel/effect");
    instance.mButtonEffectNode = instance:FindChild("Panel/btn_effect");

    instance:AddEffect();
    instance:InitRewardList();

    instance.mUpdateFirstRecharge = function()
    	instance:RefreshButton();
   	end
    CSharpInterface.AddEventListener(EventConst.UPDATE_PLAYER_FIRST_RECHARGE, instance.mUpdateFirstRecharge);
end

local sViewEffect = "UI_FirstRechargeView";
local sButtonEffect = "UI_VIP_tequan";
function FirstRechargeView:AddEffect()
	local base_view = self.mGameProxyWindow;
	local queue = self:FindComponent('Panel', 'UIPanel').startingRenderQueue - 2;

	base_view:AddUIEffect(queue, self.mEffectNode, sViewEffect, nil , true, true, false);
	base_view:AddUIEffect(RenderQueueEnum.NormalLayer10, self.mButtonEffectNode, sButtonEffect, nil , true, true, false);

	self.mLoadButtonEffectBack = function ( go )
		self.mButtonEffectNode.transform.localPosition = self.mGetButton.transform.localPosition;
	end
end

function FirstRechargeView:InitRewardList()
	local goods_list = {};
	local grid = self:FindComponent("Panel/scrollview/grid", 'UIGrid');		
	local sys_reward = mActivityControl:GetFirstRechareRewardList();
	for k, v in pairs(sys_reward) do
		local goods_vo = mCommonGoodsVo.New(v.goods_id, v.goods_num, true, 1, false)
		local go = GameObject.Instantiate(self.mGoodsItem);
		mGameObjectUtil:SetParent(go.transform, grid.transform);
		local goods_item = mCommonGoodsItem.New();
		goods_item:InjectGameObject(go);
		goods_item:SetData(goods_vo);
		goods_item:ShowView();
	end  
	self.mGoodsList = goods_list;
    grid.repositionNow = true;
end

function FirstRechargeView.Show()
	instance:RefreshButton();
end

function FirstRechargeView:GetRoleModel()
	return CSharpInterface.GetRoleModel();
end

function FirstRechargeView:RefreshButton()
	local btn_recharge = self.mRechargeButton;
	if btn_recharge == nil then
		return;
	end
	local state = self:GetRoleModel().mPlayerBase.first_charge;
    btn_recharge:SetActive(state == 0);
    self.mGetButton:SetActive(state == 1);
end

function FirstRechargeView:OnClickRechargeBtn()
	self.mGameProxyWindow:HideView();
	UIManager:OpenUIFromLua("VipView");
end

function FirstRechargeView:OnClickGetRewardBtn()
	self.mGameProxyWindow:CloseView();
	mActivityControl:SendGetFirstRechargeReward();
end

function FirstRechargeView.Hide()
end

function FirstRechargeView.Dispose()
	CSharpInterface.RemoveEventListener(EventConst.UPDATE_PLAYER_FIRST_RECHARGE, instance.mUpdateFirstRecharge);
end

function FirstRechargeView:OpenUI()
	UIManager:OpenUIFromLua("FirstRechargeView");
end

instance = FirstRechargeView.LuaNew();
return instance;