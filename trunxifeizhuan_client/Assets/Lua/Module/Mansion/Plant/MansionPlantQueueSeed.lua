local mLuaClass = require "Core/LuaClass"
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView";
local MansionPlantQueueSeed = mLuaClass("MansionPlantQueueSeed",mCommonGoodsItemView);
local mSuper = nil;

function MansionPlantQueueSeed:Init()
	mSuper = self:GetSuper(mCommonGoodsItemView.LuaClassName);
	mSuper.Init(self);
end

function MansionPlantQueueSeed:OnClickIcon()
	self:Dispatch(self.mEventEnum.ON_SELECT_PLANT_QUEUE_SEED, self.mData);
end

function MansionPlantQueueSeed:OnUpdateNumber(  )
	self:ShowGoodsNumber(self.mData.mNumber);
end

function MansionPlantQueueSeed:OnPressBack(  )
	
end

return MansionPlantQueueSeed;