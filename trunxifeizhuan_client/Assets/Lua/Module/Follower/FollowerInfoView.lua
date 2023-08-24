local mLuaClass = require "Core/LuaClass"
local mLanguageUtil = require "Utils/LanguageUtil"
local CommonSkillItemView = require "Module/CommonUI/CommonSkillItemView"
local mFollowerAttributeView = require "Module/Follower/FollowerAttributeAddView"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local FollowerInfoView = mLuaClass("FollowerInfoView",mCommonTabBaseView);

function FollowerInfoView:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_info_view",
	};
end

function FollowerInfoView:Init( )
	self:InitSubView( );
end

function FollowerInfoView:InitSubView( )
	self.mImageExp = self:Find("Image_exp");
	self.mTextLv = self:FindComponent( 'Text_level', 'Text');
	self.mTextExp = self:FindComponent('Text_exp', 'Text');
	self.mTextOffice = self:FindComponent('Text_office', 'Text');
	self.mAttributeView = mFollowerAttributeView.LuaNew(self:Find('attri_view').gameObject);

	local skill_list = {};
	for i =1, 4 do
		skill_list[i] = CommonSkillItemView.LuaNew(self:Find('skill'..i).gameObject);
	end
	self.mSkillItemList = skill_list;
end

function FollowerInfoView:OnUpdateUI(data)	
	self.mData = data;
	self.mTextOffice.text = data:GetOfficeName();
	self.mTextExp.text = data:GetExpStr( );
	self.mTextLv.text = data:GetLevel( )..mLanguageUtil.level;
	self.mImageExp.localScale = Vector3.New(data:GetExpRate( ), 1, 1);
	self.mAttributeView:OnUpdateUI(data);

	local skill_list = data:GetSkillList();
	local skill_view = self.mSkillItemList;
	for k, v in pairs(skill_list) do
		skill_view[k]:ExternalUpdate(v);
	end
end

function FollowerInfoView:Dispose()
	
end

return FollowerInfoView;