local mLuaClass = require "Core/LuaClass"
local mDungeonScene = require "Module/Scene/DungeonScene"
local mFollowerController = require "Module/Follower/FollowerController"
local FollowerDungeonScene = mLuaClass("FollowerDungeonScene",mDungeonScene);

function FollowerDungeonScene:OpenCombatView(  )
	mFollowerController:OnOpenCombatView();
end

return FollowerDungeonScene;
