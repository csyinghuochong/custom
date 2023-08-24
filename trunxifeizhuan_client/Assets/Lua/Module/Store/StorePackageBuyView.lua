local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mUIManager = require "Manager/UIManager"
local mLayoutController = require "Core/Layout/LayoutController"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mGoodsIconPath = mResourceUrl.goods_icon;
local mViewEnum = require "Enum/ViewEnum"
local mSortTable = require "Common/SortTable"
local mStorePackageVO = require "Module/Store/StorePackageVO"
local mTable = table
local mVector2 = Vector2
local mConfigSysgoods = require "ConfigFiles/ConfigSysgoods"
local mStoreController = require "Module/Store/StoreController"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mGameModelManager = require "Manager/GameModelManager"
local StorePackageBuyView = mLuaClass("StorePackageBuyView", mBaseWindow);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgDayGet = mLanguageUtil.store_day_get;
local mLgNotEnough = mLanguageUtil.store_not_enough;
local mLgPleaseWait = mLanguageUtil.store_please_wait;

function StorePackageBuyView.Show(data)
	mUIManager:HandleUI(mViewEnum.StorePackageBuyView, 1, data);
end

function StorePackageBuyView:InitViewParam()
	return {
		["viewPath"] = "ui/store/",
		["viewName"] = "store_package_buy_view",
		["ParentLayer"] = mMainPop,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
	};
end

function StorePackageBuyView:Init()
	self.mGameImageBg = self:FindComponent("Item/bg","Image");
	self.mGameImageKuang = self:FindComponent("Item/kuang","Image");
	self.mGameImgPrice = self:FindComponent("Btn/Icon","Image");
	self.mImgIcon = self:FindComponent("Item/icon","RawImage");
	self.mImgIcon.color = Color.clear;

	self.mTextName = self:FindComponent("Name","Text");
	self.mTextPrice = self:FindComponent("Btn/Price","Text");
	self.mTextBottomTitle = self:FindComponent("ScrollRect/Grid/BottomTitle/Text","Text");
	self.mGoTopTitle = self:Find("ScrollRect/Grid/TopTitle").gameObject;
	self.mGoBottomTitle = self:Find("ScrollRect/Grid/BottomTitle").gameObject;
	self.mGoGridGet = self:Find("ScrollRect/Grid/scrollView1").gameObject;
	self.mGoGridDay = self:Find("ScrollRect/Grid/scrollView2").gameObject;
	self.mTransGet = self:FindComponent("ScrollRect/Grid/scrollView1","RectTransform");
	self.mTransDay = self:FindComponent("ScrollRect/Grid/scrollView2","RectTransform");

	self.mLoadedIcon = function(icon) self:OnLoadedIcon(icon); end

	local parentGet = self:Find("ScrollRect/Grid/scrollView1/Grid");
	self.mGridGet = mLayoutController.LuaNew(parentGet, require "Module/Store/StorePackageBuyItem");
	local parentDay = self:Find("ScrollRect/Grid/scrollView2/Grid");
	self.mGridDay = mLayoutController.LuaNew(parentDay, require "Module/Store/StorePackageBuyItem");

	self:FindAndAddClickListener('Btn',function()self:OnClickBuy();end);
end

function StorePackageBuyView:OnClickBuy()
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

function StorePackageBuyView:OnViewShow(data)
	self.mData = data;
	self.mTextPrice.text = data.price;
	local equip = mConfigSysgoods[data.itemData.good_id];
	self.mTextName.text = equip.goods_name;
	self.mGameObjectUtil:SetImageSprite(self.mGameImageBg,"common_bag_iconframe_"..equip.quality.."s");
	self.mGameObjectUtil:SetImageSprite(self.mGameImageKuang,"common_bag_iconframe_"..equip.quality);
	mUITextureManager.LoadTexture(mGoodsIconPath, equip.icon,self.mLoadedIcon);

	self.mGameObjectUtil:SetImageSprite(self.mGameImgPrice,"common_city_icon_"..data.itemData.price_type);
	self.mGameImgPrice:SetNativeSize();
	
	local giftGet = data.giftData.gift1;
	if giftGet ~= nil then
		self.mGoGridGet:SetActive(true);
		self.mGoTopTitle:SetActive(true);
		local dataSoureGet = mSortTable.LuaNew(nil,nil,true);
		for k,v in ipairs(giftGet) do
			local data = mStorePackageVO.LuaNew(v,false);
			dataSoureGet:AddOrUpdate(data.goods_id,data);
		end
		self.mGridGet:UpdateDataSource(dataSoureGet);
	else
		self.mGoGridGet:SetActive(false);
		self.mGoTopTitle:SetActive(false);
	end

	local giftDay = data.giftData.gift2;
	if giftDay ~= nil then
		self.mGoGridDay:SetActive(true);
		self.mGoBottomTitle:SetActive(true);
		local dataSoureDay = mSortTable.LuaNew(nil,nil,true);
		for k,v in ipairs(giftDay) do
			local data = mStorePackageVO.LuaNew(v,true);
			dataSoureDay:AddOrUpdate(data.goods_id,data);
		end
		self.mGridDay:UpdateDataSource(dataSoureDay);
		self.mTextBottomTitle.text = string.format(mLgDayGet,data.giftData.day_count);
	else
		self.mGoGridDay:SetActive(false);
		self.mGoBottomTitle:SetActive(false);
	end

	self:SetPos(giftGet,giftDay);
	local mPlayerData = mGameModelManager.RoleModel.mPlayerBase;
	self.mPriceTypeTable = {mPlayerData.exp,mPlayerData.coin,mPlayerData.gold,mPlayerData.wisdom_coin,
	mPlayerData.arena_coin,mPlayerData.dress_coin,mPlayerData.devote_coin,mPlayerData.house_coin};
end

function StorePackageBuyView:SetPos(giftGet,giftDay)
	if giftGet ~= nil then
		local countGet = mTable.getn(giftGet);
		local vectorGet = mVector2(295,85*countGet);
		self.mTransGet.sizeDelta = vectorGet;
	end

	if giftDay ~= nil then
		local countDay = mTable.getn(giftDay);
		local vectorDay = mVector2(295,85*countDay);
		self.mTransDay.sizeDelta = vectorDay;
	end
end

function StorePackageBuyView:OnLoadedIcon(icon)
	self.mImgIcon.texture = icon;
	self.mImgIcon.color = Color.white;
end

function StorePackageBuyView:Dispose()
	self.mGridGet:Dispose();
	self.mGridDay:Dispose();
end

return StorePackageBuyView;