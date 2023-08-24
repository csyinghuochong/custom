local mLuaClass = require "Core/LuaClass"
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView";
local MansionPlantBagItem = mLuaClass("MansionPlantBagItem",mCommonGoodsItemView);
local mSuper = nil;

function MansionPlantBagItem:Init()
	mSuper = self:GetSuper(mCommonGoodsItemView.LuaClassName);
	mSuper.Init(self);
end

function MansionPlantBagItem:OnClickIcon()
	self:Dispatch(self.mEventEnum.ON_SELECT_PLANT_SEED_ITEM, self.mData);
end

return MansionPlantBagItem;