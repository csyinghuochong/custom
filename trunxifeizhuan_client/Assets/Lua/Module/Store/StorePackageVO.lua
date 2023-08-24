local mLuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local StorePackageVO = mLuaClass("StorePackageVO", BaseLua);

function StorePackageVO:OnLuaNew(data,isShowDay)
	self.goods_id = data.goods_id;
	self.count = data.count;
	self.isShowDay = isShowDay;
end

return StorePackageVO;