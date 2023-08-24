local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local List = require "Common/List"
local SkillAction = LuaClass("SkillAction",BaseLua);
local mNotifyEnum = require"Enum/NotifyEnum"
local mBuffStateEnum = require"Enum/BuffStateEnum"
local mConfigSysskill_event = require"ConfigFiles/ConfigSysskill_event"

local Time = UnityEngine.Time;
local mUpAxis = Vector3.up;
local Quaternion = Quaternion;
local math = math;
local table = table;
local pairs = pairs;

function SkillAction:OnLuaNew(config)

	self.mConfig = config;
	self.mAnimations = config.animations;
	self.mDurations = config.durations;
	self:OnAwake(config);
end

function SkillAction:GetCheckType()
	local checkType = self.mCheckType;
	if not checkType then
		local events = self.mConfig.events;
		checkType = 0;
		local evt = mConfigSysskill_event[events[1] or -1];
		if evt then
			checkType =  evt.parameters[1] or 0;
		end
		self.mCheckType = checkType;
	end
	return checkType;
end

function SkillAction:GetEvents()
	local events = self.mEvents;
	if not events then
		events = {};
		local config = self.mConfig;
		local vos = config.events;
		local times = config.event_times;
		local lastTime = 0;
		for i,v in ipairs(vos) do
			lastTime = times[i] or lastTime;
			events[i] = {mTime = lastTime,mEvent = mConfigSysskill_event[v]};
		end
		self.mEvents = events;
	end
	return events;
end

function SkillAction:OnAwake(config)

end

function SkillAction:Dispose()
	self:OnDispose();
end

function SkillAction:OnDispose()
end

function SkillAction:PlayAnimation(state)
	self.mOwner:Notify(mNotifyEnum.Animation,state);
end


function SkillAction:Start(skill)

	self.mRunning = true;
	self.mSkill = skill;
	self.mOwner = skill.mOwner;
	self.mStartTime = Time.time;
	self:OnStart(skill);
	self:ResetEvent();
	skill:ToggleScreenEffect(true);

end

function SkillAction:ShowEffect(index,logicParams)
	self.mSkill:ShowEffect(index,logicParams);
end

function SkillAction:OnStart()
end

function SkillAction:ShowMultiActorEffect(parameters)
	local skill = self.mSkill;
	local callback = function (target)
		self:ShowEffect(41,target);
	end

	skill:DoCheck(parameters,callback);
end

function SkillAction:GetEvent(index)
	local events = self:GetEvents();
	if events then
		return events[index];
	end
	return nil;
end

function SkillAction:ResetEvent()
	self.mEventCompleted = false;
	self.mEventIndex = 1;
end

function SkillAction:DoCheckEvent(parameters)
	self.mSkill:OnCheck(parameters);
end

function SkillAction:DoSelfAffect(id)
	local skill = self.mSkill;
	skill:DoHit(skill.mOwner,id);
end

function SkillAction:ExcuteEvent(evt)
	if not evt then
		return;
	end

	local eventType = evt.type;
	local parameters = evt.parameters;
	if eventType == 0 then
		self:DoSelfAffect(parameters[1]);
	elseif eventType == 1 then
		self:DoCheckEvent(parameters);
		elseif eventType == 2 then
			--self:AskForAssist(parameters);
			elseif eventType == 3 then
				self:ShowMultiActorEffect(parameters);
			end
end

function SkillAction:UpdateEvent(time)

	if self.mEventCompleted then
		return true;
	end

	local index = self.mEventIndex;
	local evt = self:GetEvent(index);

	if not evt then
		self.mEventCompleted = true;
		return true;
	end

	if time > evt.mTime then
		self:ExcuteEvent(evt.mEvent);
		self.mEventIndex = index + 1;
	end

	return false
end

function SkillAction:Update()
end

function SkillAction:SetPosition(owner,position)
	owner.mPosition = position;
	owner:Notify(mNotifyEnum.Position,position);
end

function SkillAction:SetRotation(owner,rotation)
	owner.mRotation = rotation;
	owner:Notify(mNotifyEnum.Rotation,rotation);
end

function SkillAction:RotateToTarget(owner,target)
	if owner == target then
		return;
	end

	local rotation = self:LookRotation(target.mPosition - owner.mPosition);
	self:SetRotation(owner,rotation);
end

function SkillAction:LookRotation(dir)
	return Quaternion.LookRotation(dir,mUpAxis);
end

function SkillAction:ResetRotation(lerp)
	lerp = nil;
	local owner = self.mOwner;
	local rotation = owner.mActorVo.mRotation;
	if lerp then
		self:LerpToRotation(owner,rotation);
	else
		self:SetRotation(owner,rotation);
	end
end

function SkillAction:LerpToRotation(owner,rotation)
	owner.mRotation = rotation;
	owner:Notify(mNotifyEnum.LerpToRotation,rotation);
end

function SkillAction:ResetPosition()

	local owner = self.mOwner;

	local position = owner.mActorVo.mPosition;
	local rotation = owner.mActorVo.mRotation;

	self:SetPosition(owner,position);
	self:SetRotation(owner,rotation);
end

function SkillAction:Finish()
	local skill = self.mSkill;
	skill:ToggleScreenEffect(false);
	skill:Finish();
	self.mRunning = nil;
end

function SkillAction:CheckExit()
	return not self.mRunning;
end

return SkillAction;