local mLuaClass = require "Core/LuaClass"
local mBaseController = require "Core/BaseController"
local mGameModelManager = require "Manager/GameModelManager"
local RoleController = mLuaClass("RoleController",mBaseController);

function RoleController:OnLuaNew()
	local super = self:GetSuper(mBaseController.LuaClassName);
	super.OnLuaNew(self);
end

function RoleController:AddNetListeners()
	self.mS2C:PLAYER_BASE(function(pbPlayerBase)
		mGameModelManager.RoleModel:UpdatePlayerBase(pbPlayerBase);
	end);
	self.mS2C:PLAYER_CHANGE_INFO(function (pbPlayerChange)
		mGameModelManager.RoleModel:OnPlayerChangeInfo(pbPlayerChange);
	end);
end

return RoleController.LuaNew();