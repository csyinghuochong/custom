local LuaClass = require "Core/LuaClass"
local SkillHit = LuaClass("SkillHit",BaseLua);
local mBattleController = require "Battle/Combat/BattleController"
local mNotifyEnum = require "Enum/NotifyEnum"

local pairs = pairs;
local ipairs = ipairs;
local table = table;

function SkillHit:OnLuaNew(skill,config,index,isPassive)
	self.mSkill = skill;
	self.mIndex = index;
	self.mConfig = config;
	self.mIsPassive = isPassive;
	self.mActor = skill.mOwner;
	local hitSystem = skill.mOwner:FindAndAddComponent("HitSystem");
	hitSystem:AddAffectTriggers(self,config.effect_triggers);
	self.mHitSystem = hitSystem;
end

function SkillHit:GetSkill()
	return self.mSkill;
end

function SkillHit:GetActor()
	return self.mActor;
end

function SkillHit:IsPassive()
	return self.mIsPassive;
end

function SkillHit:GetBattleController()
	return mBattleController;
end

function SkillHit:AddResult(result)
	if result then
		mBattleController:AddSkillResult(result);
	end
end

function SkillHit:TriggerOn(triggerType)
	local hitSystem = self.mHitSystem;
	if hitSystem then
		hitSystem:TriggerAffect(self,triggerType);
	end
end

function SkillHit:SetParams(atk,def)
	self.atk = atk;
	self.def = def;
end

function SkillHit:ResetTempAttribute(atk,def)
	atk:ResetTempAttribute();
	def:ResetTempAttribute();
end



function SkillHit:Calculate(atk,def,extraBaseValue)
	self.hit = true;
	self.hurt = 0;
	self.effect_hit_rate = 1;
end

function SkillHit:ApplyResult(atk,def)
	self.mSkill:ShowHitEffect(self.mIndex,def,false);
end

function SkillHit:DispatchBeforeCaculate()
end

function SkillHit:DispatchAfterCaculate()
end

function SkillHit:DispatchHitResults()
	mBattleController:SendHitResults();
end

function SkillHit:DispatchHitCompleted()
end

function SkillHit:Excute(def,extraBaseValue)
	local atk = self:GetActor();
	self:ResetTempAttribute(atk,def);
	self:SetParams(atk,def);
	self:TriggerOn(101);
	self:DispatchBeforeCaculate();
	self:Calculate(atk,def,extraBaseValue);
	self:TriggerOn(102);
	self:DispatchAfterCaculate();
	self:ApplyResult(atk,def);
	self:DispatchHitResults();
	self:TriggerOn(104);
	self:DispatchHitCompleted();
end

function SkillHit:CanTrigger()
	local skill = self:GetSkill();
	if skill:IsPassiveSkill() == false then
		return true;
	end
	return skill:IsColdDown();
end

function SkillHit:PassiveExcute(atk,def,triggerType,dispatchResults)
	if self:CanTrigger() == false then
		return;
	end
	self:SetParams(atk,def);
	self:TriggerOn(triggerType);
	self:DispatchHitResults();
end

function SkillHit:ShieldReduceHurt(actor,hurt)
	if hurt > 0 then
		local result = {hurt = hurt,reduce = 0};
		actor:Notify(mNotifyEnum.OnShieldReduceHurt,result);
		hurt = hurt - result.reduce;
	end
	return hurt;
end

return SkillHit;