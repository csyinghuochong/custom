local mLuaClass = require "Core/LuaClass"
local mDungeonScene = require "Module/Scene/DungeonScene"
local mConfigSysdungeon = require"ConfigFiles/ConfigSysendless_dungeon"
local mEndlessDungeonController = require "Module/EndlessDungeon/EndlessDungeonController"
local GongshensihaiDungeonScene = mLuaClass("GongshensihaiDungeonScene",mDungeonScene);

function GongshensihaiDungeonScene:SetSceneConfig(sceneID)
	self.mSceneConfig = mConfigSysdungeon[sceneID]
end

function GongshensihaiDungeonScene:OpenCombatView(  )
	mEndlessDungeonController:OnOpenCombatView();
end

return GongshensihaiDungeonScene;