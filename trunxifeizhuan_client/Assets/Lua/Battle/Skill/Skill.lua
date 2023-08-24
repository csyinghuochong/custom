local LuaClass = require "Core/LuaClass"
local Skill = LuaClass("Skill");
local mConfigSysskill_ai = require"ConfigFiles/ConfigSysskill_ai"
local mConfigSysskill_event = require"ConfigFiles/ConfigSysskill_event"
local mConfigSysskill_calculator = require"ConfigFiles/ConfigSysskill_calculator"
local mConfigSyscamp_restriction = require"ConfigFiles/ConfigSyscamp_restriction"
local mSkillCheck = require"Battle/Skill/SkillCheck"
local mActionManager = require "Battle/Manager/SkillActionManager"
local mEffectManager = require "Battle/Manager/EffectManager"

local mDoFileUtil = require "Utils/DoFileUtil";
local mNotifyEnum = require "Enum/NotifyEnum"
local mEventEnum = require "Enum/EventEnum"
local mEventDispatcher = require "Events/EventDispatcher"

local mRecoverEffect = mEffectManager.mCommonEffects.mRecover;

local mSkillState = {}
local math  = math;
local pairs = pairs;
local ipairs = ipairs;

local mSkillHitClasses = {
	[0] = "SkillHit";
	[1] = "AttackHit";
	[2] = "TreatHit";
}

local SkillKeyEnum = 
{
    mShake = "mShake";
    mScreenBlack = "mScreenBlack";
    mShowName = "mShowName";
    mCritShake = "mCritShake";
};

function Skill:OnLuaNew(owner,data)

	local config = data.mConfig;
	local cd = config.cd;
	self.mCd = cd;
	self.mName = data.mName;
	self.mIcon = data.mIcon;

	self.mData = data;
	self.mOwner = owner;
	self.mConfig = config;

	self.mActionCompleted = true;
	self.mTimeSinceSkillStart = cd+1;
	self.mAction = mActionManager:GetActionConfig(config.action);
	self.mAI = mConfigSysskill_ai[config.ai];
	self.mPassive = config.type > 0 ;

	self:InitOtherValues(config);
	self.mTargetType = config.target;

	local behit = config.behit;
	if behit > 0 then
		local calculator = mConfigSysskill_calculator[behit];
		if calculator then
			self.mPassiveHit = mDoFileUtil:DoFile("Battle/Skill/SkillHit/SkillHit").LuaNew(self,calculator,0,true);
		else
			Debugger.LogError(string.format("[%s] skill 表中 behit 字段配置错误,skill_calculator表中找不到ID = %s 的项",self.mName,behit));
		end
	end
end

function Skill:DispatchEvent(eventType,params)
	mEventDispatcher:Dispatch(eventType,params);
end

function Skill:SetPosition(index)
	self.mIndex = index;
end

function Skill:AddHitEffects(effectConfigs,ids)
	if ids then
		for i,v in ipairs(ids) do
			local effectConfig = mEffectManager:GetEffectConfig(v);
			if effectConfig then
				effectConfigs[50+i] = effectConfig;
			end
		end
	end
end

function Skill:AddSkillEffects(effectConfigs,ids)
	if ids then
		for i,v in ipairs(ids) do
			local effectConfig = mEffectManager:GetEffectConfig(v);
			if effectConfig then
				effectConfigs[effectConfig.index] = effectConfig;
			end
		end
	end
end

function Skill:GetEffectConfig(index)

	local effectConfigs = self.mEffectConfigs;
	if not effectConfigs then

		local config = self.mConfig;

		effectConfigs = {};
		self:AddSkillEffects(effectConfigs,config.effect);
		self:AddHitEffects(effectConfigs,config.hit_effect);
		self.mEffectConfigs = effectConfigs;
	end
	return effectConfigs[index];
end

function Skill:ShowEffect(index,logicParams)
	local effectConfig = self:GetEffectConfig(index);
	if effectConfig then
		mEffectManager:ShowEffect(mEffectManager:GetEffect(effectConfig),logicParams);
	end
end

function Skill:ShowRecoverEffect(actor)
	mEffectManager:ShowEffect(mEffectManager:GetEffect(mRecoverEffect),actor);
end

function Skill:ShowHitEffect(index,actor,playHitAnimation)
	local effectConfig = self:GetEffectConfig(50+index);
	if effectConfig then
		mEffectManager:ShowEffect(mEffectManager:GetEffect(effectConfig),actor);
		local animation = effectConfig.animation;
		if playHitAnimation and animation then
			actor:Notify(mNotifyEnum.Animation,animation);
		end
	end
end

function Skill:IsReliveSkill()
	return self.mTargetType == 3 or self.mTargetType == 4;
end

function Skill:IsPassiveSkill()
	return self.mPassive;
end

function Skill:AddOtherValue(key,value)
	if value and value ~= 0 then
		self[key] = value;
	end
end

function Skill:InitOtherValues(config)
	self:AddOtherValue(SkillKeyEnum.mShowName,config.show_name);
	self:AddOtherValue(SkillKeyEnum.mShake,config.shake);
	self:AddOtherValue(SkillKeyEnum.mCritShake,config.crit_shake);
	self:AddOtherValue(SkillKeyEnum.mScreenBlack,config.screen_black);
end

function Skill:StartAction(actionConfig,logicParams)
	if not actionConfig then
		return;
	end

	local action = mActionManager:GetAction(actionConfig);
	mActionManager:StartAction(action,logicParams);
end

function Skill:ShowTip()
	if self[SkillKeyEnum.mShowName] then
		self:DispatchEvent(mEventEnum.SHOW_SKILL_NAME,self);
	end
end

function Skill:OnUse(target)
	self.mTarget = target;
	self.mActionCompleted = false;

	self:BeginColdDown();
	self:StartAction(self.mAction,self);
	self:ShowTip();
end

function Skill:BeginColdDown()
	if self.mCd > 0 then
		self.mTimeSinceSkillStart = 0;
	end
end

function Skill:IsColdDown()
	return self.mTimeSinceSkillStart > self.mCd
end

function Skill:ResetCD()
	self.mTimeSinceSkillStart = self.mCd + 1;
end

function Skill:ModifyCD(value)
	if self.mCd > 0 then
		self.mTimeSinceSkillStart = math.max(0,self.mTimeSinceSkillStart + value);
	end
end

function Skill:CreateSkillHit(index)
	local config = self.mConfig;
	local hits = config.hit;
	if not hits then
		return nil;
	end

	local hit = hits[index];
	if not hit then
		return nil;
	end

	local vo = mConfigSysskill_calculator[hit];
	if vo then
		local cls = mSkillHitClasses[vo.formula] or mSkillHitClasses[0];
		return mDoFileUtil:DoFile("Battle/Skill/SkillHit/"..cls).LuaNew(self,vo,index);
	end
end

function Skill:GetSkillHit(index)

	local skillHits = self.mSkillHits;
	if not skillHits then
		skillHits = {};
		self.mSkillHits = skillHits;
	end

	local skillHit = skillHits[index];
	if not skillHit then
		skillHit = self:CreateSkillHit(index);
		skillHits[index] = skillHit;
	end

	return skillHit;
end

function Skill:DoHit(target,hitId)
	local skillHit = self:GetSkillHit(hitId);
	if not skillHit then
		return;
	end
	if not target then
		return;
	end
	skillHit:Excute(target);
end

function Skill:PassiveOnCheck(target,checkId)
	local vo = mConfigSysskill_event[checkId];
	if vo then
		local evtType = vo.type;
		self.mTarget = target;
		if evtType == 0 then
			self:DoHit(target,vo.parameters[1]);
			elseif evtType == 1 then
				self:OnCheck(vo.parameters);
			end
	end
end

function Skill:OnCheck(parameters)
	local hitId = parameters[2];
	local callback = function (target)
	   self:DoHit(target,hitId);
	end
	self:DoCheck(parameters,callback);
end

function Skill:DoCheck(parameters,callback)
	mSkillCheck:DoCheck(self,parameters,callback);
end

function Skill:GetShake(crit)
	local shake = nil;
	if crit then
		shake = self[SkillKeyEnum.mCritShake];
	end
		
	if not shake then
		shake = self[SkillKeyEnum.mShake];
	end
	return shake;
end

function Skill:Shake(crit)
	local shake = self:GetShake(crit);
	if shake then
		self:DispatchEvent(mEventEnum.SHAKE_CAMERA,"shake_"..shake);
	end
end
function Skill:ToggleScreenEffect(value)
	if self[SkillKeyEnum.mScreenBlack] then
		self:DispatchEvent(mEventEnum.TOGGLE_SCREEN_BLACK,value);
	end
end

function Skill:SetComboAttack(count)
	local comboCount = self.mComboCount or 0;
	if comboCount < count then
		comboCount = comboCount + 1;
		self.mComboCount = comboCount;
		self.mWaitForComboAttack = true;
	end
end

function Skill:IsComboAttack()
	return self.mComboAttack;
end

function Skill:WillComboAttack()
	return self.mWaitForComboAttack;
end

function Skill:OnComboAttack()
	self.mWaitForComboAttack = nil;
	self.mComboAttack = true;
end

function Skill:CheckCounterAttackRequest(owner)
	if owner:HasAction("CounterAttackRequest") then
		owner:Notify(mNotifyEnum.OnCounterAttackRequest,function () self:OnFinish() end);
	else
		self:OnFinish();
	end
end

function Skill:CheckCounterAttack(owner)
	if owner:HasAction("CounterAttack") then
		owner:Notify(mNotifyEnum.OnCounterAttackCompleted);
		self.mActionCompleted = true;
	else
		self:CheckCounterAttackRequest(owner);
	end
end

function Skill:CheckAssist(owner)
	if owner:HasAction("Assist") then
		owner:Notify(mNotifyEnum.OnAssistCompleted);
		self.mActionCompleted = true;
	else
		self:CheckCounterAttack(owner);
	end
end

function Skill:CheckAssistRequest()
	local owner = self.mOwner;
	if owner:HasAction("AssistRequest") then
		owner:Notify(mNotifyEnum.OnAssistRequest,function () self:CheckCounterAttack(owner) end);
	else
		self:CheckAssist(owner);
	end
end

function Skill:CheckComboAttack()
	if self:WillComboAttack() then
		self:OnComboAttack();
		self:StartAction(self.mAction,self);
	else
		self:CheckAssistRequest();
	end
end

function Skill:OnFinish()
	self.mActionCompleted = true;
	self.mComboCount = nil;
	self.mComboAttack = nil;
	self.mWaitForComboAttack = nil;
	self.mOwner:EndRound();
end

function Skill:Finish()
	self:CheckComboAttack();
end

function Skill:CheckTargetType0(owner,target)
	return owner.mTeam == target.mTeam and target:IsAlive();
end

function Skill:CheckTargetType1(owner,target)
	if target:IsAlive() == false or target:IsInState1015() then
		return false;
	end
	return owner.mTeam ~= target.mTeam or owner:IsInState2022();
end

function Skill:CheckTargetType2(owner,target)
	return owner == target;
end

function Skill:CheckTargetType3(owner,target)
	if target:IsAlive() then
		return false;
	end
	return owner.mTeam == target.mTeam;
end

function Skill:CheckTargetType4(owner,target)
	return owner.mTeam == target.mTeam;
end

function Skill:CanSelectTarget(target)
	local targetType = self.mTargetType;
	if targetType == 0 then
		return self:CheckTargetType0(self.mOwner,target);
		elseif targetType == 1 then
			return self:CheckTargetType1(self.mOwner,target);
			elseif targetType == 2 then
				return self:CheckTargetType2(self.mOwner,target);
				elseif targetType == 3 then
					return self:CheckTargetType3(self.mOwner,target);
					elseif targetType == 4 then
						return self:CheckTargetType4(self.mOwner,target);
					end
	return true;
end

function Skill:GetState()

	local timeSinceSkillStart = self.mTimeSinceSkillStart;
	local totalTime = self.mCd;
	local actionCompleted = self.mActionCompleted;
	local inDisableState = self.mIndex ~= 1 and self.mOwner:IsInState2020();

	mSkillState.mCDTotalTime = totalTime;
	mSkillState.mTimeSinceSkillStart = timeSinceSkillStart ;
	mSkillState.mActionCompleted = actionCompleted;
	mSkillState.mInDisableState = inDisableState;

	mSkillState.mEnable = actionCompleted and timeSinceSkillStart > totalTime and inDisableState == false;

	return mSkillState; 
end

function Skill:CanUse()

	if self.mPassive then
		return false;
	end

	return self:GetState().mEnable;
end

function Skill:Restrain(target)

	local owner = self.mOwner;

	if owner.mTeam == target.mTeam then
		return 0;
	end


	local camp = target.mCamp;

	local restrain_camps = self.mConfig.restrain_camps;
	if restrain_camps then
		if restrain_camps[camp] then
			return 1;
		end
	end

	local myCame = owner.mCamp;
	if mConfigSyscamp_restriction[myCame.."_"..camp] then
		return 1;
	end

	if mConfigSyscamp_restriction[camp.."_"..myCame] then
		return 2;
	end

	return 0;
end

return Skill;