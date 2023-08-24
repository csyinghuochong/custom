local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mAssetManager = require "AssetManager/AssetManager"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mStoreBuyView = require "Module/Store/StoreBuyView"
local mStoreBuySingleView = require "Module/Store/StoreBuySingleView"
local mStorePackageBuyView = require "Module/Store/StorePackageBuyView"
local mConfigSysgoods = require "ConfigFiles/ConfigSysgoods"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView";
local mCommonGoodsVO = require"Module/CommonUI/CommonGoodsVO";
local mStoreController = require "Module/Store/StoreController"
local StoreGoodsItem = mLuaClass("StoreGoodsItem",mLayoutItem);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgCanBuyTimes = mLanguageUtil.store_canbuy_times;
local mLgDayToUp = mLanguageUtil.store_day_to_up;
local mLgSellOut = mLanguageUtil.store_sell_out;

local mLgStateTable = {mLanguageUtil.store_state1,mLanguageUtil.store_state2,mLanguageUtil.store_state3};

function StoreGoodsItem:InitViewParam()
	return {
		["viewPath"] = "ui/store/",
		["viewName"] = "store_goods_item_view",
	};
end

function StoreGoodsItem:Init( )
	self.mTextName = self:FindComponent("Name","Text");
	self.mTextPrice = self:FindComponent("Price","Text");
	self.mGameImgPriceIcon = self:FindComponent("PriceIcon","Image");
	self.mGoPriceYuan =self:Find("PriceYuan").gameObject;

	self.mItem = mCommonGoodsItemView.LuaNew(self:Find('item').gameObject);

	self:FindAndAddClickListener('Back',function()self:OnClickBuy();end);

	--上架倒计时
	self.mGoTimeToUp = self:Find("TimeToUp").gameObject;
	self.mTextTimeToUp = self:FindComponent("TimeToUp/Text","Text");

	--限购
	self.mGoCanBuy = self:Find("CanBuy").gameObject;
	self.mTextCanBuy = self:FindComponent("CanBuy/Text","Text");

	--赠送
	self.mGoSong = self:Find("Song").gameObject;
	self.mTextSong = self:FindComponent("Song/Text","GameArtNumText");

	--限时
	self.mGoForTime = self:Find("ForTime").gameObject;
	self.mTextTimeType = self:FindComponent("ForTime/Type","Text");

	--打折
	self.mGoZhe = self:Find("Zhe").gameObject;
	self.mTextZhe = self:FindComponent("Zhe/Text","GameArtNumText");

	local mEvent = self.mEventEnum;
	self:RegisterEventListener(mEvent.LOGIN_NEW_DAY,function(data)self:ChangeDay(data);end,false);

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function StoreGoodsItem:ChangeDay(data)
	if self.mIsDayUp then
		if self.mDayUpNum > 1 then
			self.mDayUpNum = self.mDayUpNum - 1;
			self.mTextTimeToUp.text = string.format(mLgDayToUp,self.mDayUpNum);
			self.mGoTimeToUp:SetActive(true);
		else
			self.mIsDayUp = false;
			self.mGoTimeToUp:SetActive(false);
		end
	end
end

local mTimeUtil = require "Utils/TimeUtil"
function StoreGoodsItem:OnClickBuy()
	local data = self.mData;
	data.isDayUp = self.mIsDayUp;
	if data.itemData.price_type == 0 then
		mStoreController:SendBuyStoreGood(data.id,1);
		return;
	end
	if self:CheckSellOut(data) then
		return;
	end
	if data.itemData.good_type == 2 then
		mStorePackageBuyView.Show(data);
	else
		if data.itemData.batch_peak ~= 0 then
			mStoreBuyView.Show(data);
		else
			mStoreBuySingleView.Show(data);
		end
	end
end

function StoreGoodsItem:CheckSellOut(data)
	if data.itemData.refresh_type == 1 or (data.itemData.refresh_type == 6 and data.itemData.refresh_count == 0) then
		return false;
	else
		if data.remain_count > 0 then
			return false;
		else
			return true;
		end
	end
end

function StoreGoodsItem:OnUpdateData()
	local data = self.mData;
	local equip = mConfigSysgoods[data.itemData.good_id];
	self.mTextName.text = equip.goods_name;
	self.mItem:ExternalUpdate(mCommonGoodsVO.LuaNew(data.itemData.good_id, 0 ,nil ,false));
	
	self.mTextPrice.text = data.price;
	local price_type = data.itemData.price_type;
	if price_type == 0 then
		self.mGoPriceYuan:SetActive(true);
		self.mGameImgPriceIcon.gameObject:SetActive(false);
	else
		self.mGoPriceYuan:SetActive(false);
		self.mGameImgPriceIcon.gameObject:SetActive(true);
		self.mGameObjectUtil:SetImageSprite(self.mGameImgPriceIcon,"common_city_icon_"..price_type);
	end
	self.mGameImgPriceIcon:SetNativeSize();

	self:CheckTime(data.sell_start_time);
	self:CheckRemainCount(data);
	self:CheckIsSong(data.itemData.attach_count);
	self:CheckIsForTime(data.itemData.limit_type);
	self:CheckIsZhe(data.itemData.dicount);
end

function StoreGoodsItem:CheckTime(start_time)
	local nowTime = mGameModelManager.LoginModel:GetCurrentTime();
	local second = start_time - nowTime;
	if second > 0 then
		self.mIsDayUp = true;
		local day1,day2 = math.modf(second/86400);
		self.mDayUpNum = day1 + 1;
		self.mTextTimeToUp.text = string.format(mLgDayToUp,self.mDayUpNum);
		self.mGoTimeToUp:SetActive(true);
	else
		self.mIsDayUp = false;
		self.mGoTimeToUp:SetActive(false);
	end
end

function StoreGoodsItem:CheckRemainCount(data)
	if data.remain_count ~= nil then
		if data.itemData.refresh_type == 1 or (data.itemData.refresh_type == 6 and data.itemData.refresh_count == 0) then
			self.mGoCanBuy:SetActive(false);
		else
			self.mGoCanBuy:SetActive(true);
			if data.remain_count == 0 then
				self.mTextCanBuy.text = mLgSellOut;
			else
				self.mTextCanBuy.text = string.format(mLgCanBuyTimes,data.remain_count);
			end
		end
	else
		self.mGoCanBuy:SetActive(false);
	end
end

function StoreGoodsItem:CheckIsSong(attach_count)
	if attach_count~= nil and attach_count > 0 then
		self.mGoSong:SetActive(true);
		self.mTextSong.text = "S "..attach_count;
	else
		self.mGoSong:SetActive(false);
	end
end

function StoreGoodsItem:CheckIsForTime(limit_type)
	if limit_type ~= nil and limit_type ~= 0 then
		self.mGoForTime:SetActive(true);
		self.mTextTimeType.text = mLgStateTable[limit_type];
	else
		self.mGoForTime:SetActive(false);
	end
end

function StoreGoodsItem:CheckIsZhe(discount)
	if discount > 0 then
		self.mGoZhe:SetActive(true);
		self.mTextZhe.text = discount.."Z";
	else
		self.mGoZhe:SetActive(false);
	end
end

return StoreGoodsItem;