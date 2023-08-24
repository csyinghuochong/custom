local mLuaClass = require "Core/LuaClass"
local DraftSpecialItemVO = mLuaClass("DraftSpecialItemVO");

function DraftSpecialItemVO:OnLuaNew(title,dataSoure)
	self.mTitle = title;
    self.mDataSoure = dataSoure;
  
end

return DraftSpecialItemVO;