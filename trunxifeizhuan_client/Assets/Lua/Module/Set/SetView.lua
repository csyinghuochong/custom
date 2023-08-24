local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonSliderButton = require "Module/CommonUI/CommonSliderButton"
local mSoundManager = require "Module/Sound/SoundManager"
local mPlayerPrefs = UnityEngine.PlayerPrefs;
local mSceneManager = require "Module/Scene/SceneManager"
local mAlertView = require "Module/CommonUI/AlertView"
local mLanguageUtil = require "Utils/LanguageUtil"
local mNetInterface = NetInterface;
local mLoginController = require "Module/Login/LoginController"
local mServer = mLanguageUtil.server;
local mPreloadManager = require "Manager/PreloadManager"
local mPushManager = require "Manager/PushManager"
local mConfigSyspromote = require "ConfigFiles/ConfigSyspromote"
local mCommonPlayerHeadView = require "Module/CommonUI/CommonPlayerHeadView"
local SetView = mLuaClass("SetView", mQueueWindow);

function SetView:InitViewParam()
	return {
		["viewPath"] = "ui/set/",
		["viewName"] = "set_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function SetView:Init()
	self:FindAndAddClickListener("c_bg/Button_close",function() self:ReturnPrevQueueWindow(); end);
	self:FindAndAddClickListener("Info/Top/Btn",function()self:OnClickBackLogin();end);

	self.mTextServer = self:FindComponent("Info/Top/Sever","Text");
	local loginModel = mGameModelManager.LoginModel;
	local last_server = loginModel:GetLastServer();
	self.mTextServer.text = tostring(last_server.sid)..mServer.." - "..last_server.sname;

	local sliderChangeMusicBack = function(value)
        self:OnMusicChange(value);
    end
    local goMusic = self:Find("Info/Bottom/Music/Slider").gameObject;
    self.mSliderMusic = mCommonSliderButton.LuaNew(goMusic,sliderChangeMusicBack);
    local musicValue = mSoundManager.mMusicVolume * 100;
    self.mSliderMusic:SetInfo(musicValue,0,100);

    local sliderChangeEffectBack = function(value)
        self:OnEffectChange(value);
    end
    local goEffect = self:Find("Info/Bottom/Effect/Slider").gameObject;
    self.mSliderEffect = mCommonSliderButton.LuaNew(goEffect,sliderChangeEffectBack);
    local effectValue = mSoundManager.mSoundEffectVolume * 100;
    self.mSliderEffect:SetInfo(effectValue,0,100);

    self.mTextName = self:FindComponent("Info/info/name","Text");
    self.mTextMansion = self:FindComponent("Info/info/mansion","Text");
    self.mTextPosition = self:FindComponent("Info/info/position","Text");
    self.mTextPaixi = self:FindComponent("Info/info/paixi","Text");
    local goPlayer = self:Find("Info/info/Player").gameObject;
	self.mPLayer = mCommonPlayerHeadView.LuaNew(goPlayer);
end

function SetView:OnClickBackLogin()
	mAlertView.Show({title=mLanguageUtil.set_view_return_login,desc1=mLanguageUtil.set_view_ask_return_login,CallBack=function()

		mPushManager:TestPush();

		mPreloadManager:OnEnterLoginScenePreload(function()
			mSceneManager:AskForEnterScene(0);
			mLoginController:OnRelogin();
		end)
		
		end});
end

function SetView:OnMusicChange(value)
	self:Dispatch(self.mEventEnum.SET_MUSIC,value/100);
end

function SetView:OnEffectChange(value)
	self:Dispatch(self.mEventEnum.SET_SOUND_EFFECT,value/100);
end

function SetView:OnViewShow(param)
	local playerData = mGameModelManager.RoleModel.mPlayerBase;
	self:SetData(playerData);
end

function SetView:SetData(data)
	self.mTextName.text = data.name;
	self.mTextMansion.text = data.name.."的府邸";
	self.mTextPosition.text = self:GetPositionStr(data.sex,data.position);
	--self.mTextPaixi.text = data.force;
	self.mPLayer:SetInfo(data.sex,data.position,data.level);
end

function SetView:GetPositionStr(sex,position)
	if sex == 1 then
		return mConfigSyspromote[position].man_name
	else
		return mConfigSyspromote[position].woman_name
	end
end

function SetView:OnViewHide(param)
	mPlayerPrefs.SetInt('Music',mSoundManager.mMusicVolume * 100);
	mPlayerPrefs.SetInt('Effect',mSoundManager.mSoundEffectVolume * 100);
end

function SetView:Dispose()
	
end

return SetView;