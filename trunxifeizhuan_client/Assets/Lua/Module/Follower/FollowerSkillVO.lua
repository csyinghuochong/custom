local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mLanguage = require "Utils/LanguageUtil"
local mConfigSysskill = require"ConfigFiles/ConfigSysskill"
local CommonSkillVO = require "Module/CommonUI/CommonSkillVO"
local mConfigSysskill_info = require "ConfigFiles/ConfigSysskill_info"
local mFollowerSkillDescVO = require "Module/Follower/FollowerSkillDescVO"
local mConfigSysskill_level_up = require "ConfigFiles/ConfigSysskill_level_up"
local FollowerSkillVO = mLuaClass("FollowerSkillVO", CommonSkillVO);
local mSuper;

function FollowerSkillVO:OnLuaNew(id, level, skill_sysytem, active)
	self.mSkillSystem = skill_sysytem;
	self.mSkillVO = mConfigSysskill[ id ];
	mSuper = self:GetSuper(CommonSkillVO.LuaClassName);
	mSuper.OnLuaNew(self, id, level, active);
end

function FollowerSkillVO:UpdateLevel(  )
	self.mLevel = self.mLevel + 1;
	self.mActive = true;
end

function FollowerSkillVO:IsPassiveSkill(  )
	return self.mSkillVO.type > 0 ;
end

function FollowerSkillVO:IsMaxLevel(  )
	return self.mLevel >= self.mSkillInfo.lv_limit;
end

function FollowerSkillVO:GetSkillPosition(  )
	return self.mSkillInfo.position;
end

function FollowerSkillVO:UpdateSkillId( id , active)
	self.mID = id;
	self.mActive = active;
	self.mSkillInfo = mConfigSysskill_info[id];
end

function FollowerSkillVO:GetPrevSkillID( )
	return self.mSkillInfo.prev_skill;
end

function FollowerSkillVO:GetAfterSkillID( )
	return self.mSkillInfo.after_skill;
end

function FollowerSkillVO:GetIndexList()
	local skill_info = self.mSkillInfo;
	local position = skill_info.position;
	local index = skill_info.index;

	local index_list = {};
	if self.mSkillSystem == 1 then
		if position == 1 then
			index_list[1] = 1;
			index_list[2] = 2;
			index_list[3] = 3;
			index_list[4] = 4;
		elseif position == 2 and index == 1 then
			index_list[1] = 1;
			index_list[2] = 2;
		elseif position == 2 and index == 2 then
			index_list[3] = 3;
			index_list[4] = 4;
		else
			index_list[1] = index;
		end
	else
		index_list[1] = index;
	end

	return index_list;
end

local mLgOpenTip = mLanguage.follower_skill_open_tip;
function FollowerSkillVO:GetDesc(  )
	local skill_info = self.mSkillInfo;
	if self.mActive then
		if skill_info.name == "" then
			print('使用了未包装的技能.........'..self.mID)
		end
		return skill_info.desc;
	else
		local open = string.format(mLgOpenTip, skill_info.offfice or 1);
		return string.format('%s(%s)', skill_info.desc, open)
	end
end

function FollowerSkillVO:GetDescVOList()
	local skill_id = self.mID;
	local current_lv = self.mLevel;
	local data_source = mSortTable.LuaNew(function(a, b) return a.mIndex < b.mIndex end, nil, true);

	local up_list = mConfigSysskill_level_up[skill_id].level_up;
	if up_list then
		for k, v in pairs( up_list ) do
			data_source:AddOrUpdate(k + 1, mFollowerSkillDescVO.LuaNew(k + 1, current_lv, v, self.mActive));
		end 
	end
	
	return data_source;
end

return FollowerSkillVO;