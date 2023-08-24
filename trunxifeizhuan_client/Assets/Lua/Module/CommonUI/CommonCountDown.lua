local mLuaClass = require "Core/LuaClass"
local mTimeUtil = require "Utils/TimeUtil"
local GameTimer = require "Core/Timer/GameTimer"
local CommonCountDown = mLuaClass("CommonCountDown");

function CommonCountDown:OnLuaNew(textTime, callBack)
	self.mTextTime = textTime;
	self.mCallBack = callBack;
end

--有倒计时才调用
function CommonCountDown:ShowView( time  )
	self.mRemainTime = time and time or 0;
	
	local timer = self.mGameTimer;
	if timer == nil then
		timer = GameTimer.SetInterval(1, function() self:OnTimerInterval() end);
		self.mGameTimer = timer;
	else
		timer:Start( );
	end
	self.mTextTime.text = mTimeUtil:TransToHourMinSec(time);
end

function CommonCountDown:HideView(  )
	local timer = self.mGameTimer;
	if timer ~= nil then
		timer:Stop( );
	end
end

function CommonCountDown:OnTimerInterval()
    local time = self.mRemainTime;
    time = time - 1;
    if time >= 0 then
       	self.mTextTime.text = mTimeUtil:TransToHourMinSec(time);
    else
      	local callBack = self.mCallBack;
      	if callBack then
      		callBack( );
      	end
      	self:DisposeTimer( );
    end
    self.mRemainTime = time;
end

function CommonCountDown:Dispose(  )
	self:DisposeTimer( );
end

function CommonCountDown:DisposeTimer(  )
	local timer = self.mGameTimer;
	if timer ~= nil then
		timer:Dispose( );
		self.mGameTimer = nil;
	end
end

return CommonCountDown;