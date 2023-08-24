local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local FashionBaseItemView = mLuaClass("FashionBaseItemView", mBaseView);

local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mIconPath = mResourceUrl.goods_icon;

local Vector3 = Vector3;

function FashionBaseItemView:InitViewParam()
	return {
		["viewPath"] = "ui/fashion/",
		["viewName"] = "fashion_base_item_view",
	};
end

function FashionBaseItemView.CreateAt(root)
	local instance = FashionBaseItemView.LuaNew();
	instance.mTransformParent = root;
	return instance;
end

function FashionBaseItemView:Init()
	local parent = self.mTransformParent;
	if parent then
		self:SetParent(parent);
	end
	self.mStarsRoot = self:Find("stars");
	self.mLevelText = self:FindComponent("level","Text");
	self.mLevelBg = self:Find("left_icon").gameObject;
	self.mXuanGuangIcon = self:FindComponent('right_icon', 'GameImage');
	self.mBg1 = self:FindComponent('bg_1', 'Image');
	self.mBg2 = self:FindComponent('bg_2', 'Image');
	self.mFashionIcon = self:FindComponent("fashion_icon","RawImage");

	self.mLoadedIcon = function (tex)
		self:OnLoadedIcon(tex);
	end
end

function FashionBaseItemView:OnLoadedIcon(tex)
	self.mFashionIcon.texture = tex;
end

function FashionBaseItemView:UpdateStars(star)
	local starsRoot = self.mStarsRoot;
	for i = 0,5 do
		local child = starsRoot:GetChild(i);
		child.gameObject:SetActive(i<star);
	end

	local localPosition = starsRoot.localPosition;
	localPosition.x = (1-star)*5;
	starsRoot.localPosition = localPosition
end

function FashionBaseItemView:OnViewShow(data)
	self.mData = data;
	if data then
		self:OnUpdateData(data);
	end
end

function FashionBaseItemView:UpdateXuanguangIcon(level)
	if level > 0 then
		self.mXuanGuangIcon:SetSprite("dress_polishing"..level);
	else
		self.mXuanGuangIcon.gameObject:SetActive(false);
	end
end

function FashionBaseItemView:OnUpdateData(data)
	self:UpdateStars(data.mStar);

	local level = data.mLevel;
	local quality = data.mQuality + 1;

	self.mLevelText.text = level > 0 and level or "";
	self.mLevelBg:SetActive(level > 0);

	self:UpdateXuanguangIcon(data.mXuanguang);
	
	self.mGameObjectUtil:SetImageSprite(self.mBg1,"common_bag_iconframe_"..quality.."s");
	self.mGameObjectUtil:SetImageSprite(self.mBg2,"common_bag_iconframe_"..quality);
	
	local icon = data.mIcon;
	if icon and icon ~= "" then
		mUITextureManager.LoadTexture(mIconPath, icon,self.mLoadedIcon);
	end

end

return FashionBaseItemView;