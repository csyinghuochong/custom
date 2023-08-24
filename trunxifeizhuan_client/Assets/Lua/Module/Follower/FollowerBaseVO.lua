local BaseLua = require "Core/BaseLua"
local mLuaClass = require "Core/LuaClass"
local mEventEnum = require "Enum/EventEnum"
local mLanguageUtil = require "Utils/LanguageUtil"
local mConfigSysexp = require "ConfigFiles/ConfigSysexp"
local mEventDispatcher = require "Events/EventDispatcher"
local TalentItemVO = require "Module/Talent/TalentItemVO"
local mGameModelManager = require "Manager/GameModelManager"
local ActorTypeEnum = require "Module/Combat/ActorTypeEnum"
local AttributeEnum = require "Module/Talent/AttributeEnum"
local mConfigSysactor = require "ConfigFiles/ConfigSysactor"
local mFollowerSkillVO = require "Module/Follower/FollowerSkillVO"
local mFollowerPowerVO = require "Module/Follower/FollowerPowerVO"
local ConfigSystalent_suit = require "ConfigFiles/ConfigSystalent_suit"
local mfollower_star_info = require "ConfigFiles/ConfigSysfollower_star_info"
local FollowerTalentSuitItemVO = require "Module/Follower/FollowerTalentSuitItemVO"
local mConfigSysfollower_office_up = require "ConfigFiles/ConfigSysfollower_office_up"
local FollowerBaseVO = mLuaClass("FollowerBaseVO", BaseLua);
local mString = require "string"
local Pairs = pairs;
local mIPairs = ipairs;
local mResourceUrl = require "AssetManager/ResourceUrl"
local mRoleIcon = mResourceUrl.role_icon;

--随从基类--
function FollowerBaseVO:OnLuaNew()
	local totalAttri = {};
	for i = 1, AttributeEnum.AttributeDefenseRate do
		totalAttri[i] = 0;
	end
	self.mTotalAttri = totalAttri;
end

--construction
--构造自己的随从
function FollowerBaseVO:InitFollowerData( pbPartner, is_self, sex)
	self.mUID = pbPartner.id;
	self.mID = pbPartner.hero_id;
	self.mName = pbPartner.name;
	self.mLevel = pbPartner.level;
	self.mStar = pbPartner.star;
	self.mExp = pbPartner.exp;
	self.mModelId = pbPartner.model;
	self.mOffice = pbPartner.position;
	self.mTrainAttr = pbPartner.train;
	self.mEquips = pbPartner.equips; 
	self.mSkills = pbPartner.skills; 
	self.mTopBiography = pbPartner.top_memoir; 
	self.mLockFlag = pbPartner.lock_flag;    --锁定状态0未锁定1锁定
	self.mGetTimeTamp = pbPartner.timestamp;
	local acotrVO = mConfigSysactor[pbPartner.hero_id];
	self.mPowerID = acotrVO.camp;
	local isLead = pbPartner.main == 1;
	self.mActorType = isLead and ActorTypeEnum.ActorLead or ActorTypeEnum.ActorFollower;
	if sex ~= nil then
		self.mSex = sex;
	else
		self.mSex = isLead and mGameModelManager.RoleModel.mPlayerBase.sex or acotrVO.sex;
	end
	self.mIsSelfActor = is_self or false;

	self:InitAttributeVO();
	self:InitTalentList( pbPartner.talents );
	self:InitSkillList();

	if pbPartner.model == 0 then
		self.mModelId = self.mOffice;
	end
	if pbPartner.name == "" then
		self.mName = acotrVO.name;
	end

	self:CalculateAttri();
end

--克隆
function FollowerBaseVO:Clone(  )
	local cls = { };
	setmetatable(cls,{__index = self});
	return cls;
end

--新增随从
function FollowerBaseVO:InitAddFollowerData( pbPartnerAdd )
	-- body
	self.mUID = pbPartnerAdd.id;
	self.mID = pbPartnerAdd.partner_id;

	local acotrVO = mConfigSysactor[self.mID];
	self.mStar = acotrVO.star;
	self.mModelId = acotrVO.position;
	self.mOffice = acotrVO.position;
	self.mTopBiography = 0;
	self.mSex = sex;
	self.mLevel = 1;
	self.mExp = 1;
	self.mTrainAttr = {0, 0, 0}
	self.mEquips = {}; 
	local skills = {};
	skills[1] = {};
	skills[1].skill_list = {};
	self.mSkills = skills
	self.mPowerID = acotrVO.camp;
	self.mName = acotrVO.name;
	self.mActorType = ActorTypeEnum.ActorFollower;
	self.mIsSelfActor = true;
	self.mLockFlag = 0;
	self.mGetTimeTamp = mGameModelManager.LoginModel:GetCurrentTime();

	self:InitAttributeVO();
	self:InitSkillList();
	self:InitTalentList( {} );
	self:CalculateAttri();
end

--构造巅峰宫斗的主角随从
function FollowerBaseVO:InitPromoteArenaData( pbArenaVsPlayerPartner )
	self.mUID = pbArenaVsPlayerPartner.id;
	self.mID = pbArenaVsPlayerPartner.hero_id;
	self.mName = pbArenaVsPlayerPartner.name;
	self.mLevel = pbArenaVsPlayerPartner.lv;
	self.mStar = pbArenaVsPlayerPartner.star;
	local positon = pbArenaVsPlayerPartner.position;
	positon = positon ~= 0 and positon or 1;
	self.mModelId = positon;
	self.mOffice = positon;
	self.mExp = 0;
	self.mSex = pbArenaVsPlayerPartner.sex;
	self.mTrainAttr = pbArenaVsPlayerPartner.train;

	self.mEquips = pbArenaVsPlayerPartner.equips; 
	self.mSkills = pbArenaVsPlayerPartner.skills; 
	self.mPowerID = mConfigSysactor[self.mID].camp;
	self.mActorType = pbArenaVsPlayerPartner.is_main == 1 and ActorTypeEnum.ActorLead or ActorTypeEnum.ActorFollower;

	self:InitAttributeVO();
	self:InitTalentList( pbArenaVsPlayerPartner.talents );
	self:InitSkillList();
	self:CalculateAttri();
end

--构建读表默认随从
function FollowerBaseVO:InitConfigActorVO(sysVo)
	self.mLevel = 1;
	self.mOffice = sysVo.position;
	self.mPowerID = sysVo.camp;
	self.mID = sysVo.actor;
	self.mModelId = self.mOffice;
	self.mStar = sysVo.star;
end

function FollowerBaseVO:InitAttributeVO( )
	self.mActorVO = mConfigSysactor[self.mID];
end

function FollowerBaseVO:IsOpenSkill( id )
	local officeVO = self:GetOfficeVO();
	local openSkills = officeVO.skills;

	local active = false;
	for k, v in Pairs(openSkills) do
		if v == id then
			active = true;
		end
	end
	return active;
end

function FollowerBaseVO:InitTalentList( talents )
	local talentListToId = { };
	local talentListToIndex = { };
	for k, v in mIPairs(talents) do
		local vo = TalentItemVO.LuaNew( v , self );
		self:AttachTanlent( vo, talentListToId, talentListToIndex);
	end
	self.mTalentListToID = talentListToId;
	self.mTalentListToIndex = talentListToIndex;
end

function FollowerBaseVO:AttachTanlent( vo, listId, listIndex )
	local id = vo.mID;
	local pos = vo:GetPosition( );
	listId[ id ] = vo;
	listIndex[ pos ] = vo;
end

function FollowerBaseVO:GetSkillLevel(id)
	local activeSkills = {};
	local skills = self.mSkills[1];
	if skills ~= nil then
		activeSkills = skills.skill_list
	end
	local level = 1;
	for k, v in Pairs(activeSkills) do
		if v.skill_id == id then
			level =  v.skill_lv;
		end
	end

	local active = self:IsOpenSkill(id);
	return level, active;
end

function FollowerBaseVO:InitSkillList()
	local officeVO = self:GetOfficeVO();
	local skills = officeVO.all_skill;
	local skill_list = {};
	local skill_index = {};

	for k, v in Pairs(skills) do
		local level, active = self:GetSkillLevel(v);
		local skill_vo = mFollowerSkillVO.LuaNew(v, level, 1, active);
		skill_list[v] = skill_vo;
		skill_index[skill_vo.mSkillInfo.position] = skill_vo;
	end

	self.mSkillList = skill_list;
	self.mSkillToIndex = skill_index;
end

function FollowerBaseVO:GetSkillList()
	return self.mSkillToIndex;
end

function FollowerBaseVO:GetSuitList(  )
	local talents = { };
	local talenListToIndex = self.mTalentListToIndex;
	for k, v in Pairs ( talenListToIndex ) do
		local suitType = v:GetTalentType( );
		local suitNumber = talents[suitType];
		if suitNumber == nil then
			talents[suitType] = 1;
		else
			talents[suitType] = suitNumber + 1;
		end
	end

	local suitList = {};
	for k, v in Pairs(talents) do
		local sysVo = ConfigSystalent_suit[ k ];
		local suitNumber =  math.floor( v / sysVo.suit_number );
		for i = 1, suitNumber do
			table.insert( suitList, FollowerTalentSuitItemVO.LuaNew( k, v ));
		end
	end
	return suitList;
end
--construction

--attribute
function FollowerBaseVO:GetSuitTotalAttri(  )
	local totalSuitAttr = {};
	for i = 1, AttributeEnum.AttributeDefenseRate do
		totalSuitAttr[i] = 0;
	end

	return totalSuitAttr;
end

function FollowerBaseVO:GetTalentTotalAttri(  )
	local totalTalentAttr = {};
	for i = 1, AttributeEnum.AttributeDefenseRate do
		totalTalentAttr[i] = 0;
	end
	local talentList = self.mTalentListToIndex;
	for k, v in Pairs(talentList) do
		local talentAttri = v:GetTotalAttr();
		for key, value in Pairs(talentAttri) do
			totalTalentAttr[key] = totalTalentAttr[key] + value;
			--print('装备属性累加:  ', k,  key, value)
		end
	end
	return totalTalentAttr;
end

function FollowerBaseVO:CalculateAttri(  )
	self:CalculateBenTiAttri( );
	self:CalculateOtherAttri( );
	self:CalculateCombat();
end

function FollowerBaseVO:CalculateBenTiAttri(  )
	self:CalculateBaseAttri( );
	self:CalculateOfficeAttri();
	self:SaveBenTiAttribute( );
end

function FollowerBaseVO:CalculateBaseAttri(  )
	self:CalculateGrowAttri( );
	self:SaveGrowAttribute(  );
	self:CalculateStarAttri( );
end

function FollowerBaseVO:SaveGrowAttribute(  )
	local totalAttri = self.mTotalAttri;
	local growAttr = self.mGrowAttri;
	if growAttr == nil then
		growAttr = { };
		self.mGrowAttri = growAttr;
	end
	for k, v in Pairs( totalAttri ) do
		growAttr[ k ] = v;
	end
end

function FollowerBaseVO:SaveBenTiAttribute(  )
	local totalAttri = self.mTotalAttri;
	local bentiAttr = self.mBenTiAttri;
	if bentiAttr == nil then
		bentiAttr = { };
		self.mBenTiAttri = bentiAttr;
	end
	for k, v in Pairs( totalAttri ) do
		bentiAttr[ k ] = v;
	end
end

function FollowerBaseVO:CalculateGrowAttri(  )
	local actorVO = self.mActorVO;
	local totalAttri = self.mTotalAttri;
	for k, v in Pairs(totalAttri) do
		totalAttri[k] = 0;
	end

	--print ( '基础属性' )
	local baseAttri = actorVO.base_attri;
	for k, v in Pairs(baseAttri) do
		totalAttri[v.key] = v.value;
		--print ( v.key, v.value )
	end

	--print ( '成长属性' )
	local level = self.mLevel;
	if level > 1 then
		local growAttri = actorVO.addition_attri;
		for k, v in Pairs(growAttri) do
			--print ( v.key, v.value * (level - 1) )
			totalAttri[v.key] = totalAttri[v.key] + v.value * (level - 1);
		end
	end
end

function FollowerBaseVO:CalculateStarAttri(  )
	--print ( '星级加成' )
	local totalAttri = self.mTotalAttri;
	local starAdd = self:GetStarVO().addition_attri;
	if starAdd > 0 then
		for k, v in Pairs(totalAttri) do
			if k <= 3 then
				--print ( k, totalAttri[k], starAdd, totalAttri[k] * (1 + starAdd) )
				totalAttri[k] = totalAttri[k] * (1 + starAdd);
			end
		end
	end
end

function FollowerBaseVO:CalculateOfficeAttri()
	--print ( '随从官职加成' )
	local totalAttri = self.mTotalAttri;
	local officeAttri = self:GetOfficeVO().addition_attri;
	if officeAttri  then
		for k, v in Pairs(officeAttri) do
			--print('随从官职加成: ', totalAttri[v.key], v.key, v.value)
			totalAttri[v.key] = totalAttri[v.key] + v.value
		end
	end
end

function FollowerBaseVO:CalculateOtherAttri( )
	local totalAttri = self.mTotalAttri;
	local totalTalentAttr = self:GetTalentTotalAttri();
	local totalSuitAttr = self:GetSuitTotalAttri();

	--print ( '才艺加成:' )
	for k , v in Pairs(totalAttri) do
		if k <= 3 then
			--print ( k, totalTalentAttr[k + 8], totalAttri[k] * (1 + totalTalentAttr[k + 8] ) );
			totalAttri[k] = totalAttri[k] * (1 + totalTalentAttr[k + 8]);
		end
	end

	--print ( '才艺属性:' )
	for k, v in Pairs(totalAttri) do
		if k <= 8 then
			--print ( k, totalTalentAttr[k] ) 
			totalAttri[k] = totalAttri[k] + totalTalentAttr[k];
		end
	end

	--print('最终属性:')
	--print( totalAttri[1] );
	--print( totalAttri[2] );
	--print( totalAttri[3] );
end

function FollowerBaseVO:CalculateCombat(  )
	local totalAttri = self.mTotalAttri;
	local power_param = mFollowerPowerVO.mPowerParam;
	local combat = totalAttri[1] * power_param.hp + totalAttri[2] * power_param.attack * 
		(1 + totalAttri[4] * totalAttri[5]) * (totalAttri[8] / 100) + totalAttri[3] * power_param.defense
		+ totalAttri[6] * power_param.hit + totalAttri[7] * power_param.resist;

	combat = Mathf.Round(combat);

	local curCombat = self.mCombat;
	if curCombat ~= combat and self:IsLead() then	
		mEventDispatcher:Dispatch(mEventEnum.ON_LEAD_COMBAT_UPDATE, combat);
	end
	self.mCombat = combat;
end

function FollowerBaseVO:GetCombat( )
	return self.mCombat;
end

function FollowerBaseVO:GetTotalAttr(  )
	return self.mTotalAttri;
end

function FollowerBaseVO:GetGrowAttri(  )
	return self.mGrowAttri;
end

function FollowerBaseVO:GetBenTiAttri( )
	return self.mBenTiAttri;
end

function FollowerBaseVO:GetBaseAttr(  )
	return self.mActorVO.base_attri;
end
--attribute

--external func
function FollowerBaseVO:IsLead(  )
	return self.mActorType == ActorTypeEnum.ActorLead;
end

function FollowerBaseVO:IsFollower(  )
	return self.mActorType == ActorTypeEnum.ActorFollower;
end

function FollowerBaseVO:IsMonster(  )
	return self.mActorType == ActorTypeEnum.ActorMonster;
end 

function FollowerBaseVO:IsBoss(  )
	return self.mActorType == ActorTypeEnum.ActorBoss;
end 

function FollowerBaseVO:GetBgIcon( power )
	power = power ~= nil and power or self.mPowerID;
	return mString.format("common_power_iconframe%d", power);
end

function FollowerBaseVO:GetKuangIcon( office )
	office = office ~= nil and office or self.mOffice;
	office = math.min(office, 7);
	return mString.format("common_bag_iconframe_%d", office);
end

function FollowerBaseVO:GetActorID( )
	return self.mID;
end

function FollowerBaseVO:GetPowerID(  )
	return self.mPowerID;
end

function FollowerBaseVO:GetPowerIcon( )
	return mString.format('common_power_%d', self:GetPowerID())
end

function FollowerBaseVO:GetPowerName( )
	return mFollowerPowerVO:GetPowerInfo(self:GetPowerID());
end

function FollowerBaseVO:GetLevel()
	return self.mLevel;
end

function FollowerBaseVO:GetExp( )
	return self.mExp;
end

function FollowerBaseVO:GetCurLVMaxExp()
	local exp = mConfigSysexp[self:GetLevel( )];
	return exp ~= nil and exp.follower_exp or 0;
end

function FollowerBaseVO:GetExpRate( )
	local maxExp = self:GetCurLVMaxExp();
	local rate = maxExp ~= 0 and self:GetExp() / maxExp or 1;
	rate = math.min(rate, 1);
	return rate;
end

function FollowerBaseVO:GetExpStr( )
	local maxExp = self:GetCurLVMaxExp();
	if self:IsLevelMaxed( ) then
		return mLanguageUtil.follower_level_maxed;
	else
		return mString.format('%d/%d', self:GetExp(), maxExp);
	end
end

function FollowerBaseVO:GetSex(  )
	return self.mSex;
end

function FollowerBaseVO:GetStar(  )
	return self.mStar;
end

function FollowerBaseVO:GetStarVO(  )
	return mfollower_star_info[self:GetStar()];
end

function FollowerBaseVO:GetNextStarVO( )
	return mfollower_star_info[self:GetStar() + 1];
end

function FollowerBaseVO:GetOffice(  )
	return self.mOffice;
end

function FollowerBaseVO:GetOfficeVO(  )
	local key = mString.format("%d_%d", self.mID, self:GetOffice(  ));
	return mConfigSysfollower_office_up[key];
end

function FollowerBaseVO:GetIconPath(  )
	return mRoleIcon;
end

function FollowerBaseVO:GetOfficeName()
	return self.mActorVO.name;
end

function FollowerBaseVO:GetName(  )
	return self.mName;
end

function FollowerBaseVO:GetTypeInfo( )
	return self:GetTypeName(  ), self:GetTypeIcon();
end

function FollowerBaseVO:GetTypeName(  )
	local a_type = self.mActorVO.type;
	a_type = a_type or 1;
	local key = 'follower_type_name_'..a_type;
	return mLanguageUtil[ key ];
end

function FollowerBaseVO:GetTypeIcon( )
	local a_type = self.mActorVO.type;
	a_type = a_type or 1;
	return 'common_icon_genre'..a_type;
end

function FollowerBaseVO:GetNextOffice()
	local key = mString.format("%d_%d", self.mID, self:GetOffice() + 1);
	return mConfigSysfollower_office_up[key];
end

function FollowerBaseVO:GetShowOfficeVO(  )
	local key = mString.format("%d_%d", self.mID, self.mModelId);
	return mConfigSysfollower_office_up[key];
end

function FollowerBaseVO:GetCombatModel(  )
	return self:GetShowOfficeVO().model;
end

function FollowerBaseVO:GetUIModel( id )
	return self:GetShowOfficeVO().model;
end

function FollowerBaseVO:GetMiniIcon()
	return self:GetShowOfficeVO(  ).mini_icon;
end

function FollowerBaseVO:IsLevelMaxed( level )
	return false;
end

function FollowerBaseVO:GetUIModelVO( position )
	local Follower3DModelVO = require "Module/Follower/Follower3DModelVO";
	return Follower3DModelVO:GetModelVO( self:GetUIModel(), self:IsLead(), self:GetSex( ), position ,self:GetEquipedFashions())
end

function FollowerBaseVO:GetEquipedFashions()
	-- body
end
function FollowerBaseVO:Get3DModelVO( location )
	local Follower3DModelVO = require "Module/Follower/Follower3DModelVO";
	return Follower3DModelVO:GetModelVO( self:GetCombatModel(), self:IsLead(), self:GetSex( ), location ,self:GetEquipedFashions())
end

function FollowerBaseVO:GetPlayerItemVO(  )
    return self:GetSex(), self:GetOffice(), self:GetLevel();
end

--美人心计用到
function FollowerBaseVO:SetMeirenCurrentHp(hp)
	self.mMeirenCurrentHp = hp;
end

function FollowerBaseVO:GetMeirenCurrentHp()
	local hp = self.mMeirenCurrentHp;
	return hp == nil and self:GetTotalAttr()[1] or hp;
end

return FollowerBaseVO;