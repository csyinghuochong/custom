local mLuaClass = require "Core/LuaClass"
local FashionSubView = require "Module/Fashion/UpGrade/FashionSubView"
local FashionOpenLightView = mLuaClass("FashionOpenLightView", FashionSubView);
local string = string;
function FashionOpenLightView:InitViewParam()
	return {
		["viewPath"] = "ui/fashion/",
		["viewName"] = "fashion_xuanguang_view",
	};
end

function FashionOpenLightView:OnAwake()
	self.mStyleItemViews = self:CreateItemsView("view/attributes","Module/Fashion/FashionLongStyleItemView",4);
	self.mMaxStyleItemViews = self:CreateItemsView("max_level_view/attributes","Module/Fashion/FashionLongStyleItemView",4);
	self.mConstItemViews = self:CreateItemsView("view/cost","Module/Fashion/UpGrade/FashionUpGradeCostItemView",2);
	self.mSucceedRateText =  self:FindComponent("view/succeed_rate","Text");
end

function FashionOpenLightView:OnDispose()
	self.mStyleItemViews:Dispose();
	self.mMaxStyleItemViews:Dispose();
	self.mConstItemViews:Dispose();

	self.mStyleItemViews = nil;
	self.mMaxStyleItemViews = nil;
	self.mConstItemViews = nil;
end

function FashionOpenLightView:DoLevelUp()
	self:SendXuanguang();
end

function FashionOpenLightView:GetUpGradeCost(data)
	return data:GetXuangguangCost();
end

function FashionOpenLightView:IsMaxLevel(data)
	return data:IsMaxXuangguang();
end

function FashionOpenLightView:UpdateView(data)
	self.mBeforeFashionView:ForceShowView(data);
	local newData = self.mNewFashionVo;
	newData:Copy(data);
	newData.mXuanguang = newData.mXuanguang + 1;
	self.mAfterFashionView:ForceShowView(newData);

	self.mStyleItemViews:ShowView(data:GetStyles());
	self:ShowUpGradeCostView(data);
end

function FashionOpenLightView:UpdateMaxLevelView(data)
	self.mMaxLevelFashionView:ForceShowView(data);
	self.mMaxStyleItemViews:ShowView(data:GetStyles());
end

return FashionOpenLightView;