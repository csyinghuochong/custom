local BaseLua = require "Core/BaseLua"
local mLuaClass = require "Core/LuaClass"
local ActorTypeEnum = require "Module/Combat/ActorTypeEnum"
local mConfigSysactor = require "ConfigFiles/ConfigSysactor"
local mConfigSysrobot = require "ConfigFiles/ConfigSysrobot"
local mConfigSysmonster = require "ConfigFiles/ConfigSysmonster"
local FollowerBaseVO = require "Module/Follower/FollowerBaseVO"
local mFollowerSkillVO = require "Module/Follower/FollowerSkillVO"
local mConfigSysmonsterBase = require "ConfigFiles/ConfigSysmonster_base"
local mConfigSysmonsterRatio = require "ConfigFiles/ConfigSysmonster_ratio"
local RobotBaseVO = mLuaClass("RobotBaseVO", FollowerBaseVO);

--构造机器人
function RobotBaseVO:InitRobotActorVO(lead, robot, partnerVo)
	local id = partnerVo.monster_id;
	local level = partnerVo.lv;
	local monsterType = partnerVo.type;
	
	self.mUID = id;
	local monsterVO = mConfigSysmonster[id];
	if monsterVO == nil then
		print('configSysmonster==nil:id...', id)
	end

	self.mRobotVO = monsterVO;
	self.mID = monsterVO.monster;
	local actorVO = mConfigSysactor[monsterVO.monster];
	self.mActorVO = actorVO;
	self.mLevel = level;
	self.mStar = actorVO.star;
	self.mModelId = monsterVO.position;
	self.mOffice = monsterVO.position;
	self.mPowerID = monsterVO.camp;
	self.mSex = actorVO.sex;
	self.mActorType = lead and ActorTypeEnum.ActorLead or ActorTypeEnum.ActorFollower;
	self.mName = lead and robot.name or actorVO.name;

	self:InitRobotSkillList();
	self:CalculateRobotAttri(level, monsterType);
end

--计算机器人属性
function RobotBaseVO:CalculateRobotAttri(level,monsterType)
	local totalAttri = self.mTotalAttri;
	local key = string.format("%d_%d", level, monsterType);

    local ratio = mConfigSysmonsterRatio[self.mRobotVO.monster].attribute_ratio;
    local baseAttri = mConfigSysmonsterBase[key].base_attri;
    for i,v in ipairs(baseAttri) do
    	totalAttri[i] = v.value * ratio[i];
    end
end

function RobotBaseVO:GetCombatModel(  )
	return self.mRobotVO.model;
end

function RobotBaseVO:GetUIModel( id )
	return self.mRobotVO.model;
end

function RobotBaseVO:GetMiniIcon()
	return self.mRobotVO.mini_icon;
end

--初始化机器人技能列表
function RobotBaseVO:InitRobotSkillList()
	local skills = self.mRobotVO.skills;
	local skill_list = {};
	local skill_index = {};

	for k, v in pairs(skills) do
		local skill_vo = mFollowerSkillVO.LuaNew(v, 1, 1, true, self);
		skill_list[v] = skill_vo;
		skill_index[skill_vo.mSkillInfo.position] = skill_vo;
	end

	self.mSkillList = skill_list;
	self.mSkillToIndex = skill_index;
end

function RobotBaseVO:GetRobotSex( robot_id )
	local robot = mConfigSysrobot[robot_id];
	local lead = robot.partner_list[1].monster_id;
	local monsterVO = mConfigSysmonster[lead];
	return mConfigSysactor[monsterVO.monster].sex;
end

function RobotBaseVO:GetRobotLevel( robot_id )
	local robot = mConfigSysrobot[robot_id];
	return robot.partner_list[1].lv;
end

return RobotBaseVO;