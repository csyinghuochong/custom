local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local mUpdateManager = require "Manager/UpdateManager";
local Time = UnityEngine.Time;
local Quaternion = Quaternion;
local LerpRotation = LuaClass("LerpRotation",BaseLua);
local math = math;

function LerpRotation:LerpTo(transform,target,duration)
	
	if not transform then
		return;
	end

	self.mTransform = transform;
	self.mCurrent = transform.rotation;
	self.mTarget = target;
	self.mTime = 0;
	self.mDuration = math.max(0.001,duration or 0);

	if not self.mStarted then
		self.mStarted = true;
		mUpdateManager:AddUpdate(self);
	end
end


function LerpRotation:OnUpdate()
	local t = self.mTime + Time.deltaTime;
	local duration = self.mDuration;

	self.mTime = t;
	local current = self.mCurrent
	current = Quaternion.Lerp(current,self.mTarget,t/duration);
	self.mTransform.rotation = current;

	if t > duration then
		mUpdateManager:RemoveUpdate(self);
		self.mStarted = nil;
	end
end

return LerpRotation;