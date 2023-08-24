local mLuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local mConfigSysdungeon = require "ConfigFiles/ConfigSysdungeon"
local EliteDungeonVO = mLuaClass("EliteDungeonVO", BaseLua);
----
function EliteDungeonVO:OnLuaNew(id)
	self.mID = id;
	self.mConfig = mConfigSysdungeon[id];
end

return EliteDungeonVO;