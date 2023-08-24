local mLuaClass = require "Core/LuaClass"
local LayoutItem = require "Core/Layout/LayoutItem"
local UpGradeFashionItemView = mLuaClass("UpGradeFashionItemView", LayoutItem);
local FashionBaseItemView = require"Module/Fashion/FashionBaseItemView"
local CommonButtonEventListener = require "Module/CommonUI/CommonButtonEventListener"
local FashionInfoView = require"Module/Fashion/FashionInfoView"

function UpGradeFashionItemView:InitViewParam()
	return {
		["viewPath"] = "ui/fashion/",
		["viewName"] = "upgrade_fashion_item_view",
	};
end

function UpGradeFashionItemView:Init()
	
	local holdCallback = function ()
		self:OnHold();
	end

	local clickCallback = function()
		self:OnClick();
	end

	local pressCallback = function()
		self:OnPress();
	end

	local btn = CommonButtonEventListener.LuaNew(self.mGameObject,0.75,pressCallback,holdCallback,clickCallback);

	self.mFashionView = FashionBaseItemView.CreateAt(self.mTransform);

	local data = self.mData;
	if data then
		self:UpdateData(data);
	end
end

function UpGradeFashionItemView:OnHold()

	if self.mHolding then
		return;
	end

	local data = self.mData;
	if data and data.mActived then
		self.mHolding = true;
		FashionInfoView.ShowWith(data,self.mTransform,true);
	end
end

function UpGradeFashionItemView:OnClick()

	if self.mHolding then
		self.mHolding = false;
	else
		local data = self.mData;
		if data and data.mActived then
			self:SetSelected(true);
		end
	end
end

function UpGradeFashionItemView:OnPress(flag)
	if flag then
		self.mHolding = false;
	elseif self.mHolding then
		FashionInfoView.Hide();
	end
end

function UpGradeFashionItemView:OnUpdateData()
	local data = self.mData;
	local fashionView = self.mFashionView;
	if data.mActived then
		fashionView:ForceShowView(data);
	else
		fashionView:HideView();
	end
	
end

function UpGradeFashionItemView:OnSelected(value)
	self:Dispatch(self.mEventEnum.ON_SELECT_SFASHION_ITEM,self);
end

function UpGradeFashionItemView:Dispose()
	self.mFashionView:CloseView();
	self.mFashionView = nil;
end

return UpGradeFashionItemView;