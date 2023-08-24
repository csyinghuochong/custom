local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local AlertBaseView = mLuaClass("AlertBaseView", mBaseWindow);
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mSuper = nil;

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgOK = mLanguageUtil.friend_info_delete_ok;
local mLgCancel = mLanguageUtil.common_btn_cancel;
local mLgDefaultTitle = mLanguageUtil.alert_default_title

function AlertBaseView.Show(table)
	mUIManager:HandleUI(mViewEnum.AlertBaseView, 1, table);
end

function AlertBaseView:InitViewParam()
	return {
		["viewPath"] = "ui/common/",
		["viewName"] = "alert_view2",
		["ParentLayer"] = mPopLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
		["ForbitSound"] = true
	};
end

function AlertBaseView:Init()
	self.mTextTitle = self:FindComponent("Text/TextTitle","Text");
	self.mTextDesc1 = self:FindComponent("Text/TextDesc1","Text");
	self.mTextBtnOK = self:FindComponent("Btn/BtnOk/Text","Text");
	self.mTextBtnCancel = self:FindComponent("Btn/BtnCancel/Text","Text");
	self.mButtonCancel = self:Find('Btn/BtnCancel').gameObject;
	self.mButtonOk =  self:Find('Btn/BtnOk').gameObject;
	self:AddBtnClickListener(self.mButtonCancel, function() self:OnClickCancel() end);
	self:AddBtnClickListener(self.mButtonOk, function() self:OnClickBtnOK() end);
end

function AlertBaseView:OnClickCancel()
	local callback = self.mData.CancelCallBack;
	if callback ~= nil then
		callback();
	end
	self:HideView();
	self:PlayHideSound();
end

function AlertBaseView:OnClickBtnOK()
	local callback = self.mData.CallBack;
	if callback ~= nil then
		callback();
	end
	self:HideView();
end

function AlertBaseView:OnViewShow(logicParams)
	self.mData = logicParams;
	local data = logicParams;

	self.mTextDesc1.text = data.desc1;
	self.mTextTitle.text = data.title ~= nil and data.title or mLgDefaultTitle;
	self.mTextBtnOK.text = data.btnName ~= nil and data.btnName or mLgOK;
	self.mTextBtnCancel.text = data.btnNameCancel ~= nil and data.btnNameCancel or mLgCancel;

	local btn_number = data.btnNumber;
	local btnCancel = self.mButtonCancel;
	local btnOk = self.mButtonOk;
	if btn_number == 1 then
		btnCancel:SetActive(false);
		btnOk.transform.localPosition = Vector3.New(0, 0, 0);
	else
		btnCancel:SetActive(true);
		btnOk.transform.localPosition = Vector3.New(88, 0, 0);
	end

	mSuper = self:GetSuper(mBaseWindow.LuaClassName);
	mSuper.OnViewShow(self,logicParams);
end

function AlertBaseView:Dispose()
end

return AlertBaseView;