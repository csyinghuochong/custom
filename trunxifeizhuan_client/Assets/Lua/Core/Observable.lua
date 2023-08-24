local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local Observable = LuaClass("Observable",BaseLua);
local Pairs = pairs;

function Observable:Notify(type,params)

	local observers = self.mObservers;

	if not observers then
		return;
	end

	local observerType = observers[type];

	if not observerType then
		return;
	end

	self:LogEvent(type);

	for k,v in Pairs(observerType) do
		v(params);
	end
end

function Observable:LogEvent(type)
end

function Observable:RemoveObserver(type,o)
	local observers = self.mObservers;

	if not observers then
		return;
	end

	local observerType = observers[type];

	if not observerType then
		return;
	end

	observerType[o] = nil;
end

function Observable:AddObserver(type,o)

	local observers = self.mObservers;
	if not observers then
		observers = {};
		self.mObservers = observers;
	end

	local observerType = observers[type];

	if not observerType then
		observerType = {};
		observers[type] = observerType;
	end

	observerType[o] = o;
end

function Observable:ClearObservers()
	self.mObservers = nil;
end

return Observable;