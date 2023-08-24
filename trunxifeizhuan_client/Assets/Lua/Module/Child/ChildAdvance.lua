local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mChildStar = require "Module/Child/ChildStar"
local mCommonGoodItemView = require "Module/CommonUI/CommonGoodsItemView"
local mCommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local mChildItemView = require "Module/Child/ChildItemView"
local mChildVO = require "Module/Child/ChildVO"
local ChildAdvance = mLuaClass("ChildAdvance",mBaseView);

function ChildAdvance:Init()
	local goChild = self:Find("Top/itemNow").gameObject;
	self.mChildNow = mChildItemView.LuaNew(goChild);
	self.mTextNowCharacter = self:FindComponent("Top/itemNow/Aptitude","Text");

	local goChildNext = self:Find("Top/itemUp").gameObject;
	self.mChildNext = mChildItemView.LuaNew(goChildNext);
	self.mTextNextCharacter = self:FindComponent("Top/itemUp/Aptitude","Text");

	self.mTextAdd = self:FindComponent("Top/Data","Text");
	self.mTextAddTitle = self:FindComponent("Top/Title/titleProperty","Text");

	self.mTextExp = self:FindComponent("Top/exp","Text");
	self.mSlider = self:FindComponent("Top/Slider_exp/Slider","Slider");

	self.mGoodsItem1 = mCommonGoodItemView.LuaNew(self:Find("Bottom/item1").gameObject);
	self:FindAndAddClickListener("Bottom/Button1",function() self:OnClickButtonNormal(); end);

	self.mGoodsItem2 = mCommonGoodItemView.LuaNew(self:Find("Bottom/item2").gameObject);
	self:FindAndAddClickListener("Bottom/Button2",function() self:OnClickButtonSuper(); end);
end

function ChildAdvance:OnClickButtonNormal()
	print("Normal");
end

function ChildAdvance:OnClickButtonSuper()
	print("Super");
end

function ChildAdvance:SetInfo(data)
	self.mChildNow:ExternalUpdate(data);
	local Data = {id = data.id,name = data.name,child_id = data.child_id,quality = data.quality + 1,character = data.character,star_level = data.star_level};
	local nextData = mChildVO.LuaNew(Data);
	self.mChildNext:ExternalUpdate(nextData);
	self.mTextNowCharacter.text = data:GetAptitude();
	self.mTextNextCharacter.text = data:GetAptitude(nextData.quality);

	self.mTextAddTitle.text = data:GetAddTitle();
	self.mTextAdd.text = data:GetAddData(data.quality + 1);

	if data.quality >= 4 then
		self.mSlider.maxValue = 1;
		self.mSlider.value = 1;
		self.mTextExp.text = "MAX";
	else
		self.mTextExp.text = data.quality_exp.."/"..data:GetMaxQualityExp();
		self.mSlider.maxValue = data:GetMaxQualityExp();
		self.mSlider.value = data.quality_exp;
	end

	local itemData1 = mCommonGoodsVO.LuaNew(data:GetQualityCostGood(true));
	self.mGoodsItem1:ExternalUpdate(itemData1);
	local itemData2 = mCommonGoodsVO.LuaNew(data:GetQualityCostGood(false));
	self.mGoodsItem2:ExternalUpdate(itemData2);
end

function ChildAdvance:OnViewShow(data)
	
end

return ChildAdvance;