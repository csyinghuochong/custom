local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local SkillHitResult = LuaClass("SkillHitResult",BaseLua);

local mSkillResultEnum = require "Enum/SkillResultEnum"
local mNotifyEnum = require"Enum/NotifyEnum"
local mEventEnum = require "Enum/EventEnum"
local mCombatWordManager = require "Module/Combat/CombatWordManager";

local DebugHelper = DebugHelper;
local mIsEditor = UnityEngine.Application.isEditor;

local function Clamp(value, min, max)
	if value < min then
		value = min
	elseif value > max then
		value = max    
	end
	
	return value
end

local function GetHurt(hurt)
	if mIsEditor then
		hurt = Clamp(hurt,DebugHelper.sSkillMinHurt,DebugHelper.sSkillMaxHurt);
	end
	return hurt;
end

local function DestroyHealthLimit(actor,destroyHealthLimit)
	if destroyHealthLimit then
		actor:Notify(mNotifyEnum.OnUpdateHealthLimit,destroyHealthLimit);
	end
end

local function DoHurt(result)
	local actor = result.def;
	local hurt = result.hurt;
	local health = actor:GetHealth() - GetHurt(hurt);

	actor:Notify(mNotifyEnum.OnUpdateHealth,health);
	actor:Notify(mNotifyEnum.OnReduceHealth,result);

	if health > 0 then
		DestroyHealthLimit(actor,result.destroyHealthLimit);
	else
		actor:GetCombat():AddKillResult(result);
	end
end

local function ShowHurt(type,hurt,actor)
	if hurt > 0 then
		mCombatWordManager:ShowCombatArtTextWord(type,math.ceil(hurt),actor);
	end
end

local function ShowCombatImageWord(index,target)
	mCombatWordManager:ShowCombatImageWord(11,target);
end

local function HurtResult(result)
	local def = result.def;
	if result.nohurt then
		--ShowCombatImageWord(11);
	else
		local hurt = result.hurt;
		DoHurt(result);
		ShowHurt(1,hurt,def);
	end
end

local function ReverseResult(result)
	if result.nohurt then
		--ShowCombatImageWord(11);
	else
		DoHurt(result);
		ShowHurt(1,result.hurt,result.def);
	end
end

local function CritResult(result)
	if result.nohurt then
		--ShowCombatImageWord(11);
	else
		DoHurt(result);
		ShowHurt(3,result.hurt,result.def);
	end
end

local function TransferResult(result)
	if result.nohurt then
		--ShowCombatImageWord(11);
	else
		DoHurt(result);
		ShowHurt(1,result.hurt,result.def);
	end
end

local function RecoverResult(result)
	if result.norecover then
		ShowCombatImageWord(11,result.def);
	else
		local actor = result.def;
		local recover = GetHurt(result.hurt);
		actor:Notify(mNotifyEnum.OnUpdateHealth,actor:GetHealth() + recover);
		ShowHurt(2,recover,actor);
	end
end

local function DivideEquallyHealthResult(result)
	local actor = result.target;
	actor:Notify(mNotifyEnum.OnUpdateHealth,actor:GetHealthLimit()*result.health);
end

local function ReliveResult(result)
	local target = result.target;
	if target == result.atk then
		target:ReliveSelf();
	else
		target:Relive();
	end
end

local function AddBuffResult(result)
	result.target:Notify(mNotifyEnum.AddBuff,result.buff);
end

local function RemoveBuffResult(result)
	result.target:Notify(mNotifyEnum.RemoveBuff,result.buff);
end

local function ModifyAttackBarResult(result)
	local actor = result.def;
	local addValue = actor:GetAttackBarLimit()*result.value;
	actor:Notify(mNotifyEnum.OnUpdateAttackBar,actor:GetAttackBar()+addValue);
end

local function AddExtraAttributeResult(result)
	result.target:Notify(mNotifyEnum.AddExtraAttribute,result.extraAttribute);
end 

local mResults = {
	[mSkillResultEnum.AddBuff] = AddBuffResult;
	[mSkillResultEnum.RemoveBuff] = RemoveBuffResult;
	[mSkillResultEnum.Hurt] = HurtResult; 
	[mSkillResultEnum.Crit] = CritResult;
	[mSkillResultEnum.Reverse] = ReverseResult;
	[mSkillResultEnum.Transfer] = TransferResult;
	[mSkillResultEnum.Recover] = RecoverResult; 
	[mSkillResultEnum.ModifyAttackBar] = ModifyAttackBarResult; 
	[mSkillResultEnum.Relive] = ReliveResult;
	[mSkillResultEnum.DivideEquallyHealth] = DivideEquallyHealthResult;
	[mSkillResultEnum.AddExtraAttribute] = AddExtraAttributeResult;
}

function SkillHitResult:ExcuteResult(result)
	local func = mResults[result.type];
	if func then
		func(result);
	end
end

return SkillHitResult.LuaNew();