local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mLayoutController = require "Core/Layout/LayoutController"
local TalentAttributeItem = require "Module/Talent/TalentAttributeItem"
local CommonSkillItemView = require "Module/CommonUI/CommonSkillItemView"
local FollowerOfficeAttriView = mLuaClass("FollowerOfficeAttriView",mBaseView);

function FollowerOfficeAttriView:Init()
	local attri_list = {};
	local mPath = 'attri%d';
	for i = 1, 3 do
		attri_list[i] = TalentAttributeItem.LuaNew(self:Find(string.format(mPath, i)).gameObject);
	end
	self.mAttriList = attri_list;

	local skill_list = {};
	for i =1, 2 do
		local skill = self:Find( 'skill_item'..i );
		if skill then
			skill_list[i] = CommonSkillItemView.LuaNew(skill.gameObject);
		end
	end
	self.mSkillItemList = skill_list;
end

function FollowerOfficeAttriView:OnUpdateUI(data, vo1, vo2)
	self.mData =data;
	
	self:UpdateNewAttri( data );
	self:UpdateNewSkill( vo1, vo2 );
end

function FollowerOfficeAttriView:UpdateNewSkill( vo1, vo2 )
	skill_list = self.mSkillItemList;
	if vo1 then
		skill_list[ 1 ]:ExternalUpdate( vo1 );
	end
	if vo2 then
		skill_list[ 2 ]:ExternalUpdate( vo1 );
	end
end

function FollowerOfficeAttriView:UpdateNewAttri( data )
	local attriList = self.mAttriList;
	local office_vo = data:GetOfficeVO( );
	local voList = self:GetBaseAttribute(office_vo.addition_attri);
	for k, v in pairs(attriList) do
		local vo = voList[k];
		if vo ~= nil and vo.value > 0 then
			attriList[k]:ShowView();
			attriList[k]:UpdateAddValue(vo.key, vo.value);
		else
			attriList[k]:HideView();	
		end
	end
end

function FollowerOfficeAttriView:GetBaseAttribute( base_attri )
	local baseAttri = {};
	if base_attri ~= nil then
		for k, v in pairs(base_attri) do
			if v.value ~= 0 then
				table.insert(baseAttri, v);
			end
		end
	end
	return baseAttri;
end

return FollowerOfficeAttriView;