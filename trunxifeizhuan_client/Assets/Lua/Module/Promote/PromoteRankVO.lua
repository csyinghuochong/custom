local BaseLua = require "Core/BaseLua"
local mLuaClass = require "Core/LuaClass"
local PromoteRankVO = mLuaClass("PromoteRankVO", BaseLua);

function PromoteRankVO:OnLuaNew(data)
	self.rank = data.rank;
	self.id = data.player_id;
	self.name = data.name;
	self.sex = data.sex;
	self.lv = data.lv;
	self.position = data.position;
	self.score = data.score;
end

return PromoteRankVO;