local mLuaClass = require "Core/LuaClass"
local mCommonGoodsVo = Assets.Scripts.Com.Game.Module.CommonComponent.CommonGoodsVo;
local mDungeonLevelIndexVO = Assets.Scripts.Com.Game.Module.Dungeon.DungeonLevelIndexVO;
local LandRewardVO = mLuaClass("LandRewardVO");
local mString = require 'string'

function LandRewardVO:OnLuaNew(reward, index, sys_vo)
	self.mIndex = index;
    self.mGetReward = reward;
    self.mSysVO = sys_vo;
    self.DayStr = mString.format('第%s天', mDungeonLevelIndexVO.mChapterIndex[index - 1]);
    local land_goods = sys_vo.land_goods[1];
    self.GetGoodsVO = mCommonGoodsVo.New(land_goods.goods_id, land_goods.goods_num, true, 1, false);
end

return LandRewardVO;