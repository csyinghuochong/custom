local LuaClass = require "Core/LuaClass"
local Observer = require "Core/Observer"
local CombatObserver = LuaClass("CombatObserver",Observer);

function CombatObserver:GetCombat()
	return self.mObservable;
end

function CombatObserver:Awake()
	-- body
end

function CombatObserver:RemoveCombatListeners()
	self:RemoveListeners();
end

return CombatObserver;