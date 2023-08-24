local mLuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local MysteryVO = mLuaClass("MysteryVO", BaseLua);

--神秘商店数据--
function MysteryVO:OnLuaNew(data)
	self.uid = data.id;
	self.id = data.cfg_id;
	self.type = data.type;
	self.talent = data.talent;
	self.buy_tag = data.buy_tag;
end

return MysteryVO;