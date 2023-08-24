local mLuaClass = require "Core/LuaClass"
local AttributeEnum = require "Module/Talent/AttributeEnum"
local mLeadConfigInfo = require "Module/Lead/LeadConfigInfo"
local mConfigSysactor = require "ConfigFiles/ConfigSysactor"
local mGameModelManager = require "Manager/GameModelManager"
local mFollowerBaseVO = require "Module/Follower/FollowerBaseVO"
local mConfigSyspromote = require "ConfigFiles/ConfigSyspromote";
local mFollowerSkillVO = require "Module/Follower/FollowerSkillVO"
local mConfigSysskill_info = require "ConfigFiles/ConfigSysskill_info"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local mConfigSysfollower_office_up = require"ConfigFiles/ConfigSysfollower_office_up"
local LeadBaseVO = mLuaClass("LeadBaseVO", mFollowerBaseVO);
local mLeadBaseConfig = mLeadConfigInfo.mLeadBaseConfig;
local mActorToPower = mLeadConfigInfo.mActorToPower;
local mPairs = pairs;
local mTable = table;
local mSuper = nil;

function LeadBaseVO:OnLuaNew()
   	mSuper = self:GetSuper(mFollowerBaseVO.LuaClassName);
	mSuper.OnLuaNew(self); 
end

--external func
function LeadBaseVO:GetOfficeName(office, sex)
	office = office or self.mOffice;
	sex = sex or self.mSex;
	local prompote = mConfigSyspromote[office];
	return sex == 1 and prompote.man_name or prompote.woman_name;
end

function LeadBaseVO:GetCombatModel( id )
	return mLeadBaseConfig[id or self.mID].combatModel;
end

function LeadBaseVO:GetUIModel( id )
	return mLeadBaseConfig[id or self.mID].uiModel;
end

function LeadBaseVO:GetMiniIcon(id)
	return mLeadBaseConfig[id or self.mID].miniIcon;
end

function LeadBaseVO:IsLevelMaxed( level )
	local lv = level and level or self:GetLevel( );
	return lv>= mConfigSysglobal_value[mConfigGlobalConst.PLAYER_MAX_LV];
end
--external func

--attribute
function LeadBaseVO:CalculateBenTiAttri(  )
	self:CalculateBaseAttri( );
	self:CalculateTrainAttri();
	self:SaveBenTiAttribute( );
end

function LeadBaseVO:CalculateTrainAttri(  )
	local trainAttri = self.mTrainAttr;
	local totalAttri = self.mTotalAttri;
	for k , v in ipairs(trainAttri) do
		totalAttri[k] = totalAttri[k] + v;
	end
end

function LeadBaseVO:CalculateOtherAttri(  )
	local totalAttri = self.mTotalAttri;
	local totalFashionAttr = self:GetFashionTotalAttri();

	for k , v in mPairs(totalAttri) do
		if k <= 3 then
			totalAttri[k] = totalAttri[k] * (1 + totalFashionAttr[k + 8]);
		end
	end

	--print ( '总属性: ' )
	for k, v in mPairs(totalAttri) do
		if k <= 8 then
			--print (  k , totalAttri[k], totalFashionAttr[k] )
			totalAttri[k] = totalAttri[k] + totalFashionAttr[k];
		end
	end
end

function LeadBaseVO:GetFashionTotalAttri(  )
	local totalFashionAttr = {};
	for i = 1, AttributeEnum.AttributeDefenseRate do
		totalFashionAttr[i] = 0;
	end

	--print( '时装属性: ' )
	local fashions = self:GetEquipedFashions( );
	for k, v in mPairs( fashions ) do
		if v.mDefault ~= true then
			local attri = v:GetCombatAttributes( );
			for key, value in mPairs( attri ) do
				totalFashionAttr[ key ] = totalFashionAttr[ key ] + value;
				--print ( key, value, totalFashionAttr[ key ] ) 
			end
		end
	end

	--print ( '时装总属性：' )
	for k, v in pairs ( totalFashionAttr ) do
		--print ( k, v )
	end
 	return totalFashionAttr;
end

function LeadBaseVO:InitFashionList( fashion_list )
	self.mFashionList = fashion_list;
end

function LeadBaseVO:GetEquipedFashions(  )
	local  fashion_list = self.mFashionList;
	if fashion_list then
		return mGameModelManager.FashionModel:Convert( fashion_list );
	else
		return {};
	end
end
--attribute

--skill
function LeadBaseVO:GetActorIdToPower(power, sex)
	sex = sex or self:GetSex();
	return mActorToPower[sex][power];
end

function LeadBaseVO:GetActorPowerAndSex( id )
	local actorVO = mConfigSysactor[id];
	return actorVO.camp, actorVO.sex
end

function LeadBaseVO:IsLeadActor( id )
	for k, v in mPairs(mActorToPower) do
		for key, value in mPairs(v) do
			if value == id then
				return true;
			end
		end
	end
	return false;
end

function LeadBaseVO:GetSkillSystemByPower(power)
	if power == 1 or power == 2 or power == 3 then
		return 1;
	else
		return 2;
	end
end

function LeadBaseVO:GetSkillLevel(id, activeSkills)
	for k, v in mPairs(activeSkills) do
		if v.skill_id == id then
			return v.skill_lv;
		end
	end
	return 0;
end

function LeadBaseVO:GetFollowerSkillVO(id, skill_system, skillList)
	local level = self:GetSkillLevel(id, skillList );
	return mFollowerSkillVO.LuaNew(id, level, skill_system, level > 0);
end

function LeadBaseVO:GetPowerSkillInfo( allSkillList, actorId)
	local power, sex = self:GetActorPowerAndSex(actorId ) ;
	local skillList = nil;
	local skillLine = nil;

	for key, value in mPairs(allSkillList) do

		if value.force == power then
			skillList = value.skill_list;
			skillLine = value.line;


			if #skillList == 0 then
				skillList = self:GetDefautActiveSkill(actorId);
			end

		end
	end
	skillList = skillList  or {};
	skillLine = skillLine  or 1;

	return skillList, skillLine;
end

function LeadBaseVO:GetDefautActiveSkill( actorId )
	local key = string.format('%d_1', actorId);
	local activeSkillList = mConfigSysfollower_office_up[key].skills;
	local skills = {};

	for k, v in mPairs(activeSkillList) do
		local skillInfo = {};
		skillInfo.skill_id = v;
		skillInfo.skill_lv = 1;

		mTable.insert(skills, skillInfo)
		local nextSkills = mConfigSysskill_info[v].after_skill;

		for key, value in mPairs(nextSkills) do
			local skillInfo2 = {};
			skillInfo2.skill_id = value;
			skillInfo2.skill_lv = 0;
			mTable.insert(skills, skillInfo2);
		end
	end

	return skills;
end

function LeadBaseVO:GetPowerSkillList(allSkillList, actorId)
	local power, sex = self:GetActorPowerAndSex(actorId ) ;

	local skill_to_power = {};
	for k, v in mPairs(mActorToPower[sex]) do


		local skill_list = {};
		local skill_to_index = {};
		skill_to_index[1] = {};
		skill_to_index[2] = {};
		skill_to_index[3] = {};

		local actorId = self:GetActorIdToPower(k, sex);
		local actorVO = mConfigSysactor[actorId];
		local skills = actorVO.skills;
		skills = skills or {};
		local skill_system = self:GetSkillSystemByPower(k);
		if skill_system == 1 then
			skill_to_index[4] = {};
		end

		local skillList, skillLine = self:GetPowerSkillInfo(allSkillList, v);
		for skill_index, skill_id in mPairs(skills) do

			local skill_vo = self:GetFollowerSkillVO(skill_id, skill_system, skillList);

			local index_list = skill_vo:GetIndexList();
			local pos = skill_vo.mSkillInfo.position;

			for key1 , index in mPairs(index_list) do
				skill_to_index[index][pos] = skill_vo;
			end

			skill_list[skill_id] = skill_vo;

		end

		local skillPowers = {};
		skillPowers.mSkillList = skill_list;
		skillPowers.mSkillToIndex = skill_to_index;
		skillPowers.mSkillLine = skillLine;
		skill_to_power[k] = skillPowers;
	end

 	return skill_to_power;
end

function LeadBaseVO:InitSkillList(  )
	self.mSkillToPower = self:GetPowerSkillList(self.mSkills, self.mID);
	local skillToPower = self.mSkillToPower[self.mPowerID];
	self.mSkillToIndex =  skillToPower.mSkillToIndex[skillToPower.mSkillLine];
end
--skill
return LeadBaseVO;