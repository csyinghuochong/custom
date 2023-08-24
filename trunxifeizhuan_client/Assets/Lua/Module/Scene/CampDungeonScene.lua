local mLuaClass = require "Core/LuaClass"
local mDungeonScene = require "Module/Scene/DungeonScene"
local mCampDungeonController = require "Module/CampDungeon/CampDungeonController"
local CampDungeonScene = mLuaClass("CampDungeonScene",mDungeonScene);

function CampDungeonScene:OpenCombatView(  )
	mCampDungeonController:OnOpenCombatView();
end

return CampDungeonScene;