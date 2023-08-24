local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local CommonStatusButton = mLuaClass("CommonStatusButton", mBaseView);
local mSuper = nil;

function CommonStatusButton:OnLuaNew(go, status,callback)
	mSuper = self:GetSuper(mBaseView.LuaClassName);
	mSuper.OnLuaNew(self, go);

	self.mStatus = status;
	self.mCallback = callback;
end

function CommonStatusButton:Init()
	self.mGoCheck = self:Find("check").gameObject;
	self:FindAndAddClickListener("node", function() self:OnClick() end);
	self:SetInfo();
end

function CommonStatusButton:OnClick()
	self.mStatus = not self.mStatus;
	self:SetInfo();
	if self.mCallback ~= nil then
		self.mCallback(self.mStatus);
	end
end

function CommonStatusButton:SetInfo()
	self.mGoCheck:SetActive(self.mStatus);
end

return CommonStatusButton;