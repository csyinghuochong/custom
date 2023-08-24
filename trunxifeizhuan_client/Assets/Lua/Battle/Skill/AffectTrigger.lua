local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local List = require "Common/List"
local ExtraAttribute = require"Battle/Attribute/ExtraAttribute"
local AffectTrigger = LuaClass("AffectTrigger",BaseLua);
local mGetTargetForAffectTrigger = require "Battle/Skill/GetTargetForAffectTrigger";
local mEventDispatcher = require "Events/EventDispatcher"
local mEventEnum = require "Enum/EventEnum"
local mBuffManager = require "Battle/Manager/BuffManager";
local mAttributeBlendEnum = require "Enum/AttributeBlendEnum"
local mAttributeEnum = require "Enum/AttributeEnum"
local mSkillResultEnum = require "Enum/SkillResultEnum"
local mBuffStateEnum = require"Enum/BuffStateEnum"
local mDoFileUtil = require "Utils/DoFileUtil";

local mTestBattle = require "Battle/Test/TestBattle";
local Debugger = Debugger;
local pairs = pairs;
local ipairs = ipairs;
local math = math;

function AffectTrigger:OnLuaNew()
	self:InitAffects();
end

function AffectTrigger:InitAffects()
	self.mAffects = 
	{
		[101] = function (affect,skillHit) self:AddBuff(affect,skillHit) end;

		[102] = function (affect,skillHit) self:RemoveBuff(affect,skillHit) end;

		[103] = function (affect,skillHit) self:RobBuffs(affect,skillHit) end;

		[104] = function (affect,skillHit) self:TransferBuffs(affect,skillHit) end;

		[105] = function (affect,skillHit) self:AddSkillHurtRate(affect,skillHit) end;

		[106] = function (affect,skillHit) self:AddHurtByAttackSpeed(affect,skillHit) end;

		[107] = function (affect,skillHit) self:IgnoreDefense(affect,skillHit) end;

		[108] = function (affect,skillHit) self:IgnoreCamp(affect,skillHit) end;

		[109] = function (affect,skillHit) self:AddAttackBar(affect,skillHit) end;

		[111] = function (affect,skillHit) self:SuckAttackBar(affect,skillHit) end;

		[112] = function (affect,skillHit) self:MakeSureCrit(affect,skillHit) end;

		[113] = function (affect,skillHit) self:AddAttribute(affect,skillHit) end;

		[114] = function (affect,skillHit) self:ModifySkillHitAttribute(affect,skillHit) end;

		[115] = function (affect,skillHit) self:CounterAttack(affect,skillHit) end;

		[116] = function (affect,skillHit) self:DestroyHealthLimit(affect,skillHit) end;

		[117] = function (affect,skillHit) self:ComboAttack(affect,skillHit) end;

		[118] = function (affect,skillHit) self:Relive(affect,skillHit) end;

		[119] = function (affect,skillHit) self:Relive(affect,skillHit) end;

		[121] = function (affect,skillHit) self:ModifyCD(affect,skillHit) end;

		[123] = function (affect,skillHit) self:ModifyBuffTime(affect,skillHit) end;

		[127] = function (affect,skillHit) self:DoAffect_127(affect,skillHit) end;

		[128] = function (affect,skillHit) self:AskForAssist(affect,skillHit) end;

		[129] = function (affect,skillHit) self:ReduceHealth(affect,skillHit) end;

		[130] = function (affect,skillHit) self:DoAffect_130(affect,skillHit) end;

		[131] = function (affect,skillHit) self:DoAffect_131(affect,skillHit) end;

		[132] = function (affect,skillHit) self:DoAffect_132(affect,skillHit) end;

		[133] = function (affect,skillHit) self:DoAffect_133(affect,skillHit) end;

		[134] = function (affect,skillHit) self:RecoverHealth(affect,skillHit) end;

		[135] = function (affect,skillHit) self:DoAffect_135(affect,skillHit) end;

		[136] = function (affect,skillHit) self:DoAffect_136(affect,skillHit) end;

		[137] = function (affect,skillHit) self:DoAffect_137(affect,skillHit) end;

		[138] = function (affect,skillHit) self:DoAffect_138(affect,skillHit) end;

		[139] = function (affect,skillHit) self:DoAffect_139(affect,skillHit) end;

		[141] = function (affect,skillHit) self:DoAffect_141(affect,skillHit) end;

		[143] = function (affect,skillHit) self:DoAffect_143(affect,skillHit) end;

		[145] = function (affect,skillHit) self:DoAffect_145(affect,skillHit) end;

		[146] = function (affect,skillHit) self:DoAffect_146(affect,skillHit) end;

		[147] = function (affect,skillHit) self:DoAffect_147(affect,skillHit) end;
	}
end

function AffectTrigger:SetParams(skillHit)
	self.mSkill = skillHit.mSkill;
end

function AffectTrigger:GetSkill()
	return self.mSkill;
end

function AffectTrigger:GetEffectHitRate(skillHit,isEffectHit)
	if isEffectHit then
		return skillHit.hit and skillHit.effect_hit_rate or 0;
	end
	return 1;
end

function AffectTrigger:Done()
	local skill = self:GetSkill();
	if skill.mPassive then
		skill:BeginColdDown();
	end
end

function AffectTrigger:GetAffect(type)
	return self.mAffects[type];
end

function AffectTrigger:GetTarget(targetType,skillHit)
	return mGetTargetForAffectTrigger:GetTarget(targetType,skillHit);
end

function AffectTrigger:GetBuffCountOfType(target,buffType)
	local buffsOfType = target:GetBuffsOfType(buffType);
	if buffsOfType then
		return buffsOfType.mLength;
	end
	return 0;
end

function AffectTrigger:DoHit(cls,target,baseParams,extraParams)
	if target then
		local hit = mDoFileUtil:DoFile("Battle/Skill/SkillHit/"..cls).LuaNew(self:GetSkill(),baseParams);
		hit:Excute(target,extraParams);
	end
end

function AffectTrigger:GetLastAttackResultHurt(target)
	local lastAttackResult = target:GetLastAttackResult();
	if lastAttackResult then
		return lastAttackResult.hurt;
	end
	return 0;
end

function AffectTrigger:GetLastBeAttackResultHurt(target)
	local lastBeAttackResult = target:GetLastBeAttackResult();
	if lastBeAttackResult then
		return lastBeAttackResult.hurt;
	end
	return 0;
end

function AffectTrigger:AddTempAttribute(target,blendType,valueType,value)
    target:AddTempAttribute(blendType,valueType,value);
end

-----------------------------------------GetResult-----------------------------------------------
function AffectTrigger:GetAddBuffResult(id,target,skill)

	if mBuffManager:CanAddBuffToActor(target,id) == false then
		return nil;
	end

	local result = {};
	local buff = mBuffManager:GetBuffById(id);
	buff:SetParams(target,skill);
	buff.mId = id;

	result.target = target;
	result.buff = buff;
	result.type = mSkillResultEnum.AddBuff;
	return result;
end

function AffectTrigger:GetRemoveBuffResult(buff)
	local result = {};
	result.target = buff.mOwner;
	result.buff = buff;
	result.type = mSkillResultEnum.RemoveBuff;
	return result;
end

function AffectTrigger:GetReliveResult(atk,target)
	local result = {};
	result.target = target;
	result.atk = atk;
	result.type = mSkillResultEnum.Relive;
	return result;
end

function AffectTrigger:GetDivideEquallyHealthResult(target,p)
	local result = {};
	result.target = target;
	result.health = p;
	result.type = mSkillResultEnum.DivideEquallyHealth;
	return result;
end

function AffectTrigger:GetHurtResult(atk,def,hurt,type)
	local result = {};
	result.atk = atk;
	result.def = def;
	result.hurt = hurt;
	result.type = type;
	return result;
end


function AffectTrigger:GetExtraAttribute(blendType,valueType,value)
	local extraAttribute = ExtraAttribute.LuaNew(blendType,valueType,value);
	extraAttribute:SetForbidType(false);
	extraAttribute:SetSkill(self:GetSkill());
	return extraAttribute;
end

function AffectTrigger:GetAddExtraAttributeResult(target,affect)

	local limit = affect.value3;
	if limit > 1 then
		local component = target:FindAndAddComponent("AffectCounter");
		if component:GetAffectCount(affect) < limit then
			component:AddAffectCount(affect);
		else
			return;
		end
	end

	local result = {};
	result.target = target;
	result.extraAttribute = self:GetExtraAttribute(affect.value4,affect.value1,affect.value2/100);
	result.type = mSkillResultEnum.AddExtraAttribute;
	return result;
end

--按照某属性比例增加体力上限: value1 = 某属性类型, value2 = 系数 
function AffectTrigger:GetResultForAffect127(target,affect)

	local value = target:GetBaseAttribute(affect.value1) * affect.value2/100;
	local blendType = mAttributeBlendEnum.INCREASE_SUM;
	local valueType = mAttributeEnum.HealthLimit;

	local result = {};
	result.target = target;
	result.extraAttribute = self:GetExtraAttribute(blendType,valueType,value);
	result.type = mSkillResultEnum.AddExtraAttribute;
	return result;
end

-----------------------------------------------Effects-----------------------------------------------------
--添加BUFF
function AffectTrigger:AddBuff(affect,skillHit)

	local target = self:GetTarget(affect.target,skillHit);
	if target then
		skillHit:AddResult(self:GetAddBuffResult(affect.value1,target,self:GetSkill()));
	end
end

function AffectTrigger:RemoveBuffs(actor,buffType,count,removeCallback)

	local buffsOfType = actor:GetBuffsOfType(buffType);
	if buffsOfType then
		local removeCount = 0;
		local callback = function (buff)
		    buff:SendFinish();
			removeCallback(buff);
			removeCount = removeCount + 1;
			return removeCount >= count
		end
		buffsOfType:ReForeach(callback);
	end
end

--移除BUFF
function AffectTrigger:RemoveBuff(affect,skillHit)

	local target = self:GetTarget(affect.target,skillHit);
	local atk = skillHit.atk;
	if target then
		local removeCallback = function (buff)
			--skillHit:AddResult(self:GetRemoveBuffResult(buff));
			atk:NotifyRemoveTargetState(skillHit);
		end;
		self:RemoveBuffs(target,affect.value1,affect.value2,removeCallback);
	end
	
end

--抢夺增益buff
function AffectTrigger:RobBuffs(affect,skillHit)
	local skill = self:GetSkill();
	local src = skillHit.def;
	local dst = skillHit.atk;

	local removeCallback = function (buff)
	    --skillHit:AddResult(self:GetRemoveBuffResult(buff));
		skillHit:AddResult(self:GetAddBuffResult(buff.mId,dst,skill));
		dst:NotifyRemoveTargetState(skillHit);
	end
	self:RemoveBuffs(src,1,affect.value1,removeCallback);
end

--转移负面BUFF
function AffectTrigger:TransferBuffs(affect,skillHit)
	local skill = self:GetSkill();
	local dst = skillHit.def;
	local src = skillHit.atk;
	local removeCallback = function (buff)
	    --skillHit:AddResult(self:GetRemoveBuffResult(buff));
		skillHit:AddResult(self:GetAddBuffResult(buff.mId,dst,skill));
	end
	self:RemoveBuffs(src,2,affect.value1,removeCallback);
end

--增加技能系数
function AffectTrigger:AddSkillHurtRate(affect,skillHit)
	skillHit.atk:SetHitAttribute(mAttributeEnum.ExtraSkillRatio,affect.value1/100);
end

--每点攻速增加X伤害
function AffectTrigger:AddHurtByAttackSpeed(affect,skillHit)
	local target = skillHit.atk;
    local attackSpeed = target:GetAttribute(mAttributeEnum.AttackSpeed);
    local value = math.min(attackSpeed * affect.value1/1000,affect.value2/1000);
    self:AddTempAttribute(target,mAttributeBlendEnum.INCREASE_SUM,mAttributeEnum.HurtRate,value);
end

--无视防御
function AffectTrigger:IgnoreDefense(affect,skillHit)
	skillHit.atk:SetHitAttribute(mAttributeEnum.IgnoreDefense,true);
end

--无视阵营
function AffectTrigger:IgnoreCamp(affect,skillHit)
	skillHit.atk:SetHitAttribute(mAttributeEnum.IgnoreCamp,true);
end

--必定暴击
function AffectTrigger:MakeSureCrit(affect,skillHit)
	self:AddTempAttribute(skillHit.atk,mAttributeBlendEnum.INCREASE_SUM,mAttributeEnum.CritRate,1000);
end

--改变属性伤害计算系数,value1 = 属性类型,value2 = 系数 value4 = 属性混合类型
function AffectTrigger:ModifySkillHitAttribute(affect,skillHit)
	local target = self:GetTarget(affect.target,skillHit);
	self:AddTempAttribute(target,affect.value4,affect.value1,affect.value2/100);
end

--增加or减少攻击条
function AffectTrigger:AddAttackBar(affect,skillHit)
	local target = self:GetTarget(affect.target,skillHit);
	if target then
		self:DoHit("AttackBarHit",target,affect.value1/100);
	end
end

--吸取攻击条
function AffectTrigger:SuckAttackBar(affect,skillHit)
	local target = skillHit.def;
	if target then
		local value = math.min(target:GetAttackBarPersent(),affect.value1/100);
		self:DoHit("AttackBarHit",target,-value);
		self:DoHit("AttackBarHit",skillHit.atk,value);
	end
end

--叠加属性,value1 = 属性类型,value2 = 每次增加系数 value3 = 叠加层数上限 value4 = 属性混合类型
function AffectTrigger:AddAttribute(affect,skillHit)
	local target = self:GetTarget(affect.target,skillHit);
	if target then
		skillHit:AddResult(self:GetAddExtraAttributeResult(target,affect));
	end
end

--反击 value1 = 以X技能反击
function AffectTrigger:CounterAttack(affect,skillHit)

	local atk = skillHit.atk;
	if atk:HasAction("CounterAttack") then
		return;
	end
	
	local owner = self:GetSkill().mOwner;
	if owner.mTeam == atk.mTeam then
		return;
	end

	atk:FindAndAddComponent("CounterAttackRequest"):AddCounterAttack(owner,affect.value1);
end

--按照伤害量比例破坏生命上限
function AffectTrigger:DestroyHealthLimit(affect,skillHit)
	skillHit.atk:SetHitAttribute(mAttributeEnum.DestroyHealthLimit,affect.value1/100);
end

--增加or减少CD
function AffectTrigger:ModifyCD(affect,skillHit)
	local target = self:GetTarget(affect.target,skillHit);
	if target then
		local mNotifyEnum = target:GetNotifyEnum();
		target:Notify(mNotifyEnum.OnModifySkillCD,{-affect.value1,affect.value2});
	end
end

--增加or减少BUFF回合
function AffectTrigger:ModifyBuffTime(affect,skillHit)
	local target = self:GetTarget(affect.target,skillHit);
	if target then
		local mNotifyEnum = target:GetNotifyEnum();
		target:Notify(mNotifyEnum.OnModifyBuffTime,{affect.value1,affect.value2});
	end
end

--联合己方一名成员攻击敌方目标
function AffectTrigger:AskForAssist(affect,skillHit)
	local skill = self:GetSkill();
	local request = skill.mOwner:FindAndAddComponent("AssistRequest");
	request:AskForAssist(affect.value1,skill.mTarget);
end

--连击
function AffectTrigger:ComboAttack(affect,skillHit)
	self:GetSkill():SetComboAttack(affect.value1);
end

--复活其
function AffectTrigger:Relive(affect,skillHit)
	local target = self:GetTarget(affect.target,skillHit);
	if target:Reliveable() then
		skillHit:AddResult(self:GetReliveResult(self:GetSkill().mOwner,target));
	end
end

--按照某属性比例增加体力上限: value1 = 某属性类型, value2 = 系数 
function AffectTrigger:DoAffect_127(affect,skillHit)
	skillHit:AddResult(self:GetResultForAffect127(self:GetSkill().mOwner,affect));
end

--回血
function AffectTrigger:RecoverHealth(affect,skillHit)
	local target = self:GetTarget(affect.target,skillHit);
	self:DoHit("RecoverHealthHit",target,affect.value1/100);
end

--减血,value1 = 系数,value2 = 按当前生命还是生命上限
function AffectTrigger:ReduceHealth(affect,skillHit)
	local target = self:GetTarget(affect.target,skillHit);
	self:DoHit("ReduceHealthHit",target,affect.value1/100,target:GetAttribute(affect.value2));
end

--根据上次的伤害为比例为目标回血: value1 = 系数 
function AffectTrigger:DoAffect_131(affect,skillHit)
	local target = self:GetTarget(affect.target,skillHit);
	self:DoHit("RecoverHealthHit",target,affect.value1/100,self:GetLastAttackResultHurt(self:GetSkill().mOwner));
end

--根据上次受到的伤害为比例对目标造成伤害: value1 = 系数 
function AffectTrigger:DoAffect_141(affect,skillHit)
	local target = self:GetTarget(affect.target,skillHit);
	self:DoHit("ReduceHealthHit",target,affect.value1/100,self:GetLastBeAttackResultHurt(self:GetSkill().mOwner));
end

--根据A的X属性的百分比为伤害对B造成伤害: value1 = 属性类型, value2 = 系数 ,value3 = 参考方 0-攻方 1-守方 
function AffectTrigger:DoAffect_135(affect,skillHit)
	local targetA = affect.value3 == 0 and skillHit.atk or skillHit.def;
	local targetB = self:GetTarget(affect.target,skillHit);
	self:DoHit("ReduceHealthHit",targetB,affect.value2/100,targetA:GetAttribute(affect.value1));
end

--体力越低伤害越高: value1 = 系数1 value2 = 系数2 value3 = 属性类型 value4 = 混合类型
--增加值=计算系数1-自身当前生命值% + 计算系数2-目标当前生命%
function AffectTrigger:DoAffect_130(affect,skillHit)
	local value = (1 - skillHit.atk:GetHealthPersent()) * affect.value1/100 + (1 - skillHit.def:GetHealthPersent()) * affect.value2/100;
	self:AddTempAttribute(self:GetTarget(affect.target,skillHit),affect.value4,affect.value3,value);
end

--拥有正面效果时每个效果增加属性: value1 = 属性类型, value2 = 系数 ,value3 = 混合类型 value4 = 参考方 0-攻方 1-守方 
function AffectTrigger:DoAffect_132(affect,skillHit)
	local atk = skillHit.atk;
	local target = affect.value4 == 0 and atk or skillHit.def;
	local value2 = (affect.value2/100)*self:GetBuffCountOfType(target,1);
	self:AddTempAttribute(atk,affect.value3,affect.value1,value2);
end

--拥有负面效果时每个效果增加属性: value1 = 属性类型, value2 = 系数 ,value3 = 混合类型 value4 = 参考方 0-攻方 1-守方 
function AffectTrigger:DoAffect_138(affect,skillHit)
	local atk = skillHit.atk;
	local target = affect.value4 == 0 and atk or skillHit.def;
	local value2 = (affect.value2/100)*self:GetBuffCountOfType(target,2);
	self:AddTempAttribute(atk,affect.value3,affect.value1,value2);
end

--额外属性附加伤害: value1 = 属性类型, value2 = 系数 ,value3 = 参考方 0-攻方 1-守方 
function AffectTrigger:DoAffect_133(affect,skillHit)
	local target = affect.value3 == 0 and skillHit.atk or skillHit.def;
	skillHit.atk:AddHitAttribute(mAttributeEnum.ExtraHurt,target:GetAttribute(affect.value1) * affect.value2/1000);
end

--每个死亡队友增加属性: value1 = 属性类型, value2 = 系数 ,value4 = 混合类型 
function AffectTrigger:DoAffect_136(affect,skillHit)
	local target = self:GetSkill().mOwner;
	local deadTeamMateCount = target:GetDeadTeamMates().mLength;
	self:AddTempAttribute(target,affect.value4,affect.value1,deadTeamMateCount*affect.value2/100);
end

--平均分配生命: value1 = 1-单体 2-全体
function AffectTrigger:DoAffect_137(affect,skillHit)
	local skill = self:GetSkill();

	local divideEqually = function (actor,p)
		skillHit:AddResult(self:GetDivideEquallyHealthResult(actor,p));
	end
	if affect.value1 == 1 then
		self:DivideEquallyHealthBoth(skill.mOwner,skill.mTarget,divideEqually);
	else
		self:DivideEquallyHealth(skill.mOwner:GetTeamMates(),divideEqually);
	end
end

function AffectTrigger:DivideEquallyHealthBoth(actor1,actor2,callback)
	local totalHealth = actor1:GetHealthPersent() + actor2:GetHealthPersent();
	local p = totalHealth/2;
	callback(actor1,p);
	callback(actor2,p);
end

function AffectTrigger:DivideEquallyHealth(list,callback)
	if list.mLength == 0 then
		return;
	end
	local totalHealth = 0;
	local addTotalHealth = function (actor)
		totalHealth = totalHealth + actor:GetHealthPersent();
	end
	list:Foreach(addTotalHealth);
	
	local p = totalHealth/list.mLength;
	local divideEqually = function (actor)
		callback(actor,p);
	end
	list:Foreach(divideEqually);
end

--单次承受伤害不超过体力上限%: value1 = 系数
function AffectTrigger:DoAffect_139(affect,skillHit)
	skillHit.atk:SetHitAttribute(mAttributeEnum.HurtLimit,skillHit.def:GetHealthLimit() * affect.value1 / 100);
end

--触发受击: value1 = 对指定目标用第几个受击
function AffectTrigger:DoAffect_143(affect,skillHit)
	local target = self:GetTarget(affect.target,skillHit);
	self:GetSkill():PassiveOnCheck(target,affect.value1);
end

function AffectTrigger:DoAffect_145(affect,skillHit)
	self:GetTarget(affect.target,skillHit):ForbidRelive();
end

--无视正面BUFF
function AffectTrigger:DoAffect_146(affect,skillHit)
	skillHit.atk:SetHitAttribute(mAttributeEnum.IgnoreBuffType,1);
end

--每损失%生命加%攻击条:value1 = 每损失的生命百分比，value2 = 增加攻击条系数
function AffectTrigger:DoAffect_147(affect,skillHit)

	local target = skillHit.def;
	local component = target:FindAndAddComponent("AffectCounter");
	local tap = target:GetHealthLimit() * affect.value1/100;
	local value = affect.value2/100;
	local reduceHealth = skillHit.reduceHealth or 0;
	local totalReduceHealth = reduceHealth + component:GetLastRedcueHealth(affect);
	local total = 0;
	
	while (totalReduceHealth > tap) do
		totalReduceHealth = totalReduceHealth - tap;
		total = total + value;
	end

	if total > 0 then
		component:ResetLastReduceHealth(affect);
		self:DoHit("AttackBarHit",skillHit.def,total);
		self.mFail = nil;
	else
		component:AddLastReduceHealth(affect,reduceHealth);
		self.mFail = true;
	end
end

return AffectTrigger.LuaNew();