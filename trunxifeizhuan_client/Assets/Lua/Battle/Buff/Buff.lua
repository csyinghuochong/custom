local LuaClass = require "Core/LuaClass"
local ActorObserver = require "Battle/Component/ActorObserver"
local ExtraAttribute = require"Battle/Attribute/ExtraAttribute"
local Buff = LuaClass("Buff",ActorObserver);
local mCombatWordManager = require "Module/Combat/CombatWordManager";
local mNotifyEnum = require"Enum/NotifyEnum"
local mBuffStateEnum = require"Enum/BuffStateEnum"
local mSwimStates = {
	[mBuffStateEnum.State2019] = mBuffStateEnum.State2019;
	[mBuffStateEnum.State2023] = mBuffStateEnum.State2023;
}

local math = math;
local mUniqueId = 0;

function Buff:OnLuaNew(config)

	local duration = config.duration;
	local icon = config.icon;
	local buffType = config.buff_type;
	local valueType = config.value_type;
	local value = config.value;

	self.mConfig = config;
	self.mDuration = duration > 0 and duration or 100000;
	self.mIcon = (icon ~= "" and duration > 0) and icon or nil;

	self.mStartRound = 0;
	self.mOtherParams = config.other_params;
	self.mCombaWord = (config.combat_word or -1) - 1100;
	self.mUniqueId = mUniqueId;
	self:SetEnable(false);
	self.mBuffType = buffType;
	self.mStateType = config.state;
	self.mValue = value;

	if valueType > 0 then
		self.mExtraAttribute = ExtraAttribute.LuaNew(config.value_blend,valueType,value);
		self.mExtraAttribute:SetPlusOrMinus(buffType);
	end

	mUniqueId = mUniqueId + 1;
end

function Buff:GetStateType()
	return self.mStateType;
end

function Buff:GetBuffType()
	return self.mBuffType;
end

function Buff:GetValue()
	return self.mValue;
end

function Buff:IsSwimState()
	return mSwimStates[self:GetStateType()];
end

function Buff:CanRemoveWhenClearStage()
	local buffType = self:GetBuffType();
	if buffType == 1 or buffType == 2 then
		return true;
	end
	return self.mDuration < 100;
end

function Buff:SetParams(owner,skill)
	self.mOwner = owner;
	self.mSkill = skill;
	self:SetObservable(owner);
end

function Buff:Start()
	self.mStartRound = self.mOwner:GetCurrentRound();
	self:SetEnable(true);
	self:OnStart();
	self:ShowTip();
	self:NotifyAttribute(mNotifyEnum.AddExtraAttribute);
end

function Buff:NotifyAttribute(notifyType)
	local extraAttribute = self.mExtraAttribute;
	if not extraAttribute then
	   return;
	end
	self.mOwner:Notify(notifyType,extraAttribute);
end

function Buff:SetEnable(enable)
	self.mEnable = enable;
end

function Buff:IsEnable()
	return self.mEnable;
end

function Buff:ShowTip()
	local combat_word = self.mCombaWord;
	if combat_word > -1 then
		mCombatWordManager:ShowCombatImageWord(combat_word,self.mOwner);
	end
end

function Buff:OnStart()end
function Buff:OnFinish()end
function Buff:OnStartRound()end
function Buff:OnEndRound()end

function Buff:StartRound()
	self:OnStartRound();
end

function Buff:SendFinish()
	self.mOwner:Notify(mNotifyEnum.RemoveBuff,self);
end

function Buff:EndRound()
	self:OnEndRound();
	self:CheckTime();
end

function Buff:Finish()
	self:OnFinish();
	self:RemoveListeners();
	self:SetEnable(false);
	self:NotifyAttribute(mNotifyEnum.RemoveExtraAttribute);
end

--剩余回合
function Buff:GetRemainRound()
	return self.mDuration + self.mStartRound - self.mOwner:GetCurrentRound();
end

function Buff:ModifyTime(v)
	self.mStartRound = self.mStartRound + v;
	self.mOwner:Notify(mNotifyEnum.OnBuffUpdate,self);
	self:CheckTime();
end

function Buff:CheckTime()
	if self:GetRemainRound() <= 0 then
		self:SendFinish();
	end
end

function Buff:ToString()
	return string.format("self.mDuration = [%s] self.mStartRound = [%s] self.mOwner:GetCurrentRound() = [%s]",self.mDuration,self.mStartRound,self.mOwner:GetCurrentRound());
end
return Buff;