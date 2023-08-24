local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mOpenLog = GameDebugConfig.openLog;
local mNetInterface = NetInterface;
local mLuaNetSocketParam = LuaNetSocketParam;
local mLuaRawPacket = LuaRawPacket;
local mC2S = nil;
local mS2C = nil;
local mReceiveCallback = nil;
local mProtolDesc;
local mViewEnum = require "Enum/ViewEnum";
local mUIManager = require "Manager/UIManager"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mLanguage = require "Utils/LanguageUtil"
local mAlertView = require "Module/CommonUI/AlertView"
local mLoadingManager = require "Module/Loading/LoadingManager";
local NetManager = mLuaClass("NetManager",mBaseLua);

function NetManager:OnLuaNew()
	local param = LuaNetSocketParam.New();
	param["loginIn"] = function(v1)
		self:OnLoginIn(v1);
	end

	param["reconnectTip"] = function(v2)
		self:OnReconnectTip(v2);
	end

	param["connectTip"] = function(v3)
		self:OnConnectTip(v3);
	end

	param["receiveCallback"] = function()
		self:ReceiveCallback();
	end

	self.mLuaNetSocketParam = param;
	mNetInterface.InitLuaSocketParam(param);
end

function NetManager:SetLoginStatus(value)
	self.mLuaNetSocketParam.loginStatus = value;
end

function NetManager:OnLoginIn(v)
	--print('OnLoginIn');

	local mLoginController = require "Module/Login/LoginController"
	mLoginController:LoginIn();
end

function NetManager:OnReconnectTip(v)
	--print('OnReconnectTip:' .. tostring(v));

	if v == 0 then
		--与服务器建立连接失败，请重试！
		mCommonTipsView.Show(mLanguage.first_connect_server_error_tip);
	else -- 1 2
		mAlertView.Show({btnNumber = 1,desc1=mLanguage.retry_connect_server_tip,CallBack=function()
			mNetInterface.ReconnectManual();
		end});
	end
end

function NetManager:OnConnectTip(v)	
	--print('OnConnectTip:' .. tostring(v));

	if v then
		mUIManager:HandleUI(mViewEnum.LoadingView,1);
	else
		mUIManager:HandleUI(mViewEnum.LoadingView,0);
	end
end

function NetManager:InitIPAndPort(ip,port )
	mNetInterface.InitIPAndPort(ip,port);
end

function NetManager:SetConnectInitParam(baseValue, addValue)
	mNetInterface.SetConnectInitParam(baseValue,addValue);
end

function NetManager:InitProtolDesc()
	if mProtolDesc == nil then
		mC2S = require "ProtolManager/C2S"
		mS2C = require "ProtolManager/S2C"
		mReceiveCallback = mS2C.mReceiveCallback;
		mProtolDesc = ProtolDesc;
	end
end

function NetManager:ReceiveCallback()
	self:InitProtolDesc();

	mLoadingManager:ReceiveData();

	local buffList = self.mLuaNetSocketParam.buffList;

	for i=0,buffList.Count - 1 do
		local buff = buffList[i];
		local cmdID = buff.cmdID;
		local byteBuffer = buff.byteBuffer;

		local callback = mReceiveCallback[cmdID];
		if callback then
			if mOpenLog and cmdID ~= 10001 then
               print("<<<<<<<<<<<<<<<<<<<<<",mProtolDesc[cmdID]);
			end
			callback(byteBuffer);
		elseif mOpenLog then
			print("<<<<<<<<<<<<<<<<<<<<<未侦听 ",cmdID,mProtolDesc[cmdID]);
		end
	end
end

function NetManager:SendData(cmdID,bytes,showLoading)
	self:InitProtolDesc();

	mLoadingManager:SendData(showLoading);
	
    if mOpenLog and cmdID ~= 10001 then
       print(">>>>>>>>>>>>>>>>>>>>",mProtolDesc[cmdID]);
	end

	local packet = mLuaRawPacket.New();
	packet.mCMDID = cmdID;
	packet.bytes = bytes;
	mNetInterface.SendData(packet);
end

local instance = NetManager.LuaNew();
return instance;