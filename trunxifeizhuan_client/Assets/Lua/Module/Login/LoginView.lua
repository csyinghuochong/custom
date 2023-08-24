local mQueueWindow = require "Core/QueueWindow"
local mLuaClass = require "Core/LuaClass"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mStringUtil = require "Utils/StringUtil"
local mLoginController = require "Module/Login/LoginController"
local LoginView = mLuaClass("LoginView",mQueueWindow);

local mResourceManager = ResourceManager;

function LoginView:InitViewParam()
	return {
		["viewPath"] = "ui/login/",
		["viewName"] = "login_view",
		["ParentLayer"] = mLoginLayer,
		["ForbitSound"] = true,
	};
end

function  LoginView:Init()
	self.mInputEmail = self:FindComponent('InputField_email', 'InputField');
	self.mInputPassword = self:FindComponent('InputField_password', 'InputField');

	local callBack_quick = function() self:OnClickQuickGame() end;
	local callBack_login = function() self:OnClickLogin() end;
	local callBack_register = function() self:OnClickRegister() end;
	local callBack_find = function() self:OnClickFindPassWord() end;
	self:FindAndAddClickListener('Button_quick_game',callBack_quick);
	self:FindAndAddClickListener('Button_login',callBack_login);
	self:FindAndAddClickListener('Button_register',callBack_register);
	self:FindAndAddClickListener('Button_find_password',callBack_find);
end

function LoginView:ShowAccountInfo()
	local loginModel = mGameModelManager.LoginModel;
	local account, password = loginModel.mAccount, loginModel.mPassword;

	self.mInputEmail.text = account;
	self.mInputPassword.text = password;
end

function LoginView:OnViewShow()
	self:ShowAccountInfo();

	mResourceManager.LuaSendEvent(0);
end

function LoginView:OnClickQuickGame()
	if true then
		return;
	end
	
	local account, password = mStringUtil:GetRandomStr(7), mStringUtil:GetRandomStr(5);
	self:SaveAccout(account, password);
	mUIManager:HandleUI(mViewEnum.LandingView,1);
end

function LoginView:SaveAccout( account, password )
	local loginModel = mGameModelManager.LoginModel;
	loginModel:SetAccount(account);
	loginModel:SetPassword(password);
end

function LoginView:OnClickLogin()
	local email = self.mInputEmail.text;
	local password = self.mInputPassword.text;
	self:SaveAccout(email, password);
	mLoginController:GetServerList();
end

function LoginView:OnClickRegister()
	mUIManager:HandleUI(mViewEnum.RegisterView,1);
end

function LoginView:OnClickFindPassWord()
	print("OnClickFindPassWord");
end

return LoginView;
