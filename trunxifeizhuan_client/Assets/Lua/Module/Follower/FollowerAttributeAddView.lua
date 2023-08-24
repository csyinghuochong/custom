local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local TalentAttributeItem = require "Module/Talent/TalentAttributeItem"
local FollowerAttributeAddView = mLuaClass("FollowerAttributeAddView",mBaseView);
local mString = require 'string'

function FollowerAttributeAddView:Init()
	local attri_list = {};
	for i = 1, 8 do
		attri_list[i] = TalentAttributeItem.LuaNew(self:Find(mString.format('attri%d', i)).gameObject);
	end
	self.mAttriList = attri_list;
end

function FollowerAttributeAddView:OnUpdateUI(vo)
	local attri_list = self.mAttriList;
	local total_attr = vo:GetTotalAttr();
	local benti_attr = vo:GetBenTiAttri();

	local benti_value = nil;
	for k, v in pairs(attri_list) do
		benti_value  = benti_attr[k];
		v:UpdateUIAdd(k, benti_value, total_attr[k] - benti_value);
	end
end

return FollowerAttributeAddView;