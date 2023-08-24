local mLuaClass = require "Core/LuaClass"
local mEventDispatcherInterface = require "Events/EventDispatcherInterface"

local BaseController = mLuaClass("BaseController",mEventDispatcherInterface);

function BaseController:OnLuaNew()
	self:AddNetListeners();
	self:AddEventListeners();
end

--协议处理--
function BaseController:AddNetListeners()
	
end

--事件处理--
function BaseController:AddEventListeners()
	
end

return BaseController;