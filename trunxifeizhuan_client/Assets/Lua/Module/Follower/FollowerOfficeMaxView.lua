local mLuaClass = require "Core/LuaClass"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local FollowerOfficeMaxView = mLuaClass("FollowerOfficeMaxView", mCommonTabBaseView);
local mLanguageUtil = require "Utils/LanguageUtil"
local mString = string;

function FollowerOfficeMaxView:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_office_max_view",
	};
end

function FollowerOfficeMaxView:Init()
	self:SetParent(self.mGoParent);
	self.mTextMaxOffice = self:FindComponent('ScrollView/Text', 'Text');
end

function FollowerOfficeMaxView:OnUpdateUI(data)
	self.mData = data;
	
	self.mTextMaxOffice.text = data.mActorVO.promote_text;
end

return FollowerOfficeMaxView;