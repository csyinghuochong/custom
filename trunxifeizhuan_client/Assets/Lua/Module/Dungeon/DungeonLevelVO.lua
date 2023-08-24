local mBaseLua = require "Core/BaseLua"
local mLuaClass = require "Core/LuaClass"
local DungeonLevelVO = mLuaClass("DungeonLevelVO", mBaseLua);
local mStateClose = 0;
local mStateOpen = 1;
local mStatePass = 2;

--关卡数据--
function DungeonLevelVO:OnLuaNew(id, vo)
	self.mID = id;
	self.mSysVO = vo;
	self.mStoryState = 0;
	self.mState = mStateClose;
end

--external
function DungeonLevelVO:SetLevelPass( )
	self.mState = mStatePass;
end

function DungeonLevelVO:SetLevelOpen( )
	self.mState = mStateOpen;
end

function DungeonLevelVO:IsCombatLevel(  )
	return self.mSysVO.type == 1;
end

function DungeonLevelVO:IsStoryLevel( )
	return self.mSysVO.type == 2;
end

function DungeonLevelVO:IsPass()
	return self.mState == mStatePass;
end

function DungeonLevelVO:IsOpen(  )
	return self.mState >= mStateOpen;
end
--external

--update
function DungeonLevelVO:OnRecvDungeonOver( )
	self.mState = mStatePass;
end
--update

return DungeonLevelVO;