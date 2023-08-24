local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local CameraMask = LuaClass("CameraMask",BaseLua);
local Color = Color;
local Time = Time;
function CameraMask:OnLuaNew(maskObject)
	self.mMaskObject = maskObject;
	if maskObject then
		self.mTargetColor = maskObject.color;
	end
	self.mLateUpdateBeat = function () self:LateUpdate() end

	self.mTimer = 0;
end

function CameraMask:CrossFadeAlpha(alpha,duration,useScaledTime)
	local maskObject = self.mMaskObject;
	if maskObject then
		if duration > 0 then
			self.mTargetColor.a = alpha;
			if not self.mCrossFading then
				LateUpdateBeat:Add(self.mLateUpdateBeat);
				self.mCrossFading = true;
				self.mTimer = 0;
				self.mDuration = duration;
				self.mUseScaledTime = useScaledTime;
			end
		else
			local color = maskObject.color;
			color.a = alpha;
			maskObject.color = color;
		end
	end
end

function CameraMask:StopLateUpdate()
	LateUpdateBeat:Remove(self.mLateUpdateBeat);
	self.mCrossFading = false;
end

function CameraMask:LateUpdate()

	local maskObject = self.mMaskObject;

	if not maskObject then
		self:StopLateUpdate();
		return;
	end

	local t = self.mTimer + Time.deltaTime;
	local duration = self.mDuration;
	local color = maskObject.color;
	color = Color.Lerp(color,self.mTargetColor,t/duration);
	maskObject.color = color;
	self.mTimer = t;
	if t > duration then
		self:StopLateUpdate();
	end
end

return CameraMask;