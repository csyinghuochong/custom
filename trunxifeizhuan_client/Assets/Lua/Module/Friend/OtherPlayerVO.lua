local mLuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local OtherPlayerVO = mLuaClass("OtherPlayerVO", BaseLua);

--玩家信息数据--
function OtherPlayerVO:OnLuaNew(data)
	self.player_id = data.player_id;
	self.name = data.name;
	self.head = data.head;
	self.sex = data.sex;
	self.level = data.level;
	self.combat = data.combat;
	self.position = data.position;
	self.title_id = data.title_id;
	self.family_id = data.family_id;
	self.family_name = data.family_name;
	self.partner_list = data.partner_list;
end

return OtherPlayerVO;