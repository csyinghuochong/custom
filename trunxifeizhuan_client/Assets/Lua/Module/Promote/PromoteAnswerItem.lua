local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local PromoteAnswerItem = mLuaClass("PromoteAnswerItem",mBaseView);
local mSuper;

function PromoteAnswerItem:OnLuaNew(go, callback)
	mSuper = self:GetSuper(mBaseView.LuaClassName);
	mSuper.OnLuaNew(self, go);

	self.mCallback = callback;
end

function PromoteAnswerItem:Init()
	self.mTextAnswer = self:FindComponent('Text', 'Text');
	self.mToggle = self.mTransform:GetComponent('Toggle');
	self.mToggle.onValueChanged:AddListener(function() self:OnValueChangedBack() end);
end

function PromoteAnswerItem:OnValueChangedBack( )
	local callback =  self.mCallback;
	if callback ~= nil then
		callback();
	end
end

function PromoteAnswerItem:OnUpdateUI(vo)
	self.mOptionId = vo.option_id;
	self.mTextAnswer.text = vo.option;
end

function PromoteAnswerItem:SetToggleGroup( toggle_group )
	self.mToggle.group = toggle_group;
end

function PromoteAnswerItem:SetSelected( select )
	self.mToggle.isOn = select;
end

function PromoteAnswerItem:GetSelected(  )
	return self.mToggle.isOn;
end

return PromoteAnswerItem;