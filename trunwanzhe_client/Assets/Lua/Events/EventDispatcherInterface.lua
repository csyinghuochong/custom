local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mEventDispatcher = require "Events/EventDispatcher"

local EventDispatcherInterface = mLuaClass("EventDispatcherInterface",mBaseLua);

function EventDispatcherInterface:AddEventListener(eventType,callBack)
	mEventDispatcher:AddEventListener(eventType,callBack);
end

function EventDispatcherInterface:RemoveEventListener(eventType,callBack)
	mEventDispatcher:RemoveEventListener(eventType,callBack);
end

function EventDispatcherInterface:Dispatch(eventType,params)
	mEventDispatcher:Dispatch(eventType,params);
end

return EventDispatcherInterface;