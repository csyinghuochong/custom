local mLuaClass = require "Core/LuaClass"
local mEventDispatcherInterface = require "Events/EventDispatcherInterface"

local BaseModel = mLuaClass("BaseModel",mEventDispatcherInterface);

function BaseModel:OnDispose()
	
end

return BaseModel;