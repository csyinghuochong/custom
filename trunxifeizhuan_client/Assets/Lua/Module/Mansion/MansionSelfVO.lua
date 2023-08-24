local mLuaClass = require "Core/LuaClass"
local mMansionBaseVO = require "Module/Mansion/MansionBaseVO"
local mGameModelManager = require "Manager/GameModelManager"
local MansionSelfVO = mLuaClass("MansionSelfVO",mMansionBaseVO);
local mSuper;

function MansionSelfVO:OnLuaNew( data )
	mSuper = self:GetSuper(mMansionBaseVO.LuaClassName);
	mSuper.OnLuaNew(self, data);

	self.mMansionType = 1;
end

function MansionSelfVO:IsCanOperateID( id )
	return true;
end

function MansionSelfVO:GetDefaultName(  )
	return mGameModelManager.RoleModel.mPlayerBase.name;
end

function MansionSelfVO:GetTotalBoom(  )
	return mGameModelManager.RoleModel.mPlayerBase.boom;
end

function MansionSelfVO:GetTotalMoney(  )
	return mGameModelManager.RoleModel.mPlayerBase.house_coin;
end

function MansionSelfVO:GetPlayerItemVO(  )
	local vo = mGameModelManager.FollowerModel:GetLeadVO();
    return vo:GetPlayerItemVO( );
end

function MansionSelfVO:GetPlayerID(  )
    return mGameModelManager.RoleModel.mPlayerBase.player_id;
end

function MansionSelfVO:ShowWaterBtn( plant )
	return plant:IsCanWatering();
end

function MansionSelfVO:ShowStealBtn( plant )
	return plant:IsCanHarvest( );
end

return MansionSelfVO;