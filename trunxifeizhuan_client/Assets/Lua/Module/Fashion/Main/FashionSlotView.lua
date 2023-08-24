local mLuaClass = require "Core/LuaClass"
local CommonBaseItemView = require"Module/Fashion/Common/CommonBaseItemView"
local FashionSlotView = mLuaClass("FashionSlotView", CommonBaseItemView);
local CommonButtonEventListener = require "Module/CommonUI/CommonButtonEventListener"
local FashionBaseItemView = require"Module/Fashion/FashionBaseItemView"
local mLanguage = require "Utils/LanguageUtil"
function FashionSlotView:OnAwake()

	local pressCallback = function(flag)
		self:OnPress(flag);
	end

	local holdCallback = function ()
		self:OnHold();
	end

	CommonButtonEventListener.LuaNew(self.mGameObject,0.75,pressCallback,holdCallback);	

	self.mFashionView = FashionBaseItemView.CreateAt(self:Find("fashion_view"));
	self.mMaskText = self:FindComponent("mask/Text","Text");
	self.mMask = self:Find("mask").gameObject;
end

function FashionSlotView:OnPress(flag)

	if flag then
		self:Dispatch(self.mEventEnum.ON_SELECT_FASHION_SLOT_ITEM,self);
	end
end

function FashionSlotView:OnHold()
	local data = self.mData;
	if  data and data.mDefault == false then
		self:Dispatch(self.mEventEnum.ON_HOLD_FASHION_SLOT_ITEM,self);
	end
end

function FashionSlotView:OnViewShow(logicParams)
	if logicParams then
		self.mData = logicParams;
		self:OnUpdateData(logicParams);
	end
end

function FashionSlotView:UpdateFashion(data)
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

function FashionSlotView:OnUpdateData(data)

	local fashionView = self.mFashionView;
	if data and data.mDefault == false then
		self:UpdateFashion(data);
		fashionView:ForceShowView(data);
	else
		self.mMask:SetActive(false);
		fashionView:HideView();
	end
	
end

function FashionSlotView:Dispose()
	self.mFashionView:CloseView();
	self.mFashionView = nil;
end

return FashionSlotView;