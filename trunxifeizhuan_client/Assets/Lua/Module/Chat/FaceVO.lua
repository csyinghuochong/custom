local mLuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local FaceVO = mLuaClass("FaceVO", BaseLua);

function FaceVO:OnLuaNew(id)
	self.id = id;
	self.icon = "chat_face_"..id;
end

return FaceVO;