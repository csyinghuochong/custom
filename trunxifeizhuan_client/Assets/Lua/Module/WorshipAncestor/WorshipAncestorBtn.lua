local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mColor = Color
local mTimeUtil = require "Utils/TimeUtil"
local mGameTimer = require "Core/Timer/GameTimer"
local mGameModelManager = require "Manager/GameModelManager"
local WorshipAncestorBtn = mLuaClass("WorshipAncestorBtn", mBaseView);
local mSuper = nil;

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgState1 = mLanguageUtil.worshipancestor_state1;
local mLgState2 = mLanguageUtil.worshipancestor_state2;
local mLgTimes = mLanguageUtil.worshipancestor_times;

local timesTable = {3,2,1};

function WorshipAncestorBtn:OnLuaNew(go, callback)
	mSuper = self:GetSuper(mBaseView.LuaClassName);
	mSuper.OnLuaNew(self, go);

	self.mCallback = callback;
end

function WorshipAncestorBtn:Init()
	self.mTextTime = self:FindComponent("text","Text");
	self.mGoNot = self:Find("not").gameObject;
	self.mGoCan = self:Find("can").gameObject;
	self.mBtn = self.mTransform:GetComponent("Button");
	self:AddBtnClickListener(self.mGameObject,function()self:OnClickBtn();end);
end

function WorshipAncestorBtn:OnClickBtn()
	local callback = self.mCallback;
	if callback ~= nil then
		callback(self.mType);
	end
end

--state(1为已上香，2为可上香，3为CD中，4为未激活)
function WorshipAncestorBtn:SetInfo(type,state,time)
	self.mType = type;
	if state == 1 then
		self:SetBtnState(false);
		self.mTextTime.text = mLgState1;
	elseif state == 2 then
		self:SetBtnState(true);
		self.mTextTime.text = mLgState2;
	elseif state == 3 then
		self:SetBtnState(false);
		local nowTime = mGameModelManager.LoginModel:GetCurrentTime();
		self.mSecond = time - nowTime;
		if self.mTimerInterval ~= nil then
			self.mTimerInterval:Stop();
		end
		self.mTimerInterval = mGameTimer.SetInterval(1, function() self:OnTimerInterval() end);
	elseif state == 4 then
		self:SetBtnState(false);
		self.mTextTime.text = mLgState2..timesTable[type]..mLgTimes;
	end
end

function WorshipAncestorBtn:OnTimerInterval()
	local second = self.mSecond;
	second = second - 1;
	if second > 0 then
		self.mTextTime.text = mTimeUtil:TransToHourMinSec(second);
	else
		self.mTimerInterval:Stop();
		self:SetInfo(self.mType,2,0);
	end
	self.mSecond = second;
end

function WorshipAncestorBtn:SetBtnState(state)
	self.mGoCan:SetActive(state);
	self.mGoNot:SetActive(not state);
	self.mBtn.enabled = state;
end

function WorshipAncestorBtn:OnViewHide()
	self:Dispose();
end

function WorshipAncestorBtn:Dispose()
	local time_interval = self.mTimerInterval;
	if time_interval ~= nil then	
		time_interval:Dispose();
		self.mTimerInterval = nil;
	end
end

return WorshipAncestorBtn;