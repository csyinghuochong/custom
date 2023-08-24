local mLuaClass = require "Core/LuaClass"
local FollowerSortFunction = mLuaClass("FollowerSortFunction");

--按等级排序
function FollowerSortFunction.Sort1( a, b )
	local aLead = a:IsLead();
	local bLead = b:IsLead();
	local aLevel = a:GetLevel();
	local bLevel = b:GetLevel();
	local aId = a.mUID;
	local bId = b.mUID;
	if aLead == bLead then
		if aLevel == bLevel then
			return aId < bId;
		else
			return bLevel < aLevel;
		end
	else
		return aLead;
	end
end

--按星级排序
function FollowerSortFunction.Sort2( a, b )
	local aLead = a:IsLead();
	local bLead = b:IsLead();
	local aStar = a:GetStar();
	local bStar = b:GetStar();
	local aId = a.mUID;
	local bId = b.mUID;
	if aLead == bLead then
		if aStar == bStar then
			return aId < bId;
		else
			return bStar < aStar;
		end
	else
		return aLead;
	end
end

--按势力排序
function FollowerSortFunction.Sort3( a, b )
	local aLead = a:IsLead();
	local bLead = b:IsLead();
	local aPower = a:GetPowerID();
	local bPower = b:GetPowerID();
	local aId = a.mUID;
	local bId = b.mUID;
	if aLead == bLead then
		if aPower == bPower then
			return aId < bId;
		else
			return aPower < bPower;
		end
	else
		return aLead;
	end
end

--最近使用排序
function FollowerSortFunction.Sort4( a, b )
	local aLead = a:IsLead();
	local bLead = b:IsLead();
	local aUse = a.mNearestUse;
	local bUse = b.mNearestUse;
	local aId = a.mUID;
	local bId = b.mUID;

	if aLead == bLead then
		if aUse == bUse then
			return aId < bId;
		else
			return aUse;
		end
	else
		return aLead;
	end
end

return FollowerSortFunction;