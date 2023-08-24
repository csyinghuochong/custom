local mLuaClass = require "Core/LuaClass"
local mDungeonScene = require "Module/Scene/DungeonScene"
local ArenaController = require "Module/Arena/ArenaController"
local ArenaScene = mLuaClass("ArenaScene",mDungeonScene);

function ArenaScene:OpenCombatView(  )
	ArenaController:OnOpenCombatView();
end

return ArenaScene;