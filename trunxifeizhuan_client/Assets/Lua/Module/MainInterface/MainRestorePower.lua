local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mBaseView = require "Core/BaseView"
local MainRestorePower = mLuaClass("MainRestorePower",mBaseView);
local mReceivePowerController = require "Module/ReceivePower/RecievePowerController"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local mGameTimer = require "Core/Timer/GameTimer"
local mEventEnum = require "Enum/EventEnum"
local mTimeUtil = require "Utils/TimeUtil"


function MainRestorePower:OnLuaNew(mSpRestoreBtn,mEnergeRestoreBtn,mStrengthTime,mEnergyTime)
	self.mIsShowRestoreTime = false;
	self.mIsShowView = false;
	self.mStrengthTime = mStrengthTime;
	self.mEnergyTime = mEnergyTime;
	self.mIsRestoreSp = false;
	self.mIsRestoreEnergy = false;
	self.mNowSp = 0;
	self.mNowEnergy = 0;

	self:AddBtnClickListener(mSpRestoreBtn,function() self:SetRestorePower() end);
	self:AddBtnClickListener(mEnergeRestoreBtn,function() self:SetRestorePower() end);
	self:RegisterEventListener(mEventEnum.ON_RESTORE_TIME,function(value) self:RefreshRestoreTime(value); end,false);
end

function MainRestorePower:SetRestorePower()
	if self.mIsShowRestoreTime then
		self.mStrengthTime.gameObject:SetActive(false);
		self.mEnergyTime.gameObject:SetActive(false);
		self.mStrengthTime.text = "";
		self.mEnergyTime.text = "";
		self:DisposeTimer();
		self.mIsShowRestoreTime = false;
	else
		self:GetRestoreTime();
		self.mStrengthTime.gameObject:SetActive(true);
		self.mEnergyTime.gameObject:SetActive(true);
		self.mIsShowRestoreTime = true;
	end
end

function MainRestorePower:GetRestoreTime()
	local currentTime = mGameModelManager.LoginModel:GetCurrentTime();
	local model = mGameModelManager.ReceivePowerModel;
	local roleBase = mGameModelManager.RoleModel.mPlayerBase;
	local spT = model.mRestoreSpTime - currentTime;
	local enT = model.mRestoreEnergyTime - currentTime;

	if (roleBase.sp < 100 and spT <=0) or (roleBase.energy < 10 and enT <=0) then
		mReceivePowerController:GetRestoreTime();
		self.mNowSp = roleBase.sp;
		self.mNowEnergy = roleBase.energy;
	elseif roleBase.sp >= 100 and roleBase.energy >=10 then
		self.mStrengthTime.text = mTimeUtil:TransToMinSec(0);
		self.mEnergyTime.text = mTimeUtil:TransToMinSec(0);
	else
		self:RefreshRestoreTime(nil);
	end
end

function MainRestorePower:RefreshRestoreTime(value)	
	if self.mIsShowView then
		self:OnTimerInterval();
		self.mTimerInterval = mGameTimer.SetInterval(1, function() self:OnTimerInterval() end);
	end
end

function MainRestorePower:OnTimerInterval()	
	local currentTime = mGameModelManager.LoginModel:GetCurrentTime();
	local model = mGameModelManager.ReceivePowerModel;
	local spT = model.mRestoreSpTime - currentTime;
	local enT = model.mRestoreEnergyTime - currentTime;

	if spT >= 0 then
		self.mStrengthTime.text = mTimeUtil:TransToMinSec(spT);
	else
		self.mStrengthTime.text = mTimeUtil:TransToMinSec(0);
	end

	if enT >= 0 then
		self.mEnergyTime.text = mTimeUtil:TransToMinSec(enT);
	else
		self.mEnergyTime.text = mTimeUtil:TransToMinSec(0);
	end
	self:RefreshData();
end

function MainRestorePower:RefreshData()
	local currentTime = mGameModelManager.LoginModel:GetCurrentTime();
	local roleBase = mGameModelManager.RoleModel.mPlayerBase;
	local model = mGameModelManager.ReceivePowerModel;
	local spT = 0;
	local enT = 0;

	if model.mRestoreSpTime - currentTime > 0 then
		spT = model.mRestoreSpTime - currentTime;
	end
	if model.mRestoreEnergyTime  - currentTime > 0 then
		enT = model.mRestoreEnergyTime - currentTime;
	end	

	if roleBase.sp < 100 then 
		if spT <= 0 then
			model.mRestoreSpTime = model.mRestoreSpTime + mConfigSysglobal_value[mConfigGlobalConst.PLAYER_SP_EVERYDY_DAY_LOOP_RECOVER_TIME];
			spT = model.mRestoreSpTime - currentTime;
			self:RefreshRestoreSp(roleBase.sp);
		end
	else
		if spT ~= 0 then
			spT = 0;
			self:RefreshRestoreSp(roleBase.sp);
		end
	end

	if roleBase.energy < 10 then 
		if enT <= 0 then
			model.mRestoreEnergyTime = model.mRestoreEnergyTime + mConfigSysglobal_value[mConfigGlobalConst.PLAYER_ENERGY_EVERYDY_DAY_LOOP_RECOVER_TIME];
			enT = model.mRestoreEnergyTime - currentTime;
			self:RefreshRestoreSp(roleBase.energy);
		end
	else
		if enT ~= 0 then
			enT = 0 ;
			self:RefreshRestoreSp(roleBase.energy);
		end
	end

	if spT <= 0 and enT <= 0 then
		self:DisposeTimer();
		if self.mEnergyTime ~= nil and self.mStrengthTime ~= nil then
			self.mEnergyTime.text = mTimeUtil:TransToMinSec(0);
			self.mStrengthTime.text = mTimeUtil:TransToMinSec(0);
		end			
	end
end

function MainRestorePower:RefreshRestoreSp(sp)
	if sp > self.mNowSp then
		self:Dispatch(mEventEnum.ON_RESTORE_UPDATE_STRENGTH, sp);
	else
		self.mIsRestoreSp = true;
		self.mNowSp = sp;
	end
end

function MainRestorePower:RefreshRestoreSp(Energy)
	--[[if Energy > self.mNowEnergy then
		self:Dispatch(mEventEnum.ON_RESTORE_UPDATE_ENERGY, Energy);
	else
		self.mIsRestoreEnergy = true;
		self.mNowEnergy = Energy;
	end--]]
end

function MainRestorePower:RefreshRestoreData()
	self:RefreshData();
	if self.mIsRestoreSp then
		self:Dispatch(mEventEnum.ON_RESTORE_UPDATE_STRENGTH, self.mNowSp);
		self.mIsRestoreSp = false;
	end
	if self.mIsRestoreEnergy then
		self:Dispatch(mEventEnum.ON_RESTORE_UPDATE_ENERGY, self.mNowEnergy);
		self.mIsRestoreEnergy = false;
	end
end

function MainRestorePower:IsShowView(isShow)
	self.mIsShowView = isShow;
	local currentTime = mGameModelManager.LoginModel:GetCurrentTime();
	local model = mGameModelManager.ReceivePowerModel;
	local spT = model.mRestoreSpTime - currentTime;
	local enT = model.mRestoreEnergyTime - currentTime;

	if isShow then
		if spT <= 0 or enT <= 0 then		
			self:RefreshRestoreTime(nil);
		end
	else
		self:DisposeTimer();
	end
end

function MainRestorePower:DisposeTimer()
	if self.mTimerInterval ~= nil then
		self.mTimerInterval:Dispose();
		self.mTimerInterval = nil;
	end
end

function MainRestorePower:Dispose()
	self:DisposeTimer();
end

return MainRestorePower;