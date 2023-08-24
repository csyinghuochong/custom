local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mOpenLog = GameDebugConfig.openLog;
local EventDispatcher = mLuaClass("EventDispatcher",mBaseLua);

function EventDispatcher:OnLuaNew()
	self.mEventTypeList = {};
end

function EventDispatcher:AddEventListener(eventType,callBack)
	if not callBack then
		return;
	end
	local eventTypeList = self.mEventTypeList;
	local list = eventTypeList[eventType];
	if not list then
		list = {};
		eventTypeList[eventType] = list;
	end
	
	list[callBack] = callBack;
end

function EventDispatcher:RemoveEventListener(eventType,callBack)
	if not callBack then
		return;
	end
	local list = self.mEventTypeList[eventType];
	if not list then
		return;
	end
	
	list[callBack] = nil;
end

function EventDispatcher:Dispatch(eventType,params)
	if mOpenLog then
		print('[EVENT]' .. eventType);
	end
	local list = self.mEventTypeList[eventType];
	if not list then
		return;
	end
	
	for _,v in pairs(list) do
		v(params);
	end
end

function EventDispatcher:DebugEvents()
	for k,v in pairs(self.mEventTypeList) do
		local count = 0;
		for i,j in pairs(v) do
			count = count + 1;

			local info = debug.getinfo(i);
			print(k,info.source,"line:",info.linedefined);
		end
	end
end

local instance = EventDispatcher.LuaNew();
return instance;