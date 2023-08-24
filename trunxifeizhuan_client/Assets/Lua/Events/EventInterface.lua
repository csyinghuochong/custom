local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local EventInterface = LuaClass("EventInterface",BaseLua);
local mEventDispatcher = require "Events/EventDispatcher"
local mEventEnum = require "Enum/EventEnum"

function EventInterface:OnLuaNew()
end

function EventInterface:GetEventEnum()
	return mEventEnum;
end

function EventInterface:RemoveEventListeners()
	local listeners = self.mListeners;
	if listeners then
		for i,v in ipairs(listeners) do
			mEventDispatcher:RemoveEventListener(v[1],v[2]);
		end
		self.mListeners = nil;
	end
end

function EventInterface:RegisterEventListener(eventType,eventListener)
	local listeners = self.mListeners;
	if not listeners then
		listeners = {};
		self.mListeners = listeners;
	end

	table.insert(listeners,{eventType,eventListener});
	mEventDispatcher:AddEventListener(eventType,eventListener);
end

function EventInterface:Dispatch(eventType,params)
	mEventDispatcher:Dispatch(eventType,params);
end

return EventInterface;
