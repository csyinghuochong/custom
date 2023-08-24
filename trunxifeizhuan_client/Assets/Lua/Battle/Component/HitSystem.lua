local LuaClass = require "Core/LuaClass"
local ActorObserver = require "Battle/Component/ActorObserver"
local HitSystem = LuaClass("HitSystem",ActorObserver);
local mAffectTriggerController = require "Battle/Skill/AffectTriggerController"
local mAttributeEnum = require "Enum/AttributeEnum"
local mNotifyEnum = require"Enum/NotifyEnum"
local table = table;
local pairs = pairs;
local ipairs = ipairs;

function HitSystem:Awake()
	self.mAttributes = {};
	self.mAffectTriggers = {};
	self:ResetAttributes();
end

function HitSystem:GetAttribute(key)
	return self.mAttributes[key];
end

function HitSystem:SetAttribute(key,value)
	self.mAttributes[key] = value;
end

function HitSystem:AddAttribute(key,add)
	self:SetAttribute(key,self:GetAttribute(key) + add);
end

function HitSystem:ResetAttributes()
	local attributes = self.mAttributes;
	attributes[mAttributeEnum.IgnoreDefense] = nil;
	attributes[mAttributeEnum.IgnoreCamp] = nil;
	attributes[mAttributeEnum.HurtLimit] = nil;
	attributes[mAttributeEnum.DestroyHealthLimit] = nil;
	attributes[mAttributeEnum.ExtraHurt] = 0;
	attributes[mAttributeEnum.ExtraSkillRatio] = 0;
	attributes[mAttributeEnum.IgnoreBuffType] = nil;
end

local function OnAssistKill(skillHit,triggerType,target)
	skillHit:PassiveExcute(skillHit:GetActor(),target,triggerType);
end

local function OnOtherSkillHit(skillHit,triggerType,otherSkillHit)
	skillHit.crit = otherSkillHit.crit;
	skillHit.hit = otherSkillHit.hit;
	skillHit.hurt = otherSkillHit.hurt;
	skillHit.effect_hit_rate = otherSkillHit.effect_hit_rate;
	
	skillHit:PassiveExcute(otherSkillHit.atk,otherSkillHit.def,triggerType);
end

local function OnSelfOtherSkillHit(skillHit,triggerType,otherSkillHit)
	if otherSkillHit.atk == skillHit:GetActor() then
		OnOtherSkillHit(skillHit,triggerType,otherSkillHit);
	end
end

local function OnOtherCheckCombatKill(skillHit,triggerType,otherSkillHit)
	skillHit:PassiveExcute(otherSkillHit.atk,otherSkillHit.def,triggerType);
end

local function OnSelfKill(skillHit,triggerType,otherSkillHit)
	if otherSkillHit.atk == skillHit:GetActor() then
		OnOtherCheckCombatKill(skillHit,triggerType,otherSkillHit);
	end
end

local function OnSelfPassiveHit(skillHit,triggerType)
	local owner = skillHit:GetActor();
	skillHit:ResetTempAttribute(owner,owner);
	skillHit:PassiveExcute(owner,owner,triggerType);
end

local function OnReduceHealth(skillHit,triggerType,result)
	skillHit.reduceHealth = result.hurt;
	skillHit:PassiveExcute(result.atk,result.def,triggerType);
end

local mCombatListeners = {

    ["BeforeSelfOtherSkillHit"] = OnSelfOtherSkillHit;
    ["AfterSelfOtherSkillHit"] = OnSelfOtherSkillHit;
    ["OnSelfOtherSkillKill"] = OnSelfKill;

	[mNotifyEnum.BeforeOtherAttack] = OnOtherSkillHit;
	[mNotifyEnum.AfterOtherAttack] = OnOtherSkillHit;

	[mNotifyEnum.BeforeOtherTreat] = OnOtherSkillHit;
	[mNotifyEnum.BeforeOtherPoison] = OnOtherSkillHit;
	[mNotifyEnum.BeforeOtherRecoverAttackBar] = OnOtherSkillHit;

	[mNotifyEnum.OnOtherCheckCombatKill] = OnOtherCheckCombatKill;

	[mNotifyEnum.OnEnterCombat] = OnSelfPassiveHit;
	[mNotifyEnum.OnCombatStart] = OnSelfPassiveHit;
	[mNotifyEnum.OnStartRound] = OnSelfPassiveHit;
	[mNotifyEnum.OnReduceHealth] = OnReduceHealth;
	[mNotifyEnum.OnRemoveTargetState] = OnOtherSkillHit;

	[mNotifyEnum.OnAssistKill] = OnAssistKill;
	[mNotifyEnum.OnCheckRelive] = OnSelfPassiveHit;
}

function HitSystem:GetObserverType(key,isPassive)
	if isPassive then
		if key == 101 then
			return mNotifyEnum.BeforeOtherAttack;
			elseif key == 102 then
				return mNotifyEnum.AfterOtherAttack;
				elseif key == 104 then
					return mNotifyEnum.OnOtherCheckCombatKill;
				end
	end
	return key;
end

function HitSystem:GetCombatListener(key,isPassive)
	if isPassive then
		if key == 101 then
			return mCombatListeners["BeforeSelfOtherSkillHit"];
			elseif key == 102 then
				return mCombatListeners["AfterSelfOtherSkillHit"];
				elseif key == 104 then
					return mCombatListeners["OnSelfOtherSkillKill"];
				end
	end
	return mCombatListeners[key];
end

function HitSystem:AddCombatListeners(skillHit,triggers)

	local isPassive = skillHit:IsPassive();
	for k,v in pairs(triggers) do
		local listener = self:GetCombatListener(k,isPassive);
		if listener then
			self:RegisterListener(self:GetObserverType(k,isPassive),function (params) listener(skillHit,k,params); end);
		end
	end
end

function HitSystem:AddAffectTrigger(triggers,trigger)
	
	local triggerType = trigger.type;
	local triggersOfType = triggers[triggerType];
	if not triggersOfType then
		triggersOfType = {};
		triggers[triggerType] = triggersOfType;
	end

	table.insert(triggersOfType,trigger);
end

function HitSystem:TriggerAffect(skillHit,triggerType)
	local triggers = self.mAffectTriggers[skillHit];
	if triggers then
		local triggersOfType = triggers[triggerType];
		if triggersOfType then
			for k,v in ipairs(triggersOfType) do
				mAffectTriggerController:Excute(v,skillHit);
			end
		end
	end
end

function HitSystem:AddAffectTriggers(skillHit,triggerVos)
	if triggerVos then
		local triggers = {}
		for i,v in ipairs(triggerVos) do
			self:AddAffectTrigger(triggers,v);
		end
		self:AddCombatListeners(skillHit,triggers);
		self.mAffectTriggers[skillHit] = triggers;
	end
end

return HitSystem;