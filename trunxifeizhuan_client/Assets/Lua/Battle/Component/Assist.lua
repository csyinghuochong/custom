local LuaClass = require "Core/LuaClass"
local ActorObserver = require "Battle/Component/ActorObserver"
local Assist = LuaClass("Assist",ActorObserver);
local mNotifyEnum = require"Enum/NotifyEnum"

function Assist:Awake()
	self:RegisterListener(mNotifyEnum.OnAssistCompleted,function ()
		self:OnCompleted();
	end);
end

function Assist:OnCompleted()
	local completedCallback = self.mCompletedCallback;
	if completedCallback then
		completedCallback();
	end
	self.mCompletedCallback = nil;
end
function Assist:Excute(target,completedCallback)
	self.mCompletedCallback = completedCallback;
	self:GetActor():Notify(mNotifyEnum.OnAssist,target);
end

function Assist:HasAction()
	return self.mCompletedCallback;
end
return Assist;