local mLuaClass = require "Core/LuaClass"
local EndlessMeirenxinjiItemVO = mLuaClass("EndlessMeirenxinjiItemVO");

local MEIREN_FIRST = 1601000;
local mConfigSysendless_dungeon = require "ConfigFiles/ConfigSysendless_dungeon"
function EndlessMeirenxinjiItemVO:OnLuaNew(id,name,sex,level,defense,robotID)
   self.mID = id;
   self.mBattleID = id + MEIREN_FIRST;
   self.mName = name;
   self.mSex = sex;
   self.mLevel = level;
   self.mDefense = defense;
   self.mRobotID = robotID;
   self.mConfig = mConfigSysendless_dungeon[mBattleID];
end

return EndlessMeirenxinjiItemVO;