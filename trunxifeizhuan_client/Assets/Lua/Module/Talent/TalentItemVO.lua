local BaseLua = require "Core/BaseLua"
local mLuaClass = require "Core/LuaClass"
local mLanguage = require "Utils/LanguageUtil"
local AttributeEnum = require "Module/Talent/AttributeEnum"
local CommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local ConfigSystalent_suit = require "ConfigFiles/ConfigSystalent_suit"
local ConfigSystalent_type = require "ConfigFiles/ConfigSystalent_type"
local TalentAttributeItem = require "Module/Talent/TalentAttributeItem"
local ConfigSystalent_strength = require "ConfigFiles/ConfigSystalent_strength"
local ConfigSystalent_attribute = require "ConfigFiles/ConfigSystalent_attribute"
local ConfigSystalent_other_attribute = require "ConfigFiles/ConfigSystalent_other_attribute"
local TalentItemVO = mLuaClass("TalentItemVO",BaseLua);
local mString = string;
local mIpairs = ipairs;
local mTable = table;
local mMath = math;
local mResourceUrl = require "AssetManager/ResourceUrl"
local mGoodsIcon = mResourceUrl.goods_icon;

function TalentItemVO:OnLuaNew(pb_vo, follower)
	self.mFollowerVO = follower;
	self:InitTalentInfo( pb_vo );
	if pb_vo.main_attribute ~= nil then
		self:OnUpdateTalent( pb_vo );
		self:InitAttri( );
		self:UpdateAttri( );
	else
		self.mStrengthLevel = 0;
	end
end

function TalentItemVO:InitTalentInfo( pb_vo )
	self.mID = pb_vo.id;
	self.mGoodsType = pb_vo.type;
	self.mColor = pb_vo.color;
	self.mStarLevel = pb_vo.star_level;
	self.mPosition = pb_vo.pos;
	self.mTalentType = pb_vo.talent_type;
end
--optional int32  key           = 1;        //属性
--optional float  value         = 2;        //值
--optional float  add_value     = 3;        //上次使用心得增加的值
--optional int32  changed       = 4;        //是否已研习过，1是0否, 研习过只能改这一条
function TalentItemVO:OnUpdateTalent( pb_vo )
	self.mStrengthLevel = pb_vo.strength_level;
	local mainAttri = pb_vo.main_attribute[ 1 ];
	self.mMainAttri = { key = mainAttri.key, value = mainAttri.value };
	self.mWashAttribute = pb_vo.temp_attribute;
	local additonAttri = { };
	for k, v in mIpairs( pb_vo.add_attribute ) do
		mTable.insert( additonAttri, self:GetAttriTable( v ) );
	end
	self.mAdditionAttri = additonAttri;
end

function TalentItemVO:InitAttri( )
	local totalAttri = {};
	for i = 1, AttributeEnum.AttributeDefenseRate do
		totalAttri[i] = 0;
	end
	self.mTotalAttri = totalAttri;
end

function TalentItemVO:ResetAttri(  )
	local totalAttri = self.mTotalAttri;
	for k, v in pairs(totalAttri) do
		totalAttri[k] = 0;
	end
end

function TalentItemVO:UpdateAttri(  )
	self:ResetAttri(  );
	local totalAttri = self.mTotalAttri;
	local mainAttri = self:GetMainAttri();
	totalAttri[ mainAttri.key ] = mainAttri.value;
	for k, v in mIpairs( self:GetAdditionAttri() ) do
		totalAttri[ v.key ] = totalAttri[ v.key ] + v.value;
	end
end

--external
--心得，强化当前属性
--秘诀，改变当前属性
function TalentItemVO:IsCanStudyXinDe( sel_attri )
	local mainKey = self:GetMainAttriKey( );
	if self:IsCanStudyXinDeAttri( mainKey ) then 
		local attriMax = self:GetOtherAttributeMax( );
		return mainKey == sel_attri.key and attriMax > sel_attri.add_value;
	else
		return false;
	end
end

function TalentItemVO:IsCanStudyXinDeAttri( attri_key )
	if  attri_key == AttributeEnum.AttributeCritRate or 
		attri_key == AttributeEnum.AttributeCritHurt or 
		attri_key == AttributeEnum.AttributeEffectHitRate or 
		attri_key == AttributeEnum.AttributeEffectResistRate then
		return false;
	end
	return true;
end

function TalentItemVO:IsCanStudyMiJueAttri( attri_key )
	local add_attribute = self:GetAdditionAttri( );
	local last_study = nil;
	for k, v in pairs( add_attribute ) do
		if v.changed == 1 then
			last_study = v.key;
			break;
		end
	end
	return last_study == nil or last_study ~= attri_key;
end

function TalentItemVO:IsCanStudyMiJue( sel_attri, self_talent )
	local mainKey = self:GetMainAttriKey( );
	local attriMax = self:GetOtherAttributeMax( );
	if mainKey == sel_attri.key then
		return attriMax > sel_attri.value;
	else
		local selfMainKey = self_talent:GetMainAttriKey( );
		if selfMainKey == mainKey then
			return false;
		end
		local validAttri = self_talent:GetAdditionAttri( );
		for k, v in pairs( validAttri ) do
			if mainKey == v.key then
				return false;
			end
		end	
		return true;
	end
end

function TalentItemVO:GetTotalAttr(  )
	return self.mTotalAttri;
end

function TalentItemVO:GetMainAttri(  )
	return self.mMainAttri;
end

function TalentItemVO:GetAdditionAttri(  )
	return self.mAdditionAttri;
end

function TalentItemVO:GetWashAttribute(  )
	return self.mWashAttribute;
end

function TalentItemVO:GetUID(  )
	return self.mID;
end

function TalentItemVO:GetFollowerUID(  )
	local follower_vo = self.mFollowerVO;
	if follower_vo then
		return follower_vo.mUID;
	else
		return 0;
	end
end

function TalentItemVO:IsStrengthMax(  )
	return ConfigSystalent_strength[ self:GetLevel() + 1 ] == nil;
end

function TalentItemVO:GetGoodsType(  )
	return self.mGoodsType;
end

function TalentItemVO:GetTalentType(  )
	return self.mTalentType;
end

function TalentItemVO:GetTalengDesc(  )
	return ConfigSystalent_suit[ self:GetTalentType( ) ].suit_desc;
end

function TalentItemVO:GetLevel(  )
	return self.mStrengthLevel;
end

function TalentItemVO:GetStar( )
	local star = self.mStarLevel;
	return star ~= 0 and star or 1;
end

function TalentItemVO:GetColor(  )
	local color = self.mColor
	return color ~= 0 and color or 1;
end

function TalentItemVO:GetPosition(  )
	return self.mPosition;
end

function TalentItemVO:GetRotationZ(  )
	local position = self:GetPosition( );
	local goods_type = self:GetGoodsType( );
	if position == 1 or goods_type ~= 1 then
		return 0;
	elseif position < 4 then
		return ( position - 1 ) * -45;
	else
		return position * -45;
	end
end

function TalentItemVO:GetColorScale(  )
	local position = self:GetPosition( );
	local goods_type = self:GetGoodsType( );
	if goods_type == 1 and ( position == 2 or position == 5 ) then
		return Vector3.one * 0.95; 
	else
		return Vector3.one;
	end
end

function TalentItemVO:GetName(  )
	return ConfigSystalent_type[ self:GetTalentType() ].name;
end

function TalentItemVO:GetBgIcon(  )
	return CommonGoodsVO:GetBgIcon( self:GetColor() );
end

function TalentItemVO:GetKuangIcon(  )
	return CommonGoodsVO:GetKuangIcon( self:GetColor() );
end

function TalentItemVO:GetIcon( )
	return ConfigSystalent_type[ self:GetTalentType() ].icon;
end

function TalentItemVO:GetIconPath(  )
	return mGoodsIcon;
end

function TalentItemVO:GetColorIcon(  )
	local type_1 = self:GetGoodsType( );
	local color = self:GetColor( );
	return mString.format( 'retinue_color_%d_%d', type_1, color );
end

function TalentItemVO:GetStrengthSucceed( )
	local vo = ConfigSystalent_strength[ self:GetLevel() ];
	return (vo.succeed_rate / 100)..'%';
end

function TalentItemVO:GetStrengthCost(  )
	return ConfigSystalent_strength[ self:GetLevel() ].cost ;
end

function TalentItemVO:GetStrengthAttriTip( )
	local s_level = self:GetLevel( );
	local a_number = #self:GetAdditionAttri( );
	local next_s_level = ( mMath.floor(s_level / 3) + 1 ) * 3;
	if a_number < next_s_level / 3 then
		return mString.format( mLanguage.talent_strength_tip1,  next_s_level);
	else
		return mString.format( mLanguage.talent_strength_tip2,  next_s_level);
	end
end

function TalentItemVO:GetMainAttriKey(  )
	return self:GetMainAttri().key;
end

function TalentItemVO:GetStrengthAttri(  )
	local attri_id = self:GetMainAttriKey( );
	local key = mString.format( '%d_%d', self:GetStar(), attri_id );
	local add = ConfigSystalent_attribute[ key ].strength_add;
	return add + self:GetMainAttri().value;
end

function TalentItemVO:GetOtherAttributeStr(  )
	local sys_vo = self:GetOtherAttributeSys( );
	local min = sys_vo.min;
	local max = sys_vo.max;
	local main_key = self:GetMainAttriKey( );
	local name = TalentAttributeItem:GetName( main_key );
	local value1 = TalentAttributeItem:GetValue( main_key, min );
	local value2 = TalentAttributeItem:GetValue( main_key, max );
	return mString.format( '%s +%s-%s', name, value1, value2 );
end

function TalentItemVO:GetOtherAttributeSys( )
	local goods_type = self:GetGoodsType( );
	local color = self:GetColor( );
	local main_key = self:GetMainAttriKey( );
	local key = mString.format( '%d_%d_%d', goods_type, color, main_key );
	local sys_vo = ConfigSystalent_other_attribute[ key ];
	if sys_vo == nil then
		error( 'talent_other_attribute:'..key );
	end
	return sys_vo;
end

function TalentItemVO:GetOtherAttributeMax(  )
	return self:GetOtherAttributeSys( ).max;
end

function TalentItemVO:GetBaseValue(  )
	local talent_type = self:GetTalentType( );
	local star = self:GetStar( );
	local color = self:GetColor( );
	local sys_vo = ConfigSystalent_type[ talent_type ];
	local value = sys_vo.base_value * sys_vo.star_value[ star ] * sys_vo.qulity_value[ color ];
	return mMath.floor( value );
end

function TalentItemVO:GetSellPrice(  )
	local base_value = self:GetBaseValue( );
	return mMath.floor ( mMath.pow( base_value , 1.5 ) * 100 );
end
--克隆
function TalentItemVO:Clone(  )
	local cls = { };
	setmetatable(cls,{__index = self});
	return cls;
end

function TalentItemVO:GetNextLevelClone(  )
	local vo = self:Clone( );
	vo.mStrengthLevel = vo:GetLevel() + 1;
	return vo;
end

function TalentItemVO:IsHighQulity( )
	return self:GetLevel( ) >= 9 or self:GetColor() >= 5;
end
--end

--update
function TalentItemVO:OnStrengthTalent( pbTalent )
	self:OnUpdateTalent( pbTalent );
	self:UpdateAttri( );
end

function TalentItemVO:OnRecvTalentWash(  pbTalentAttributeAdd )
	self.mWashAttribute = pbTalentAttributeAdd.add_attribute;
end

function TalentItemVO:OnRecvTalentWashSave( pbTalent )
	self:OnUpdateTalent( pbTalent );
	self:UpdateAttri( );
end

function TalentItemVO:OnRecvTalentWashGiveUp( )
	self.mWashAttribute = nil;
end

function TalentItemVO:GetAttriTable( pbTalentAttributeAdd  )
	local attri_value =  pbTalentAttributeAdd.value + pbTalentAttributeAdd.add_value;
	return { key = pbTalentAttributeAdd.key, value = attri_value, add_value = pbTalentAttributeAdd.add_value, changed = pbTalentAttributeAdd.changed };
end

function TalentItemVO:OnRecvTalentStudy( sequence,  pbTalentAttributeAdd )
	local addAttri = pbTalentAttributeAdd.add_attribute [ 1 ];
	self.mAdditionAttri[ sequence ] = self:GetAttriTable( addAttri );
end
--end

return TalentItemVO;