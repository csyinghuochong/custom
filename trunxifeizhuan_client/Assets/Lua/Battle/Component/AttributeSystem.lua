local LuaClass = require "Core/LuaClass"
local ActorObserver = require "Battle/Component/ActorObserver"
local AttributeSystem = LuaClass("AttributeSystem",ActorObserver);
local BaseAttribute = require "Battle/Attribute/BaseAttribute"
local Modification = require "Battle/Attribute/Modification"
local AttributeModifier = require "Battle/Attribute/AttributeModifier"
local mEventDispatcher = require "Events/EventDispatcher"
local mEventEnum = require "Enum/EventEnum"
local mNotifyEnum = require"Enum/NotifyEnum"
local mBuffStateEnum = require"Enum/BuffStateEnum"
local mAttributeEnum = require "Enum/AttributeEnum"
local math = math;
local mAttackBarLimit = 1000;

function AttributeSystem:Awake()

	local config = self:GetActor().mActorVo.mAttri;

	self.mBaseAttributes = BaseAttribute.LuaNew(config);
	self.mAttributes = BaseAttribute.LuaNew(config);

	self:AddObservers();
end

function AttributeSystem:AddObservers()
	self:RegisterListener(mNotifyEnum.OnUseSkill,function ()
		self:UpdateAttackBar(0);
	end);
	self:RegisterListener(mNotifyEnum.OnBeKilled,function ()
		self:OnBeKilled();
	end);
	self:RegisterListener(mNotifyEnum.OnRelive,function ()
		self:OnRelive();
	end);
	self:RegisterListener(mNotifyEnum.OnClearStage,function (params)
		self:OnClearStage(params);
	end);
	self:RegisterListener(mNotifyEnum.OnUpdateHealth,function (value)
		self:UpdateHealth(value);
	end);
	self:RegisterListener(mNotifyEnum.OnUpdateHealthLimit,function (value)
		self:UpdateHealthLimit(value);
	end);
	self:RegisterListener(mNotifyEnum.OnUpdateAttackBar,function (value)
		self:UpdateAttackBar(value);
	end);
	self:RegisterListener(mNotifyEnum.AddExtraAttribute,function (extraAttribute)
		self:AddExtraAttribute(extraAttribute);
	end);
	self:RegisterListener(mNotifyEnum.RemoveExtraAttribute,function (extraAttribute)
		self:RemoveExtraAttribute(extraAttribute);
	end);
end

function AttributeSystem:OnRelive()
	local health = self:GetHealth();
	if health <= 0 then
		self:UpdateHealth(1);
	end
end

function AttributeSystem:OnBeKilled()
	self:UpdateAttackBar(0);
	self:UpdateHealth(0);
end
function AttributeSystem:OnClearStage(params)
	local recover_hp = params.recover_hp or 0;
	self:UpdateHealth(self:GetHealth()+self:GetHealthLimit()*recover_hp);
	self:UpdateAttackBar(0);
end

function AttributeSystem:GetHealthPersent()
	return math.max(self:GetHealth() / self:GetHealthLimit(),0);
end

function AttributeSystem:GetAttackBarPersent()
	return math.min(self:GetAttackBar() / self:GetAttackBarLimit(),1);
end

function AttributeSystem:GetHealth()
	return self.mHealth or self:GetAttribute(mAttributeEnum.Health);
end

function AttributeSystem:GetHealthLimit()
	return self.mHealthLimit or self:GetAttribute(mAttributeEnum.HealthLimit);
end

function AttributeSystem:GetAttackBarLimit()
	return mAttackBarLimit;
end

function AttributeSystem:GetAttackBar()
	return self.mAttackBar or self:GetAttribute(mAttributeEnum.AttackBar);
end

function AttributeSystem:GetAttribute(key)
	return self.mAttributes[key] or 0;
end

function AttributeSystem:GetBaseAttribute(key)
	return self.mBaseAttributes[key] or 0;
end

function AttributeSystem:SetAttribute(key,value)
	self.mAttributes[key] = value;
	self:GetActor():Notify(key,value);
end

function AttributeSystem:UpdateHealth(value)
	local health = math.min(value,self:GetHealthLimit());
	self.mHealth = health
	self:SetAttribute(mAttributeEnum.Health,health);
	self:GetActor():Notify(mNotifyEnum.Health,self:GetHealthPersent());
end

function AttributeSystem:SetAttackBar(value)
	self.mAttackBar = value;
	self:SetAttribute(mAttributeEnum.AttackBar,value);
end
function AttributeSystem:UpdateAttackBar(value)
	self:SetAttackBar(value);
	self:GetActor():Notify(mNotifyEnum.AttackBar,self:GetAttackBarPersent());
end

function AttributeSystem:UpdateHealthLimit(value)
	local healthLimit = self:GetHealthLimit();
	local health = self:GetHealth();
	if value > healthLimit then
		health = health + value - healthLimit;
	end
	self.mHealthLimit = value;
	self:UpdateHealth(health);
	self:SetAttribute(mAttributeEnum.HealthLimit,value);
end

function AttributeSystem:IsAlive()
	return self:GetHealth() > 0;
end

function AttributeSystem:GetModifyAttribute(valueType,includeTemp,ignoreBuffType)

	local tempModifier = includeTemp and self:GetTempModifier(valueType) or nil;
	if not ignoreBuffType and not tempModifier then
		return self:GetAttribute(valueType);
	end

	local modifier = self:GetTotalModifier();

	modifier:AddModifier(self:GetModifier(valueType,ignoreBuffType));
	modifier:AddModifier(tempModifier);

	return self.mBaseAttributes:GetModifyAttribute(modifier,valueType);
end

function AttributeSystem:GetModifier(valueType,ignoreBuffType)
	local modification = self:GetModification(valueType);
	if modification then
		return modification:GetModifierIgnoreType(ignoreBuffType);
	end
end

function AttributeSystem:GetTotalModifier()
	local modifier = self.mModifier;
	if modifier then
		modifier:Dispose();
	else
		modifier = AttributeModifier.LuaNew();
		self.mModifier = modifier;
	end
	return modifier;
end

function AttributeSystem:GetModification(valueType)
	local modifications = self.mModifications;
	if not modifications then
		return nil;
	end
	return modifications[valueType];
end

function AttributeSystem:OnRebuildExtraAttribute(valueType,modifier,extraAttribute,actionName)
	--print(self:GetActor().mName,"Before"..actionName,valueType,self:GetAttribute(valueType),extraAttribute:GetBlendType(),extraAttribute:GetValue());
	if valueType == mAttributeEnum.HealthLimit then
		self:UpdateHealthLimit(self.mBaseAttributes:GetModifyAttribute(modifier,valueType));
	else
		self:SetAttribute(valueType,self.mBaseAttributes:GetModifyAttribute(modifier,valueType));
	end
	--print(self:GetActor().mName,"After"..actionName,valueType,self:GetAttribute(valueType),extraAttribute:GetBlendType(),extraAttribute:GetValue());
end

function AttributeSystem:AddExtraAttribute(extraAttribute)
    local valueType = extraAttribute:GetValueType();
	local modifications = self.mModifications;
	if not modifications then
		modifications = {};
		self.mModifications = modifications;
	end
	local modification = modifications[valueType];
	if not modification then
		modification = Modification.LuaNew();
		modifications[valueType] = modification;
	end
	modification:AddExtraAttribute(extraAttribute,function (modifier)
		self:OnRebuildExtraAttribute(valueType,modifier,extraAttribute,"AddExtraAttribute");
	end);

end

function AttributeSystem:RemoveExtraAttribute(extraAttribute)
	local valueType = extraAttribute:GetValueType();
	local modification = self:GetModification(valueType);
	if not modification then
		return;
	end
	modification:RemoveExtraAttribute(extraAttribute,function (modifier)
		self:OnRebuildExtraAttribute(valueType,modifier,extraAttribute,"RemoveExtraAttribute");
	end);
end

function AttributeSystem:AddTempAttribute(blendType,valueType,value)
	local modifiers = self.mTempModifiers;
	if not modifiers then
		modifiers = {};
		self.mTempModifiers = modifiers;
	end
	local modifier = modifiers[valueType];
	if not modifier then
		modifier = AttributeModifier.LuaNew();
		modifiers[valueType] = modifier;
	end
	modifier:Add(blendType,value);
	--print("AddTempAttribute---------->",blendType,valueType,value);
end

function AttributeSystem:GetTempModifier(valueType)
	local modifiers = self.mTempModifiers;
	if not modifiers then
		return nil;
	end
	return modifiers[valueType];
end

function AttributeSystem:ResetTempModifier()
	self.mTempModifiers = nil;
end

return AttributeSystem;