local LuaClass = require "Core/LuaClass"
local SkillAction = require "Battle/Skill/Action/SkillAction"
local SARush = LuaClass("SARush",SkillAction);
local Vector3 = Vector3;
local Time = UnityEngine.Time;
function SARush:OnAwake(config)
	self.mReady = function ()
	    self:Ready();
	end

	self.mRush = function ()
		self:Rush();
	end

	self.mBack = function ()
		self:Back();
	end
end

function SARush:OnStart(skill)

	self.mStatus = self.mReady;
	self.mArrived = false;
	self.mChecked = false;

	local owner = skill.mOwner;
	local target = skill.mTarget;
	local position = owner.mPosition;
	local targetPosition = target.mPosition;
	local rotation = self:LookRotation(targetPosition-position);
	
	self.mFromPosition = owner.mPosition;
	self.mTargetPosition = targetPosition + (targetPosition - owner.mPosition).normalized*2;
	
	self:SetRotation(owner,rotation);
	self:PlayAnimation(self.mAnimations[1]);
	self:ShowEffect(11,skill);
end

function SARush:Ready()
	if Time.time - self.mStartTime > self.mDurations[1] then
		self.mStatus = self.mRush;
		self.mRushTime = Time.time;
		self:PlayAnimation(self.mAnimations[2]);
		self:ShowEffect(21,self);
	end
end

function SARush:Rush()

	local time = Time.time - self.mRushTime;
	
	self:UpdateEvent(time);

	local t = time / self.mDurations[2];
	local owner = self.mOwner;
	local targetPosition = self.mTargetPosition;
	local myPosition = Vector3.Lerp(self.mFromPosition,targetPosition,t);
	self:SetPosition(owner,myPosition);
	local distance = Vector3.Distance(targetPosition,myPosition);

	if self.mChecked == false and distance < 3 then
		self:ShowEffect(31,self.mSkill);
	end

	if t > 1 then
		self:PlayAnimation(self.mAnimations[3]);
		self.mFinishTime = Time.time;
		self.mStatus = self.mBack;
	end

end

function SARush:Back()
	if Time.time - self.mFinishTime > self.mDurations[3] then
		self:Finish();
		self:ResetPosition();
		self.mStatus = nil;
	end
end

function SARush:Update()
	local status = self.mStatus;
	if status then
		status();
	end
end

return SARush;