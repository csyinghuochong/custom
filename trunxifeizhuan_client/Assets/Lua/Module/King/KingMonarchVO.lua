local mLuaClass = require "Core/LuaClass"
local mConfigSysmonarch = require "ConfigFiles/ConfigSysmonarch"
local KingMonarchVO = mLuaClass("KingMonarchVO");

function KingMonarchVO:OnLuaNew(monrachId,mood)
   self.mMonarchID = monrachId;
   self.mMood = mood;
end

function KingMonarchVO:GetConfig()
	return mConfigSysmonarch[self.mMonarchID];
end

return KingMonarchVO;