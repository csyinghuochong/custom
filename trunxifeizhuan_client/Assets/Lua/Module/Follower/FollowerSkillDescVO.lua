local mLuaClass = require "Core/LuaClass"
local FollowerSkillDescVO = mLuaClass("FollowerSkillDescVO");
local mString = require "string"

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgHurtRatio = mLanguageUtil.follower_hurt_ratio;
local mLgProbability = mLanguageUtil.follower_probability;
local mLgCD = mLanguageUtil.follower_cd;

--1额外伤害
--2触发概率
--3缩减冷却回合
function FollowerSkillDescVO:OnLuaNew(index, cur_lv, skill_vo, active)
	self.mIndex = index;
	self.mSkillVO = skill_vo;

	local key = skill_vo.key;
	local value = skill_vo.value;

	local desc = '';
	if key == 1 then
		desc = mString.format(mLgHurtRatio, index, value, '%'); 
	elseif key == 2 then
		desc = mString.format(mLgProbability,index, value, '%');
	elseif key == 3 then
		desc = mString.format(mLgCD, index, value);
	end
	self.mDesc = desc;
	self.mActive = cur_lv >= index and active;
end

return FollowerSkillDescVO;