local LuaClass = require "Core/LuaClass"
local ActorObserver = require "Battle/Component/ActorObserver"
local AssistRequest = LuaClass("AssistRequest",ActorObserver);
local List = require "Common/List"
local mBuffStateEnum = require"Enum/BuffStateEnum"
local mNotifyEnum = require"Enum/NotifyEnum"
local mGameTimer = require "Core/Timer/GameTimer"
local mControlledStates = {mBuffStateEnum.State2019,mBuffStateEnum.State2021,mBuffStateEnum.State2023};
local INTERVAL = 1;
local mRandomList = List.LuaNew();

function AssistRequest:Awake()
	self.mAssistList = List.LuaNew();
	self:RegisterListener(mNotifyEnum.OnAssistRequest,function (completedCallback)
		self:Excute(completedCallback);
	end);
end

function AssistRequest:OnCompleted()
	local completedCallback = self.mCompletedCallback;
	if completedCallback then
		completedCallback();
	end
	self.mCompletedCallback = nil;

	local target = self.mTarget;
	if target:IsAlive() == false then
		self:GetActor():Notify(mNotifyEnum.OnAssistKill,target);
	end
end

function AssistRequest:HasAction()
	return not self.mRemainCount;
end

function AssistRequest:AddAssist(actor)
	local list = self.mAssistList;
	local assist = actor:FindAndAddComponent("Assist");
	list:Add(assist);
	return list.mLength;
end

function AssistRequest:OnAssistCompleted(assist)
	local remainCount = self.mRemainCount - 1;
	self.mRemainCount = remainCount;
	if remainCount == 0 then
		self:OnCompleted();
	end
end

function AssistRequest:BeginNextAssist(target,delay)
	local list = self.mAssistList;
	if list:GetLen() > 0 then
		local assist = list:GetValue(1);
		list:RemoveAt(1);
		local excuteAssist = function ()
			assist:Excute(target,function ()self:OnAssistCompleted(assist);end);
			self:BeginNextAssist(target,INTERVAL);
		end
		mGameTimer.SetTimeout(delay,excuteAssist,false,true);
	end
end

function AssistRequest:Excute(completedCallback)
	self.mRemainCount = self.mAssistList:GetLen();
	self.mCompletedCallback = completedCallback;
	self:BeginNextAssist(self.mTarget,0);
end

local function RandomSort(a,b)
	return a.mRandomSort < b.mRandomSort;
end

function AssistRequest:IsValidAssister(actor)
	if actor == self:GetActor() then
		return false;
	end

	if actor:ContainsOneOfStates(mControlledStates) then
		return false;
	end

	return true;
end

function AssistRequest:AddToRandomList(teamActors)
	local randomList = mRandomList;
	local addToRandomList = function (actor)
		if self:IsValidAssister(actor) then
			actor.mRandomSort = math.random(0,100);
			randomList:Add(actor);
		end
	end
	teamActors:Foreach(addToRandomList);
end

function AssistRequest:AddToAssistList(totalCount)
	local randomList = mRandomList;
	if randomList.mLength > 0 then
		randomList:Sort(RandomSort);
		local addToAssistList = function (actor)
			return self:AddAssist(actor) == totalCount;
		end
		randomList:Foreach(addToAssistList);
		randomList:Clear();
	end
end

function AssistRequest:AskForAssist(assistCount,target)
	local owner = self:GetActor();
	self:AddAssist(owner);
	self:AddToRandomList(owner:GetTeamMates());
	self:AddToAssistList(assistCount+1);
	self.mTarget = target;
	self.mRemainCount = nil;
end

return AssistRequest;