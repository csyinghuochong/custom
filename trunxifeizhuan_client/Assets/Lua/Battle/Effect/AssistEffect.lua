local LuaClass = require "Core/LuaClass"
local Effect = require "Battle/Effect/Effect"
local AssistEffect = LuaClass("AssistEffect",Effect);
local AnimatorType = typeof(UnityEngine.Animator);

function AssistEffect:OnLoadEffectCompleted(go)

	local transform = go.transform;
	local main = self:FindChild(transform,"maineffect");
	if main then
		self.mAnimator = main:GetComponent(AnimatorType);
	end
end

function AssistEffect:CheckExit()
	local owner = self.mLogicParams;
	if owner.mWaitForAssist then
		return false;
	end

	if owner.mOnAssist then
		return false;
	end

	return true;
end

function AssistEffect:OnShow()
	--淡入
	local animator = self.mAnimator;
	if animator then
		animator:CrossFade("on",0);
	end
	self:OnUpdate();
end

return AssistEffect;