local mLuaClass = require "Core/LuaClass"
local mUIGray = require "Utils/UIGray"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mAssetManager = require "AssetManager/AssetManager"
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView";
local mCommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local mTalentItemVO = require "Module/Talent/TalentItemVO"
local mConfigSysshops_mystery = require "ConfigFiles/ConfigSysshops_mystery"
local mMysteryBuyView = require "Module/Mystery/MysteryBuyView"
local mMysteryBuyTalentView = require "Module/Mystery/MysteryBuyTalentView"
local mTalentItemBaseView = require "Module/Talent/TalentItemBaseView"
local mGameModelManager = require "Manager/GameModelManager"
local MysteryItem = mLuaClass("MysteryItem",mLayoutItem);
local mSuper = nil;

function MysteryItem:InitViewParam()
	return {
		["viewPath"] = "ui/mystery/",
		["viewName"] = "mystery_item_view",
	};
end

function MysteryItem:Init( )
	local goItem = self:Find("item").gameObject;
	self.mGoods = mCommonGoodsItemView.LuaNew(goItem);
	self.mGoItem = goItem;

	local goTalentItem = self:Find("talent_item").gameObject;
	self.mTalentItem = mTalentItemBaseView.LuaNew(goTalentItem);
	self.mGoTalentItem = goTalentItem;

	self.mTextName = self:FindComponent("name","Text");
	self.mTextPrice = self:FindComponent("Price","Text");
	self.mImgPrice = self:FindComponent("PriceIcon","Image");
	self.mGoOut = self:Find("Out").gameObject;

	self:FindAndAddClickListener("Back",function() self:OnClickItem(); end);

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function MysteryItem:OnClickItem()
	local data = self.mData;
	local model = mGameModelManager.MysteryModel;
	if data.type == 1 then
		mMysteryBuyView.Show(data);
	else
		mMysteryBuyTalentView.Show(data);
	end
end

function MysteryItem:OnUpdateData()
	local data = self.mData;
	local price;
	local price_type;
	if data.type == 1 then
		local config = mConfigSysshops_mystery[data.id];
		local goodsVO = mCommonGoodsVO.LuaNew(config.goods_id,nil,nil,false);
		self.mGoods:ExternalUpdate(goodsVO);
		self.mTextName.text = config.name;
		price = config.price[2];
		price_type = config.price[1];
	else
		local talentVO = mTalentItemVO.LuaNew(data.talent.talent,nil);
		self.mTextName.text = talentVO:GetName();
		self.mTalentItem:ExternalUpdate(talentVO);
		price = data.talent.price;
		price_type = 2;
	end
	self.mGoItem:SetActive(data.type == 1);
	self.mGoTalentItem:SetActive(data.type ~= 1);
	self.mGoOut:SetActive(data.buy_tag == 1);
	self:SetPrice(price_type,price);
end

function MysteryItem:SetPrice(type,price)
	self.mTextPrice.text = price;
	self.mGameObjectUtil:SetImageSprite(self.mImgPrice,"common_city_icon_"..type);
	self.mImgPrice:SetNativeSize();
end

return MysteryItem;