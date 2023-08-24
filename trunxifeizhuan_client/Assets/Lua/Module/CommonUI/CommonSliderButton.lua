local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local CommonSliderButton = mLuaClass("CommonSliderButton", mBaseView);
local mSuper = nil;

function CommonSliderButton:OnLuaNew(go, callback)
	mSuper = self:GetSuper(mBaseView.LuaClassName);
	mSuper.OnLuaNew(self, go);

	self.mCallback = callback;
end

function CommonSliderButton:Init()
	local addBtn = self:Find('add');
	if addBtn ~= nil then
		self.mAddBtn = self:FindComponent('add', 'Button');
	else
		self.mAddBtn = self:FindComponent('Slider/add', 'Button');
	end

	local minusBtn = self:Find('minus');
	if minusBtn ~= nil then
		self.mMinusBtn = self:FindComponent('minus', 'Button');
	else
		self.mMinusBtn = self:FindComponent('Slider/minus', 'Button');
	end

	self:AddBtnClickListener(self.mAddBtn.gameObject, function() self:OnAdd() end);
	self:AddBtnClickListener(self.mMinusBtn.gameObject, function() self:OnMinus() end);

	local slider = self:FindComponent("Slider","Slider");
	slider.onValueChanged:AddListener(function() self:OnValueChange() end);
	self.mSlider = slider;
end

function CommonSliderButton:SetInfo(initNum,minNum,maxNum)
	local slider = self.mSlider;
    if maxNum == 1 then
    	slider.minValue = 0;
    	slider.enabled = false;
    else
    	slider.minValue = minNum;
    	slider.enabled = true;
    end
    slider.maxValue = maxNum;
    slider.value = initNum;
    self:OnValueChange();
end

function CommonSliderButton:OnAdd()
	local value = self.mSlider.value + 1;
	self.mSlider.value = value;
end

function CommonSliderButton:OnMinus()
	local value = self.mSlider.value - 1;
	self.mSlider.value = value;
end

function CommonSliderButton:OnValueChange()
	local value = self.mSlider.value;
    self.mMinusBtn.enabled = value > self.mSlider.minValue;
    self.mAddBtn.enabled = value < self.mSlider.maxValue;
	local call_back = self.mCallback;
	if call_back ~= nil then
		call_back(value);
	end
end

return CommonSliderButton;