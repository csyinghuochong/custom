local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mViewEnum = require "Enum/ViewEnum";
local mUIManager = require "Manager/UIManager"
local mAlertView = require "Module/CommonUI/AlertView"
local WWW = UnityEngine.WWW;
local LoadingManager = mLuaClass("LoadingManager",mBaseLua);

function LoadingManager:WWW(url,callBack,errorTip)
	self.mWWWURL = url;
	self.mWWWCallBack = callBack;
	self.mErrorTip = errorTip;

	StartCoroutine(function () self:DoWWW() end);
end

function LoadingManager:DoWWW()
	mUIManager:HandleUI(mViewEnum.LoadingView,1);

	local url = self.mWWWURL;
	local callBack = self.mWWWCallBack;

	local www = WWW(self.mWWWURL);
	Yield(www);
	
	if www.error then
		mUIManager:HandleUI(mViewEnum.LoadingView,0);

		mAlertView.Show({desc1 = self.mErrorTip,btnNumber = 1,CallBack = function()
			StartCoroutine(function () self:DoWWW() end);
		end});
		return;
	end

	mUIManager:HandleUI(mViewEnum.LoadingView,0);
	self.mWWWURL = nil;
	self.mWWWCallBack = nil;

	callBack(www);
end

function LoadingManager:SendData(showLoading)
	if showLoading then
		self.mShowSendDataLoading = showLoading;
		mUIManager:HandleUI(mViewEnum.LoadingView,1);
	end
end

function LoadingManager:ReceiveData()
	if self.mShowSendDataLoading then
		self.mShowSendDataLoading = nil;
		mUIManager:HandleUI(mViewEnum.LoadingView,0);
	end
end

local instance = LoadingManager.LuaNew();
return instance;