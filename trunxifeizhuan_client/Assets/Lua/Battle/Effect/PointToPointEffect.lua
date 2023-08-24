local LuaClass = require "Core/LuaClass"
local Effect = require "Battle/Effect/Effect"
local PointToPointEffect = LuaClass("Point2PointEffect",Effect);
local Time = UnityEngine.Time;
local Vector3 = Vector3;
local mHitPoint = "Bip001 Spine1";

function PointToPointEffect:OnLoadEffectCompleted(go)
	local transform = go.transform;
	self.mMainEffect = self:FindChild(transform,"maineffect");
end

function PointToPointEffect:Show(skill)

	local owner = skill.mOwner;
	local target = skill.mTarget;

	self.mOwner = owner;
	self.mTarget = target;
	
	self.mStartTime = Time.time;
	self.mActived = false;
	self.mStatus = self.mOnDelay;
	self:SetBindTransform(owner.mTransform);
end

function PointToPointEffect:GetHitPoint(target)
	local point = target:FindNode(mHitPoint);
	if point then
		return point.position;
	end

	return target.mPosition + mUpAxis*1;
end

function PointToPointEffect:OnShow()

	local owner = self.mOwner;

	self:SetLocation(owner.mPosition,owner.mRotation);

	local main = self.mMainEffect;
	if main then
		local target = self:GetHitPoint(self.mTarget);
		local distance = Vector3.Distance(main.position,target);
		local scale = main.localScale;
		scale.z = distance;
		main:LookAt(target);
		main.localScale = scale;
	else
		Debugger.LogError("PointToPointEffect 类型的特效中，需要拉伸的部分要放在 maineffect 节点下");
	end

end

function PointToPointEffect:OnUpdate()

end

return PointToPointEffect;