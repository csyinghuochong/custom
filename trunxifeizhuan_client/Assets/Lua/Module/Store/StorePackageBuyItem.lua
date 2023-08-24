local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mGoodsIconPath = mResourceUrl.goods_icon;
local mConfigSysgoods = require "ConfigFiles/ConfigSysgoods"
local StorePackageBuyItem = mLuaClass("StorePackageBuyItem",mLayoutItem);

function StorePackageBuyItem:InitViewParam()
	return {
		["viewPath"] = "ui/store/",
		["viewName"] = "store_package_item_view",
	};
end

function StorePackageBuyItem:Init( )
	self.mGameImgBg = self:FindComponent("bg","Image");
	self.mGameImgKuang = self:FindComponent("kuang","Image");
	self.mTextDesc = self:FindComponent("Desc","Text");

	self.mGoDay = self:Find("Day").gameObject;
	self.mImgIcon = self:FindComponent("icon","RawImage");
	self.mImgIcon.color = Color.clear;
	self.mLoadedIcon = function(icon) self:OnLoadedIcon(icon); end

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function StorePackageBuyItem:OnUpdateData()
	local data = self.mData;
	local equip = mConfigSysgoods[data.goods_id];
	self.mGameObjectUtil:SetImageSprite(self.mGameImgBg,"common_bag_iconframe_"..equip.quality.."s");
	self.mGameObjectUtil:SetImageSprite(self.mGameImgKuang,"common_bag_iconframe_"..equip.quality);
	self.mTextDesc.text = equip.goods_name.."X"..data.count;
	self.mGoDay:SetActive(data.isShowDay);
	mUITextureManager.LoadTexture(mGoodsIconPath, equip.icon,self.mLoadedIcon);
end

function StorePackageBuyItem:OnLoadedIcon(icon)
	self.mImgIcon.texture = icon;
	self.mImgIcon.color = Color.white;
end

return StorePackageBuyItem;