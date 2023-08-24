local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mEventEnum = require "Enum/EventEnum"
local mStringUtil = require "Utils/StringUtil"
local mUIManager = require "Manager/UIManager"
local mQueueWindow = require "Core/QueueWindow"
local mGameModelManager = require "Manager/GameModelManager"
local RegisterView = mLuaClass("RegisterView",mQueueWindow);

function RegisterView:InitViewParam()
	return {
		["viewPath"] = "ui/login/",
		["viewName"] = "register_view",
		["ParentLayer"] = mLoginLayer,
	};
end

function  RegisterView:Init()
	self.mInputEmail = self:FindComponent('InputField_email', 'InputField');
	self.mInputEmailPassword = self:FindComponent('InputField_password', 'InputField');
	self.mInputEmailPassword2 = self:FindComponent('InputField_password2', 'InputField');

	self:FindAndAddClickListener('Button_ok',function() self:OnClickOk() end);
	self:FindAndAddClickListener("Button_return",function() self:ReturnPrevQueueWindow() end);
end

function RegisterView:OnViewShow()
	
end

function RegisterView:OnClickOk()
	local loginModel = mGameModelManager.LoginModel;
	local account, password, password2 = self.mInputEmail.text, self.mInputEmailPassword.text, self.mInputEmailPassword2.text;

	if (mStringUtil:HaveInvalidChar(account)) then
		print("账号含有非法字符");
	elseif (mStringUtil:HaveInvalidChar(password)) then
		print("密码含有非法字符");
	elseif(mStringUtil:GetStrLength(account) < 5) then
		print("账号长度不能小于5位数");
	elseif (mStringUtil:GetStrLength(password) < 6) then
		print("密码长度不能小于6位数");
	elseif (password ~= password2) then
		print("密码不一致");
	else
		loginModel:SetAccount(account);
		loginModel:SetPassword(password);

		mUIManager:HandleUI(mViewEnum.LoginView,1);
	end
end

return RegisterView;