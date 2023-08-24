local LuaClass = require "Core/LuaClass"
local ActorObserver = require "Battle/Component/ActorObserver"
local Skill = require "Battle/Skill/Skill"
local SkillSystem = LuaClass("SkillSystem",ActorObserver);
local pairs = pairs;
local ipairs = ipairs;
local table = table;

function SkillSystem:Awake()
	self.mSkills = {};
	self.mSkillCount = 0;
	self:AddSkills(self:GetActor().mActorVo.mSkills);
	self:AddObservers();
end

function SkillSystem:AddObservers()
	local mNotifyEnum = self:GetNotifyEnum();
	self:RegisterListener(mNotifyEnum.OnStartRound,function ()
		self:ModifyAllSkillCD(1);
	end);
	self:RegisterListener(mNotifyEnum.OnSelectSkill,function (index)
		self:OnSelectSkill(index);
	end);
	self:RegisterListener(mNotifyEnum.OnUseSkill,function (target)
		self:OnUseSkill(target);
	end);
	self:RegisterListener(mNotifyEnum.OnClearStage,function (params)
		self:OnClearStage(params);
	end);
	self:RegisterListener(mNotifyEnum.OnModifySkillCD,function (params)
		self:OnModifySkillCD(params);
	end);
	self:RegisterListener(mNotifyEnum.OnAssist,function (target)
		self:OnAssist(target);
	end);
	self:RegisterListener(mNotifyEnum.OnCounterAttack,function (target)
		self:OnCounterAttack(target);
	end);
	self:RegisterListener(mNotifyEnum.OnSetCounterAttack,function (index)
		self:SetCounterAttack(index);
	end);
end

function SkillSystem:OnModifySkillCD(params)
	local v = params[1];
	local index = params[2];
	if index > 4 then
		self:ModifyAllSkillCD(v);
	else
		self:ModifySkillCD(v,index);
	end
end
function SkillSystem:OnClearStage(params)
	local reset_cd = params.reset_cd or 0;
	if reset_cd > 0 then
		self:ModifyAllSkillCD(reset_cd);
	end
end
function SkillSystem:InternalAddSkill(skillData)
	local skill = Skill.LuaNew(self:GetActor(),skillData);
	local index = self.mSkillCount + 1;
	skill:SetPosition(index);
	table.insert(self.mSkills,skill);
	self.mSkillCount = index;
end

--添加技能
function SkillSystem:AddSkills(skills)
	for k,v in ipairs(skills) do
		self:InternalAddSkill(v);
	end
end

--添加技能
function SkillSystem:AddSkill(skillData)
	self:InternalAddSkill(skillData);
end

function SkillSystem:AddSpecialSkill(skillData)
	local skills = self.mSpecialSkills;
	if not skills then
		skills = {};
		self.mSpecialSkills = skills;
	end
	local skill = Skill.LuaNew(self:GetActor(),skillData);
	skill:SetPosition(0);
	table.insert(skills,skill);
end

function SkillSystem:Reset()
	local skills = self.mSkills;
	for k,v in ipairs(skills) do
		v:ResetCD();
	end	
end

function SkillSystem:ModifySkillCD(value,index)
	local skill = self.mSkills[index];
	if skill then
		skill:ModifyCD(value);
	end
end

function SkillSystem:ModifyAllSkillCD(value)
	local skills = self.mSkills;
	for k,v in ipairs(skills) do
		v:ModifyCD(value);
	end	
end
function SkillSystem:CanUseSkill(index)
	return self.mSkills[index]:CanUse();
end

function SkillSystem:OnSelectSkill(index)
	self.mSelectedSkill = self.mSkills[index];
end

function SkillSystem:GetSelectedSkill()
	return self.mSelectedSkill;
end

function SkillSystem:GetSkills()
	return self.mSkills;
end

function SkillSystem:SetCounterAttack(index)
	self.mCounterAttack = self.mSkills[index] or self.mSkills[1];
end

function SkillSystem:OnCounterAttack(target)
	self.mCounterAttack:OnUse(target);
end

function SkillSystem:OnAssist(target)
	self.mSkills[1]:OnUse(target);
end

function SkillSystem:CanSelectTarget(target)
	return self.mSelectedSkill:CanSelectTarget(target);
end

function SkillSystem:OnUseSkill(target)
	self.mSelectedSkill:OnUse(target);
end


return SkillSystem;