local LuaClass = require "Core/LuaClass"
local SkillAction = require "Battle/Skill/Action/SkillAction"
local SAAttack = LuaClass("SAAttack",SkillAction);
local Time = UnityEngine.Time;

function SAAttack:OnStart(skill)

	local owner = skill.mOwner;
	local target = skill.mTarget;
	local checkType = self:GetCheckType();
	if skill.mTargetType == 1 and checkType == 3 then
		self:RotateToTarget(owner,target);
	end

	self:PlayAnimation(self.mAnimations[2]);
	self:ShowEffect(11,skill);
	self:ShowEffect(21,skill);
end

function SAAttack:Update()

	local time = Time.time - self.mStartTime;

	local completed = self:UpdateEvent(time) and time > self.mDurations[2];

	if completed then
		self:Finish();
		self:ResetRotation(true);
	end

end

return SAAttack;