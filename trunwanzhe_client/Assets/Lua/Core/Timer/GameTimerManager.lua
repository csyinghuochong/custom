local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mLinkedList = require "Common/LinkedList"
local mTime = UnityEngine.Time;
local GameTimerManager = mLuaClass("GameTimerManager",mBaseLua);

function GameTimerManager:OnLuaNew()
	self.mScaleTime = 0;
	self.mChangeList = {};
	self.mScaleTimeList = mLinkedList.LuaNew();
	self.mRealTimeList = mLinkedList.LuaNew();
end

function GameTimerManager:AddGameTimer(timer)
	self:AddChangeTimer(timer);
end

function GameTimerManager:RemoveGameTimer(timer)
	self:AddChangeTimer(timer);
end

function GameTimerManager:AddChangeTimer(timer)
	self.mChangeList[timer] = timer;
end

function GameTimerManager:Execute()
	local scaleTime = self.mScaleTime + mTime.deltaTime;
	self.mScaleTime = scaleTime;
	self:InternalExecute(self.mScaleTimeList,scaleTime);

	local realTime = mTime.realtimeSinceStartup;
	self.mRealTime = realTime;
	self:InternalExecute(self.mRealTimeList,realTime);

	self:ExecuteChangeTimerList();
end

function GameTimerManager:InternalExecute(list,time)
	local node = list.mFirst;
	local timer = nil;

	while node do 
		timer = node;
		if timer.mNextExecuteTime <= time then
			node = node.mLinkedNextNode;
			self:AddChangeTimer(timer);
			if timer.mRunning then
				timer:Execute()
			end
		else
			return;
		end
	end
end

function GameTimerManager:ExecuteChangeTimerList()
	local changeList = self.mChangeList;
	for key,timer in pairs(changeList) do
		if timer.mRunning then
			self:InternalAddGameTimer(timer);
		else
			local list = timer.mLinkedList;
			if list then
				list:Remove(timer);
			end
		end

		changeList[key] = nil;
	end
end

function GameTimerManager:InternalAddGameTimer(timer)
	if timer.mTimeScale then
		if timer.mDelay > 0 then
			timer.mNextExecuteTime = self.mScaleTime + timer.mDelay;
		end

		self:InternalAddGameTimerList(self.mScaleTimeList,timer);
	else
		if timer.mDelay > 0 then
			timer.mNextExecuteTime = self.mRealTime + timer.mDelay;
		end

		self:InternalAddGameTimerList(self.mRealTimeList,timer);
	end
end

function GameTimerManager:InternalAddGameTimerList(list,timer)
	local node = list.mFirst;

	while node do 
		if timer.mNextExecuteTime < node.mNextExecuteTime then
			list:AddBefore(node,timer);
			return;
		end
		node = node.mLinkedNextNode;
	end

	list:AddLast(timer);
end

return GameTimerManager.LuaNew();