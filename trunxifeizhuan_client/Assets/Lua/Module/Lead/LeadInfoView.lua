local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local CommonSkillItemView = require "Module/CommonUI/CommonSkillItemView"
local mFollowerAttributeView = require "Module/Follower/FollowerAttributeAddView"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local LeadInfoView = mLuaClass("LeadInfoView",mCommonTabBaseView);

function LeadInfoView:InitViewParam()
	return {
		["viewPath"] = "ui/lead/",
		["viewName"] = "lead_info_view",
	};
end

function LeadInfoView:Init( )
	self:InitSubView( );
end

function LeadInfoView:InitSubView( )
	self.mImageExp = self:Find("Image_exp");
	self.mTextLv = self:FindComponent( 'Text_level', 'Text');
	self.mTextExp = self:FindComponent('Text_exp', 'Text');
	self.mTextOffice = self:FindComponent('Text_office', 'Text');
	self.mAttributeView = mFollowerAttributeView.LuaNew(self:Find('attri_view').gameObject);

	local clickSkill = function ( data )
		self:OnClickSkill( data );
	end
	local skill_list = {};
	for i =1, 4 do
		skill_list[i] = CommonSkillItemView.LuaNew(self:Find('skill'..i).gameObject, clickSkill);
	end
	self.mSkillItemList = skill_list;
end

function LeadInfoView:OnClickSkill( vo )
	mUIManager:HandleUI(mViewEnum.LeadSkillActiveView, 1, { vo, 1 } );
end

function LeadInfoView:OnUpdateUI(data)	
	self.mData = data;
	self.mTextOffice.text = data:GetOfficeName();
	self.mTextExp.text = data:GetExpStr( );
	self.mTextLv.text = data:GetLevel( );
	self.mImageExp.localScale = Vector3.New(data:GetExpRate( ), 1, 1);
	self.mAttributeView:OnUpdateUI(data);

	local skill_list = data:GetSkillList();
	local skill_view = self.mSkillItemList;
	for k, v in pairs(skill_list) do
		skill_view[k]:ExternalUpdate(v, false);
	end
end

function LeadInfoView:Dispose()
	
end

return LeadInfoView;