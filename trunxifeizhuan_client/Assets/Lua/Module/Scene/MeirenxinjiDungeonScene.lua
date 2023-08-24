local mLuaClass = require "Core/LuaClass"
local mDungeonScene = require "Module/Scene/DungeonScene"
local mConfigSysdungeon = require"ConfigFiles/ConfigSysendless_dungeon"
local mEndlessDungeonController = require "Module/EndlessDungeon/EndlessDungeonController"
local MeirenxinjiDungeonScene = mLuaClass("MeirenxinjiDungeonScene",mDungeonScene);

function MeirenxinjiDungeonScene:SetSceneConfig(sceneID)
	self.mSceneConfig = mConfigSysdungeon[sceneID]
end

function MeirenxinjiDungeonScene:OpenCombatView(  )
	mEndlessDungeonController:OnOpenCombatView();
end

return MeirenxinjiDungeonScene;