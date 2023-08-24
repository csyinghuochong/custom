local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mNetManager = require "Net/NetManager"
local mUIManager = require "Manager/UIManager"
local mBaseController = require "Core/BaseController"
local mGameModelManager = require "Manager/GameModelManager"
local mSceneManager = require "Module/Scene/SceneManager"
local mConfigSysecodeConst = require "ConfigFiles/ConfigSysecodeConst"
local mErrorCodeController = require "Module/CommonErrorCode/ErrorCodeController"
local mNetInterface = NetInterface;
local mString = require "string"
local mCsjon = require "cjson"
local mLoadingManager = require "Module/Loading/LoadingManager";
local mLanguage = require "Utils/LanguageUtil"
local mResourceManager = ResourceManager;
local mDeviceID = UnityEngine.SystemInfo.deviceUniqueIdentifier;
local mAlertView = require "Module/CommonUI/AlertView"
local mPreloadManager = require "Manager/PreloadManager"
local LoginController = mLuaClass("LoginController",mBaseController);

function LoginController:OnLuaNew()
	local super = self:GetSuper(mBaseController.LuaClassName);
	super.OnLuaNew(self);

	self.mLoginID = 0;
	self.mLoginOK = true;
	self:SetLoginStatus(false);
end

function LoginController:AddNetListeners()
	local mS2C = self.mS2C;
	
	mS2C:LOGIN_OK_SERVER(function(pbResult)
		if self.mLoginID > 0 then
			self.mLoginOK = false;
		end
	end);

	mS2C:LOGIN(function(pbAccountInit)
		if self.mLoginOK then
			mNetManager:SetConnectInitParam(pbAccountInit.init_num,pbAccountInit.add_num);
			if self.mLoginID <=0 then
				mPreloadManager:OnLoginEnterMainScenePreload(function()
					mSceneManager:AskForEnterScene(1);
				end);
			end
			self:Dispatch(self.mEventEnum.LOGIN_SUCCESS,self.mLoginID);
			
			self:OnLogin();
			mGameModelManager.LoginModel.mServerTimeDiffer = pbAccountInit.time - os.time();
		else
			self:DoRelogin();
		end
	end);
end

function LoginController:AddEventListeners()
	mErrorCodeController:RegisterErrorCodeAction(mConfigSysecodeConst.ERROR_ACCOUNT_NOT_EXIST,function()
		print("ERROR_ACCOUNT_NOT_EXIST");
		mUIManager:HandleUI(mViewEnum.CreatePlayerView,1);
	end);

	mErrorCodeController:RegisterErrorCodeAction(mConfigSysecodeConst.ERROR_ROLE_LOGIN_OTHER_MACHINE,function(config)
		print("ERROR_ROLE_LOGIN_OTHER_MACHINE");
		self:DoRelogin(config.error_tips);
	end);

	mErrorCodeController:RegisterErrorCodeAction(mConfigSysecodeConst.ERROR_LOGIN_DIFF_DEVICE,function()
		print("ERROR_LOGIN_DIFF_DEVICE");
		self:DoRelogin();
	end);

	mErrorCodeController:RegisterErrorCodeAction(mConfigSysecodeConst.ERROR_SYS_ERROR,function(config)
		print("ERROR_SYS_ERROR");
		self:DoRelogin(config.error_tips);
	end);
end

function LoginController:DoRelogin(tip)
	mAlertView.Show({btnNumber = 1,desc1= tip or mLanguage.relogin_tip,CallBack=function()
			mSceneManager:AskForEnterScene(0);
		end});

	self:OnRelogin();
end

function LoginController:OnLogin()
    self.mLoginID = 1;
    self:SetLoginStatus(true);
end

function LoginController:OnRelogin()
    self.mLoginID = 0;
    self:SetLoginStatus(false);
    mNetInterface.CloseConnect();
end

function LoginController:SetLoginStatus(value)
	mNetManager:SetLoginStatus(value);
end

function LoginController:GetPlatformConfigValue(key1,key2)
	return self.mPlatformConfig:GetValue(key1,key2);
end

function LoginController:OpenLoginView()
	if self.mPlatformConfig == nil then
		mResourceManager.GetPlatformConfig(function(config)
			self.mPlatformConfig = config;
		end);
	end

	mUIManager:HandleUI(mViewEnum.LoginView,1);
end

function LoginController:GetServerListLink()
	local loginModel = mGameModelManager.LoginModel;
	local account = loginModel.mAccount;
	local link = mString.format(self:GetPlatformConfigValue("game","serverlist"),account);

	return link;
end

function LoginController:GetServerList()
	mLoadingManager:WWW(self:GetServerListLink(),function(www)
		local loginModel = mGameModelManager.LoginModel;
		loginModel:InitServerInfo(mCsjon.decode(www.text));
		mUIManager:HandleUI(mViewEnum.LandingView,1);
	end,mLanguage.get_server_list_error_tip);
end

function LoginController:ApplyforLogin()
	local loginModel = mGameModelManager.LoginModel;
	local server = loginModel:GetLastServer();
	mNetInterface.CloseConnect();
	mNetManager:InitIPAndPort(server.host, server.port);
	self:LoginIn();
end

function LoginController:LoginIn()
	self.mLoginOK = true;
	self:Login();
end

function LoginController:CreatePlayer(nickName,sex)
	self:Login(nickName,sex,true);
end

function LoginController:Login(nickName,sex,showLoading)
	local loginModel = mGameModelManager.LoginModel;
	local acc_id = 10;
	local acc_name = loginModel.mAccount;
	local timestamp = 0;
	local serverID = loginModel.mLastServerID;
	sex = sex or 0;
	nickName = nickName or "";
	self.mC2S:LOGIN(acc_id,acc_name,timestamp,serverID,"","","ApkDev","",nickName,self.mLoginID,0,sex,mDeviceID,0,showLoading);
end

local mLoginControllerInstance = LoginController.LuaNew();
return mLoginControllerInstance;