local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mUIManager = require "Manager/UIManager"
local mReceivePowerController = require "Module/ReceivePower/RecievePowerController"
local mGameModelManager = require "Manager/GameModelManager"
local mLanguageUtil = require "Utils/LanguageUtil"
local mConfigSysmanual = require "ConfigFiles/ConfigSysmanual"
local mConfigSysmanualConst = require "ConfigFiles/ConfigSysmanualConst";
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local mAlertView = require "Module/CommonUI/AlertView"
local mTimeUtil = require "Utils/TimeUtil"
local mGameTimer = require "Core/Timer/GameTimer"
local ReceivePowerView = mLuaClass("ReceivePowerView",mQueueWindow);

local morningStart = mConfigSysglobal_value[mConfigGlobalConst.PLAYER_SP_EVERY_DAY_TIME_GET_1];
local morningEnd = mConfigSysglobal_value[mConfigGlobalConst.PLAYER_SP_EVERY_DAY_TIME_GET_2];
local noonStart = mConfigSysglobal_value[mConfigGlobalConst.PLAYER_SP_EVERY_DAY_TIME_GET_3];
local noonEnd = mConfigSysglobal_value[mConfigGlobalConst.PLAYER_SP_EVERY_DAY_TIME_GET_4];
local nightStart = mConfigSysglobal_value[mConfigGlobalConst.PLAYER_SP_EVERY_DAY_TIME_GET_5];
local nightEnd = mConfigSysglobal_value[mConfigGlobalConst.PLAYER_SP_EVERY_DAY_TIME_GET_6];

function ReceivePowerView:InitViewParam()
	return {
		["viewPath"] = "ui/receive_power/",
		["viewName"] = "receive_power_view",
		["ParentLayer"] = mMainLayer,
		["full_cost"] = {"gold","silver","strength","energy"},
		["ChangeSceneDispose"] = true,
	};
end

function ReceivePowerView:Init()
	self.mWhetherRecevie = false;
	self.mRecevieNum = 0;
	self.mRefreshUiTime = 0;
	self.mCanRecevie = self:Find('CanRecevie');
	self.mCanNotRecevie = self:Find('CanNotRecevie');
	self.mExplain = self:Find('Explain');
	self.mExplainText = self:FindComponent("Explain/Text","Text");

	self:FindAndAddClickListener("Top/CloseButton",function() self:ReturnPrevQueueWindow(); end);
	self:FindAndAddClickListener("Recevie",function() self:ClickReceive();end)
	self:AddListeners();

	--请求一次数据
	mReceivePowerController:GetEveryDayPower();	
end

function ReceivePowerView:AddListeners()
	local mEvent = self.mEventEnum;
	self:RegisterEventListener(mEvent.ON_GET_EVERY_DAY_POWER,function(data)self:ReGetEveryDayPower(data);end,true)
	self:RegisterEventListener(mEvent.ON_RECEIVE_POWER,function(data)self:ReceivePower(data);end,true)
end

function ReceivePowerView:OnViewShow()
	self:AddNextRefresh();
end

function ReceivePowerView:OnViewHide()
	self:DisposeTimer();
end

function ReceivePowerView:AddNextRefresh()
	local cTime = self:CalculateTime();
	if cTime > 0 then 
		self.mTimerInterval = mGameTimer.HandSetTimeout(cTime, function() self:OnTimerInterval() end);
	end
end

function ReceivePowerView:OnTimerInterval()	
	self:ReGetEveryDayPower(nil);
	self:AddNextRefresh();
end

function ReceivePowerView:CalculateTime()
	local currentTime = mGameModelManager.LoginModel:GetCurrentTime();
	local hTime = self:TransToYearMonthDayHMS(currentTime);
	local CurrTime = self:JudgeTime();

	if CurrTime == 0 then
		return morningEnd - hTime;
	elseif CurrTime == 1 then
		return noonEnd - hTime;
	elseif CurrTime == 2 then
		return nightEnd - hTime;
	elseif CurrTime == 3 then
		if morningStart - hTime > 0 then
			return morningStart - hTime;
		elseif noonStart - hTime > 0 then
			return noonStart - hTime;
		elseif nightStart - hTime > 0 then
			return nightStart - hTime;
		else
			return 0;
		end
	end
end

function ReceivePowerView:JudgeTime()
	local currentTime = mGameModelManager.LoginModel:GetCurrentTime();
	local hTime = self:TransToYearMonthDayHMS(currentTime);

	if hTime >= morningStart and  hTime < morningEnd then
		return 0;		
	end

	if hTime >= noonStart and hTime < noonEnd then			
		return 1;		
	end

	if hTime >= nightStart and hTime < nightEnd then			
		return 2;		
	end

	return 3;
end

function ReceivePowerView:ReGetEveryDayPower(data)
	local num = self:JudgeTime();
	self:RefreshUI(num);
end

function ReceivePowerView:RefreshUI(TimeSlot)
	local model = mGameModelManager.ReceivePowerModel;
	local len = table.getn(model.mReceiveTable);
	if len > TimeSlot then
		local isReceive = model.mReceiveTable[TimeSlot+1];
		if isReceive == 1 then
			self.mCanNotRecevie.gameObject:SetActive(true);
			self.mCanRecevie.gameObject:SetActive(false);
			self.mExplain.gameObject:SetActive(false);
			self.mWhetherRecevie = false;
			self.mRecevieNum = 0;
		else
			self.mCanNotRecevie.gameObject:SetActive(false);
			self.mCanRecevie.gameObject:SetActive(true);
			self.mExplain.gameObject:SetActive(false);
			self.mWhetherRecevie = true;
			self.mRecevieNum = TimeSlot+1;
		end
	else
		self.mCanNotRecevie.gameObject:SetActive(false);
		self.mCanRecevie.gameObject:SetActive(false);
		self.mExplain.gameObject:SetActive(true);
		self.mWhetherRecevie = false;
		self.mRecevieNum = 0;
		local RPdesc = mConfigSysmanual[mConfigSysmanualConst.RECEIVE_POWER].desc;
		self.mExplainText.text = string.gsub(RPdesc,"\\n","\n");
	end
end

function ReceivePowerView:TransToYearMonthDayHMS(second)
	local h = os.date("%H",second);
	local m = os.date("%M",second);
	local s = os.date("%S",second);
	return h*3600 + m*60 + s;
end

function ReceivePowerView:GetCurrentTime(t)	
	return os.date("%H",t);
end

function ReceivePowerView:ReceivePower( data )
	local mDesc = string.format( mLanguageUtil.ReceviePower,mConfigSysglobal_value[mConfigGlobalConst.PLAYER_SP_EVERY_DAY_STAGE_VALUE_1]);
	mAlertView.Show({title=nil, desc1=mDesc, desc2=nil, btnName= nil,CallBack = function()self:RefreshData(); end, btnNumber = 1});
end

function ReceivePowerView:RefreshData()
	local model = mGameModelManager.ReceivePowerModel;
	model.mReceiveTable[self.mRecevieNum] = 1;
	self:ReGetEveryDayPower(nil);
end

function ReceivePowerView:ClickReceive()
	if self.mWhetherRecevie then
		mReceivePowerController:ReceiveEveryDayPower();
	end
end

function ReceivePowerView:DisposeTimer()
	if self.mTimerInterval ~= nil then
		self.mTimerInterval:Dispose();
		self.mTimerInterval = nil;
	end
end

return ReceivePowerView;