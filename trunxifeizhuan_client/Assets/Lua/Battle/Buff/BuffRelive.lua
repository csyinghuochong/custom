local LuaClass = require "Core/LuaClass"
local Buff = require "Battle/Buff/Buff"
local BuffRelive = LuaClass("BuffRelive",Buff);

function BuffRelive:OnStart()
end

function BuffRelive:Relive()
end


return BuffRelive;