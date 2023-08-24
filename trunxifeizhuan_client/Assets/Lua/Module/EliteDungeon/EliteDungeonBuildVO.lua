local mLuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local mConfigSysdungeon_chapter = require "ConfigFiles/ConfigSysdungeon_chapter"
local EliteDungeonBuildVO = mLuaClass("EliteDungeonBuildVO", BaseLua);
----
function EliteDungeonBuildVO:OnLuaNew(id)
	self.mID = id;
	self.mConfig = mConfigSysdungeon_chapter[id];
end

return EliteDungeonBuildVO;