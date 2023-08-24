local LuaClass = require "Core/LuaClass"
local SkillAction = require "Battle/Skill/Action/SkillAction"
local mBulletManager = require "Battle/Manager/BulletManager"
local mActionManager = require "Battle/Manager/SkillActionManager"
local SABullet = LuaClass("SABullet",SkillAction);
local Time = UnityEngine.Time;
local mDefaultHitAction = {cls = "SABulletHit",event_times = {0}};
function SABullet:OnAwake(config)
	self.mHitCallback = function (bullet)
	    self:OnHit(bullet);
	end
	self.mHitCompletedCallback = function ()
		self.mBulletCount = self.mBulletCount - 1;
	end
	
	self.mHitAction = mActionManager:GetActionConfig(config.other_params or 0) or mDefaultHitAction;
end

function SABullet:OnStart(skill)
	local owner = skill.mOwner;
	self.mPosition = owner.mPosition;
	self:RotateToTarget(owner,skill.mTarget);
	self:PlayAnimation(self.mAnimations[2]);
	self:ShowEffect(11,skill);
	self.mBulletCount = 0;
end


function SABullet:Update()
	local time = Time.time - self.mStartTime;
	local completed = self:UpdateEvent(time);
	if completed and self.mBulletCount == 0 then
		self:Finish();
		self:ResetRotation(true);
	end
end

function SABullet:OnHit(bullet)
	self:StartHitAction(self.mHitAction,bullet);
	--self:ShowEffect(3,bullet.mTarget);
end

function SABullet:StartHitAction(hitAction,bullet)
	local action = mActionManager:GetAction(hitAction);
	action.mCompletedCallback = self.mHitCompletedCallback;
	mActionManager:StartAction(action,bullet);
end

function SABullet:GetBulletId(index)
	local bullets = self.mConfig.bullet;
	if bullets then
		return bullets[index] or bullets[1];
	end
end

function SABullet:FireBulletEvent(parameters,bulletId)
	local skill = self.mSkill;
	local hitCallback = self.mHitCallback;
	local bulletCount = self.mBulletCount;
	local callback = function (target)
		local bullet = mBulletManager:GetBulletById(bulletId);
		if bullet then
			bullet:SetParams(skill,target,parameters[2]);
			mBulletManager:FireBullet(bullet,hitCallback);
			bulletCount = bulletCount + 1;
		else
			Debugger.LogError(string.format("[%s]配置错误 -> skill_action表,bullet字段中的 id = [%d]的弹道不存在",skill.mName,bulletId));
		end
	end

	skill:DoCheck(parameters,callback);
	self.mBulletCount = bulletCount;
end

function SABullet:DoCheckEvent(parameters)
	local bulletId = self:GetBulletId(self.mEventIndex);
	if bulletId then
		if bulletId == 0 then
			self.mSkill:OnCheck(parameters);
		else
			self:FireBulletEvent(parameters,bulletId);
		end
	else
		Debugger.LogError(string.format("[%s] 配置错误 -> skill_action表，bullet字段不能为空",self.mSkill.mName));
	end
end

return SABullet;