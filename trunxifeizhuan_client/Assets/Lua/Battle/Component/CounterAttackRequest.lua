local LuaClass = require "Core/LuaClass"
local ActorObserver = require "Battle/Component/ActorObserver"
local CounterAttackRequest = LuaClass("CounterAttackRequest",ActorObserver);
local List = require "Common/List"
local mNotifyEnum = require"Enum/NotifyEnum"

function CounterAttackRequest:Awake()
	self.mCounterAttackList = List.LuaNew();
	self:RegisterListener(mNotifyEnum.OnCounterAttackRequest,function (completedCallback)
		self:Excute(completedCallback);
	end);
end

function CounterAttackRequest:AddCounterAttack(actor,skill)
	local counterAttack = actor:FindAndAddComponent("CounterAttack");
	counterAttack:SetSkill(skill);
	self.mCounterAttackList:Insert(counterAttack);
end

function CounterAttackRequest:BeginNextCounterAttack(target)
	local list = self.mCounterAttackList;
	if list:GetLen() > 0 then
		local counterAttack = list:GetValue(1);
		list:RemoveAt(1);
		counterAttack:Excute(target,function () self:BeginNextCounterAttack(target) end);
	else
		self:OnCompleted();
	end
end

function CounterAttackRequest:Excute(completedCallback)
	self.mCompletedCallback = completedCallback;
	self:BeginNextCounterAttack(self:GetActor());
end

function CounterAttackRequest:HasAction()
	return self.mCounterAttackList:GetLen() > 0;
end

function CounterAttackRequest:OnCompleted()
	local completedCallback = self.mCompletedCallback;
	if completedCallback then
		completedCallback();
	end
	self.mCompletedCallback = nil;
end

return CounterAttackRequest;