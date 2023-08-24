local mLuaClass = require "Core/LuaClass"
local mEventDispatcherInterface = require "Events/EventDispatcherInterface"

local BaseModel = mLuaClass("BaseModel",mEventDispatcherInterface);

return BaseModel;