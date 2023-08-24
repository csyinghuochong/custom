local LuaClass = require "Core/LuaClass"
local Observer = require "Core/Observer"
local ActorObserver = LuaClass("ActorObserver",Observer);
local mNotifyEnum = require"Enum/NotifyEnum"

function ActorObserver:Awake()
end

function ActorObserver:GetActor()
	return self.mObservable; 
end

function ActorObserver:GetNotifyEnum()
	return mNotifyEnum;
end

function ActorObserver:Dispose()
end

return ActorObserver;