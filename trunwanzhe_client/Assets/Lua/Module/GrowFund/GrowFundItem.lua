local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local GameObject = UnityEngine.GameObject;
local RenderQueueEnum = Assets.Scripts.Com.Game.Enum.RenderQueueEnum;
local mCommonGoodsItem = Assets.Scripts.Com.Game.Module.CommonComponent.CommonGoodsItem;
local GrowFundItem = mLuaClass("GrowFundItem",mLayoutItem);
local mVector3 = Vector3;
local mMath = require 'math'
local mSuper;

function GrowFundItem:InitViewParam()
	return {
		["viewPath"] = "UI/Activity/GrowFundItem",
		["viewName"] = "GrowFundItem",
	};
end

function GrowFundItem:Init( )
	local goods_item =  mCommonGoodsItem.New();
	self.mGoodsItem = goods_item;
    goods_item:InjectGameObject(self:FindChild("goods"));
    self.mTxtLevel = self:FindComponent("txt_level", 'UILabel');
    self.mEffectNode = self:FindChild("effect");
    self.mMask = self:FindChild("mask");
    self.mTxtLeft = self:FindComponent("txt_left", 'Transform');
    self.mTxtRight = self:FindComponent("txt_right", 'Transform');

    self.mLoadEffectBack = function(go)
    	if self.mGameObject == nil then
    		GameObject.Destroy(go);
            return;
    	end

        self.mEffect = go;
        local effect_transform = go.transform;
        mGameObjectUtil:SetParent(effect_transform, self.mEffectNode.transform);
        effect_transform.localScale =  mVector3.New(1.65, 0.95, 1);
        go:SetActive(true);
    end

    mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function GrowFundItem:ExternalSetData(recv, player_lv, buy)
	local mData = self.mData;
	self.mReceived = recv;
	self.mShowEffect = mData.Level <= player_lv and not recv and buy;
	if self.mGameObject ~= nil then
		self:FreshUI();
	end
end

function GrowFundItem:FreshUI()
    self:SetMaskVisible();
    self:UpdateEffect();
end

function GrowFundItem:SetMaskVisible()
    self.mMask:SetActive(self.mReceived);
end

local sGoodsEffect = "UI_LandRewardView_item";
function GrowFundItem:UpdateEffect()
	local effect_node = self.mEffectNode;
	if self.mShowEffect then
		effect_node:SetActive(true);

		if self.mEffect == nil then
			self:AddUIEffect(10, RenderQueueEnum.NormalLayer2, self.mGameObject, sGoodsEffect, self.mLoadEffectBack)
		end
	else
		effect_node:SetActive(false);
	end
end

function GrowFundItem:OnUpdateData()
	local mData = self.mData;

	self.mGoodsItem:SetData(mData.GetGoodsVO);
	local text_level = self.mTxtLevel;
    local pos = text_level.transform.localPosition;
    text_level.text = mData.Level; 
    self.mTxtLeft.localPosition = mVector3.New(pos.x - mMath.ceil(text_level.width / 2), pos.y, pos.z);
    self.mTxtRight.localPosition = mVector3.New(pos.x + mMath.ceil(text_level.width / 2), pos.y, pos.z);
    self:FreshUI(); 
end

return GrowFundItem;