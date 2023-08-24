local BaseLua = require "Core/BaseLua"
local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mLanguageUtil = require "Utils/LanguageUtil"
local mGameModelManager = require "Manager/GameModelManager"
local mMansionPlantVO = require "Module/Mansion/Plant/MansionPlantVO"
local mMansionRankInfo = require "Module/Mansion/Rank/MansionRankInfo"
local ConfigSysmansion_level = require "ConfigFiles/ConfigSysmansion_level"
local mMansionServantVO = require "Module/Mansion/Servant/MansionServantVO";
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local mConfigSysmansion_operation_event = require "ConfigFiles/ConfigSysmansion_operation_event"
local MansionBaseVO = mLuaClass("MansionBaseVO", BaseLua);
local mIpairs = ipairs;
local mPairs = pairs;

function MansionBaseVO:OnLuaNew( data )
	self.mPbData = data;
	self:OnRecvPlantInfo( data.plant.list );
	self:OnRecvServantInfo( data.list );
end

function MansionBaseVO:OnAtlerMansionName( name )
	self.mPbData.name = name;
end

local mansion_no_name = mLanguageUtil.mansion_no_name;
function MansionBaseVO:GetMansionName( )
	local name = self.mPbData.name;
	return name ~= '' and name or string.format(mansion_no_name, self:GetDefaultName());
end

function MansionBaseVO:IsSelfMansion(  )
	return self.mMansionType == 1;
end

function MansionBaseVO:IsVisitMansion(  )
	return self.mMansionType == 2;
end

function MansionBaseVO:IsAgentMansion(  )
	return self.mMansionType == 3;
end

function MansionBaseVO:GetMansionLevel( )
	return mMansionRankInfo:GetLevelByBoom( self:GetTotalBoom() );
end

function MansionBaseVO:GetAssetByType( a_type )
	local asset = self.mPbData.day_assets;
	for k, v in mIpairs(asset) do
		if v.key == a_type then
			return v.value;
		end
	end
	return 0;
end

function MansionBaseVO:GetTodayBoom(  )
	return self:GetAssetByType( mGameModelManager.RoleModel.mTypeEnum.mEnumCostBoom )
end

function MansionBaseVO:GetTodayMoney(  )
	return self:GetAssetByType( mGameModelManager.RoleModel.mTypeEnum.mEnumCostMansion );
end

function MansionBaseVO:GetTotalBoom(  )
	return  self.mPbData.target_mansion.boom_target;
end

function MansionBaseVO:GetTotalMoney(  )
	return self.mPbData.target_mansion.house_coin_target;
end

function MansionBaseVO:GetNeedBoom( )
	local level = self:GetMansionLevel();
	if ConfigSysmansion_level[ level + 1 ] then
		return ConfigSysmansion_level[ level + 1 ].boom_need;
	else
		return ConfigSysmansion_level[ level ].boom_need;
	end
end

function MansionBaseVO:IsMaxLevel(  )
	return ConfigSysmansion_level[self:GetMansionLevel() + 1] == nil;
end

function MansionBaseVO:GetBoomRate(  )
	if self:IsMaxLevel() then
		return 1;
	else
		return self:GetTotalBoom() / self:GetNeedBoom();
 	end
end

function MansionBaseVO:GetBoomRateStr(  )
	return string.format('%d/%d', self:GetTotalBoom(), self:GetNeedBoom())
end

function MansionBaseVO:GetDefaultName(  )
	return self.mPbData.target_mansion.base.name;
end

function MansionBaseVO:GetPlayerItemVO(  )
	local data = self.mPbData.target_mansion.base;
    return data.sex, data.position, data.level;
end

function MansionBaseVO:GetPlayerID(  )
    return self.mPbData.target_mansion.base.player_id;
end

function MansionBaseVO:GetHeadIcon(  )
	local sex = self:GetPlayerItemVO();
	return sex == 2 and 'city_head_10201' or 'city_head_10103';
end

--是否可以执行某项具体的操作
--自己的府邸都可以操作, 拜访的府邸不能操作, 代管的府邸看权限设置
function MansionBaseVO:IsCanOperateID( id )
	return false;
end

function MansionBaseVO:CanOperateClean(  )
	return self:IsCanOperateID() and self.mPbData.cleanup <= 75;
end

function MansionBaseVO:CanOperateServant(  )
	return self:IsCanOperateID();
end

function MansionBaseVO:CanOperatePlant(  )
	return self:IsCanOperateID();
end

--府邸信息更新
function MansionBaseVO:OnRecvMansionInfoUpdate( pb_info )
	
end

--清洁返回
function MansionBaseVO:OnRecvMansionClean( clean )
	self.mPbData.cleanup = clean;
end

--种植相关
local mGlobalUtil = require "Utils/GlobalUtil"
function MansionBaseVO:OnRecvPlantInfo( list )
	local plantInfo = {};
	for k, v in mIpairs( list ) do
		local land_id = v.land_id;
		plantInfo[ land_id ] = mMansionPlantVO.LuaNew(v, land_id, self );
	end
	self.mPlantInfoList = plantInfo;
end

function MansionBaseVO:GetOpenPlantNum(  )
	local num = 0;
	for k, v in pairs( self.mPlantInfoList ) do
		num  = num + ( v:IsOpen() and 1 or 0 );
	end
	return num;
end

--external function
function MansionBaseVO:ShowTroubleBtn( plant )
	return false;
end

function MansionBaseVO:ShowStealBtn( plant )
	return false;
end

function MansionBaseVO:ShowWaterBtn( plant )
	return false;
end
--end

function MansionBaseVO:UpdatePlantOperateTime( op_type, target_id )
	if op_type == nil or target_id == nil then
		return;
	end
	local pbData = self.mPbData.plant;
	if op_type == 4 then
		pbData.water_count = pbData.water_count + 1;
	elseif op_type == 5 then
		pbData.trouble_count = pbData.trouble_count + 1;
	elseif op_type == 6 then
		pbData.steal_count = pbData.steal_count + 1;
	end
end

--种植操作类型 1种植 2铲除 3施肥 4浇水 5捣乱 6 偷取 7 收获
function MansionBaseVO:OnRecvPlantOperate( pbMansionPlantingResult, crop )
	local op_type = pbMansionPlantingResult.type;
	local target_id = pbMansionPlantingResult.target_id;
	self:UpdatePlantOperateTime( op_type, target_id );
	local data = self.mPlantInfoList[ pbMansionPlantingResult.crop.land_id ];  
	data:OnRecvPlantOperate( pbMansionPlantingResult );
	return data;
end

function MansionBaseVO:IsTypeLandOpen( land_type )
	for k, v in mPairs(self.mPlantInfoList) do
		if v.mLandSysVO.land_type == land_type and v:IsOpen() then
			return true;
		end
	end

	return false;
end

function MansionBaseVO:GetTotalStealNumber(  )
	return self.mPbData.plant.steal_count, mConfigSysglobal_value[ mConfigGlobalConst.MANSION_TOTAL_STEAL_NUMBER ];
end

function MansionBaseVO:GetWaterTroubleNumber(  )
	local pbData = self.mPbData.plant;
	return pbData.water_count + pbData.trouble_count , mConfigSysglobal_value[ mConfigGlobalConst.MANSION_WATERING_TROUBLE_NUMBER ];
end

--仆从相关
function MansionBaseVO:OnRecvServantInfo( list )
	local servantList =  mSortTable.LuaNew(function(a, b) return self:ServantSort(a,b) end, nil, true);
	for i = 1, 3 do
		servantList:AddOrUpdate( i,  mMansionServantVO.LuaNew(self:GetServantInfo(i, list), i, self) );
	end
	self.mServantList =  servantList;
end
function MansionBaseVO:ServantSort( a, b )
	return a.mID < b.mID;
end
function MansionBaseVO:GetServantInfo( id, list )
	for k, v in mIpairs( list ) do
		if v.id == id then
			return v;
		end
	end
	return nil;
end
--end

--NPC事件
function MansionBaseVO:OnRecvUpdateNPCEvent( id )
	self.mPbData.event_npc_id = id;
end

function MansionBaseVO:OnRecvNPCEventReward(  )
	self.mPbData.event_npc_id = 0;
end

function MansionBaseVO:OnRecvNPCEventDelete(  )
	self.mPbData.event_npc_id = 0;
end

function MansionBaseVO:IsHaveNpcStore(  )
	local event_id = self.mPbData.event_npc_id;
	if event_id ~= 0 then
		return mConfigSysmansion_operation_event[ event_id ].type == 1;
	else
		return false;
	end
end
--end

function MansionBaseVO:GetSelfPlayerID(  )
	return mGameModelManager.RoleModel.mPlayerBase.player_id;
end

return MansionBaseVO;
