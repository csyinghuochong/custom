local LuaClass = require "Core/LuaClass"
local ActorObserver = require "Battle/Component/ActorObserver"
local CounterAttack = LuaClass("CounterAttack",ActorObserver);
local mNotifyEnum = require"Enum/NotifyEnum"

function CounterAttack:Awake()
	self:RegisterListener(mNotifyEnum.OnCounterAttackCompleted,function ()
		self:OnCompleted();
	end);
end

function CounterAttack:OnCompleted()
	local completedCallback = self.mCompletedCallback;
	if completedCallback then
		completedCallback();
	end
	self.mCompletedCallback = nil;
end

function CounterAttack:IsDisableCounterAttack()
	return self:GetActor():IsDisableDoRound();
end

function CounterAttack:Excute(target,completedCallback)
	self.mCompletedCallback = completedCallback;
	if self:IsDisableCounterAttack() then
		self:OnCompleted();
	else
		self:GetActor():Notify(mNotifyEnum.OnCounterAttack,target);
	end
end

function CounterAttack:SetSkill(skill)
	self:GetActor():Notify(mNotifyEnum.OnSetCounterAttack,skill);
end

function CounterAttack:HasAction()
	return self.mCompletedCallback;
end

return CounterAttack;