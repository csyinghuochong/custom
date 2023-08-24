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
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mConfigSysshops_mystery = require "ConfigFiles/ConfigSysshops_mystery"
local mMysteryController = require "Module/Mystery/MysteryController"
local MysteryBuyView = mLuaClass("MysteryBuyView", mBaseWindow);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgNotEnough = mLanguageUtil.store_not_enough;

function MysteryBuyView.Show(data)
	mUIManager:HandleUI(mViewEnum.MysteryBuyView, 1, data);
end

function MysteryBuyView:InitViewParam()
	return {
		["viewPath"] = "ui/store/",
		["viewName"] = "store_buy_single_view",
		["ParentLayer"] = mMainPop,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
	};
end

function MysteryBuyView:Init()
	self.mGameImgBg = self:FindComponent("goods/bg","Image");
	self.mGameImgKuang = self:FindComponent("goods/kuang","Image");
	self.mGameImgPrice = self:FindComponent("Btn/PriceIcon","Image");
	self.mImgPrice = self:FindComponent("Btn/PriceIcon","Image");

	self.mTextName = self:FindComponent("goods/Text","Text");
	self.mTextDesc = self:FindComponent("Desc","Text");
	self.mTextPrice = self:FindComponent("Btn/Text","Text");

	self.mImgIcon = self:FindComponent("goods/icon","RawImage");
	self.mImgIcon.color = Color.clear;
	self.mLoadedIcon = function(icon) self:OnLoadedIcon(icon); end

	self:FindAndAddClickListener("Btn",function()self:OnClickBuy();end);

	self:RegisterEventListener(self.mEventEnum.ON_GET_MYSTERY_LIST,function(data)self:HideView();end,true);
end

function MysteryBuyView:OnClickBuy()
	local data = self.mData;
	local config = mConfigSysshops_mystery[data.id];
	if self.mPriceTypeTable[config.price[1]] >= config.price[2] then
		mMysteryController:SendBuy(data);
	else
		local equip = mConfigSysgoods[config.price[1] + 1000000];
		local str = string.format(mLgNotEnough,equip.goods_name);
		mCommonTipsView.Show(str);
	end
	self:HideView();
end

function MysteryBuyView:OnViewShow(data)
	self.mData = data;
	local config = mConfigSysshops_mystery[data.id];
	local equip = mConfigSysgoods[config.goods_id];
	self.mGameObjectUtil:SetImageSprite(self.mGameImgBg,"common_bag_iconframe_"..equip.quality.."s");
	self.mGameObjectUtil:SetImageSprite(self.mGameImgKuang,"common_bag_iconframe_"..equip.quality);

	self.mGameObjectUtil:SetImageSprite(self.mGameImgPrice,"common_city_icon_"..config.price[1]);
	self.mImgPrice:SetNativeSize();

	self.mTextName.text = equip.goods_name;
	self.mTextDesc.text = equip.desc;
	self.mTextPrice.text = config.price[2];

	mUITextureManager.LoadTexture(mGoodsIconPath, equip.icon,self.mLoadedIcon);

	local mPlayerData = mGameModelManager.RoleModel.mPlayerBase;
	self.mPriceTypeTable = {mPlayerData.exp,mPlayerData.coin,mPlayerData.gold,mPlayerData.wisdom_coin,
	mPlayerData.arena_coin,mPlayerData.dress_coin,mPlayerData.devote_coin,mPlayerData.house_coin};
end

function MysteryBuyView:OnLoadedIcon(icon)
	self.mImgIcon.texture = icon;
	self.mImgIcon.color = Color.white;
end

function MysteryBuyView:OnViewHide()

end

function MysteryBuyView:Dispose()
end

return MysteryBuyView;