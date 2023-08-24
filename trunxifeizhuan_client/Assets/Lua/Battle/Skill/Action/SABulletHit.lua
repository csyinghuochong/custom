local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local SABulletHit = LuaClass("SABulletHit",BaseLua);
local mConfigSysskill_event = require"ConfigFiles/ConfigSysskill_event"
local Time = UnityEngine.Time;

function SABulletHit:OnLuaNew(config)
	self.mEvents = config.event_times;
	self.mCompleted = false;
	self.mStartTime = 0;
end


function SABulletHit:GetEvent(index)
	local events = self.mEvents;
	if events then
		return events[index];
	end
	return nil;
end

function SABulletHit:ResetEvent()
	self.mCompleted = false;
	self.mEventIndex = 1;
end

function SABulletHit:Start(bullet)
	self.mTarget = bullet.mTarget;
	self.mAffect = bullet.mAffect;
	self.mSkill = bullet.mSkill;
	self.mStartTime = Time.time;
	self:ResetEvent();
end

function SABulletHit:DoCheck()
	self.mSkill:DoHit(self.mTarget,self.mAffect);
end

function SABulletHit:OnCompleted()
	local completedCallback = self.mCompletedCallback;
	if completedCallback then
		completedCallback();
	end
end

function SABulletHit:Update()

	if self.mCompleted then
		return;
	end

	local index = self.mEventIndex;
	local event_time = self:GetEvent(index);

	if event_time then
		local time = Time.time - self.mStartTime;
		if time > event_time then
			self:DoCheck();
			self.mEventIndex = index + 1;
		end
	else
		self.mCompleted = true;
		self:OnCompleted();
	end
end

function SABulletHit:CheckExit()
	return self.mCompleted;
end

function SABulletHit:Dispose()
end

return SABulletHit;