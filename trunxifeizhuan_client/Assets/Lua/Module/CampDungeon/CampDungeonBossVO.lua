local mLuaClass = require "Core/LuaClass"
local mConfigSyschapter = require "ConfigFiles/ConfigSysdungeon_chapter"
local mSortTable = require "Common/SortTable"
local CampDungeonBossVO = mLuaClass("CampDungeonBossVO");

function CampDungeonBossVO:OnLuaNew(id,passid,time)
	self.mID = id;
	local sys_vo = mConfigSyschapter[id];
	self.mSysVO = sys_vo;
	self.mPassID = passid;
	self.mDungeonList = mSortTable.LuaNew(function(a, b) return a.mID < b.mID end, nil, true);
	self.mTime = time;
	self.mSelectLevel = {};
end

return CampDungeonBossVO;