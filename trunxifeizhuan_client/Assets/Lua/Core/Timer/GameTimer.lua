local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mGameTimerManager = require "Core/Timer/GameTimerManager"
local mDebugTimer = GameDebugConfig.debugTimer;
local GameTimer = mLuaClass("GameTimer",mBaseLua);

local ObjectPool = require "Common/ObjectPool"
function SyncCallBack()
	--print("-------------------------new timer");
	return GameTimer.LuaNew();
end
local GameTimerPool = ObjectPool.LuaNew(SyncCallBack,nil,nil);

--返回引用，需要调用Dispose()释放
function GameTimer.HandSetTimeout(delay,timerCompleteHandler,stopOnChangeScene,timeScale)
	local timer = GameTimerPool:Get();
	timer:Init(delay,1,nil,timerCompleteHandler,stopOnChangeScene,timeScale);
	timer:Start();
	return timer;
end

--不返回引用，内部自行释放
function GameTimer.SetTimeout(delay,timerCompleteHandler,stopOnChangeScene,timeScale)
	local timer = GameTimerPool:Get();
	timer:Init(delay,1,nil,timerCompleteHandler,stopOnChangeScene,timeScale,true);
	timer:Start();
end

--返回引用，需要调用Dispose()释放
function GameTimer.SetInterval(delay,timerHandler,stopOnChangeScene,timeScale)
	local timer = GameTimerPool:Get();
	timer:Init(delay,0,timerHandler,nil,stopOnChangeScene,timeScale);
	timer:Start();
	return timer;
end

--返回引用，需要调用Dispose()释放
function GameTimer.SetFrameExecute(duration,timerHandler,timerCompleteHandler,stopOnChangeScene)
	local timer = GameTimerPool:Get();
	timer:Init(0,0,timerHandler,timerCompleteHandler,stopOnChangeScene);
	timer.mDuration = duration;
	timer:Start();
	return timer;
end

--返回引用，需要调用Dispose()释放
function GameTimer.ExecuteTotalFrames(framecount,timerHandler,timerCompleteHandler,stopOnChangeScene,timeScale)
	local timer = GameTimerPool:Get();
	timer:Init(0,framecount,timerHandler,timerCompleteHandler,stopOnChangeScene,timeScale);
	timer:Start();
	return timer;
end

function GameTimer:Init(delay,repeatCount,timerHandler,timerCompleteHandler,stopOnChangeScene,timeScale,autoDispose)
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
	self.mAutoDispose = autoDispose;

	if mDebugTimer then
		self.mDebugTimerStr = debug.traceback();
	end
end

function GameTimer:Dispose()
	if self.mInPool == false then
		self:Stop();
		self:ClearAction();

		self.mInPool = true;
		GameTimerPool:Put(self);
	end
end

function GameTimer:CheckInPool()
	if self.mInPool then
		error("GameTimer CheckInPool");
	end
end

function GameTimer:ClearAction()
	self.mTimerHandler = nil;
	self.mTimerCompleteHandler = nil;
end

function GameTimer:Start()
	if not self.mRunning then
		self:CheckInPool();

		mGameTimerManager:AddGameTimer(self);
		self.mRunning = true;
	end
end

function GameTimer:Stop()
	if self.mRunning then
		self:CheckInPool();
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
	local timerCompleteHandler = self.mTimerCompleteHandler;
	if timerCompleteHandler then
		timerCompleteHandler();
	end

	if self.mAutoDispose then
		self:Dispose();
	else
		self:Stop();
	end
end


return GameTimer;