local mQueueWindow = require "Core/QueueWindow"
local mLuaClass = require "Core/LuaClass"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mEventEnum = require "Enum/EventEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mLoginController = require "Module/Login/LoginController"
local LandingView = mLuaClass("LandingView",mQueueWindow);

local mLanguageUtil = require "Utils/LanguageUtil"
local mGameBuildVersion = require "Utils/GameBuildVersion";
local mServer = mLanguageUtil.server;

function LandingView:InitViewParam()
	return {
		["viewPath"] = "ui/login/",
		["viewName"] = "landing_view",
		["ParentLayer"] = mLoginLayer,
		["ForbitSound"] = true,
	};
end

function LandingView:Init()
	self.mTextServerName = self:FindComponent('Bottom/Button_select_server/Text_name', 'Text');

	local versionText = self:FindComponent('TopLeft/version', 'Text');
	versionText.text = mLanguageUtil.login_version_str .. mLoginController:GetPlatformConfigValue("game","version") .. "." .. mGameBuildVersion;

	self:FindAndAddClickListener('Bottom/Button_select_server',function() self:OnClickSelectServer() end);
	self:FindAndAddClickListener('Bottom/Button_start_game',function() self:OnClickStartGame() end,"ty_0205",2);

	self:RegisterEventListener(mEventEnum.LOGIN_SELECT_SERVER, function()
		self:InitSelectServer();
	end, false);
end

function  LandingView:OnClickSelectServer()
	mUIManager:HandleUI(mViewEnum.ServerInfoView,1);
end

function  LandingView:OnClickStartGame()
	mLoginController:ApplyforLogin();
end

function LandingView:OnViewShow()
	self:InitSelectServer();
end

function LandingView:InitSelectServer()
	local loginModel = mGameModelManager.LoginModel;
	local last_server = loginModel:GetLastServer();

	self.mTextServerName.text = tostring(last_server.sid)..mServer..last_server.sname;
end

return LandingView;