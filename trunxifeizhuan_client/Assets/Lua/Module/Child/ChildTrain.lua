local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mChildStar = require "Module/Child/ChildStar"
local mCommonGoodItemView = require "Module/CommonUI/CommonGoodsItemView"
local mCommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local ChildTrain = mLuaClass("ChildTrain",mBaseView);

function ChildTrain:Init()
	self.mTextAttack = self:FindComponent("Top/DataOld/text1","Text");
	self.mTextDefense = self:FindComponent("Top/DataOld/text2","Text");
	self.mTextPhysical = self:FindComponent("Top/DataOld/text3","Text");
	self.mTextSpeed = self:FindComponent("Top/DataOld/text4","Text");
	self.mTextAdd = self:FindComponent("Top/DataOld/text5","Text");

	self.mTextAttackNew = self:FindComponent("Top/DataNew/text1","Text");
	self.mTextDefenseNew = self:FindComponent("Top/DataNew/text2","Text");
	self.mTextPhysicalNew = self:FindComponent("Top/DataNew/text3","Text");
	self.mTextSpeedNew = self:FindComponent("Top/DataNew/text4","Text");
	self.mTextAddNew = self:FindComponent("Top/DataNew/text5","Text");

	self.mTextAddTitle = self:FindComponent("Top/Title/titleAdd","Text");

	self.mTextExp = self:FindComponent("Top/exp","Text");
	self.mSlider = self:FindComponent("Top/Slider_exp/Slider","Slider");

	local goOld = self:Find("Top/starOld").gameObject;
	self.mStarOld = mChildStar.LuaNew(goOld);

	local goNew = self:Find("Top/starNew").gameObject;
	self.mStarNew = mChildStar.LuaNew(goNew);

	self.mGoodsItem1 = mCommonGoodItemView.LuaNew(self:Find("Bottom/item1").gameObject);
	self:FindAndAddClickListener("Bottom/Button1",function() self:OnClickButtonNormal(); end);

	self.mGoodsItem2 = mCommonGoodItemView.LuaNew(self:Find("Bottom/item2").gameObject);
	self:FindAndAddClickListener("Bottom/Button2",function() self:OnClickButtonSuper(); end);
end

function ChildTrain:OnClickButtonNormal()
	print("Normal");
end

function ChildTrain:OnClickButtonSuper()
	print("Super");
end

function ChildTrain:SetInfo(data)
	local property = data:GetProperty(false);
	self.mTextAttack.text = property[1];
	self.mTextDefense.text = property[2];
	self.mTextPhysical.text = property[3];
	self.mTextSpeed.text = property[4];

	local nextProperty = data:GetProperty(true);
	self.mTextAttackNew.text = nextProperty[1];
	self.mTextDefenseNew.text = nextProperty[2];
	self.mTextPhysicalNew.text = nextProperty[3];
	self.mTextSpeedNew.text = nextProperty[4];

	self.mTextAddTitle.text = data:GetAddTitle();

	self.mTextAdd.text = data:GetAddData();
	self.mTextAddNew.text = data:GetAddData(data.quality,data.star_level + 1);

	self.mStarOld:SetInfo(data.star_level);
	self.mStarNew:SetInfo(data.star_level + 1);

	if data.star_level >= 20 then
		self.mSlider.maxValue = 1;
		self.mSlider.value = 1;
		self.mTextExp.text = "MAX";
	else
		self.mTextExp.text = data.star_level_exp.."/"..data:GetMaxExp();
		self.mSlider.maxValue = data:GetMaxExp();
		self.mSlider.value = data.star_level_exp;
	end

	local itemData1 = mCommonGoodsVO.LuaNew(data:GetStarCostGood(true));
	self.mGoodsItem1:ExternalUpdate(itemData1);

	local itemData2 = mCommonGoodsVO.LuaNew(data:GetStarCostGood(false));
	self.mGoodsItem2:ExternalUpdate(itemData2);
end

function ChildTrain:OnViewShow(data)

end

return ChildTrain;