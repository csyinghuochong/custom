local mLuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local FriendVO = mLuaClass("FriendVO", BaseLua);

--好友数据--
function FriendVO:OnLuaNew(data,type)
	self.id = data.id;
	self.name = data.name;
	self.head = data.head;
	self.sex = data.sex;
	self.online = data.online;
	self.last_online_time = data.last_online_time;
	self.combat = data.combat;
	self.level = data.level;
	self.vip = data.vip;
	self.position = data.position;
	self.receive_flag = data.receive_flag;
	self.send_flag = data.send_flag;
	self.isDelete = false;
	self.type = type;					--查找界面三种item类型标记（1为查找，2为申请，3为推荐）
end

return FriendVO;