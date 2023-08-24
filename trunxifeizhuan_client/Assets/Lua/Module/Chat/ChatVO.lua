local mLuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local ChatVO = mLuaClass("ChatVO", BaseLua);

--聊天数据--
--频道统一定义 1世界2系统3工会4队伍5私聊
function ChatVO:OnLuaNew(data)
	self.channel = data.channel;
	self.player_id = data.player_id;
	self.player_name = data.player_name;
	self.target_id = data.target_id;
	self.create_time = data.create_time;
	self.level = data.level;
	self.sex = data.sex;
	self.position = data.position;
	self.arena = data.arena;
	self.icon_id = data.icon_id;
	self.family_name = data.family_name;
	self.title_id = data.title_id;
	self.msg = data.msg;
	self.isShowTime = false;
	self.value = data.value;
end

return ChatVO;