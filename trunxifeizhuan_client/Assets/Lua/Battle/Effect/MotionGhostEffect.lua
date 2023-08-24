local LuaClass = require "Core/LuaClass"
local Effect = require "Battle/Effect/Effect"
local MotionGhostEffect = LuaClass("MotionGhostEffect",Effect);
local SkinnedMeshRendererType = typeof(UnityEngine.SkinnedMeshRenderer);
local MotionGhostType = typeof(MotionGhost);

function MotionGhostEffect:OnShow()
	self:InitMotionGhost();
end

return MotionGhostEffect;