local mLuaClass = require "Core/LuaClass"
local DraftDataVO = mLuaClass("DraftDataVO");

function DraftDataVO:OnLuaNew(type,goodsId,name,id,sysVO,chipId)
	self.mType = type;
    self.mGoodsId = goodsId;  --显示的图标的物品ID
    self.mId = id;       ------排序用的
    self.mName = name;
    self.mSysVO = sysVO;
    self.mChipId = chipId;  --dataSoure的KEY(需要的道具)
end


return DraftDataVO;