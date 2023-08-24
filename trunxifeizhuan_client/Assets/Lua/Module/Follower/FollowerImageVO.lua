local mLuaClass = require "Core/LuaClass"
local FollowerImageVO = mLuaClass("FollowerImageVO");

function FollowerImageVO:OnLuaNew(data, office, callback)
	self.mID = data.office;
	self.mOfficeVO = data;
	self.mCallBack = callback;
	self.mOfficeLevel = office;
end

function FollowerImageVO:IsValidOffice(  )
	return self.mOfficeLevel >= self.mID;
end

return FollowerImageVO;