local mLuaClass = require "Core/LuaClass"
local mGameModelManager = require "Manager/GameModelManager"
local ConfigSysmansion_feast = require "ConfigFiles/ConfigSysmansion_feast"
local MansionFeastCostItemVO = require "Module/Mansion/Feast/MansionFeastCostItemVO"
local MansionFeastListItemVO = mLuaClass("MansionFeastListItemVO");

function MansionFeastListItemVO:OnLuaNew( pbMansionFeast )
	self.mPlayer = pbMansionFeast.base;
	self.mFeastId = pbMansionFeast.id;
	self.mPlayerId = self.mPlayer.player_id;
	self.mSelfJoin = pbMansionFeast.is_joined;
	self.mGuestNum = pbMansionFeast.prople_number;
	self.mSysVO = ConfigSysmansion_feast[ pbMansionFeast.id ];
end

function MansionFeastListItemVO:GetPlayerItemVO(  )
	local data = self.mPlayer;
    return data.sex, data.position, data.level;
end

function MansionFeastListItemVO:GetPlayerName(  )
	return self.mPlayer.name;
end

function MansionFeastListItemVO:GetFeastName( )
	return self.mSysVO.name;
end

function MansionFeastListItemVO:GetFeastGuestRate(  )
	return string.format( '%d/%d',  self.mGuestNum, self.mSysVO.guest_number );
end

function MansionFeastListItemVO:GetRemainTime(  )
	return self.mPdDetail.time_expire - mGameModelManager.LoginModel:GetCurrentTime();
end

function MansionFeastListItemVO:OnRecvFeastDetail( pbMansionFeastDetail )
	self.mPdDetail = pbMansionFeastDetail;
	self.mGuestNum = #pbMansionFeastDetail.list;
end

function MansionFeastListItemVO:OnRecvJoinFeast(  )
	self.mSelfJoin = true;
end

function MansionFeastListItemVO:IsCanJoinFeast(  )
	return not self.mSelfJoin and self.mGuestNum < self.mSysVO.guest_number;
end

function MansionFeastListItemVO:GetCostVoList( )
	local costVoList = self.mCostVoList;
	if costVoList then
		return costVoList;
	end
	costVoList = { };
	local guest_info = self.mSysVO.guest_info;
	for k, v in pairs ( guest_info ) do
		costVoList[ k ] = MansionFeastCostItemVO.LuaNew( k, v );
	end
	self.mCostVoList = costVoList;
	return costVoList;
end

return MansionFeastListItemVO;