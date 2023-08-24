local mLuaClass = require "Core/LuaClass"
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView";
local MansionFeastCostItem = mLuaClass("MansionFeastCostItem",mCommonGoodsItemView);

function MansionFeastCostItem:Init()
	mSuper = self:GetSuper(mCommonGoodsItemView.LuaClassName);
	mSuper.Init(self);
end

function MansionFeastCostItem:OnClickIcon(  )
	self:Dispatch(self.mEventEnum.ON_SELECT_FEAST_COST_ITEM,self.mExtData);
end

function MansionFeastCostItem:SetData( data )
	self.mExtData = data;
	self:UpdateByIdAndNum( data:GetCostItemVo( ) );
end

return MansionFeastCostItem;