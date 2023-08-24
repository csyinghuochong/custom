local mLuaClass = require "Core/LuaClass"
local mBaseProxyWindow = require "Core/BaseProxyWindow"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mLandRewardVO = require "Module/LandReward/LandRewardVO"
local mLandRewardItem = require "Module/LandReward/LandRewardItem"
local mLandRewardModel = require "Module/LandReward/LandRewardModel"
local mLandRewardControl = require "Module/LandReward/LandRewardController"
local mConfigSyssign_always = require "ConfigFiles/ConfigSyssign_always"
local mSpecialButton = Assets.Scripts.Com.Game.Mono.UI.SpecialButton;
local UIManager = Com.Game.Manager.CSharpToLuaInterface.GetUIManager();
local BaseViewParam = Assets.Scripts.Com.Game.Core.BaseViewParam;
local BgEnum = Assets.Scripts.Com.Game.Enum.BgEnum;
local CSharpInterface = Com.Game.Manager.CSharpToLuaInterface;
local SysSoundConst = Assets.Scripts.Com.Game.Config.SysSoundConst;
local RenderQueueEnum = Assets.Scripts.Com.Game.Enum.RenderQueueEnum;
local GameObject = UnityEngine.GameObject;
local LandRewardView = mLuaClass("LandRewardView",mBaseProxyWindow);
local mString = require 'string'
local instance;

function LandRewardView:OnLuaNew()
	local baseViewParam = BaseViewParam.New();
	baseViewParam.url = "UI/Activity/LandRewardView";
	baseViewParam.viewName = "LandRewardView";
	baseViewParam.ParentLayer = UIManager.mNormalPop;
    baseViewParam.bgEnum = BgEnum.GRAY;
    baseViewParam.hideAllActors = true;

	self.mGameProxyWindow = UIManager:RegisterViewFromLua("LandRewardView",baseViewParam,LandRewardView.Init,LandRewardView.Show,LandRewardView.Hide,LandRewardView.Dispose);
end

function LandRewardView.Init()
	instance.mTransform = instance.mGameProxyWindow.transform;
	instance.mGameObject = instance.mGameProxyWindow.gameObject;

	instance.mButtonEffectNode = instance:FindChild("get_reward/effect").gameObject;
    local btn_get = mSpecialButton.New(instance:FindComponent("get_reward", 'UISprite'), instance:FindComponent("get_reward/Label", 'UILabel'));
    instance.mGetButton = btn_get;
    CSharpInterface.GameUIEventListenerGet(btn_get.gameObject, function ()
			instance:OnClickGetReward();
	end)

	local btn_close = instance:FindChild("Button_Close");
	CSharpInterface.GameUIEventListenerGet(btn_close,function ()
		instance.mGameProxyWindow:HideView();
	end);

	instance.mRecvLandRewardInfoBack = function( )
		instance:OnRecvLandRewardInfoBack();
	end

    instance:AddEffect();
    instance:InitRewardList();
    instance:RefreshRewardList();
end

local sButtonEffect = 'UI_LandRewardView_get_reward';
function LandRewardView:AddEffect()
	self.mLoadEffectBack = function(go)
		if self.mGameObject == nil then
			GameObject.Destroy(go);
			return;
		end

        mGameObjectUtil:SetParent(go.transform, self.mButtonEffectNode.transform);
        go:SetActive(true);
	end
	
	self.mGameProxyWindow:AddUIEffect(15, RenderQueueEnum.NormalPop, self.mButtonEffectNode, sButtonEffect, 
		nil, true, true, false);
end

function LandRewardView.Show()
	instance:RefreshRewardList();
	mLandRewardModel.mRecvLandRewardInfo = instance.mRecvLandRewardInfoBack;
end

function LandRewardView:OnRecvLandRewardInfoBack()
 	self:RefreshRewardList();
end

function LandRewardView.Hide()
	mLandRewardModel.mRecvLandRewardInfo = nil;
end

function LandRewardView:OnClickGetReward()
	local reward_day = mLandRewardModel.mLandReward.get_award_day;
    mLandRewardControl:SendGetLandReward(reward_day + 1);
end

local ItemPath = "Panel/item/%d";
local NamePath = "Panel/item/%d/goods/name";
function LandRewardView:InitRewardList()
	local reward_list = {};
	local name_list = {};

	for i = 1, mLandRewardModel.LADN_REWARD_DAYS do
		local go = self:FindChild(mString.format(ItemPath, i - 1));
		local item = mLandRewardItem.LuaNew(go);
		reward_list[i] = item;

		local text_name = self:FindComponent(mString.format(NamePath, i - 1), 'UILabel')
		name_list[i] = text_name;
	end
	self.mNameList = name_list;
	self.mRewardList = reward_list;
end

function LandRewardView:RefreshRewardList()
	local land_reward = mLandRewardModel.mLandReward;
	local land_day = land_reward.login_day;
	local reward_day = land_reward.get_award_day;
	local reward_list = self.mRewardList;
	local name_list = self.mNameList;
	for i = 1, mLandRewardModel.LADN_REWARD_DAYS do
		--0不可领取1可领取2已领取
		local get_reward = 0;
		if i <= land_day then
			get_reward = i <= reward_day and 2 or 1;
		end

		local reward = mConfigSyssign_always[i];
		local vo = mLandRewardVO.LuaNew(get_reward, i, reward);
		reward_list[i]:SetData(vo);
		name_list[i].text = reward.goods_name;
	end

	self.mGetButton.isEnabled = reward_day < land_day;
	self.mButtonEffectNode:SetActive(reward_day < land_day);
end

function LandRewardView.Dispose()
	
end

function LandRewardView:OpenUI()
	UIManager:OpenUIFromLua("LandRewardView");
end

instance = LandRewardView.LuaNew();
return instance;