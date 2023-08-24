local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mCommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local MansionComposeGoodsVO = mLuaClass("MansionComposeGoodsVO",mCommonGoodsVO);
local mSuper = nil;

function MansionComposeGoodsVO:OnLuaNew(id, number, vo, goodsEnough)
    self.mCompositionVo = vo;
    self.mGoodsEnough = goodsEnough;
  	self.mKuang = "common_bag_iconback_1";
     
  	mSuper = self:GetSuper(mCommonGoodsVO.LuaClassName);
  	mSuper.OnLuaNew(self, id, number, nil, false);
end

function MansionComposeGoodsVO:GetComposeCostGoods(  )
	local goods_data = mSortTable.LuaNew();
   	for i,v in ipairs( self.mCompositionVo.compose_cost) do
	   goods_data:AddOrUpdate(i,mCommonGoodsVO.LuaNew(v.goods_id,v.goods_number));
    end
    return goods_data;
end

function MansionComposeGoodsVO:IsGoodsGray(  )
	return not self.mGoodsEnough and self.mNumber == 0;
end

return MansionComposeGoodsVO;