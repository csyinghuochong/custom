local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"

local EventDispatcher = mLuaClass("EventDispatcher",mBaseLua);

function EventDispatcher:AddEventListener(eventType,callBack)
	if not callBack then
		return;
	end
	
	local list = self[eventType];
	if not list then
		list = {};
		self[eventType] = list;
	end
	
	list[callBack] = callBack;
end

function EventDispatcher:RemoveEventListener(eventType,callBack)
	if not callBack then
		return;
	end
	
	local list = self[eventType];
	if not list then
		return;
	end
	
	list[callBack] = nil;
end

function EventDispatcher:Dispatch(eventType,params)
	print('[EVENT]' .. eventType);

	local list = self[eventType];
	if not list then
		return;
	end
	
	for _,v in pairs(list) do
		v(params);
	end
end

local instance = EventDispatcher.LuaNew();
return instance;