local mLuaClass = require "Core/LuaClass"
local CommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local FollowerSkillCostVO = mLuaClass("FollowerSkillCostVO",CommonGoodsVO);

--1消耗道具2消耗随从
function FollowerSkillCostVO:OnLuaNew(goods_type, id, key, vo)
	self.mID = id;
	self.mKey = key;
	self.mCostType = goods_type;
	self.mCostVo = vo;
	self.mStar = goods_type == 1 and 0 or vo:GetStar( );
end

return FollowerSkillCostVO;