local mLuaClass = require "Core/LuaClass"
local FashionSubView = require "Module/Fashion/UpGrade/FashionSubView"
local FashionQualityUpView = mLuaClass("FashionQualityUpView", FashionSubView);
local FashionSaveAttributesView = require "Module/Fashion/UpGrade/FashionSaveAttributesView"
local FashionAttributeItemView = require"Module/Fashion/FashionAttributeItemView"

function FashionQualityUpView:InitViewParam()
	return {
		["viewPath"] = "ui/fashion/",
		["viewName"] = "fashion_quality_up_view",
	};
end

function FashionQualityUpView:OnAwake()

	self.mAttributeItemViews = self:InitItemsView("view/combat_attributes/attributes","Module/Fashion/FashionAttributeItemView");
	self.mConstItemViews = self:CreateItemsView("view/cost","Module/Fashion/UpGrade/FashionUpGradeCostItemView",2);

	self.mMaxAttributeItemViews = self:InitItemsView("max_level_view/combat_attributes/attributes","Module/Fashion/FashionAttributeItemView");

	self.mMaxConstItemViews = self:CreateItemsView("max_level_view/cost","Module/Fashion/UpGrade/FashionUpGradeCostItemView",2);

	self.mBaseAttributeView = FashionAttributeItemView.LuaNew(self:Find("max_level_view/combat_attributes/base_attribute").gameObject);

	self:FindAndAddClickListener("max_level_view/Button",function() self:DoRecovery() end);

	local btnGraphic = self:FindComponent('max_level_view/Button/icon',"Graphic");
	self.mMaxUpGradeButtonGraphic = btnGraphic;
	self.mMaxUpGradeButtonGray = self:InitGrayGraphic(btnGraphic);
end

function FashionQualityUpView:OnDispose()
	self.mAttributeItemViews:Dispose();
	self.mConstItemViews:Dispose();
	self.mMaxAttributeItemViews:Dispose();
	self.mMaxConstItemViews:Dispose();

	self.mBaseAttributeView:CloseView();

	self.mAttributeItemViews = nil;
	self.mConstItemViews = nil;
	self.mMaxAttributeItemViews = nil;
	self.mMaxConstItemViews = nil;

	self.mBaseAttributeView = nil;
end

function FashionQualityUpView:DoLevelUp()
	self:SendQualityUp();
end

function FashionQualityUpView:GetUpGradeCost(data)
	return data:GetQualityUpCost();
end

local mOpenWashParams = {};
function FashionQualityUpView:DoRecovery()

	local data = self.mData;
	mOpenWashParams.data = data;
	mOpenWashParams.btnCallback = function (flag)
		self:SendSaveWash(flag);
	end
	self:SendWash();
	FashionSaveAttributesView.Show(mOpenWashParams);
end

function FashionQualityUpView:IsMaxLevel(data)
	return data:IsMaxQuality();
end


function FashionQualityUpView:UpdateView(data)
	self.mBeforeFashionView:ForceShowView(data);
	local newData = self.mNewFashionVo;
	newData:Copy(data);
	newData.mQuality = newData.mQuality + 1;
	self.mAfterFashionView:ForceShowView(newData);
	self.mAttributeItemViews:ShowView(data.mAdditionalAttributes);
	self.mBaseAttributeView:ForceShowView(data.mBaseAttribute);
	self:ShowUpGradeCostView(data);
end

function FashionQualityUpView:CanWash(data)

	local info = data:GetRecoveryCost();
	if info then
		return data:CheckEnoughGoods(info.cost);
	end

	return false;
end

function FashionQualityUpView:UpdateMaxUpGradeButton(data)
	local canUpgrade = self:CanWash(data);
	self.mMaxUpGradeButtonGraphic.raycastTarget = canUpgrade;
	self.mMaxUpGradeButtonGray:SetGray(canUpgrade == false);
end

function FashionQualityUpView:UpdateMaxLevelView(data)
	self.mMaxLevelFashionView:ForceShowView(data);

	self.mMaxAttributeItemViews:ShowView(data.mAdditionalAttributes);
	local info = data:GetRecoveryCost();
	if info then
		self.mMaxConstItemViews:ShowView(info.cost);
	else
		self.mMaxConstItemViews:HideView();
	end

	self:UpdateMaxUpGradeButton(data);
end

return FashionQualityUpView;