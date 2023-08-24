local BaseLua = require "Core/BaseLua"
local mLuaClass = require "Core/LuaClass"
local MansionPlayerItemVO = mLuaClass("MansionPlayerItemVO", BaseLua);

function MansionPlayerItemVO:OnLuaNew( pbOtherPlayerBase )
	self.mPbData = pbOtherPlayerBase;
	self.mPlayerID = pbOtherPlayerBase.base.player_id;
end

function MansionPlayerItemVO:GetState(  )
	return nil;
end

return MansionPlayerItemVO;