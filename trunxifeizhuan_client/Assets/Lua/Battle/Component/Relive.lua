local LuaClass = require "Core/LuaClass"
local ActorObserver = require "Battle/Component/ActorObserver"
local GameTimer = require "Core/Timer/GameTimer"
local Relive = LuaClass("Relive",ActorObserver);

function Relive:OnCompleted()
	local callback = self.mCallback;
	if callback then
		callback();
		self.mCallback = nil;
	end
end

function Relive:Begin(delay,callback)
	self.mCallback = callback;
	GameTimer.SetTimeout(delay,function ()self:OnCompleted();end,true,true);
end

function Relive:HasAction()
	return self.mCallback;
end
return Relive;