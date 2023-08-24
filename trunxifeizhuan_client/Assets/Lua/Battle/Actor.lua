local LuaClass = require "Core/LuaClass"
local Observable = require "Core/Observable"
local mDoFileUtil = require "Utils/DoFileUtil";
local mCombatPosition = require "Module/Combat/CombatPosition"
local Actor = LuaClass("Actor",Observable);
local mNotifyEnum = require"Enum/NotifyEnum"
local mAttributeEnum = require "Enum/AttributeEnum"
local mEventDispatcher = require "Events/EventDispatcher"
local mEventEnum = require "Enum/EventEnum"
local mBuffStateEnum = require"Enum/BuffStateEnum"
local mControlledStates = {mBuffStateEnum.State2019,mBuffStateEnum.State2023};
local mLoseControlStates = {mBuffStateEnum.State2012,mBuffStateEnum.State2022};
local mSwimStates = {
	[mBuffStateEnum.State2019] = mBuffStateEnum.State2019;
	[mBuffStateEnum.State2023] = mBuffStateEnum.State2023;
}

local DebugHelper = DebugHelper;
local Time = UnityEngine.Time;
local Vector3 = Vector3;
local mNormalScale = Vector3.New(1,1,1);
local mMirrorScale = Vector3.New(-1,1,1);

local pairs = pairs;

function Actor:Init(vo,unReal)
	self.mDisposed = false;
	self.mPlayerControl = false;

	self.mUnReal = unReal;
	
	self.mActorVo = vo;
	self.mName = vo.mName;
	self.mCamp = vo.mCamp;
	self.mUniqueId = vo.mUniqueId;
	self.mPlayer = vo.mPlayer;
	self.mTeam = vo.mTeam;
	self.mLevel = vo.mLevel or 1;
	self.mRotation = vo.mRotation;
	self.mPosition = vo.mPosition;
	
	self.mComponents = {};

	if self.mUnReal == false then
		self:AddComponent("ActorView");
	end
end

function Actor:GetNameWithId()
	return self.mName..self.mUniqueId;
end

function Actor:GetLevel()
	return self.mLevel;
end

function Actor:GetNotifyEnum()
	return mNotifyEnum;
end

function Actor:GetAttributeEnum()
	return mAttributeEnum;
end

function Actor:GetBuffStateEnum()
	return mBuffStateEnum;
end

function Actor:GetCombat()
	return self.mCombat;
end

function Actor:EnterCombat(combat)
	self.mCombat = combat;

	self:AddComponent("AttributeSystem");
	self:AddComponent("SkillSystem");
	self:AddComponent("BuffSystem");
	self:AddComponent("CombatListener");

end

function Actor:Dispose()
	local components = self.mComponents;
	for k,v in pairs(components) do
		v:Dispose();
		v:RemoveListeners();
		components[k] = nil;
	end
	self.mDisposed = true;
	self.mCombat = nil;
	self.mEnterCombat = nil;
end

function Actor:GetComponent(keyName)
	return self.mComponents[keyName];
end

function Actor:GetTeamMates()
	return self.mCombat:GetAliveActorsOfTeam(self.mTeam);
end

function Actor:GetDeadTeamMates()
	return self.mCombat:GetDeadActorsOfTeam(self.mTeam);
end

function Actor:GetTotalTeamMates()
	return self.mCombat:GetTotalActorsOfTeam(self.mTeam);
end
function Actor:GetEnemies()
	return self.mTeam == 1 and self.mCombat:GetAliveActorsOfTeam(2) or self.mCombat:GetAliveActorsOfTeam(1);
end

function Actor:GetTotalAliveActors()
	return self.mCombat:GetAliveActors();
end

function Actor:GetSelectedTarget()
	if self.mTeam == 1 then
		return self.mCombat:GetSelectedTarget();
	end
end

function Actor:GetCombatCenter()
	return mCombatPosition.mCenter;
end

function Actor:GetTeamCenter()
	return mCombatPosition.mTeamPositions[self.mTeam];
end

function Actor:IsTeamMate(target)
	if not target then
		return false;
	end
	return self.mTeam == target.mTeam;
end

function Actor:IsMirror()
	return self.mTeam == 2;
end

function Actor:GetModelScale()
	return self:IsMirror() and mMirrorScale or mNormalScale;
end

function Actor:FindAndAddComponent(comp,keyName)
	local key = keyName or comp;
	local component = self.mComponents[key];
	if not component then
		component = self:AddComponent(comp,keyName);
	end
	return component;
end

function Actor:AddComponent(comp,keyName)
	local key = keyName or comp;
	local components = self.mComponents;
	local component = components[key];
	if not component then
		component = mDoFileUtil:DoFile("Battle/Component/"..comp).LuaNew(self);
		components[key] = component;
		component:Awake();
	end
	return component;
end

function Actor:RemoveComponent(keyName)
	local components = self.mComponents;
	local component = components[keyName];
	if component then
		component:Dispose();
		component:RemoveListeners();
		components[keyName] = nil;
	end
end

function Actor:GetTeamPosition()
	return self.mTeamPosition;
end

function Actor:DispatchEvent(eventType,params)
	mEventDispatcher:Dispatch(eventType,params);
end

---------------------------------------View----------------------------------------
function Actor:Raycast(hitCollider)
	return self.mCollider == hitCollider;
end

function Actor:FindNode(nodeName)
	local view = self:GetComponent("ActorView");
	if view then
		return view:FindNode(nodeName);
	end
end

function Actor:GetGameObject()
	local view = self:GetComponent("ActorView");
	if view then
		return view.mGameObject;
	end
end
------------------------------------------------------------------------------------
function Actor:GetPlayerControlState()
	if not self.mPlayer and DebugHelper.sPlayerControlMonster == false then
		return false;
	end

	if self:ContainsOneOfStates(mLoseControlStates) then
		return false;
	end

	if self.mUnReal then
		return false;
	end

	if self.mCombat:IsAutoAttack() then
		return false;
	end

	return true;
end

function Actor:IsDisableDoRound()
	if self:IsAlive() == false then
		return true;
	end
	return self:ContainsOneOfStates(mControlledStates);
end

function Actor:IsPlayerControl()
	return self.mPlayerControl;
end

function Actor:OnCombatStart()
	self:Notify(mNotifyEnum.OnCombatStart);
	if not self.mEnterCombat then
		self:Notify(mNotifyEnum.OnEnterCombat);
		self.mEnterCombat = true;
	end
end

function Actor:GetCurrentRound()
	return self.mRound or 0;
end

function Actor:StartRound()
	self.mRound = self:GetCurrentRound() + 1;
	self.mBeAttackCount = 0;
	self.mBeRandomAttackCount = 0;
	self.mIsRoundDone = false;
	self.mPlayerControl = self:GetPlayerControlState();
	self:Notify(mNotifyEnum.OnStartRound);
	self:DispatchEvent(mEventEnum.ON_START_ROUND,self);
end

function Actor:EndRound()
	self:Notify(mNotifyEnum.OnEndRound);
	self:DispatchEvent(mEventEnum.ON_CLEAR_ROUND);
	self:DispatchEvent(mEventEnum.ON_FINISH_ROUND);
end
----------------------------------------------BUFF---------------------------------------------
--隐身BUFF需要有至少一个不处于隐身状态的队友才有效
function Actor:CheckNotInState1015TeamMate()
	local lastCheckTime = self.mLastCheckNotInState1015TeamMateTime or 0;
	local frameCount = Time.frameCount;

	if frameCount - lastCheckTime > 5 then
		local actors = self:GetTeamMates();
		local result = nil;
		actors:Foreach(function (actor)
			if actor:ContainsState(mBuffStateEnum.State1015) == false then
				result = true;
				return true;
			end
		end);
		self.mHaveNoState1015TeamMate = result;
		self.mLastCheckNotInState1015TeamMateTime = frameCount;
	end

	return self.mHaveNoState1015TeamMate;
end
--------------------------正面状态--------------------
--是否处于隐身状态
function Actor:IsInState1015()
	return self:ContainsState(mBuffStateEnum.State1015) and self:CheckNotInState1015TeamMate();
end
--是否处于不屈状态
function Actor:IsInState1018()
	return self:ContainsState(mBuffStateEnum.State1018);
end
--是否处于无敌状态
function Actor:IsInStateNoHurt()
	return self:ContainsState(mBuffStateEnum.State1021);
end

--------------------------负面状态----------------------
--是否处于混乱状态
function Actor:IsInState2022()
	return self:ContainsState(mBuffStateEnum.State2022);
end
--是否处于封印状态
function Actor:IsInState2020()
	return self:ContainsState(mBuffStateEnum.State2020);
end
--是否处于嘲讽状态
function Actor:IsInState2012()
	return self:ContainsState(mBuffStateEnum.State2012);
end
--是否处于禁疗状态
function Actor:IsInStateNoRecover()
	return self:ContainsState(mBuffStateEnum.State2015);
end

function Actor:ContainsSwimState()
	return self:ContainsOneOfStates(mSwimStates);
end

function Actor:ContainsState(state)
	return self:GetStateCount(state) > 0;
end

function Actor:ContainsOneOfStates(states)
	return self:FindAndAddComponent("BuffSystem"):ContainsOneOfStates(states);
end

function Actor:HaveBuffType(buffType)
	return self:FindAndAddComponent("BuffSystem"):HaveBuffType(buffType);
end

function Actor:GetImmuneStateTypes()
	return self:FindAndAddComponent("BuffSystem").mImmuneStateTypes;
end

function Actor:GetImmuneStates()
	return self:FindAndAddComponent("BuffSystem").mImmuneStates;
end

function Actor:GetBuffsOfType(buffType)
	return self:FindAndAddComponent("BuffSystem"):GetBuffsOfType(buffType);
end

function Actor:GetBuffs()
	return self:FindAndAddComponent("BuffSystem").mBuffs;
end

function Actor:GetStateCount(state)
	return self:FindAndAddComponent("BuffSystem"):GetStateCount(state);
end
--------------------------------------------属性-----------------------------------------------

function Actor:GetModifyAttribute(valueType,includeTemp,ignoreBuffType)
	return self:FindAndAddComponent("AttributeSystem"):GetModifyAttribute(valueType,includeTemp,ignoreBuffType);
end

function Actor:ResetTempAttribute()
	self:FindAndAddComponent("AttributeSystem"):ResetTempModifier();
	self:FindAndAddComponent("HitSystem"):ResetAttributes();
end

function Actor:AddTempAttribute(blendType,valueType,value)
	self:FindAndAddComponent("AttributeSystem"):AddTempAttribute(blendType,valueType,value);
end

function Actor:GetAttribute(valueType)
	return self:FindAndAddComponent("AttributeSystem"):GetAttribute(valueType);
end

function Actor:GetBaseAttribute(valueType)
	return self:FindAndAddComponent("AttributeSystem"):GetBaseAttribute(valueType);
end

function Actor:GetHealthLimit()
	return self:FindAndAddComponent("AttributeSystem"):GetHealthLimit();
end

function Actor:GetHealth()
	return self:FindAndAddComponent("AttributeSystem"):GetHealth();
end

function Actor:GetAttackBarLimit()
	return self:FindAndAddComponent("AttributeSystem"):GetAttackBarLimit();
end

function Actor:GetAttackBar()
	return self:FindAndAddComponent("AttributeSystem"):GetAttackBar();
end

function Actor:IsAlive()
	return self:FindAndAddComponent("AttributeSystem"):IsAlive();
end

function Actor:GetAttackBarPersent()
	return self:FindAndAddComponent("AttributeSystem"):GetAttackBarPersent();
end

function Actor:GetHealthPersent()
	return self:FindAndAddComponent("AttributeSystem"):GetHealthPersent();
end

function Actor:SaveLastAttackResult(result)
	self.mLastAttackResult = result;
end

function Actor:GetLastAttackResult()
	return self.mLastAttackResult;
end

function Actor:SaveLastBeAttackResult(result)
	self.mLastBeAttackResult = result;
	self.mBeAttackCount = self:GetBeAttackCount() + 1;
	self.mTotalBeAttackCount = self:GetTotalBeAttackCount() + 1;
end

function Actor:GetLastBeAttackResult()
	return self.mLastBeAttackResult;
end
--回合内受到攻击次数,每回合清0
function Actor:GetBeAttackCount()
	return self.mBeAttackCount or 0;
end
--受到攻击总次数,死亡清0
function Actor:GetTotalBeAttackCount()
	return self.mTotalBeAttackCount or 0;
end

function Actor:AddBeRandomAttackCount()
	self.mBeRandomAttackCount = self:GetBeRandomAttackCount() + 1;
end

function Actor:GetBeRandomAttackCount()
	return self.mBeRandomAttackCount or 0;
end

----------------------------------------------临时特殊战斗属性-----------------------------------------

function Actor:GetHitAttribute(key)
	return self:FindAndAddComponent("HitSystem"):GetAttribute(key);
end

function Actor:SetHitAttribute(key,value)
	self:FindAndAddComponent("HitSystem"):SetAttribute(key,value);
end

function Actor:AddHitAttribute(key,add)
	self:FindAndAddComponent("HitSystem"):AddAttribute(key,add);
end

----------------------------------------------技能---------------------------------------------

function Actor:CanSelectTarget(target)
	if not target then
		return false;
	end
	return self:FindAndAddComponent("SkillSystem"):CanSelectTarget(target)
end

function Actor:GetSelectedSkill()
	return self:FindAndAddComponent("SkillSystem"):GetSelectedSkill();
end

function Actor:GetSkills()
	return self:FindAndAddComponent("SkillSystem"):GetSkills();
end

function Actor:OnSelectSkill(index)
	self:Notify(mNotifyEnum.OnSelectSkill,index);
	self:DispatchEvent(mEventEnum.ON_ACTOR_SELECT_SKILL,self:GetSelectedSkill());
end

function Actor:OnUseSkill(target)
	self.mIsRoundDone = true;
	self:Notify(mNotifyEnum.OnUseSkill,target);
	self:DispatchEvent(mEventEnum.ON_ACTOR_USE_SKILL,self:GetSelectedSkill());
end
---------------------------------------------------------------------------------------------------

function Actor:NotifyRemoveTargetState(skillHit)
	self:Notify(mNotifyEnum.OnRemoveTargetState,skillHit);
end

function Actor:OnBeKilled()
	self:Notify(mNotifyEnum.OnBeKilled);
	self:Notify(mNotifyEnum.OnToggleModel,false);
	self:DispatchEvent(mEventEnum.ON_ACTOR_DEAD,self);
end

function Actor:CheckRelive()
	if self:Reliveable() then
		self:Notify(mNotifyEnum.OnCheckRelive);
	end
end

function Actor:OnRelive()
	self:Notify(mNotifyEnum.OnRelive);
	self:Notify(mNotifyEnum.OnEnterCombat);
	self:DispatchEvent(mEventEnum.ON_ACTOR_RELIVE,self);
end

--isTakeCoinRelive 花钱复活
function Actor:Relive(isTakeCoinRelive)
	self:OnRelive();
	self:Notify(mNotifyEnum.OnToggleModel,true);
	if isTakeCoinRelive then
		self.mForbidRelive = nil;
		self:Notify(mNotifyEnum.OnUpdateHealth,self:GetHealthLimit());
	end
end

function Actor:ReliveSelf()
	self:OnRelive();
	local callback = function ()
		self:Notify(mNotifyEnum.OnToggleModel,true);
	end
	self:FindAndAddComponent("Relive"):Begin(1,callback);
end

function Actor:Reliveable()
	return not self.mForbidRelive;
end

function Actor:ForbidRelive()
	self.mForbidRelive = true;
end

function Actor:HasAction(actionType)
	local action = self:GetComponent(actionType);
	return action and action:HasAction();
end

return Actor;