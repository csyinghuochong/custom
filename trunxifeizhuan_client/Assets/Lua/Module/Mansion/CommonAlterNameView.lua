local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBaseWindow = require "Core/BaseWindow"
local mGameNameManager = require "Module/GameName/GameNameManager"
local CommonAlterNameView = mLuaClass("CommonAlterNameView", mBaseWindow);

function CommonAlterNameView:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_alter_name_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
	};
end

function CommonAlterNameView:Init()
	self.mInputname = self:FindComponent('InputField_name', 'InputField');

	self:FindAndAddClickListener('button_cancel',function() self:OnClickCancel() end);
	self:FindAndAddClickListener('button_confirm',function() self:OnClickConfirm() end);

	self.mTextCost = self:FindComponent('Text_alter_cost', 'Text');
end

function CommonAlterNameView:OnViewShow(data)
	self.mData = data;
	self.mInputname.text = '';
	self.mTextCost.text = data.mCost;
end

function CommonAlterNameView:OnClickCancel(  )
	self:HideView();
end

function CommonAlterNameView:OnClickConfirm(  )
	local name = self.mInputname.text;
	if mGameNameManager:CheckName(name) then
		self.mData.mCallBack( name );
		self:HideView();
	end
end

return CommonAlterNameView;