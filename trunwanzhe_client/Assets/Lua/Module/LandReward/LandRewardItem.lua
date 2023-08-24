local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local LandRewardItem = mLuaClass("LandRewardItem",mBaseView);
local RenderQueueEnum = Assets.Scripts.Com.Game.Enum.RenderQueueEnum;
local mCommonGoodsItem = Assets.Scripts.Com.Game.Module.CommonComponent.CommonGoodsItem;
local GameObject = UnityEngine.GameObject;
local mColor = Color;
local mVector3 = Vector3;

function LandRewardItem:Init()
	self.mMask = self:FindChild("mask");
    self.mBg = self:FindComponent("bg", 'UISprite');
    self.mTxtTitle = self:FindComponent("title", 'UILabel');
    self.mEffectNode = self:FindChild("effect");
    local goods_item = mCommonGoodsItem.New();
    goods_item:InjectGameObject(self:FindChild("goods"));
    self.mGoods = goods_item;

    self.mLoadEffectBack = function(go)
		if self.mGameObject == nil then
			GameObject.Destroy(go);
			return;
		end
		local mVO = self.mVO;
		local effect_transform = go.transform;
		mGameObjectUtil:SetParent(effect_transform, self.mEffectNode.transform);
		if mVO.mIndex == 7 then
			effect_transform.localScale = mVector3.New(2.1, 1, 1);
		end
		go:SetActive(true);
	end
end

function LandRewardItem:Reset()
	self.mMask:SetActive(false);
    self.mEffectNode:SetActive(false);
    self.mTxtTitle.color =  mColor.New(1, 1, 1);
end

function LandRewardItem:SetData(vo)
	self.mVO = vo;
	local text_time = self.mTxtTitle;
	text_time.text = vo.DayStr;
	self.mGoods:SetData(vo.GetGoodsVO);

	self:Reset();
    self:AddEffect();
    self:UpdateBG();

    if vo.mGetReward == 1 then
    	self.mEffectNode:SetActive(true);
        text_time.color = mColor.New(239 / 255, 229 / 255, 65 / 255);
    elseif vo.mGetReward == 2 then
    	self.mMask:SetActive(true);
    end
end

local mItemBg1 = "activity_reward_band";
local mItemBg2 = "activity_reward_band2";
local mItemBg3 = "activity_reward_bg1";
local mItemBg4 = "activity_reward_bg2";
function LandRewardItem:UpdateBG()
	local mVO = self.mVO;
	local mBg = self.mBg;
	if mVO.mGetReward == 1 then
		if mVO.mIndex == 7 then
            mBg.spriteName = mItemBg2;
        else
            mBg.spriteName = mItemBg1;
        end
	else
		if mVO.mIndex == 7 then
            mBg.spriteName = mItemBg4;
        else
            mBg.spriteName = mItemBg3;
        end
	end
end

local sLandRewardEffect = "UI_LandRewardView_item";
function LandRewardItem:AddEffect()
	local mVO = self.mVO;
	local mLoadEffect = self.mLoadEffect;
	if mVO.mGetReward == 1 and not mLoadEffect then
		self.mLoadEffect = true;
		self:AddUIEffect(10, RenderQueueEnum.NormalPop, self.mGameObject, sLandRewardEffect, self.mLoadEffectBack);
	end
end

return LandRewardItem;