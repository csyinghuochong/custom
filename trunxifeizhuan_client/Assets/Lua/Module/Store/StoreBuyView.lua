local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mGoodsIconPath = mResourceUrl.goods_icon;
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonSliderButton = require "Module/CommonUI/CommonSliderButton"
local mConfigSysgoods = require "ConfigFiles/ConfigSysgoods"
local mTable = table
local mStoreController = require "Module/Store/StoreController"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local StoreBuyView = mLuaClass("StoreBuyView", mBaseWindow);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgPleaseWait = mLanguageUtil.store_please_wait;

function StoreBuyView.Show(data)
	mUIManager:HandleUI(mViewEnum.StoreBuyView, 1, data);
end

function StoreBuyView:InitViewParam()
	return {
		["viewPath"] = "ui/store/",
		["viewName"] = "store_buy_view",
		["ParentLayer"] = mMainPop,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
	};
end

function StoreBuyView:Init()
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

	local sliderChangeBack = function ( value )
        self:OnValueChange(value);
    end
    local go = self:Find("Slider").gameObject;
    self.mSlider = mCommonSliderButton.LuaNew(go,sliderChangeBack);
end

function StoreBuyView:OnClickBuy()
	local data = self.mData;
	if data.isDayUp then
		mCommonTipsView.Show(mLgPleaseWait);
		self:HideView();
		return;
	end
	if self.mValue > 0 then
		mStoreController:SendBuyStoreGood(self.mData.id,self.mValue);
	end
	self:HideView();
end

function StoreBuyView:OnViewShow(data)
	self.mData = data;
	local equip = mConfigSysgoods[data.itemData.good_id];
	self.mGameObjectUtil:SetImageSprite(self.mGameImgBg,"common_bag_iconframe_"..equip.quality.."s");
	self.mGameObjectUtil:SetImageSprite(self.mGameImgKuang,"common_bag_iconframe_"..equip.quality);
	self.mTextDesc.text = equip.desc;

	self.mGameObjectUtil:SetImageSprite(self.mGameImgPrice,"common_city_icon_"..data.itemData.price_type);
	self.mGameImgPrice:SetNativeSize();

	mUITextureManager.LoadTexture(mGoodsIconPath, equip.icon,self.mLoadedIcon);

	local mPlayerData = mGameModelManager.RoleModel.mPlayerBase;
	self.mPriceTypeTable = {mPlayerData.exp,mPlayerData.coin,mPlayerData.gold,mPlayerData.wisdom_coin,
	mPlayerData.arena_coin,mPlayerData.dress_coin,mPlayerData.devote_coin,mPlayerData.house_coin};

	self.mValue = self:GetMin(data);
	if self.mValue <= 0 then
    	self.mSlider:SetInfo(0,0,self.mValue);
    	self:SetInfo(0);
    else
    	self.mSlider:SetInfo(1,0,self.mValue);
    	self:SetInfo(1);
    end
end

function StoreBuyView:GetMin(data)
	local numTable = {};
	local buyMaxNum1,buyMaxNum = math.modf(self.mPriceTypeTable[data.itemData.price_type]/data.price);
	mTable.insert(numTable,buyMaxNum1);
	local buyMaxNum2 = data.itemData.batch_peak;
	if buyMaxNum2 > 0 then
		mTable.insert(numTable,buyMaxNum2);
	end
	local buyMaxNum3 = data.remain_count;
	if buyMaxNum3 ~= nil and self:CheckForType(data.itemData)then
		if buyMaxNum3 > 0 then
			mTable.insert(numTable,buyMaxNum3);
		end
	end
	return math.min(unpack(numTable));
end

function StoreBuyView:CheckForType(itemData)
	local isPushForRefreshType = not(itemData.refresh_type == 1 or (itemData.refresh_type == 6 and itemData.refresh_count == 0));
	return isPushForRefreshType;
end

function StoreBuyView:OnValueChange(value)
    if self.mData == nil then
        return;
    end
    self:SetInfo(value);
end

function StoreBuyView:SetInfo(value)
	local data = self.mData;
	local equip = mConfigSysgoods[data.itemData.good_id];
    self.mTextPrice.text = data.price * value;
    self.mTextName.text = equip.goods_name.."X"..value;
    self.mValue = value;
end

function StoreBuyView:OnLoadedIcon(icon)
	self.mImgIcon.texture = icon;
	self.mImgIcon.color = Color.white;
end

function StoreBuyView:Dispose()
end

return StoreBuyView;