local LuaClass = require "Core/LuaClass"
local Effect = require "Battle/Effect/Effect"
local BulletEffect = LuaClass("BulletEffect",Effect);
local Time = UnityEngine.Time;
local AnimatorType = typeof(UnityEngine.Animator);
local mOnState = "on";
local mOffState = "off";
function BulletEffect:OnLoadEffectCompleted(go)

	local transform = go.transform;
	local trail = self:FindChild(transform,"trail");
	if trail then
		self.mTrail = trail:GetComponent(AnimatorType);
	end
	self.mMainEffect = self:FindChild(transform,"maineffect");

end

function BulletEffect:OnDispose()
	self.mTrail = nil;
	self.mMainEffect = nil;
	self.mArrived = nil;
end

function BulletEffect:CheckExit()
	local trail = self.mTrail;
	if trail then
		return self.mArrived and Time.time - self.mArriveTime > 0.5;
	else
		return self.mArrived;
	end
end

function BulletEffect:OnUpdate()

	local bullet = self.mBullet;

	self:SetLocation(bullet.mPosition,bullet.mRotation);

	if not self.mArrived and bullet.mArrived then
		self:OnArrive();
	end
end


function BulletEffect:ToggleMainEffect(flag)
	local main = self.mMainEffect;
	if main then
		main.gameObject:SetActive(flag);
	end
end

function BulletEffect:ToggleTrail(flag)
	local trail = self.mTrail;
	if trail then
		trail:CrossFade(flag,0);
	end
end

function BulletEffect:OnArrive()
	self.mArrived = true;
	self.mArriveTime = Time.time;
	self:ToggleMainEffect(false);
	self:ToggleTrail(mOffState);
end

function BulletEffect:UpdateParams(logicParams)
	self.mBullet = logicParams;
	if self.mMirror then
		self.mScale = logicParams.mSkill.mOwner:GetModelScale();
	end
end

function BulletEffect:OnShow()
	self.mArrived = nil;
	self:ToggleMainEffect(true);
	self:ToggleTrail(mOnState);
	self:OnUpdate();
end

local message1 = "若技能[%s]是弹道,请将skill_action表中的cls字段改成SABullet"
local message2 = "否则请将effect表中特效[%s]的cls改成SKillEffect";
function BulletEffect:Assert(logicParams)
	if not logicParams.mPosition then
		Debugger.LogError(string.format("配置错误:"..message1..","..message2,logicParams.mName,self.mEffectFile));
		return false;
	end
	return true;
end

return BulletEffect;