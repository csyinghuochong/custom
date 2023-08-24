local LuaClass = require "Core/LuaClass"
local SkillAction = require "Battle/Skill/Action/SkillAction"
local SACloseAttack = LuaClass("SACloseAttack",SkillAction);
local Vector3 = Vector3;
local Time = UnityEngine.Time;

function SACloseAttack:OnAwake(config)
	self.mCloseTo = function ()
	    self:CloseTo();
	end

	self.mAttack = function ()
		self:Attack();
	end

	self.mBack = function ()
		self:Back();
	end

	self.mTargetPositionType = config.other_params or 0;
	local duration = config.durations[1];
	if duration == 0 then
		duration = 0.0000001;
	end
	self.mCloseDuration = duration;
end

function SACloseAttack:OnStart(skill)

	local owner = skill.mOwner;
	local target = skill.mTarget;

	self.mStatus = self.mCloseTo;
	self:PlayAnimation(self.mAnimations[1]);

	local dir = target:GetTeamCenter() - owner:GetCombatCenter();
	local position = owner.mPosition;
	local rotation = self:LookRotation(dir);

	self.mPosition = position;
	self.mTargetPosition = self:GetTargetPosition(target,dir);
	self:SetRotation(owner,rotation);
	self:ShowEffect(11,skill);
	self:ShowEffect(41,skill);
end

function SACloseAttack:GetTargetPosition(target,dir)
	local positionType = self.mTargetPositionType;
	if positionType == 0 then
		return target.mPosition - dir.normalized*2;
		elseif positionType == 1 then
			return target:GetCombatCenter();
			elseif positionType == 2 then
				return target:GetTeamCenter();
			end
end

function SACloseAttack:CloseTo()

	local owner = self.mOwner;
	local t = Time.time - self.mStartTime;
	local duration = self.mCloseDuration;
	local myPosition = Vector3.Lerp(self.mPosition,self.mTargetPosition,t/duration);
	self:SetPosition(owner,myPosition);
	if t > duration then
		self:StartAttack();
	end

end


function SACloseAttack:StartAttack()
	self:ResetEvent();
	self:PlayAnimation(self.mAnimations[2]);
	self.mAttackTime = Time.time;
	self:ShowEffect(21,self.mSkill);
	self.mStatus = self.mAttack;
end


function SACloseAttack:Attack()

	local config = self.mConfig;

	local time = Time.time - self.mAttackTime;
	local completed = self:UpdateEvent(time) and time > self.mDurations[2];

	if completed then
		local owner = self.mOwner;
		local skill = self.mSkill;
		if skill:WillComboAttack() then
			skill:OnComboAttack();
			self:StartAttack();
		else
			self:PlayAnimation(self.mAnimations[3]);
			self.mFinishTime = Time.time;

			self.mStatus = self.mBack;
		end

	end

end

function SACloseAttack:Back()
	if Time.time - self.mFinishTime > self.mDurations[3] then
		self:ResetPosition();
		self.mStatus = nil;
		self:Finish();
	end
end

function SACloseAttack:Update()
	local status = self.mStatus;
	if status then
		status();
	end
end

return SACloseAttack;