local mLuaClass = require "Core/LuaClass"
local SeverItemVO = mLuaClass("SeverItemVO");

function SeverItemVO:OnLuaNew(id, name, callBack)
	self.mID = id;
	self.mCallBack = callBack;
	self.mServerName = name;
end

return SeverItemVO;