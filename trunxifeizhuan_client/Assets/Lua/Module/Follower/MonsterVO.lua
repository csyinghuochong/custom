local mLuaClass = require "Core/LuaClass"
local ActorTypeEnum = require "Module/Combat/ActorTypeEnum"
local mFollowerBaseVO = require"Module/Follower/FollowerBaseVO"
local mConfigSysmonster = require "ConfigFiles/ConfigSysmonster"
local mConfigSysmonsterRatio = require "ConfigFiles/ConfigSysmonster_ratio"
local mConfigSysmonsterBase = require "ConfigFiles/ConfigSysmonster_base"
local mFollowerSkillVO = require "Module/Follower/FollowerSkillVO"
local mFollowerBaseVO = require "Module/Follower/FollowerBaseVO"
local MonsterVO = mLuaClass("MonsterVO", mFollowerBaseVO);

function MonsterVO:OnLuaNew(id, level,monsterType, actor_type)
	self:InitData(id, level,monsterType, actor_type)
end

--construction 
--构造野怪
function MonsterVO:InitData(id, level,monsterType, actor_type )
	self.mUID = id;
	self.mID = id;
	local actorVO = mConfigSysmonster[id];
	if actorVO == nil then
		print('无效的野怪id...', id)
	end
	self.mActorVO = actorVO;
	self.mName = actorVO.name;
	self.mLevel = level;
	self.mStar = 1;
	self.mExp = 0;
	self.mModelId = 1;
	self.mOffice = 1;
	self.mTotalAttri = {};
	self.mPowerID = actorVO.camp;
	self.mActorType = actor_type or ActorTypeEnum.ActorMonster;
	
	self:InitSkillList();
	self:CalculateAttri(level,monsterType);
end

function MonsterVO:CalculateAttri(level,monsterType)
	local totalAttri = self.mTotalAttri;
	local key = string.format("%d_%d", level, monsterType);
    local ratio = mConfigSysmonsterRatio[self.mActorVO.monster].attribute_ratio;
    local baseAttri = mConfigSysmonsterBase[key].base_attri;
    for i,v in ipairs(baseAttri) do
    	totalAttri[i] = v.value * ratio[i];
    end
end

function MonsterVO:GetCombatModel(  )
	return self.mActorVO.model;
end

function MonsterVO:GetUIModel( id )
	return self.mActorVO.model;
end

function MonsterVO:GetOfficeName()
	return self.mActorVO.name;
end

function MonsterVO:GetMiniIcon()
	return self.mActorVO.mini_icon;
end

function MonsterVO:InitSkillList()
	local skills = self.mActorVO.skills;
	local skill_list = {};
	local skill_index = {};

	for k, v in pairs(skills) do
		local skill_vo = mFollowerSkillVO.LuaNew(v, 1, 1, true);
		skill_list[v] = skill_vo;
		skill_index[skill_vo.mSkillInfo.position] = skill_vo;
	end

	self.mSkillList = skill_list;
	self.mSkillToIndex = skill_index;
end

return MonsterVO;