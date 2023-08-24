local mLuaClass = require "Core/LuaClass"
local mCommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local CommonGoodsUseVO = mLuaClass("CommonGoodsUseVO",mCommonGoodsVO);
local mSuper = nil;

function CommonGoodsUseVO:OnLuaNew(id,number, selectBack,changeCount)
    self.mSelectBack = selectBack;
    self.mChangeCount = changeCount;
	mSuper = self:GetSuper(mCommonGoodsVO.LuaClassName);
	mSuper.OnLuaNew(self,id,number);
end

return CommonGoodsUseVO;
