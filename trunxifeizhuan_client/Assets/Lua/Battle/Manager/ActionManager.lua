
local LuaClass = require "Core/LuaClass";
local ActionManager = LuaClass("ActionManager");
local mUpdateManager = require "Manager/UpdateManager";
local pairs = pairs;

function ActionManager:OnLuaNew(startCallback,putCallback)
	self.mActions = {};
	self.mStartCallBack = startCallback;
	self.mPutCallback = putCallback;
end

function ActionManager:CheckExit(action)
	
	if action.mNeverExit then
		return false;
	end

	return action:CheckExit();
end

function ActionManager:OnUpdate()

	local actions = self.mActions;
	local putCallback = self.mPutCallback;
	local hasAction = nil;

	for k,v in pairs(actions) do
		if self:CheckExit(v) then
			actions[k] = nil;
			putCallback(v);
		else
			v:Update();
			hasAction = true;
		end
    end

    if not hasAction then
    	mUpdateManager:RemoveUpdate(self);
    	self.mEnableUpdate = nil;
    end
end

function ActionManager:EnableUpdate()
	if not self.mEnableUpdate then
		self.mEnableUpdate = true;
		mUpdateManager:AddUpdate(self);
	end
end

function ActionManager:DisableUpdate()
	if self.mEnableUpdate then
		mUpdateManager:RemoveUpdate(self);
		self.mEnableUpdate = nil;
	end
end

function ActionManager:StartAction(action,logicParams)
	self.mStartCallBack(action,logicParams);
	self.mActions[action] = action;
	self:EnableUpdate();
end

function ActionManager:EndAction(action)
	self.mActions[action] = nil;
	self.mPutCallback(action);
end

function ActionManager:Dispose()

	self:DisableUpdate();

	local actions = self.mActions;
	local putCallback = self.mPutCallback;
	for k,v in pairs(actions) do
		actions[k] = nil;
		putCallback(v);
	end
end

return ActionManager;