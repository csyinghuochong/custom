local mLuaClass = require "Core/LuaClass"
local mLeadBaseVO = require "Module/Lead/LeadBaseVO"
local mRobotBaseVO = require "Module/Follower/RobotBaseVO"
local ArenaLeadVO = mLuaClass("ArenaLeadVO", mRobotBaseVO);

function ArenaLeadVO:GetOfficeName(  )
	return mLeadBaseVO:GetOfficeName(self.mOffice, self.mSex);
end

function ArenaLeadVO:GetCombatModel(  )
	return mLeadBaseVO:GetCombatModel(self.mID);
end

function ArenaLeadVO:GetUIModel( id )
	return mLeadBaseVO:GetUIModel( self.mID )
end

function ArenaLeadVO:GetMiniIcon()
	return mLeadBaseVO:GetMiniIcon(self.mID);
end

function ArenaLeadVO:IsLevelMaxed(  )
	return mLeadBaseVO:IsLevelMaxed( self:GetLevel( ) )
end

return ArenaLeadVO;