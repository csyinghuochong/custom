local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mEventEnum = require "Enum/EventEnum"
local mConfigSysAncestor = require "ConfigFiles/ConfigSysworship_ancestor"
local mGameModelManager = require "Manager/GameModelManager"
local WorshipAncestorModel = mLuaClass("WorshipAncestorModel",mBaseModel);

function WorshipAncestorModel:OnLuaNew()
	self.mTimesTable = {1,1,1,2,2,3};
	self.mMaxTimes = 6;
end

function WorshipAncestorModel:OnRecvInfo(pbWorshipInfo)
	self.mTimes = pbWorshipInfo.times;
	local time = pbWorshipInfo.end_time;
	if time > 0 then
		local nowTime = mGameModelManager.LoginModel:GetCurrentTime();
		self.mEndTime = pbWorshipInfo.end_time;
	else
		self.mEndTime = pbWorshipInfo.end_time;
	end
	self:Dispatch(mEventEnum.ON_WORSHIP_ANCESTOR_GET_INFO);
end

function WorshipAncestorModel:OnRecvAward(pbWorshipReward)
	local nowTime = mGameModelManager.LoginModel:GetCurrentTime();
	self.mEndTime = nowTime + mConfigSysAncestor[self.mTimes + 1].cd;
	local data = {id = pbWorshipReward.goods_id,num = pbWorshipReward.goods_num};
	self:Dispatch(mEventEnum.ON_WORSHIP_ANCESTOR_GET_AWARD,data);
	self.mTimes = self.mTimes + 1;
	self:Dispatch(mEventEnum.ON_WORSHIP_ANCESTOR_GET_INFO);
end

return WorshipAncestorModel;