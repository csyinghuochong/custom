local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBaseVindow = require "Core/BaseWindow"
local mGameNameManager = require "Module/GameName/GameNameManager"
local FollowerController = require "Module/Follower/FollowerController"
local mGameNameManager = require "Module/GameName/GameNameManager"
local FollowerAlterNameView = mLuaClass("FollowerAlterNameView", mBaseVindow);

function FollowerAlterNameView:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_alter_name_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
	};
end

function FollowerAlterNameView:Init()
	self.mInputname = self:FindComponent('InputField_name', 'InputField');

	self:FindAndAddClickListener('button_cancel',function() self:OnClickCancel() end);
	self:FindAndAddClickListener('button_confirm',function() self:OnClickConfirm() end);
	self:FindAndAddClickListener('Button_random',function() self:OnClickRandomName() end);
end

function FollowerAlterNameView:OnViewShow(data)
	self.mData = data;
	self.mInputname.text = '';
end

function FollowerAlterNameView:OnClickCancel(  )
	self:HideView();
end

function FollowerAlterNameView:OnClickConfirm(  )
	local name = self.mInputname.text;
	if mGameNameManager:CheckName(name) then
		self:HideView();
		FollowerController:SendAlterFollowerName(self.mData.mUID, name);
	end
end

function FollowerAlterNameView:OnClickRandomName(  )
	self.mInputname.text = mGameNameManager:GetRoleName(self.mData:GetSex());
end

return FollowerAlterNameView;