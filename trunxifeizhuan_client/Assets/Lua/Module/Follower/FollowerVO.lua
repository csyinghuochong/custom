local mLuaClass = require "Core/LuaClass"
local CommonSkillVO = require "Module/CommonUI/CommonSkillVO"
local TalentItemVO = require "Module/Talent/TalentItemVO"
local mFollowerBaseVO = require "Module/Follower/FollowerBaseVO"
local mfollower_star_info = require "ConfigFiles/ConfigSysfollower_star_info"
local mConfigSysfollower_office_up = require"ConfigFiles/ConfigSysfollower_office_up"
local FollowerVO = mLuaClass("FollowerVO", mFollowerBaseVO);
local mString = require "string"
local mTable = table;

--随从数据--
--external func
function FollowerVO:IsCanBreak(  )
	return self:GetLevel() >= self:GetStarVO().max_lv; 
end

function FollowerVO:IsBreakMax(  )
	local max = mTable.getn(mfollower_star_info);
	local starInfo = mfollower_star_info[max];
	return self:GetStar() >= max and self:GetLevel() >= starInfo.max_lv;
end

function FollowerVO:IsOfficeMax(  )
	return self:GetNextOffice() == nil;
end

function FollowerVO:GetUpgradeNeed(  )
	return self:GetCurLVMaxExp() - self:GetExp();
end

function FollowerVO:GetBreakCost(  )
	return self:GetStarVO().cost_follow[ 1 ];
end

function FollowerVO:GetBreakCoin( )
	return self:GetStarVO().cost_coin;
end

function FollowerVO:GetUpAddAttri( id )
	local upgradeAttri = self.mActorVO.addition_attri;
	for k, v in pairs(upgradeAttri) do
		if v.key == id then
			return v.value;
		end
	end
	return 0;
end

function FollowerVO:GetNextLevelClone( )
	local vo = self:Clone( );
	vo.mLevel = self:GetLevel() + 1;
	return vo;
end

function FollowerVO:GetNextStarClone(  )
	local vo = self:Clone( );
	vo.mStar = self:GetStar() + 1;
	return vo;
end

function FollowerVO:GetNextOfficeClone(  )
	local vo = self:Clone( );
	vo.mOffice = self:GetOffice() + 1;
	return vo;
end

function FollowerVO:CanBeBreakCost( star )
	return self.mLockFlag ~= 1 and self:GetStar() >= star and self:GetStar() < 6 ;
end

function FollowerVO:GetUpOfficeSkill(  )
	local newSkill = self:GetOfficeVO().add_skill;
	if newSkill == 0 then
		return nil, nil;
	else
		local newSkillVo = CommonSkillVO.LuaNew(newSkill, 1, true, true);
		local pos = newSkillVo:GetPosition();
		local preSkillVo = self.mSkillToIndex[ pos ];
		if preSkillVo then
			preSkillVo = preSkillVo.mActive and preSkillVo or nil;
		end
		return newSkillVo, preSkillVo;
	end
end
--external func

--skill
function FollowerVO:UpdateSkillList()
	local officeVO = self:GetOfficeVO();
	local skills = officeVO.all_skill;

	local skill_list = {};
	local skill_to_index = self.mSkillToIndex;
	for k, v in pairs(skill_to_index) do
		local skill_id = skills[k];
		local active  = self:IsOpenSkill(skill_id);
		v:UpdateSkillId(skill_id, active);
		skill_list[skill_id] = v;
	end

	self.mSkillList = skill_list;
end
--skill

--talent
function FollowerVO:OnWearTalent( pbTalent )
	local vo = TalentItemVO.LuaNew(pbTalent, self);
	self:AttachTanlent( vo, self.mTalentListToID, self.mTalentListToIndex);
	self:CalculateAttri();
	return vo;
end

function FollowerVO:GetFirstValidTalent(  )
	for k, v in pairs ( self.mTalentListToIndex ) do
		if v then return v; end
	end
	return nil;
end

function FollowerVO:OnRecvTalentRemove( talentPos )
	local talentListToID = self.mTalentListToID;
	local talentListToIndex = self.mTalentListToIndex;
	local talentVo =  talentListToIndex[ talentPos ];
	local uid = talentVo:GetUID( );
	talentListToID[ uid ] = nil;
	talentListToIndex[ talentPos ] = nil;
	self:CalculateAttri();
end

function FollowerVO:UpdateFollowerAttribute(  )
	self:CalculateAttri();
end
--bowlder

--update func
function FollowerVO:OnUpdateModel( id )
	self.mModelId = id;
end

function FollowerVO:OnUpdateSkillLevel( skill_id )
	local skill_vo = self.mSkillList[skill_id];
	skill_vo:UpdateLevel();
	return skill_vo;
end

function FollowerVO:OnUpdateOffice()
	self.mOffice = self.mOffice + 1;
	self.mModelId = self.mOffice;
	self:UpdateSkillList();

	self:CalculateAttri();
end

function FollowerVO:OnUpdateStar()
	self.mStar = self.mStar + 1;
	self.mExp = 0;

	self:CalculateAttri();
end

function FollowerVO:OnUpdateExp(exp)
	self.mExp = self.mExp + exp;

	if self.mExp >= self:GetCurLVMaxExp() and self:IsCanUpgrade() then
		self:OnUpdateLevel();
	end
end

function FollowerVO:IsCanUpgrade(  )
	local starInfo = mfollower_star_info[self:GetStar()];
	return self:GetLevel() < starInfo.max_lv;
end

function FollowerVO:OnUpdateLevel(  )
	self.mLevel = self.mLevel + 1;
	self.mExp = 0;

	self:CalculateAttri();
end

function FollowerVO:OnPassBiography(chapter_id)
	local last_id = self.mTopBiography;
	if last_id == nil or chapter_id > last_id then
		 self.mTopBiography = chapter_id;
	end
end

function FollowerVO:OnAlterName(name)
	self.mName = name;
end

function FollowerVO:OnUpateLock(lock)
	self.mLockFlag = lock;
end
--update func

return FollowerVO;