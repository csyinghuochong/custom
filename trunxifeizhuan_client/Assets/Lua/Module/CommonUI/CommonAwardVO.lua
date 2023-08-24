local mLuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local mCommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local CommonAwardVO = mLuaClass("CommonAwardVO",BaseLua);

function CommonAwardVO:OnLuaNew(goods_id)
	self.mGoodsID = goods_id;
	self.mGoodsData = mCommonGoodsVO.LuaNew(goods_id,0,nil,false);
end

return CommonAwardVO;
