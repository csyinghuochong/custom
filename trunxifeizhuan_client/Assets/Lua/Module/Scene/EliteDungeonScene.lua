local mLuaClass = require "Core/LuaClass"
local mDungeonScene = require "Module/Scene/DungeonScene"
local mEliteDungeonController = require "Module/EliteDungeon/EliteDungeonController"
local EliteDungeonScene = mLuaClass("EliteDungeonScene",mDungeonScene);

function EliteDungeonScene:OpenCombatView(  )
	mEliteDungeonController:OnOpenCombatView();
end

return EliteDungeonScene;