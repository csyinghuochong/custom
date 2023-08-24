local mLuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local mConfigSysfollower_office_up = require "ConfigFiles/ConfigSysfollower_office_up"
local mConfigSyschild_star_exp = require "ConfigFiles/ConfigSyschild_star_exp"
local mConfigSyschild_quality_exp = require "ConfigFiles/ConfigSyschild_quality_exp"
local mConfigSyschild_model = require "ConfigFiles/ConfigSyschild_model"
local mString = string
local ChildVO = mLuaClass("ChildVO", BaseLua);

local MAX_STAR = 20;
local MAX_QUALITY = 4;

local mChildType = 
{
    "<color=#00FF00>冒险型</color>",
    "<color=#00FFFF>文静型</color>",
    "<color=#FF00FF>沉稳型</color>",
    "<color=#FF7A00>睿智型</color>",
}

local mChildAptitude = 
{
    "普通","良好","优秀","完美",
}

local mChildAddTitle =
{
    "攻击：","防御：","体力：","速度：",
}

local mChildAdditionData =
{
    2.5,5,7.5,10,
}

local mChildLevelData =
{
    0.5,1,1.5,2,
}

--子女信息--
function ChildVO:OnLuaNew(data)
	self.id = data.id;
	self.child_id = data.child_id;
	self.name = data.name;
	self.sex = data.sex;
	self.character = data.character;
	self.quality = data.quality;
	self.quality_exp = data.quality_exp;
	self.star_level = data.star_level;
	self.star_level_exp = data.star_level_exp;
	self.partner_id = data.partner_id;
	self.use_partner = data.use_partner;
	self.main_attribute = data.main_attribute;
	self.add_attribute = data.add_attribute;
	self.bord = self:GetBord();
	self.back = self:GetBack();
end

function ChildVO:GetChildTypeWithColor()
	return mChildType[self.character];
end

function ChildVO:GetProperty(isNext)
	local starLevel;
	if isNext and self.star_level < MAX_STAR then
		starLevel = self.star_level + 1;
	else
		starLevel = self.star_level;
	end
	local character = self.character;
	local config = mConfigSyschild_star_exp[starLevel];
	local propertyTable = {config.property1,config.property2,config.property3,config.property4};
	return propertyTable[character];
end

function ChildVO:GetMaxExp()
	local starLevel = self.star_level;
	local config = mConfigSyschild_star_exp[starLevel];
	return config.exp;
end

function ChildVO:GetMaxQualityExp()
	local quality = self.quality;
	local config = mConfigSyschild_quality_exp[quality];
	return config.exp;
end

function ChildVO:GetAddTitle()
	local character = self.character;
	return mChildAddTitle[character];
end

function ChildVO:GetAptitude(Quality)
	local quality = Quality ~= nil and Quality or self.quality;
	if quality > MAX_QUALITY then
		quality = MAX_QUALITY;
	end
	return mChildAptitude[quality];
end

function ChildVO:GetAddData(nextQuality,nextStar)
	local quality;
	local star_level;
	quality = nextQuality ~= nil and nextQuality or self.quality;
	star_level = nextStar ~= nil and nextStar or self.star_level;
	if quality > MAX_QUALITY then
		quality = MAX_QUALITY;
	end
	if star_level > MAX_STAR then
		star_level = MAX_STAR;
	end
	local num = mChildAdditionData[quality] + star_level * mChildLevelData[quality];
	return num.."%";
end

function ChildVO:GetStarCostGood(isNormal)
	local config = mConfigSyschild_model[self.child_id];
	if isNormal then
		return config.star_normal;
	else
		return config.star_super;
	end
end

function ChildVO:GetQualityCostGood(isNormal)
	local config = mConfigSyschild_model[self.child_id];
	if isNormal then
		return config.quality_normal;
	else
		return config.quality_super;
	end
end

function ChildVO:GetIcon()
	return self:GetShowOfficeVO().mini_icon;
end

function ChildVO:GetBord()
	if self.quality > MAX_QUALITY then
		return "common_bag_iconframe_"..MAX_QUALITY;
	end
	return "common_bag_iconframe_"..self.quality;
end

function ChildVO:GetBack()
	if self.quality > MAX_QUALITY then
		return "common_bag_iconframe_"..MAX_QUALITY.."s";
	end
	return "common_bag_iconframe_"..self.quality.."s";
end

function ChildVO:GetUIModelVO( position )
	local Follower3DModelVO = require "Module/Follower/Follower3DModelVO";
	return Follower3DModelVO:GetModelVO( self:GetUIModel(), false, 1, position)
end

function ChildVO:GetUIModel()
	return self:GetShowOfficeVO().model;
end

function ChildVO:GetShowOfficeVO(  )
	local key = mConfigSyschild_model[self.child_id].model;
	return mConfigSysfollower_office_up[tostring(key)];
end

function ChildVO:IsLead()
	return false;
end

return ChildVO;