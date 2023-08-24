local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local SortTable = require "Common/SortTable"
local mConfigSysfashion_star_up = require "ConfigFiles/ConfigSysfashion_star_up"
local mConfigSysfashion_level_up = require "ConfigFiles/ConfigSysfashion_level_up"
local mConfigSysfashion_quality_up_cost = require "ConfigFiles/ConfigSysfashion_quality_up_cost"
local mConfigSysfashion_xuanguang = require "ConfigFiles/ConfigSysfashion_xuanguang"
local mConfigSysactor = require "ConfigFiles/ConfigSysactor"
local mFollowerPowerVO = require "Module/Follower/FollowerPowerVO"

local mGameModelManager = require "Manager/GameModelManager"
local FashionVO = mLuaClass("FashionVO", mBaseLua);
local FashionAttributeVO = require"Module/Fashion/FashionAttributeVO";
local FashionStyleVO = require"Module/Fashion/FashionStyleVO";
local ipairs = ipairs;
local pairs = pairs;
local math = math;

local mMaxLevel = 15;
local mMaxStar = 5;
local mMaxQuality = 5;
local mMaxXuangguang = 6;

local mLeadConfig = mConfigSysactor[11001];
local mLeadBaseAttr = mLeadConfig.base_attri;
local mLeadAddAttr = mLeadConfig.addition_attri;
local mLeadLevel = 60;

local mMaxLeveRoleAttributes = {
	[1] = mLeadBaseAttr[1].value + mLeadAddAttr[1].value * mLeadLevel;
	[2] = mLeadBaseAttr[2].value + mLeadAddAttr[2].value * mLeadLevel;
	[3] = mLeadBaseAttr[3].value + mLeadAddAttr[3].value * mLeadLevel;
}

function FashionVO:OnLuaNew(id,config)

	if not config then
		return;
	end

	self.mId = id;
	self.mConfig = config;
	self.mPosition = config.position;
	self.mIcon = config.icon;

	self.mActived = false;
	self.mEquiped = false;
	self.mDefault = false;

	self.mScore = 0;

	self.mLevel = 0;
	self.mQuality = 0;
	self.mStar = 1;
	self.mXuanguang = 0;

	local baseAttributeType = config.base_attribute;
	local levelUpConfig = mConfigSysfashion_level_up[0];

	self.mBaseAttribute = FashionAttributeVO.LuaNew(baseAttributeType,levelUpConfig.attributes[baseAttributeType] or 0);
	self.mAdditionalAttributes = {};
	self.mTempAdditionalAttributes = {};
	self:CalculateScore();

end

function FashionVO:SetAsDefault()
	self.mIcon = nil;
	self.mDefault = true;
end

function FashionVO:GetCombatAttributes()
	local attributes = {};
	local addAttributes = self.mAdditionalAttributes;
	local baseAttribute = self.mBaseAttribute;
	for k,v in pairs(addAttributes) do
		attributes[v.type] = v.value;
	end
	attributes[baseAttribute.type] = baseAttribute.value;
	return attributes;
end

--[[
时装总评分=战斗属性评分*1+时装属性评分*1
战斗属性评分=生命*生命战力+攻击*攻击战力*（1+暴击概率*暴击伤害）*（1+速度/100）+防御*防御战力+效果命中*效果命中战力+效果抵抗*效果抵抗战力
时装属性评分=该部位所有已解锁的特征属性之和+已解锁风格数量*600
]]

function GetAddAttribute(key,add_key,attributes,role_attributes)
	local v = attributes[key] or 0;
	local role_v = role_attributes[key] or 0;
	local add_v = attributes[add_key] or 0;
	return v + role_v*add_v;
end

function FashionVO:CalculateScore()

	local totalStyleScore = 0;
	local styles = self:GetStyles();
	for k,v in pairs(styles) do
		if v.actived then
			totalStyleScore = totalStyleScore + v.value;
		end
	end

	local use_number = 0;
	local star = self.mStar;
	local uses = self.mConfig.uses;
	for k,v in pairs(uses) do
		if star >= v.actived_star then
			use_number = use_number + 1;
		end
	end

	local role_attributes = mMaxLeveRoleAttributes;
	local attributes = self:GetCombatAttributes();

	local hp = GetAddAttribute(1,9,attributes,role_attributes);
	local atk = GetAddAttribute(2,10,attributes,role_attributes);
	local def = GetAddAttribute(3,11,attributes,role_attributes);

	local crit_rate = attributes[4] or 0;
	local crit_hurt = attributes[5] or 0;
	local hit = attributes[6] or 0;
	local hit_resist = attributes[7] or 0;
	local atk_speed = attributes[8] or 0;

	local power_params = mFollowerPowerVO.mPowerParam;

	local hp_power = hp * power_params.hp;
	local atk_power = atk * power_params.attack * (1 + crit_rate*crit_hurt) * (1+ atk_speed/100);
	local def_power = def * power_params.defense ;
	local hit_power = hit * power_params.hit;
	local hit_resist_power = hit_resist * power_params.resist ;
	
	self.mScore = totalStyleScore + use_number*600 + hp_power + atk_power + def_power + hit_power + hit_resist_power;

end

local function SortStyle(a,b)
	return a.value < b.value;
end 
function FashionVO:GetStyles()
	local styles = self.mStyles;
	if not styles then
		styles = {};
		local style_properties = self.mConfig.style_properties;
		local star = self.mStar;
		for k,v in ipairs(style_properties) do
			local actived_star = v.actived_star;
			local style = FashionStyleVO.LuaNew(v.type,v.value,actived_star);
			if star >= actived_star then
				style:SetActive();
			end
			styles[k] = style;
		end
		table.sort( styles, SortStyle);

		self.mStyles = styles;
	end
	return styles;
end

function FashionVO:GetNextStarInfos()
	local nextStarInfos = self.mNextStarInfos;
	if not nextStarInfos then
		local config = self.mConfig;
		nextStarInfos = {{},{},{},{},{}};

		local uses = config.uses;
		local styles = self:GetStyles();

		for k,v in ipairs(uses) do
			local actived_star = v.actived_star;
			local info = nextStarInfos[actived_star];
			info.use = v.type;
		end

		for k,v in ipairs(styles) do
			local actived_star = v.actived_star;
			local info = nextStarInfos[actived_star];
			info.style = v;
		end
		self.mNextStarInfos = nextStarInfos;
	end

	return nextStarInfos;
end

function FashionVO:GetNextStarInfo()
	local nextStarInfos = self:GetNextStarInfos();
	return nextStarInfos[self.mStar+1];
end

function FashionVO:OnRecvData(data)
	local level = data.level;
	local star = data.star;
	local quality = data.quality;
	local xuanguang = data.color;

	if level ~= self.mLevel then
		self:SetLevel(level);
	end

	if quality ~= self.mQuality then
		self:SetQuality(quality);
	end

	if star ~= self.mStar then
		self:SetStar(star);
	end

	if xuanguang ~= self.mXuanguang then
		self:SetXuanguang(xuanguang);
	end
	self:UpdateAttributes(self.mAdditionalAttributes,data.add_attribute);
	self:UpdateAttributes(self.mTempAdditionalAttributes,data.temp_attribute);
	self.mScore = data.score;
	self.mEquiped = data.wear > 0;
	self.mActived = true;

end

function FashionVO:UpdateAttributes(attributes,newAttributes)
	if newAttributes then
		for k,v in ipairs(newAttributes) do
			local attribute = attributes[k];
			if not attribute then
				attribute = FashionAttributeVO.LuaNew(v.key,v.value);
				attributes[k] = attribute;
			end
			attribute:UpdateData(v.key,v.value);

		end
	end
end

function FashionVO:SetEquiped(value)
	self.mEquiped = value;
end

function FashionVO:SetActive()
	self.mActived = true;
end

function FashionVO:IsMaxLevel()
	return self.mLevel >= mMaxLevel;
end

function FashionVO:IsMaxStar()
	return self.mStar >= mMaxStar;
end

function FashionVO:IsMaxQuality()
	return self.mQuality >= mMaxQuality;
end

function FashionVO:IsMaxXuangguang()

	return self.mXuanguang >= mMaxXuangguang;
end
function FashionVO:SetStar(star)

	local styles = self:GetStyles();
	for k,v in pairs(styles) do
		if star >= v.actived_star then
			v:SetActive();
		end
	end
	self.mStar = star;
end

function FashionVO:SetLevel(level)

	local baseAttribute = self.mBaseAttribute;
	local baseAttributeType = baseAttribute.type;
	local levelUpConfig = mConfigSysfashion_level_up[level];
	baseAttribute.value = levelUpConfig.attributes[baseAttributeType] or 0;
	self.mLevel = level;
end

function FashionVO:SetQuality(quality)
	self.mQuality = quality;
end

function FashionVO:SetXuanguang(xuanguang)
	local styles = self:GetStyles();
	for k,v in pairs(styles) do
		local info = mConfigSysfashion_xuanguang[xuanguang];
		if info then
			local add_value = info.grades1;
			if k < 3 then
				add_value = info.grades2;
			end
			v:UpdateValue(v.base_value + add_value);
		end
	end
	self.mXuanguang = xuanguang;
end

function FashionVO:GetLevelUpCost()
	return mConfigSysfashion_level_up[self.mLevel];
end

function FashionVO:GetQualityUpCost()
	return mConfigSysfashion_quality_up_cost[self.mPosition.."_"..self.mQuality];
end

function FashionVO:GetStarUpCost()
	return mConfigSysfashion_star_up[self.mStar];
end

function FashionVO:GetXuangguangCost()
	return mConfigSysfashion_xuanguang[self.mXuanguang];
end

local mRcoveryCost = 
{
	cost = {{goods = 1010901,number = 1}};
};

function FashionVO:GetRecoveryCost()
	return mRcoveryCost;
end

function FashionVO:Copy(src)

	self.mId = src.mId;
	self.mConfig = src.mConfig;
	self.mActived = src.mActived;

	self.mScore = src.mScore;

	self.mLevel = src.mLevel;
	self.mQuality = src.mQuality;
	self.mStar = src.mStar;
	self.mXuanguang = src.mXuanguang;
	
	self.mIcon = src.mIcon;
	
	local baseAttribute = self.mBaseAttribute;
	if not baseAttribute then
		baseAttribute = FashionAttributeVO.LuaNew();
		self.mBaseAttribute = baseAttribute;
	end
	baseAttribute:Copy(src.mBaseAttribute);
end

local mTest = nil;

function FashionVO:CheckEnoughGoods(cost_list)
	if not cost_list or mTest then
		return true;
	end
	local bag = mGameModelManager.BagModel;
	for i,v in ipairs(cost_list) do
		local goodsVo = bag:GetGoodsByGoodsId(v.goods);
		local goodsNumber = 0;
		if goodsVo then
			goodsNumber = goodsVo.mNumber;
		end
		if goodsNumber < v.number then
			return false;
		end
	end
	return true;
end

function FashionVO:CheckEnoughCoins(cost_list)
	if not cost_list or mTest then
		return true;
	end
	local playerData = mGameModelManager.RoleModel.mPlayerBase;

	for i,v in ipairs(cost_list) do
		if self:CheckEnoughCoin(v.goods,v.number) == false then
			return false;
		end
	end

	return true;
end

function FashionVO:CheckEnoughCoin(coin_type,cost_number)
	local playerData = mGameModelManager.RoleModel.mPlayerBase;
	if coin_type == 1000002 then
		return playerData.coin >= cost_number;
		elseif coin_type == 1000003 then
			return playerData.gold >= cost_number;
			elseif coin_type == 1000006 then
				return playerData.dress_coin >= cost_number;
			end
	return false;
end

function FashionVO:CanCombine()
	local config = self.mConfig;
	if config.from == 1 then
		return self:CheckEnoughGoods(config.cost);
	end
end

function FashionVO:CanGetNow()
	local config = self.mConfig;
	local from = config.from;
	if from == 2 then
		return self:CheckEnoughCoins(config.cost);
	else
		return self:CheckEnoughGoods(config.cost);
	end
end

return FashionVO;