local mLuaClass = require "Core/LuaClass"
local mChatModel = require "Module/Chat/ChatModel"
local mLanguageUtil = require "Utils/LanguageUtil"
local mGameModelManager = require "Manager/GameModelManager"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local mConfigSysmansion_servant = require "ConfigFiles/ConfigSysmansion_servant"
local mConfigSysmansion_servant_exp = require "ConfigFiles/ConfigSysmansion_servant_exp"
local mConfigSysmansion_servant_award = require "ConfigFiles/ConfigSysmansion_servant_award"
local MansionServantVO = mLuaClass("MansionServantVO");
local mString = string;

function MansionServantVO:OnLuaNew( pb_vo , id, modelVO)
	self.mID = id;

	self.mStates = pb_vo and 3 or 1;
	self.mName = pb_vo and pb_vo.name or '';
	self.mLevel = pb_vo and pb_vo.level or 1;
	self.mExp = pb_vo and pb_vo.exp or 0;
	self.mRewardNum = pb_vo and pb_vo.reward_num  or 0;
	self.mWorkEndTime = pb_vo and pb_vo.reward_date_prev or 0;
	self.mFreeName = pb_vo and pb_vo.free_change_name or true;
	self.mStatusToday = pb_vo and pb_vo.status_today or nil;
	
	self.mSysVO = mConfigSysmansion_servant[id];
	self.mMansionVO = modelVO;
end

--1 未被雇佣时 2 被雇佣还没取名 3雇佣时
function MansionServantVO:GetState()
	return self.mStates;
end

function MansionServantVO:IsNotHire(  )
	return self:GetState() == 1;
end

local mViewTypeVO = {
	{ path = "base_view", cls = "MansionServantHireBaseView" },
	{ path = "hire_first", cls = "MansionServantHireNewView" },
	{ path = "hire_work", cls = "MansionServantHireWorkView"}
};
function MansionServantVO:GetCurrentView(  )
	return mViewTypeVO[self:GetState()];
end

function MansionServantVO:GetHeadIcon(  )
	return self.mSysVO.mini_icon;
end

function MansionServantVO:GetName( )
	local name = self.mName;
	return name ~= '' and name or self.mSysVO.name;
end

function MansionServantVO:GetLevel( )
	return self.mLevel;
end

function MansionServantVO:GetExp(  )
	return self.mExp;
end

function MansionServantVO:IsMaxLevel(  )
	return mConfigSysmansion_servant_exp[self:GetLevel() + 1] == nil;
end

function MansionServantVO:GetNextExp(  )
	local key = mString.format( 'exp_%d', self.mID )
	return mConfigSysmansion_servant_exp[self:GetLevel() + 1][key];
end

function MansionServantVO:GetCurLevelVO( )
	return mConfigSysmansion_servant_exp[ self:GetLevel() ];
end

function MansionServantVO:GetExpRate(  )
	if self:IsMaxLevel() then
		return 1;
	else
		return self:GetExp() / self:GetNextExp( );
	end
end

function MansionServantVO:GetNextLevel( )
	return self:IsMaxLevel() and '' or self:GetLevel() + 1;
end

function MansionServantVO:IsCanHire(  )
	local needLv = self.mSysVO.open_level;
	local mansionLv = mGameModelManager.MansionModel:GetMansionLevel();
	if needLv <= mansionLv then
		return true, '';
	else
		return false, mString.format(mLanguageUtil.mansion_hire_tip, needLv);
	end
end

function MansionServantVO:IsCanAward(  )
	local key = mString.format( '%d_%d', self.mID, self.mRewardNum + 1 )
	return mConfigSysmansion_servant_award[ key ] ~= nil;
end

function MansionServantVO:GetAwardCost(  )
	local key = mString.format( '%d_%d', self.mID, self.mRewardNum + 1 )
	return mConfigSysmansion_servant_award[ key  ].cost;
end

function MansionServantVO:GetAwardExp(  )
	local key = mString.format( '%d_%d', self.mID, self.mRewardNum )
	return mString.format( mLanguageUtil.mansion_servant_get_exp,   mConfigSysmansion_servant_award[ key  ].exp);
end

function MansionServantVO:IsCanPayoff(  )
	if self.mID == 1 then
		return false;
	else
		local endTime = self.mWorkEndTime;
		return endTime == 0 and true or endTime - mGameModelManager.LoginModel:GetCurrentTime()  <= 3 * 24 * 3600;
	end
end

function MansionServantVO:ShowPlantButton(  )
	return self.mID == 3 and not self:IsStopWork();
end

function MansionServantVO:IsStopWork(  )
	if self.mID == 1 then
		return false;
	else
		local endTime = self.mWorkEndTime;
		return endTime == 0 and true or endTime < mGameModelManager.LoginModel:GetCurrentTime();
	end
end

function MansionServantVO:GetPayoff(  )
	return self.mSysVO.hire_money;
end
 
function MansionServantVO:GetUpgradeTip(  )
	local id = self.mID;
	if id == 1 then
		local feastReturn = mConfigSysglobal_value[mConfigGlobalConst.MANSION_FESST_RETURN_RATE];
		local returnAdd = self:GetCurLevelVO( ).feast;
		return mString.format(mLanguageUtil.mansion_servant_up_tip1, ( feastReturn/100 ).."%", ( returnAdd/100 ).."%" );
	elseif id == 2 then
		local cleanRoom = mConfigSysglobal_value[ mConfigGlobalConst.MANSION_CLEANUP_ADD_VALUE ];
		local roomAdd =  self:GetCurLevelVO( ).cleanup;
		return mString.format(mLanguageUtil.mansion_servant_up_tip2, cleanRoom, roomAdd);
	else 
		local harvestTime = mConfigSysglobal_value[ mConfigGlobalConst.MANSION_AUTO_HARVEST_TIME ] / 60;
		local reduce = self:GetCurLevelVO( ).harvest / 60;
		return mString.format(mLanguageUtil.mansion_servant_up_tip3, harvestTime, reduce);
	end
end

function MansionServantVO:GetUpgradeHire(  )
	local hire = self:GetPayoff( );
	if hire == 0 then
		return mLanguageUtil.mansion_no_need_payoff;
	else
		return mString.format(mLanguageUtil.mansion_need_payoff_tip, hire);
	end
end

function MansionServantVO:GetMaxCleanNum( )
	return ( 24 * 3600 ) / mConfigSysglobal_value[ mConfigGlobalConst.MANSION_CLEANUP_INTERVAL ];
end

function MansionServantVO:GetWorkState(  )
	if self:IsStopWork() then
		return '';
	end

	local id = self.mID;
	local todayWork = self.mStatusToday;
	if id == 1 then
		return  mLanguageUtil.mansion_work_status1;
	elseif id == 2 then
		return  mString.format(mLanguageUtil.mansion_work_status2, todayWork.cleanup, todayWork.boom, todayWork.house_coin);
	elseif id == 3 then
		return  mString.format(mLanguageUtil.mansion_work_status3, todayWork.boom, todayWork.plant_plan_number, self.mMansionVO:GetOpenPlantNum());
	end
end

--update
function MansionServantVO:OnRecvServantUpdate(pbMansionServant)
	--print ( 'level', pbMansionServant.level)
	--print ( 'exp', pbMansionServant.exp)
	--print ( 'reward_num', pbMansionServant.reward_num)
	--print ( 'reward_date_prev', pbMansionServant.reward_date_prev)
	--print ( 'free_change_name', pbMansionServant.free_change_name)

	if pbMansionServant.level ~= nil then
		self.mLevel = pbMansionServant.level;
	end
	if pbMansionServant.exp ~= nil then
		self.mExp = pbMansionServant.exp;
	end
	if pbMansionServant.reward_date_prev ~= nil then
		self.mWorkEndTime = pbMansionServant.reward_date_prev;
	end
	if pbMansionServant.status_today ~= nil then
		self.mStatusToday = pbMansionServant.status_today;
	end
end

function MansionServantVO:OnRecvServantHire(  )
	self.mStates = 2;
end

function MansionServantVO:OnRecvAlterSkip( )
	self.mStates = 3;
end

function MansionServantVO:OnRecvServantAlterName( name )
	self.mName = name;
	self.mStates = 3;
	self.mFreeName = false;
end

function MansionServantVO:OnRecvServantPayOffHire(  )
	
end

function MansionServantVO:OnRecvServantAwardMoney(  )
	self.mRewardNum = self.mRewardNum + 1;
end
--update 

return MansionServantVO;