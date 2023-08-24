local mLuaClass = require "Core/LuaClass"
local FashionSubView = require "Module/Fashion/UpGrade/FashionSubView"
local FashionLevelUpView = mLuaClass("FashionLevelUpView", FashionSubView);
local string = string;
local mLanguage = require "Utils/LanguageUtil"
function FashionLevelUpView:InitViewParam()
	return {
		["viewPath"] = "ui/fashion/",
		["viewName"] = "fashion_level_up_view",
	};
end

function FashionLevelUpView:OnAwake()
	self.mAttributeType = self:FindComponent("view/attribute/type","Text");
	self.mAttributeBeforeValue = self:FindComponent("view/attribute/value_before","Text");
	self.mAttributeAfterValue = self:FindComponent("view/attribute/value_after","Text");
	self.mConstNumber = self:FindComponent("view/cost/number","Text");

	self.mMaxAttributeType = self:FindComponent("max_level_view/attribute/type","Text");
	self.mMaxAttributeValue = self:FindComponent("max_level_view/attribute/value","Text");

	self:FindAndAddClickListener("view/btn_use_goods",function() self:OnClickUseGoods() end);

	self.mUseGoodsView = self:Find("view/btn_use_goods/icon_use").gameObject;
	self.mUseGoods = false;
	self.mSucceedRate = 0;
	self.mSucceedRateText =  self:FindComponent("view/succeed_rate","Text");
	self.mGoodsNumberText =  self:FindComponent("view/btn_use_goods/goods_number","Text");
end

function FashionLevelUpView:OnClickUseGoods()

	local goods_number = self:GetGoodsNumber(1010701);
	local use_goods = true;
	local add_succeed_rate = 2;

	if self.mUseGoods or goods_number == 0 then
		use_goods = false;
		add_succeed_rate = 1;
	end

	self.mUseGoods = use_goods;
	self.mUseGoodsView:SetActive(use_goods);
	self:UpdateSucceedRateView(add_succeed_rate*self.mSucceedRate);
end

function FashionLevelUpView:DoLevelUp()

	local use_goods = 0;
	if self.mUseGoods then
		use_goods = 1;
	end

	self:SendLevelUp(use_goods);
end

function FashionLevelUpView:GetUpGradeCost(data)
	return data:GetLevelUpCost();
end

function FashionLevelUpView:CanUpGrade(data)

	local info = self:GetUpGradeCost(data);
	if info then
		return data:CheckEnoughCoin(1000002,info.cost);
	end

	return false;
end

function FashionLevelUpView:IsMaxLevel(data)
	return data:IsMaxLevel();
end

function FashionLevelUpView:UpdateView(data)

	self.mBeforeFashionView:ForceShowView(data);

	local attribute = data.mBaseAttribute;
	local newData = self.mNewFashionVo;
	newData:Copy(data);
	newData:SetLevel(data.mLevel + 1);
	self.mAfterFashionView:ForceShowView(newData);

	self.mAttributeType.text = attribute:GetName();
	self.mAttributeBeforeValue.text = string.format(attribute.value * 100).."%";
	self.mAttributeAfterValue.text = string.format(newData.mBaseAttribute.value * 100).."%";

	local info = self:GetUpGradeCost(data);

	--如意石
	local goods_number = self:GetGoodsNumber(1010701);
	local use_goods = self.mUseGoods;
	
	if goods_number == 0 then
		use_goods = false;
		self.mUseGoods = false;
	else
		use_goods = self.mUseGoods;
	end

	if info then
		local succeed_rate = info.succeed_rate;
		local add_succeed_rate = 1;
		if use_goods then
			add_succeed_rate = 2;
		end
		self.mConstNumber.text = info.cost;
		self.mSucceedRate = succeed_rate;
		self:UpdateSucceedRateView(add_succeed_rate*succeed_rate);
	end
	self.mUseGoodsView:SetActive(use_goods);
	
	self.mGoodsNumberText.text = string.format(mLanguage.common_ruyishi.."X%d",goods_number);
end

function FashionLevelUpView:UpdateMaxLevelView(data)

	self.mMaxLevelFashionView:ForceShowView(data);

	local attribute = data.mBaseAttribute;

	self.mMaxAttributeType.text = attribute:GetName();
	self.mMaxAttributeValue.text = string.format("%d",attribute.value * 100).."%";
	
end

return FashionLevelUpView;