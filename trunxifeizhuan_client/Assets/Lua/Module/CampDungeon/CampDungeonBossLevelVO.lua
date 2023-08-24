local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mCampDungeonFollowerVO = require "Module/CampDungeon/CampDungeonFollowerVO"
local CampDungeonBossLevelVO = mLuaClass("CampDungeonBossLevelVO");

function CampDungeonBossLevelVO:OnLuaNew(id,vo,state)
	self.mID = id;
	self.mSysVO = vo;
	self.mState = state;--1为已通关，2为开启，3为未开启
	self.mDungeonList = mSortTable.LuaNew(nil, nil, true);
	self.mIsGetFollower = false;
end

function CampDungeonBossLevelVO:CreateFollower(list)
	local data_soure = self.mDungeonList;
	for k,v in ipairs(list) do
		local follower = mCampDungeonFollowerVO.LuaNew(k,v);
		data_soure:AddOrUpdate(follower.id,follower);
	end
	self.mDungeonList = data_soure;
end

return CampDungeonBossLevelVO;