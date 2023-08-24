local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local SkillData = require "Battle/Data/SkillData";
local mConfigSysactor = require"ConfigFiles/ConfigSysactor"
local mGameModelManager = require "Manager/GameModelManager"
local mConfigSysdungeon_play = require "ConfigFiles/ConfigSysdungeon_play"
local mConfigSysgrace_skill_level = require "ConfigFiles/ConfigSysgrace_skill_level"
local mConfigSysfollower_office_up = require"ConfigFiles/ConfigSysfollower_office_up"
local ActorVO = LuaClass("ActorVO",BaseLua);
local pairs = pairs;
local sUniqueId = 0;
local Vector3 = Vector3;
local Quaternion = Quaternion;
local mNormalScale = 1;
local mBossScale = 1;

function ActorVO:OnLuaNew()
	sUniqueId = sUniqueId + 1;
	self.mUniqueId = sUniqueId;
end

function ActorVO:InitActorVO(followerVO, location, team)
	self.mAttri = followerVO:GetTotalAttr();
	self.mActorID = followerVO.mID;
	self.mActorType = followerVO.mActorType;

	local config = followerVO.mActorVO;
	local isLead = followerVO:IsLead();
	local sex = followerVO:GetSex();

	self.mName = config.name;
	self.mCamp = config.camp;

	local skills = {};
	local skillList = followerVO:GetSkillList();
	local index = 1;
	for i,v in pairs(skillList) do
		if v:IsActive() then
			local skill = SkillData.LuaNew(v.mID);
			skill:SetLevel(v.mLevel, v.mActive);
			skills[index] = skill;
			index = index + 1;
		end
	end

	self.mTeam = team;
	self.mSkills = skills;
	self:SetLocation( location );
	self.mLead = isLead;
	self.mSex = sex;
	self.mModel = followerVO:Get3DModelVO( location ); 
	self.mModel.mScale = followerVO:IsBoss() and mBossScale or mNormalScale;

	self.mFollowerUid = followerVO.mUID;
	if followerVO.mIsSelfActor then
		self.mPlayer = 10000;
	end

	self.mLevel = followerVO:GetLevel();
end

--测试随从用的
function ActorVO:InitTestFollowerVo(id,location,team)
	self.mActorID = id;
	local config = mConfigSysactor[id];
	local office = mConfigSysfollower_office_up[id.."_5"];
	local office1 = mConfigSysfollower_office_up[id.."_1"];
	self.mTeam = team;
	self.mLead = false;
	self.mActorType = 3;
	self:SetLocation( location );
	self.mSex = config.sex;
	self.mFollowerUid = self.mUniqueId;
	local model = {};
	model.mFile = office1.model;
	model.mRotation = Quaternion.Euler(location.rotation.x, 0, location.rotation.z);
	model.mScale = mNormalScale;
	self.mModel = model;

	local skills = {};
	for i,v in pairs(office.all_skill) do
		local skill = SkillData.LuaNew(v);
		skills[i] = skill;
	end

	self.mSkills = skills;
	local attri = {};
	for k, v in pairs(config.base_attri) do
		attri[v.key] = v.value;
	end
	self.mAttri = attri;
	self.mName = config.name;
	self.mCamp = config.camp;
end

--皇上
function ActorVO:InitKingVO(play_id, team)
	local KingModel = mGameModelManager.KingModel;
	local king_skill = mConfigSysdungeon_play[play_id].king_skill;
	local combat_skill = king_skill[1];

	self.mSex = 1;
	local skills = {};
	local skill = SkillData.LuaNew(combat_skill);
	skills[1] = skill;

	self.mTeam = team;
	self.mSkills = skills;
	self.mLead = false;

	self.mAttri = KingModel:GetTotalAttribute( );
	self.mName = "皇上";
	self.mCamp = 1;
end

function ActorVO:SetLocation(location)
	self.mPosition = location.position;
	self.mRotation = Quaternion.Euler(0, location.rotation.y, 0);
	self.mBloodScale = location.blood_scale;
end

return ActorVO;