local mLuaClass = require "Core/LuaClass"
local mEventEnum = require "Enum/EventEnum"
local mCommonAllAwardItemView = require "Module/CommonUI/CommonAllAwardItemView"
local MailAwardItem = mLuaClass("MailAwardItem",mCommonAllAwardItemView);
local mSuper = nil;
local mColor = Color

function MailAwardItem:InitViewParam()
	return {
		["viewPath"] = "ui/mail/",
		["viewName"] = "mail_award_item_view",
	};
end

function MailAwardItem:Init()
	self.mGoGet = self:Find("get").gameObject;
	mSuper = self:GetSuper(mCommonAllAwardItemView.LuaClassName);
	mSuper.Init(self);
end

function MailAwardItem:OnUpdateData()
	mSuper.OnUpdateData(self);
	local param = self.mData;
	self.mGoGet:SetActive(param.mIsGet);
end

return MailAwardItem;