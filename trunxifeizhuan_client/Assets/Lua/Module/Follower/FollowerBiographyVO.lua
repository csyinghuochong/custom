local mLuaClass = require "Core/LuaClass"
local mConfigSysdungeon = require "ConfigFiles/ConfigSysdungeon"
local FollowerBiographyVO = mLuaClass("FollowerBiographyVO");

function FollowerBiographyVO:OnLuaNew(id, top_id, follower_id)
	self.mID = id;
	self.mTopId = top_id;
	self.mFollowerID = follower_id;
	local sys_vo = mConfigSysdungeon[id];
	if sys_vo == nil then
		print('无效的传记副本...'..id)
	else
		self.mSysVO = sys_vo;
	end
end

function FollowerBiographyVO:IsPass(  )
	return self.mID <= self.mTopId;
end

function FollowerBiographyVO:IsOpen(  )
	return self.mID <= self.mTopId + 1 or (self.mTopId == 0 and self.mSysVO.index == 1);
end

function FollowerBiographyVO:GetDungeonName(  )
	return self.mSysVO.dungeon_name;
end

return FollowerBiographyVO;