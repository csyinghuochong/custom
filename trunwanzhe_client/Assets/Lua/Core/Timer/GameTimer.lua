local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mGameTimerManager = require "Core/Timer/GameTimerManager"

local GameTimer = mLuaClass("GameTimer",mBaseLua);

local ObjectPool = require "Common/ObjectPool"
function SyncCallBack()
	--print("-------------------------new timer");
	return GameTimer.LuaNew();
end
local GameTimerPool = ObjectPool.LuaNew(SyncCallBack,nil,nil);

function GameTimer.SetTimeout(delay,timerCompleteHandler,stopOnChangeScene,timeScale)
	local timer = GameTimerPool:Get();
	timer:Init(delay,1,nil,timerCompleteHandler,stopOnChangeScene,timeScale);
	timer:Start();
	return timer;
end

function GameTimer.SetInterval(delay,timerHandler,stopOnChangeScene,timeScale)
	local timer = GameTimerPool:Get();
	timer:Init(delay,0,timerHandler,nil,stopOnChangeScene,timeScale);
	timer:Start();
	return timer;
end

function GameTimer.SetFrameExecute(duration,timerHandler,timerCompleteHandler,stopOnChangeScene)
	local timer = GameTimerPool:Get();
	timer:Init(0,0,timerHandler,timerCompleteHandler,stopOnChangeScene);
	timer.mDuration = duration;
	timer:Start();
	return timer;
end

function GameTimer.ExecuteTotalFrames(framecount,timerHandler,timerCompleteHandler,stopOnChangeScene,timeScale)
	local timer = GameTimerPool:Get();
	timer:Init(0,framecount,timerHandler,timerCompleteHandler,stopOnChangeScene,timeScale);
	timer:Start();
	return timer;
end

function GameTimer:Init(delay,repeatCount,timerHandler,timerCompleteHandler,stopOnChangeScene,timeScale)
	self.mDelay = delay;
	self.mRepeatCount = repeatCount;
	self.mTimerHandler = timerHandler;
	self.mTimerCompleteHandler = timerCompleteHandler;
	self.mStopOnChangeScene = stopOnChangeScene;
	self.mTimeScale = timeScale;
	self.mCurrentCount = 0;
	self.mDuration = 0;
	self.mNextExecuteTime = 0;
	self.mStartTime = 0;
	self.mInPool = false;
end

function GameTimer:Dispose()
	self:Stop();
	self:ClearAction();

	self.mInPool = true;
	--GameTimerPool:Put(self);
end

function GameTimer:CheckInPool()
	if self.mInPool then
		--error("GameTimer CheckInPool");
	end
end

function GameTimer:ClearAction()
	self.mTimerHandler = nil;
	self.mTimerCompleteHandler = nil;
end

function GameTimer:Start()
	self:CheckInPool();

	if not self.mRunning then
		mGameTimerManager:AddGameTimer(self);
		self.mRunning = true;
	end
end

function GameTimer:Stop()
	self:CheckInPool();

	if self.mRunning then
		self.mStartTime = 0;

		mGameTimerManager:RemoveGameTimer(self);
		self.mRunning = false;
	end
end

function GameTimer:Reset()
	self:CheckInPool();

	self.mCurrentCount = 0;
	self:Stop();
end

function GameTimer:ReStart()
	self:CheckInPool();
	
	self:Reset();
	self:Start();
end

function GameTimer:Execute()
	local currentCount = self.mCurrentCount + 1;
	self.mCurrentCount = currentCount;

	local timerHandler = self.mTimerHandler;
	local repeatCount = self.mRepeatCount;
	local duration = self.mDuration;

	if timerHandler then
		timerHandler();
	end

	if repeatCount ~= 0 and currentCount >= repeatCount then
		self:InternalTimerCompleteHandler();
	elseif duration > 0 then
		local curTime = nil;
		if self.mTimeScale then
			curTime = mGameTimerManager.mScaleTime;
		else
			curTime = mGameTimerManager.mRealTime;
		end

		local startTime = self.mStartTime;
		if startTime == 0 then
			startTime = curTime;
			self.mStartTime = startTime;
		end

		if startTime + duration > curTime then
			return;
		end

		self:InternalTimerCompleteHandler();
	end

end

function GameTimer:InternalTimerCompleteHandler()
	self.mRunning = false;
	local timerCompleteHandler = self.mTimerCompleteHandler;
	if timerCompleteHandler then
		timerCompleteHandler();
	end

	self:Dispose();
end


return GameTimer;