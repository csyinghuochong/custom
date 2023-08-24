local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mLayoutController = require "Core/Layout/LayoutController"
local CommonSkillItemView = require "Module/Follower/FollowerSkillItemView"
local FollowerSkillList = mLuaClass("FollowerSkillList",mBaseView);

function FollowerSkillList:Init()
	self:InitSkillItemList();

	self.mSkillDesc = self:FindComponent('Text_desc', 'Text');
	self.mSkillName = self:FindComponent('Text_name', 'Text');
	local i_select = self:Find('Image_4');
	if i_select == nil then
		i_select = self:Find('skill1/Image_select');
	end
	self.mObjectSelect = i_select;

	local parent = self:Find('ScrollView/Grid');
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Follower/FollowerSkillDescItem");
end

function FollowerSkillList:InitSkillItemList()
	local callBack = function ( vo )
		self:OnClickSkill(vo);
	end

	local skill_list = {};
	for i =1, 4 do
		skill_list[i] = CommonSkillItemView.LuaNew(self:Find('skill'..i).gameObject, callBack);
	end
	self.mSkillItemList = skill_list;
end

function FollowerSkillList:OnUpdateUI(data)
	self.mData =data;
	local skill_list = data:GetSkillList();
	local skill_view = self.mSkillItemList;

	for k, v in pairs(skill_list) do
		skill_view[k]:ExternalUpdate(v);
	end

	self:OnClickSkill(skill_list[1]);
end

function FollowerSkillList:OnUpdateSkill( skill_vo )
	local position = skill_vo:GetSkillPosition( );
	self.mSkillItemList[ position ]:ExternalUpdate(skill_vo);
end

function FollowerSkillList:SetSetSkillBack( callBack )
	self.mCallBack = callBack;
end

function FollowerSkillList:OnClickSkill(skill_vo)
	local data_source = skill_vo:GetDescVOList();
	self.mGridEx:UpdateDataSource(data_source);
	self:UpdateSelectState(skill_vo);

	local callBack = self.mCallBack;
	if callBack then
		callBack( skill_vo );
	end
end

function FollowerSkillList:UpdateSelectState(skill_vo)
	self.mSkillDesc.text = skill_vo:GetDesc();
	self.mSkillName.text = skill_vo.mSkillInfo.name;
	local position = skill_vo.mSkillInfo.position;
	if position >= 1 and position <= 4 then
		local skill_item = self.mSkillItemList[position];
		local i_select = self.mObjectSelect;
		mGameObjectUtil:SetParent(i_select, skill_item.mTransform);
		i_select:SetSiblingIndex(0);
	end
end

function FollowerSkillList:Dispose( )
	self.mGridEx:Dispose();
end

return FollowerSkillList;