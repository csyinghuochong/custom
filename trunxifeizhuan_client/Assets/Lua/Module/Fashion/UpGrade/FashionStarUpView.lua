local mLuaClass = require "Core/LuaClass"
local FashionSubView = require "Module/Fashion/UpGrade/FashionSubView"
local FashionStarUpView = mLuaClass("FashionStarUpView", FashionSubView);
local FashionLongStyleItemView = require"Module/Fashion/FashionLongStyleItemView"
local mLanguage = require "Utils/LanguageUtil"
function FashionStarUpView:InitViewParam()
	return {
		["viewPath"] = "ui/fashion/",
		["viewName"] = "fashion_star_up_view",
	};
end

function FashionStarUpView:OnAwake()
	self.mConstItemViews = self:CreateItemsView("view/cost","Module/Fashion/UpGrade/FashionUpGradeCostItemView",2);
	self:InitNewStyleView();
	self:InitNewUseView();
end

function FashionStarUpView:OnDispose()
	self.mConstItemViews:Dispose();
	self.mNewStyleView:CloseView();
	self.mConstItemViews = nil;
	self.mNewStyleView = nil;
end

function FashionStarUpView:InitNewStyleView()
	local styleItemView = FashionLongStyleItemView.LuaNew();
	styleItemView:SetIndex(1);
	styleItemView:SetItemRoot(self:Find("view/new_attribute/new_style"));
	styleItemView:AlwaysShowActiveView();
	self.mNewStyleView = styleItemView;
end

function FashionStarUpView:InitNewUseView()
	local useText = self:FindComponent("view/new_attribute/new_use","Text");
	self.mNewUseText = useText;
	self.mNewUseView = useText.gameObject;
end

function FashionStarUpView:DoLevelUp()
	self:SendStarUp();
end

function FashionStarUpView:GetUpGradeCost(data)
	return data:GetStarUpCost();
end

function FashionStarUpView:IsMaxLevel(data)
	return data:IsMaxStar();
end

local mUseNames = {
	mLanguage.fashion_use_1,
	mLanguage.fashion_use_2,
	mLanguage.fashion_use_3,
	mLanguage.fashion_use_4,
	mLanguage.fashion_use_5,
	mLanguage.fashion_use_6,
	mLanguage.fashion_use_7,
	mLanguage.fashion_use_8,
	mLanguage.fashion_use_9,
	mLanguage.fashion_use_10,
	mLanguage.fashion_use_11,
	mLanguage.fashion_use_12,
	mLanguage.fashion_use_13,
	mLanguage.fashion_use_14,
	mLanguage.fashion_use_15,
	mLanguage.fashion_use_16
}

function FashionStarUpView:UpdateView(data)
	self.mBeforeFashionView:ForceShowView(data);
	local newData = self.mNewFashionVo;
	newData:Copy(data);
	newData.mStar = newData.mStar + 1;

	self.mAfterFashionView:ForceShowView(newData);

	local info = data:GetNextStarInfo();
	local style = info.style;
	local styleView = self.mNewStyleView;
	if style then
		styleView:ForceShowView(style);
	else
		styleView:HideView();
	end

	local use = info.use;
	if use then
		self.mNewUseText.text = mLanguage.fashion_use..":        "..mUseNames[use];
		self.mNewUseView:SetActive(true);
	else
		self.mNewUseView:SetActive(false);
	end

	self:ShowUpGradeCostView(data);
end

function FashionStarUpView:UpdateMaxLevelView(data)
	self.mMaxLevelFashionView:ForceShowView(data);
end

return FashionStarUpView;