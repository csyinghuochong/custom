local mLuaClass = require "Core/LuaClass"
local mDungeonScene = require "Module/Scene/DungeonScene"
local PromoteController = require "Module/Promote/PromoteController"
local PromoteArenaScene = mLuaClass("PromoteArenaScene",mDungeonScene);

function PromoteArenaScene:OpenCombatView(  )
	PromoteController:OnOpenCombatView();
end

return PromoteArenaScene;