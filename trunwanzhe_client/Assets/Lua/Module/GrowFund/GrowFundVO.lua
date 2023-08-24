local mLuaClass = require "Core/LuaClass"
local mCommonGoodsVo = Assets.Scripts.Com.Game.Module.CommonComponent.CommonGoodsVo;
local GrowFundVO = mLuaClass("GrowFundVO");

function GrowFundVO:OnLuaNew(vo)
	self.mSysVO = vo;
    self.Level = vo.lv;
    self.GetGoodsVO = mCommonGoodsVo.New(100001, vo.gold_num, true, 1, false);
end

return GrowFundVO;