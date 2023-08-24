local mLuaClass = require "Core/LuaClass"
local mLanguageUtil = require "Utils/LanguageUtil"
local mGameModelManager = require "Manager/GameModelManager"
local MansionFeastTypeVo = mLuaClass("MansionFeastTypeVo");
local mString = string;

function MansionFeastTypeVo:OnLuaNew(id, sys_vo)
	self.mID = id;
	self.mSysVO = sys_vo;
end

function MansionFeastTypeVo:UpdateFeastVO(mansion_lv, pb_vo)
	self.mPbVO = pb_vo;
	self.mMansionLv = mansion_lv;
end

function MansionFeastTypeVo:IsLock(  )
	return self.mMansionLv < self.mSysVO.level;
end

function MansionFeastTypeVo:IsOpen(  )
	return self.mPbVO.id == self.mID and self:GetRemainTime( ) > 0;
end

function MansionFeastTypeVo:GetRemainTime(  )
	return self.mPbVO.time_expire - mGameModelManager.LoginModel:GetCurrentTime();
end

local mTip = mLanguageUtil.mansion_feast_open_tip1;
function MansionFeastTypeVo:GetOpenTip( )
	return mString.format( mTip,  self.mSysVO.level);
end

function MansionFeastTypeVo:GetGuestRate(  )
	return mString.format( '%d/%d', self.mPbVO.prople_number, self.mSysVO.guest_number );
end

function MansionFeastTypeVo:IsHaveGuest( )
	return self:GetRemainTime( ) > 0 ;
end

return MansionFeastTypeVo;