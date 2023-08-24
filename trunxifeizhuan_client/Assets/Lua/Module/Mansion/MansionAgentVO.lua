local mLuaClass = require "Core/LuaClass"
local mMansionBaseVO = require "Module/Mansion/MansionBaseVO"
local MansionAgentVO = mLuaClass("MansionAgentVO",mMansionBaseVO);
local mSuper;

function MansionAgentVO:OnLuaNew( data )
	mSuper = self:GetSuper(mMansionBaseVO.LuaClassName);
	mSuper.OnLuaNew(self, data);

	self.mMansionType = 3;
end

function MansionAgentVO:IsCanOperateID( id )
	return false;
end

function MansionAgentVO:ShowWaterBtn( plant )
	return false;
end

return MansionAgentVO;