local mLuaClass = require "Core/LuaClass"
local TalentAttributeItem = require "Module/Talent/TalentAttributeItem"
local mFollowerItemView = require "Module/CommonUI/CommonFollowerItemView"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local FollowerBreakMaxView = mLuaClass("FollowerBreakMaxView", mCommonTabBaseView);
local mLanguageUtil = require "Utils/LanguageUtil"
local mString = string;

function FollowerBreakMaxView:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_break_max_view",
	};
end

function FollowerBreakMaxView:Init()
	self:SetParent(self.mGoParent);
	local attri_list = {};
	for i = 1, 4 do
		attri_list[i] = TalentAttributeItem.LuaNew(self:Find(mString.format('attriItem%d', i)).gameObject);
	end
	self.mAttriList = attri_list;

	self.mFollowerItem = mFollowerItemView.LuaNew(self:Find('Image_current/follower_item').gameObject);
end

function FollowerBreakMaxView:OnUpdateUI(data)
	self.mData = data;
	self:ShowAttribute(data);
	self.mFollowerItem:ExternalUpdateData(data);
end

function FollowerBreakMaxView:ShowAttribute( data )
	local totalAtti = data:GetTotalAttr();
	local attriList = self.mAttriList;
	for k, v in pairs(attriList) do
		v:UpdateUI(k, data:GetUpAddAttri(k) * data:GetLevel());
	end
end

function FollowerBreakMaxView:Dispose( )
	
end

return FollowerBreakMaxView;