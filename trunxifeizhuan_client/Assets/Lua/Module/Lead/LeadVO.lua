local mLuaClass = require "Core/LuaClass"
local mLeadBaseVO = require "Module/Lead/LeadBaseVO"
local mConfigSysexp = require "ConfigFiles/ConfigSysexp"
local mGameModelManager = require "Manager/GameModelManager"
local LeadVO = mLuaClass("LeadVO", mLeadBaseVO);
local Pairs = pairs;
local mSuper;

--主角数据--
--external func
function LeadVO:GetTrainInfo(  )
	return self.mTrainAttr;
end

function LeadVO:OnRecvTrain(pbId32R)
	self.mTrainTemp = pbId32R;
	self.mWaitOperate = true;
end
--0放弃1保存
function LeadVO:OnRecvTrainOperate(op_type)
	self.mWaitOperate = false;

	if op_type == 1 then
		self.mTrainAttr = self.mTrainTemp;
		self:CalculateAttri();
	end
end

function LeadVO:IsCanBreak()
	local train = self.mTrainAttr;
	local starVO = self:GetStarVO();
	return train[1] >= starVO.train_health and train[2] >= starVO.train_attack and train[3] >= starVO.train_defense;
end

function LeadVO:GetTrainLimit( )
	return mConfigSysexp[self.mLevel];
end

function LeadVO:GetCurLVMaxExp()
	local exp = mConfigSysexp[self.mLevel];
	return exp ~= nil and exp.lead_exp or 0;
end
--external func

--update func
function LeadVO:OnUpdateLevel( level )
	self.mLevel = level;
	self:CalculateAttri();
end

function LeadVO:OnUpdateExp(exp)
	self.mExp = exp;
end

function LeadVO:OnAlterName(name)
	self.mName = name;
end

function LeadVO:OnUpdateStar()
	local trainAttr = self.mTrainAttr;
	trainAttr[1] = 0;
	trainAttr[2] = 0;
	trainAttr[3] = 0;

	self.mLevel = self.mLevel + 1;
	self.mStar = self.mStar + 1;
	self.mExp = 0;

	self:CalculateAttri();
end

function LeadVO:OnLeadUpdateSkill(power, id)
	local skillToPower = self.mSkillToPower[power];
	local skillVO = skillToPower.mSkillList[id];
	skillVO:UpdateLevel();
	return skillVO;
end

function LeadVO:OnLeadUpdatePower( power, skill_line )
	local id = self:GetActorIdToPower(power, self:GetSex());
	self.mID = id;
	self.mPowerID = power;
	self:InitAttributeVO();
	self.mSkillToPower[power].mSkillLine = skill_line;
	local skillToPower = self.mSkillToPower[self.mPowerID];
	self.mSkillToIndex =  skillToPower.mSkillToIndex[skillToPower.mSkillLine];
end

function LeadVO:OnUpdateOffice( office )
	self.mOffice = office;
end
--update func

--attribute
function LeadVO:GetEquipedFashions(  )
	return mGameModelManager.FashionModel:GetEquipedFashions( );
end
--attribute

--skill
function LeadVO:PrintSkillInfo(  )
	local skill_to_power = self.mSkillToPower;
	for k, v in Pairs(skill_to_power) do
 		print('势力', k,  v.mSkillLine)
 		local skill_list = v.mSkillList;
 		print('所有技能')
 		for key, value in Pairs(skill_list) do
 			print(key, value.mID, value.mLevel, value.mSkillInfo.name,value.mActive)
 		end
 		local skill_to_index = v.mSkillToIndex
 		for kk, vv in Pairs(skill_to_index) do
 			print('支线技能'..kk)
 			for kkk, vvv in Pairs(vv) do
 				print('位置', kkk, vvv.mID, vvv.mLevel,vvv.mActive);
 			end
 		end

 	end
end

function LeadVO:GetSkillListByPower( power )
	return self.mSkillToPower[power].mSkillList;
end

function LeadVO:GetSkillLineByPower( power )
	return self.mSkillToPower[power].mSkillLine;
end

--skill

return LeadVO;