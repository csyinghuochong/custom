local mLuaClass = require "Core/LuaClass"
local LayoutItem = require "Core/Layout/LayoutItem"
local MainFashionItemView = mLuaClass("MainFashionItemView", LayoutItem);
local CommonButtonEventListener = require "Module/CommonUI/CommonButtonEventListener"
local FashionBaseItemView = require"Module/Fashion/FashionBaseItemView"
local FashionInfoView = require"Module/Fashion/FashionInfoView"
local mLanguage = require "Utils/LanguageUtil"

function MainFashionItemView:InitViewParam()
	return {
		["viewPath"] = "ui/fashion/",
		["viewName"] = "main_fashion_item_view",
	};
end

function MainFashionItemView:Init()
	self.mNameText = self:FindComponent("fashion_name","Text");
	self.mMaskText = self:FindComponent("mask/Text","Text");

	local holdCallback = function ()
		self:OnHold();
	end

	local clickCallback = function()
		self:OnClick();
	end

	local btn = CommonButtonEventListener.LuaNew(self.mGameObject,0.75,pressCallback,holdCallback,clickCallback);

	self.mFashionView = FashionBaseItemView.CreateAt(self:Find("fashion_view"));
	self.mMask = self:Find("mask").gameObject;

	local data = self.mData;
	if data then
		self:UpdateData(data);
	end
end

function MainFashionItemView:OnClick()

	if self.mSelected then
		return;
	end

	self:Dispatch(self.mEventEnum.ON_CLICK_BFASHION_ITEM,self);
end

function MainFashionItemView:OnHold()
	self:SetSelected(true);
end

function MainFashionItemView:OnUpdateData()

	local data = self.mData;
	local config = data.mConfig;

	self.mNameText.text = config.name;
	self.mFashionView:ForceShowView(data);

	if data.mActived then
		self.mMask:SetActive(false);
	else
		self.mMask:SetActive(true);
		local maskText = self.mMaskText;
		if data:CanCombine() then
			maskText.text = mLanguage.fashion_combine_able;
		else
			maskText.text = mLanguage.fashion_not_have;
		end
	end
end

function MainFashionItemView:OnSelected(value)
	self:Dispatch(self.mEventEnum.ON_SELECT_BFASHION_ITEM,self);
	if value then
		FashionInfoView.Show(self.mData);
	else
		FashionInfoView.Hide();
	end
end

function MainFashionItemView:Dispose()
	self.mFashionView:CloseView();
	self.mFashionView = nil;
end

return MainFashionItemView;