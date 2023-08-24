local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mGoodsIconPath = mResourceUrl.goods_icon;
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mConfigSysgoods = require "ConfigFiles/ConfigSysgoods"
local mStoreController = require "Module/Store/StoreController"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local StoreBuySingleView = mLuaClass("StoreBuySingleView", mBaseWindow);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgNotEnough = mLanguageUtil.store_not_enough;
local mLgPleaseWait = mLanguageUtil.store_please_wait;

function StoreBuySingleView.Show(data)
	mUIManager:HandleUI(mViewEnum.StoreBuySingleView, 1, data);
end

function StoreBuySingleView:InitViewParam()
	return {
		["viewPath"] = "ui/store/",
		["viewName"] = "store_buy_single_view",
		["ParentLayer"] = mMainPop,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
	};
end

function StoreBuySingleView:Init()
	self.mGameImgBg = self:FindComponent("goods/bg","Image");
	self.mGameImgKuang = self:FindComponent("goods/kuang","Image");
	self.mGameImgPrice = self:FindComponent("Btn/PriceIcon","Image");

	self.mTextName = self:FindComponent("goods/Text","Text");
	self.mTextDesc = self:FindComponent("Desc","Text");
	self.mTextPrice = self:FindComponent("Btn/Text","Text");

	self.mImgIcon = self:FindComponent("goods/icon","RawImage");
	self.mImgIcon.color = Color.clear;
	self.mLoadedIcon = function(icon) self:OnLoadedIcon(icon); end

	self:FindAndAddClickListener("Btn",function()self:OnClickBuy();end);
end

function StoreBuySingleView:OnClickBuy()
	local data = self.mData;
	if data.isDayUp then
		mCommonTipsView.Show(mLgPleaseWait);
		self:HideView();
		return;
	end
	if self.mPriceTypeTable[data.itemData.price_type] >= data.price then
		mStoreController:SendBuyStoreGood(data.id,1);
	else
		local equip = mConfigSysgoods[data.itemData.price_type + 1000000];
		local str = string.format(mLgNotEnough,equip.goods_name);
		mCommonTipsView.Show(str);
	end
	self:HideView();
end

function StoreBuySingleView:OnViewShow(data)
	self.mData = data;
	local equip = mConfigSysgoods[data.itemData.good_id];
	self.mGameObjectUtil:SetImageSprite(self.mGameImgBg,"common_bag_iconframe_"..equip.quality.."s");
	self.mGameObjectUtil:SetImageSprite(self.mGameImgKuang,"common_bag_iconframe_"..equip.quality);

	self.mGameObjectUtil:SetImageSprite(self.mGameImgPrice,"common_city_icon_"..data.itemData.price_type);
	self.mGameImgPrice:SetNativeSize();

	self.mTextName.text = equip.goods_name;
	self.mTextDesc.text = equip.desc;
	self.mTextPrice.text = data.price;

	mUITextureManager.LoadTexture(mGoodsIconPath, equip.icon,self.mLoadedIcon);

	local mPlayerData = mGameModelManager.RoleModel.mPlayerBase;
	self.mPriceTypeTable = {mPlayerData.exp,mPlayerData.coin,mPlayerData.gold,mPlayerData.wisdom_coin,
	mPlayerData.arena_coin,mPlayerData.dress_coin,mPlayerData.devote_coin,mPlayerData.house_coin};
end

function StoreBuySingleView:OnLoadedIcon(icon)
	self.mImgIcon.texture = icon;
	self.mImgIcon.color = Color.white;
end

function StoreBuySingleView:Dispose()
end

return StoreBuySingleView;