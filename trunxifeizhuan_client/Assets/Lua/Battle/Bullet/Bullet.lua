local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local Bullet = LuaClass("Bullet",BaseLua);
local Vector3 = Vector3;
local mUpAxis = Vector3.up;
local Quaternion = Quaternion;
local Time = UnityEngine.Time;
local math = math;
local mHitPoint = "Bip001 Spine1";
function Bullet:OnLuaNew(config)
	self.mConfig = config;
	self.mSpeed = config.speed;
	self.mFirePoint = config.fire_point;
	local hit_point = config.hit_point;
	if not hit_point or hit_point == "" then
		hit_point = mHitPoint;
	end
	self.mHitPoint = hit_point;
	self.mEffect = config.effect;
	self.mAccelerationY = config.acceleration_y or 0;
end

function Bullet:Dispose()
end

function Bullet:Start(hitCallback)
	self.mArrived = false;
	self.mHitCallback = hitCallback;
	self:ShowEffect(self.mEffect,self);
end

function Bullet:LookRotation(dir)
	return Quaternion.LookRotation(dir,mUpAxis);
end

function Bullet:SetParams(skill,target,affect)
	self.mSkill = skill;
	self.mAffect = affect;
	self:SetTarget(target,self:GetFirePoint(skill.mOwner));
end

function Bullet:SetTarget(target,startPosition)
	self.mTarget = target;

	local dir = self:GetHitPoint(target) - startPosition;
	local d = dir:Magnitude();
	local v = self.mSpeed;
	local h = self.mAccelerationY*d;
	local t = 0.5*d/v;
	local a = -mUpAxis*(2*h)/(t*t);

	self.mAcceleration  = a;
	self.mVelocity = dir.normalized*v - a*t;
	self.mTime = 0;
	self.mTotalTime = t*2;
	self.mStartPosition = startPosition;
	self.mPosition = startPosition;
	self.mRotation = self:LookRotation(dir);
end

function Bullet:GetHitPoint(target)
	local point = target:FindNode(self.mHitPoint);
	if point then
		return point.position;
	end
	return target.mPosition + mUpAxis;
end

function Bullet:GetFirePoint(owner)
	
	local fire_point = self.mFirePoint;
	if fire_point then
		local point = owner:FindNode(fire_point);
		if point then
			return point.position;
		end
	end
	return owner.mPosition;
end

function Bullet:ShowEffect(index,logicParams)
	self.mSkill:ShowEffect(index,logicParams);
end

function Bullet:ExcuteHitCallback()
	local hitCallback = self.mHitCallback;
	if hitCallback then
		hitCallback(self);
	end
end

function Bullet:Update()
	if self.mArrived == false then
		local totalTime = self.mTotalTime;
		local t = math.min(self.mTime + Time.deltaTime , totalTime);
		local v = self.mVelocity;
		local a = self.mAcceleration;
		local position = self.mStartPosition + v*t + a*0.5*t*t;
		self.mTime = t;
		self.mPosition = position;
		self.mRotation = self:LookRotation(v+a*t);
		if t >= totalTime then
			self:ExcuteHitCallback();
			self:OnArrived(position);
		end
	end
end

function Bullet:OnArrived(position)
	self.mArrived = true;
end

function Bullet:CheckExit()
	return self.mArrived;
end

return Bullet;