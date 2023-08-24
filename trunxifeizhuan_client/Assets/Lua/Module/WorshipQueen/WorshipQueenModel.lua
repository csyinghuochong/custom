local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mEventEnum = require "Enum/EventEnum"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local WorshipQueenModel = mLuaClass("WorshipQueenModel",mBaseModel);

function WorshipQueenModel:OnLuaNew()
	self.mIsEverGetInfo = false;
	self.mMaxTimes = mConfigSysglobal_value[mConfigGlobalConst.WORSHIP_QUEEN_LIMIT];
	self.mTimesTable = {0,0};
end

function WorshipQueenModel:OnRecvWishAward(pbWorshipReward)
	self.mTimesTable[1] = self.mTimesTable[1] + 1;
	local data = {id = pbWorshipReward.goods_id,num = pbWorshipReward.goods_num};
	self:Dispatch(mEventEnum.ON_WORSHIP_QUEEN_GET_AWARD,data);
end

function WorshipQueenModel:OnRecvGiftAward(pbWorshipReward)
	self.mTimesTable[2] = self.mTimesTable[2] + 1;
	local data = {id = pbWorshipReward.goods_id,num = pbWorshipReward.goods_num};
	self:Dispatch(mEventEnum.ON_WORSHIP_QUEEN_GET_AWARD,data);
end

function WorshipQueenModel:OnRecvQueenInfo(pbQueenInfo)
	self.mTimesTable[1] = pbQueenInfo.times1;
	self.mTimesTable[2] = pbQueenInfo.times2;
	self.mTimeEnd = pbQueenInfo.end_time;
	self:Dispatch(mEventEnum.ON_WORSHIP_QUEEN_GET_INFO);
end

return WorshipQueenModel;