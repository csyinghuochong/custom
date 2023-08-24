local mLuaClass = require "Core/LuaClass"
local mMansionBaseVO = require "Module/Mansion/MansionBaseVO"
local MansionVisitVO = mLuaClass("MansionVisitVO",mMansionBaseVO);
local mSuper;

function MansionVisitVO:OnLuaNew( data )
	mSuper = self:GetSuper(mMansionBaseVO.LuaClassName);
	mSuper.OnLuaNew(self, data);

	self.mMansionType = 2;
end

function MansionVisitVO:ShowTroubleBtn( plant )
	local player_id = self:GetSelfPlayerID( );
	local times1, times2 = self:GetWaterTroubleNumber( );
	local canTrouble = plant:IsPlayerCanTrouble( player_id );
	return times1 < times2 and canTrouble;
end

function MansionVisitVO:ShowStealBtn( plant )
	local player_id = self:GetSelfPlayerID( );
	local times1, times2 = self:GetTotalStealNumber( );
	local canSteal = plant:IsPlayerCanSteal( player_id );
	return times1 < times2 and canSteal;
end

function MansionVisitVO:ShowWaterBtn( plant )
	local player_id = self:GetSelfPlayerID( );
	local times1, times2 = self:GetWaterTroubleNumber( );
	local canWater = plant:IsPlayerCanWater( player_id );
	return times1 < times2 and canWater;
end

return MansionVisitVO;