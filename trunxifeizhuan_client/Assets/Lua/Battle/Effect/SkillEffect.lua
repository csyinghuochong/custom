local LuaClass = require "Core/LuaClass"
local Effect = require "Battle/Effect/Effect"
local SkillEffect = LuaClass("SkillEffect",Effect);
local Time = UnityEngine.Time;
local Quaternion = Quaternion;
local Vector3 = Vector3;
local mUpAxis = Vector3.up;

local function FollowOwner(effect)
	local owner = effect.mOwner;
	effect:SetLocation(effect,owner.mPosition,owner.mRotation);
end

local function FollowTarget(effect)
	local target = effect.mTarget;
	effect:SetLocation(effect,target.mPosition,target.mRotation);
end

local function TargetCenter(effect)

	local owner = effect.mOwner;
	local target = effect.mTarget;
	local center = owner:GetCombatCenter();
	local position = target:GetTeamCenter();
	local dir = (target.mTeam == owner.mTeam) and (center - position) or (position - center);
	effect:SetLocation(effect,position,Quaternion.LookRotation(dir,mUpAxis));
end


local function Center(effect)

	local owner = effect.mOwner;
	local position = owner:GetCombatCenter();
	local dir = position - owner:GetTeamCenter();
	effect:SetLocation(effect,position,Quaternion.LookRotation(dir,mUpAxis));

end

local function TargetPoint(effect)

	local owner = effect.mOwner;
	local target = effect.mTarget;
	local position = target.mPosition;
	local rotation = target.mRotation;
	if owner ~= target then
		rotation = Quaternion.LookRotation(position-owner.mPosition,mUpAxis);
	end

	effect:SetLocation(effect,position,rotation);
end

local mUpdateMode = 
{
	["FollowOwner"] = FollowOwner;
	["FollowTarget"] = FollowTarget;
	["TargetCenter"] = TargetCenter;
	["TargetPoint"] = TargetPoint;
	["Center"] = Center;
}

function SkillEffect:Assert(skill)
	if not skill.mOwner then
		Debugger.LogError(string.format("effect 表 配置错误: 特效 = [%s] 的cls字段配置不正确,请修改为 cls = Effect ?",self.mEffectFile));
		return false;
	end
	return true;
end

function SkillEffect:Show(skill)

	local owner = skill.mOwner;
	local target = skill.mTarget;

	self.mOwner = owner;
	self.mTarget = target;
	
	if self.mMirror then
		self.mScale = owner:GetModelScale();
	end

	self.mStartTime = Time.time;
	self.mActived = false;
	self.mStatus = self.mOnDelay;

	self:SetBindTransform(owner.mTransform);
end

function SkillEffect:OnInitExternalConfigs(effectConfig)
	self.mOnStartPosition = mUpdateMode[effectConfig.onStartPosition];
	self.mOnUpdatePosition = mUpdateMode[effectConfig.onUpdatePosition];
end

function SkillEffect:UpdatePosition(update_mode)
	if update_mode then
		update_mode(self);
	end
end

function SkillEffect:OnShow()
	self:UpdatePosition(self.mOnStartPosition);
	self:UpdateNodes();
	self:InitMotionGhost();
end

function SkillEffect:OnUpdate()
	self:UpdatePosition(self.mOnUpdatePosition);
end

return SkillEffect;