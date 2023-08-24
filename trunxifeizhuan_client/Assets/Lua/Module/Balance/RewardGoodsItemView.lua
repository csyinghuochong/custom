local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local RewardGoodsItemView = mLuaClass("RewardGoodsItemView", mBaseView);

local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mGoodsIconPath = mResourceUrl.goods_icon;

local Vector3 = Vector3;

function RewardGoodsItemView:Init()
	local position = self.mPosition;
	if position then
		self:SetPosition(self.mTransformParent,position);
	end

	self:OnAwake();
end

function RewardGoodsItemView:OnAwake()

	self.mTextNumber = self:FindComponent("Text","Text");
	self.mTextName = self:FindComponent("Text_name","Text");
	self.mGoodsIcon = self:FindComponent('icon', 'RawImage');
	self.mLoadedIcon = function (icon)
		self:OnLoadedIcon(icon);
	end
end

function RewardGoodsItemView:OnViewShow(data)
	local vo = data.mGoodsVo;
	self.mTextName.text = vo.goods_name;
	self.mTextNumber.text = data.mNumber;
	mUITextureManager.LoadTexture(mGoodsIconPath, vo.icon,self.mLoadedIcon);
end

function RewardGoodsItemView:OnLoadedIcon(icon)
	self.mGoodsIcon.texture = icon;
end

function RewardGoodsItemView:SetPosition(parent,position)
	self.mTransformParent = parent;
	self.mPosition = position;
	local transform = self.mTransform;
	if transform then
		transform:SetParent(parent);
		transform.localPosition = position or Vector3.zero;
		transform.localScale = Vector3.one;
	end
end

return RewardGoodsItemView;