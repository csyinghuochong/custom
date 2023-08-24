local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mTimeUtil = require "Utils/TimeUtil"
local GameTimer = require "Core/Timer/GameTimer"
local mGameModelManager = require "Manager/GameModelManager"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local MainArenaBalanceView = mLuaClass("MainArenaBalanceView",mBaseView);
local mSuper = nill;
local mOs = os;

function  MainArenaBalanceView:Init()
    
	mSuper = self:GetSuper(mBaseView.LuaClassName);
    mSuper.Init(self);

    self.mTimeObject = self:Find( 'time' ).gameObject;
    self.mTextTime = self:FindComponent( 'time/Text_time', 'Text' );

end

function MainArenaBalanceView:OnViewShow(logicParams)
	self:OnUpdateArenaTime( );
end

function MainArenaBalanceView:TransToYearMonthDayHMS(second)
	local d = os.date("%w",second);
    local h = os.date("%H",second);
    local m = os.date("%M",second);
    local s = os.date("%S",second);
    return d * 86400 + h*3600 + m*60 + s;
end

function MainArenaBalanceView:OnUpdateArenaTime(  )
	self:ResetUI( );

	local state, time = self:GetArenaBalanceState( );
	if state == 1 then
		self.mGameTimer = GameTimer.HandSetTimeout(time, function() self:OnUpdateArenaTime() end);
	else
		self.mRemainTime = time;
		self.mTimeObject:SetActive( true );
		self.mGameTimer = GameTimer.SetInterval(1, function() self:OnTimerInterval() end);
	end
end

--1没到结算时间 2正在结算
local mTotalWeekTime = 7 * 24 * 3600;
local mBalanceTimeBegin = mConfigSysglobal_value[mConfigGlobalConst.ARENA_BALANCE_BAGIN_TIME];
local mBalanceTimeEnd = mConfigSysglobal_value[mConfigGlobalConst.ARENA_BALANCE_END_TIME];
function MainArenaBalanceView:GetArenaBalanceState(  )
	local timeStamp = mGameModelManager.LoginModel:GetCurrentTime();
	local todayTime = self:TransToYearMonthDayHMS( timeStamp );

	if todayTime < mBalanceTimeBegin then
		return 1, mBalanceTimeBegin - todayTime;
	elseif todayTime < mBalanceTimeEnd then
		return 2, mBalanceTimeEnd - todayTime;
	else
		return 1, mTotalWeekTime - todayTime + mBalanceTimeBegin;
	end
end

function MainArenaBalanceView:OnTimerInterval()
    local time = self.mRemainTime;
    time = time - 1;
    if time >= 0 then
       self.mTextTime.text = mTimeUtil:TransToHourMinSec(time);
    else
       self:OnUpdateArenaTime( );
    end
    self.mRemainTime = time;
end

function MainArenaBalanceView:ResetUI( )
	self:DisposeTimer( );
	self.mTimeObject:SetActive( false );
end

function MainArenaBalanceView:OnViewHide( logicParams )
	self:DisposeTimer( );
end

function MainArenaBalanceView:DisposeTimer(  )
	local timer = self.mGameTimer;
	if timer ~= nil then
		timer:Dispose( );
		self.mGameTimer = nil;
	end
end

function MainArenaBalanceView:Dispose()
	
end

return MainArenaBalanceView;