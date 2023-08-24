local mLuaClass = require "Core/LuaClass"
local mUIGray = require "Utils/UIGray"
local mLayoutItem = require "Core/Layout/LayoutItem"
local FollowerSkillDescItem = mLuaClass("FollowerSkillDescItem",mLayoutItem);
local mSuper = nil;

function FollowerSkillDescItem:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "skill_up_desc_item",
	};
end

function FollowerSkillDescItem:Init( )
	self.mTextDesc = self:FindComponent('Text_desc', 'Text');
	self.mUIGray = mUIGray.LuaNew():InitGoGraphic(self:Find('Text_desc'));

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function FollowerSkillDescItem:OnViewShow( )
	
end

function FollowerSkillDescItem:OnUpdateData()
	local data = self.mData;
	self.mTextDesc.text = data.mDesc;
	self.mUIGray:SetGray(not data.mActive);
end

return FollowerSkillDescItem;