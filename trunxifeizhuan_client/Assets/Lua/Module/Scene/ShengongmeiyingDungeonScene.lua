local mLuaClass = require "Core/LuaClass"
local mDungeonScene = require "Module/Scene/DungeonScene"
local mConfigSysdungeon = require"ConfigFiles/ConfigSysendless_dungeon"
local mEndlessDungeonController = require "Module/EndlessDungeon/EndlessDungeonController"
local ShengongmeiyingDungeonScene = mLuaClass("ShengongmeiyingDungeonScene",mDungeonScene);

function ShengongmeiyingDungeonScene:SetSceneConfig(sceneID)
	self.mSceneConfig = mConfigSysdungeon[sceneID]
end

function ShengongmeiyingDungeonScene:OpenCombatView(  )
	mEndlessDungeonController:OnOpenCombatView();
end

return ShengongmeiyingDungeonScene;