local mLuaClass = require "Core/LuaClass"
local FollowerCommentVO = mLuaClass("FollowerCommentVO");

function FollowerCommentVO:OnLuaNew(index, pbPartnerComment)
	self.mIndex = index;
	self.mPbVO = pbPartnerComment;
	self.mPraiseNumber = pbPartnerComment.vote_times;
end

function FollowerCommentVO:GetPraiseNumber( )
	return self.mPraiseNumber;
end

function FollowerCommentVO:GetPlayerId(  )
	return self.mPbVO.player_id;
end

return FollowerCommentVO;