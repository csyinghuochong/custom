local mLuaClass = require "Core/LuaClass"
local mChatModel = require "Module/Chat/ChatModel"
local mConfigSysmansion_events = require "ConfigFiles/ConfigSysmansion_events"
local MansionEventVO = mLuaClass("MansionEventVO");

function MansionEventVO:OnLuaNew( pbMansionEvent )
	self.mPbData = pbMansionEvent;
	self.mID = pbMansionEvent.params.msg.id;
	local sys_vo = mConfigSysmansion_events[self.mID];

	self.mSysVO = sys_vo;
	self.mContentStr = mChatModel:GetCreatedString(sys_vo.msg, pbMansionEvent.params.msg);
end

function MansionEventVO:GetPlayerItemVO(  )
	local data = self.mPbData.params.base;
    return data.sex, data.position, data.level;
end

function MansionEventVO:GetPlayerID(  )
	return self.mPbData.params.base.player_id;
end

return MansionEventVO;