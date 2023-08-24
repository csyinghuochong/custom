local mLuaClass = require "Core/LuaClass"
local mConfigSysgoods = require "ConfigFiles/ConfigSysgoods"
local mGameModelManager = require "Manager/GameModelManager"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local mFunctionOpenManager = require "Module/MainInterface/FunctionOpenManager"
local mConfigSysmansion_plant_land = require "ConfigFiles/ConfigSysmansion_plant_land"
local MansionPlantVO = mLuaClass("MansionPlantVO");
local mIpairs = ipairs;

--土地状态  0 未开启 1 已开启(未种植种子) 2 未成熟种子(这里前端要自行区分是种子状态还是半成熟状态) 
--3 成熟种子,但在cd1状态，这个状态仆从无法自动收获 4 成熟种子，但在cd2状态, 这个状态仆从无法自动种植
function MansionPlantVO:OnLuaNew( pb_vo, id, modelVO )
	self.mID = id;
	self.mItemId = 0;
	self.mMansionVO = modelVO;
	self.mLandSysVO = mConfigSysmansion_plant_land[id];

	self:OnRecvPlantUpdate( pb_vo );
end

function MansionPlantVO:IsUnLock(  )
	return mFunctionOpenManager:IsFunctionOpen( self.mLandSysVO.open_condition );
end

function MansionPlantVO:GetLockTip(  )
	return mFunctionOpenManager:GetFunctionOpenStrByCondition( self.mLandSysVO.open_condition );
end

function MansionPlantVO:OnRecvBuyLand(  )
	self.mLandState = 1;
end

function MansionPlantVO:IsOpen( )
	return self.mLandState ~= 0;
end

function MansionPlantVO:IsCanHarvest( )
	return self.mLandState == 3 and self:IsHaveSeed() ;
end

function MansionPlantVO:IsHaveSeed( )
	return self.mItemId ~= 0;
end

function MansionPlantVO:SetSeedRipe(  )
	self.mLandState = 3;
end

function MansionPlantVO:IsNotRipe( )
	return self.mLandState == 2 and self:IsHaveSeed();
end

function MansionPlantVO:IsCanWatering(  )
	if self.mItemId == 0 then
		return false;
	else
		return self.mWaterList[ self:GetCurRipeStage( ) ] == 0 and self:IsNotRipe( );
	end
end

function MansionPlantVO:ShowStealBtn(  )
	return self.mMansionVO:ShowStealBtn( self ) ;
end

function MansionPlantVO:ShowTroubleBtn(  )
	return self.mMansionVO:ShowTroubleBtn( self ) ;
end

function MansionPlantVO:ShowWaterBtn(  )
	return self.mMansionVO:ShowWaterBtn( self ) ;
end

function MansionPlantVO:IsPlayerCanWater( id )
	local ids = self.mWaterRoles;
	for k, v in mIpairs( ids ) do
		if v == id then
			return false;
		end
	end
	return #ids < mConfigSysglobal_value[ mConfigGlobalConst.MANSION_CROP_WATER_NUMBER_ONE ] and self:IsNotRipe( );
end

function MansionPlantVO:IsPlayerCanSteal( id )
	local ids = self.mStealRoles;
	for k, v in mIpairs( ids ) do
		if v == id then
			return false;
		end
	end
	return #ids < mConfigSysglobal_value[ mConfigGlobalConst.MANSION_CROP_STEAL_NUMBER_ONE ] and self:IsCanHarvest();
end

function MansionPlantVO:IsPlayerCanTrouble( id )
	local ids = self.mTroubleRoles;
	for k, v in mIpairs( ids ) do
		if v == id then
			return false;
		end
	end
	return #ids < mConfigSysglobal_value[ mConfigGlobalConst.MANSION_CROP_TROUBLE_NUMBER_ONE ] and self:IsNotRipe( );
end

--每1/3阶段可以浇一次水
function MansionPlantVO:GetCurRipeStage()
	local total_stage = 3;
	local last_time = self:GetSeedLastRipeTime( );
	local total_time = self:GetSeedTotalRipeTime( );
	local begin_time = total_time - last_time;
	local state = ( begin_time / ( total_time / total_stage ) );
	state = math.ceil( state );
	if state < 1 then
		state = 1;
	elseif state > total_stage then
		state = total_stage;
	end

	return state;
end

function MansionPlantVO:GetPlantCurIcon(  )
	local sysVo = self.mItemSysVO.seed_info;
	local last_time = self:GetSeedLastRipeTime( );
	local total_time = self:GetSeedTotalRipeTime( );
	local begin_time = total_time - last_time;
	local rate = begin_time / total_time;

	if rate < 1 / 3 then
		return sysVo.model_init;
	elseif rate < 1 then
		return sysVo.model_half_ripe;
	else
		return sysVo.model_ripe;
	end
end

function MansionPlantVO:OnRecvPlantUpdate( pb_vo )

	self.mLandState = pb_vo.land_status;
	self.mWaterList =  pb_vo.water_list;
	self.mWaterRoles =  pb_vo.water_role_id;
	self.mStealRoles =  pb_vo.steal_role_id;
	self.mTroubleRoles =  pb_vo.trouble_role_id;
	local item_id = pb_vo.item_id;
	if item_id then
		self.mItemId = item_id;
		self.mItemSysVO = mConfigSysgoods[ item_id ];
	end
	if pb_vo.finish_time then
		self.mFinishTime = pb_vo.finish_time;
	end

	if pb_vo ~= nil then
		--print ( 'land_id', self.mID );
		--print ( 'land_status', pb_vo.land_status );
		--print ( 'item_id', pb_vo.item_id );
		--print ( 'finish_time', pb_vo.finish_time, pb_vo.finish_time - mGameModelManager.LoginModel:GetCurrentTime() );
	end
end

function MansionPlantVO:OnRecvOperateGoods(pb_vo )
	self.mOpItemType = pb_vo.type;
	self.mOpItemID = pb_vo.item_id;
	self.mOpItemNum = pb_vo.item_count;
end

function MansionPlantVO:OnRecvPlantOperate( pbMansionPlantingResult )
	self:OnRecvOperateGoods( pbMansionPlantingResult );
	self:OnRecvPlantUpdate( pbMansionPlantingResult.crop );
end

function MansionPlantVO:GetSeedTotalRipeTime(  )
	return self.mItemSysVO.seed_info.ripe_time;
end

function MansionPlantVO:GetSeedLastRipeTime(  )
	if self:IsNotRipe( ) then
		local left_time = self.mFinishTime - mGameModelManager.LoginModel:GetCurrentTime();
		return math.max(1, left_time);
	else
		return 0;
	end
end

--解析购买提示
function MansionPlantVO:ExplainBuyTip( str )
	local land_vo = self.mLandSysVO;
	return string.format( str, land_vo.cost[2], land_vo.income_add..'%', land_vo.name )
end

return MansionPlantVO;