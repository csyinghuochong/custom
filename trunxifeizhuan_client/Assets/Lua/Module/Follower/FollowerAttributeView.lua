local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local TalentAttributeItem = require "Module/Talent/TalentAttributeItem"
local FollowerAttributeView = mLuaClass("FollowerAttributeView",mBaseView);
local mString = require 'string'

function FollowerAttributeView:Init()
	local attri_list = {};
	for i = 1, 8 do
		attri_list[i] = TalentAttributeItem.LuaNew(self:Find(mString.format('attri%d', i)).gameObject);
	end
	self.mAttriList = attri_list;
end

function FollowerAttributeView:OnUpdateUI(vo)
	local attri_list = self.mAttriList;
	if vo ~= nil then
		local data = vo:GetTotalAttr();
		for k, v in pairs(attri_list) do
			v:UpdateUI(k, data[k]);
		end
	else
		for k,v in pairs(attri_list) do
			v:UpdateUI(k, "");
		end
	end
end

return FollowerAttributeView;