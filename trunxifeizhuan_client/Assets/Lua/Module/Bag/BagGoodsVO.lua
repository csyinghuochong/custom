local mLuaClass = require "Core/LuaClass"
local mConfigSysgoods = require "ConfigFiles/ConfigSysgoods"
local mCommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local BagGoodsVO = mLuaClass("BagGoodsVO",mCommonGoodsVO);
local mTableInsert = table.insert;
local mIpairs = ipairs;
local mSuper = nil;

function BagGoodsVO:OnLuaNew(uid,id,color,number, pb_vo)
	self.mKuang = "common_bag_iconback_1";
	self.mGoodsUID = uid;
	self.mPbGoodVO = pb_vo; --装备要用到其他的一些属性

  if color == nil then
    color = mConfigSysgoods[ id ].quality;
  end

	self.mColor = color      
	mSuper = self:GetSuper(mCommonGoodsVO.LuaClassName);
	mSuper.OnLuaNew(self,id,number,self.mColor,false);
end

function BagGoodsVO:IsEquip(  )
	return self.mSysVO ~= nil and self.mSysVO.type == 2;
end

function BagGoodsVO:IsMaxNumber(  )
    return self.mNumber >=  self.mSysVO.stack;
end

return BagGoodsVO;