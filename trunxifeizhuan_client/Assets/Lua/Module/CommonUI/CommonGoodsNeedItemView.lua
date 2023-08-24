local mCommonGoodsItem = require "Module/CommonUI/CommonGoodsItemView"
local mLuaClass = require "Core/LuaClass"
local mBagController = require "Module/Bag/BagController"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonLongClick = require "Module/CommonUI/CommonLongClick"
local mUIGray = require "Utils/UIGray"
local mGlobalUtil = require "Utils/GlobalUtil"
local CommonGoodsNeedItemView = mLuaClass("CommonGoodsNeedItemView", mCommonGoodsItem);
local mSuper = nil;

function CommonGoodsNeedItemView:Init( )
	self.mIconGray = mUIGray.LuaNew():InitGoGraphic(self:Find('icon').gameObject);
  self.mBgGray = mUIGray.LuaNew():InitGoGraphic(self:Find('bg').gameObject);
  self.mKuangGray = mUIGray.LuaNew():InitGoGraphic(self:Find('kuang').gameObject);
  mSuper = self:GetSuper(mCommonGoodsItem.LuaClassName);
	mSuper.Init(self);
end

--外部调用
function CommonGoodsNeedItemView:AddLongClick(data)
  -- if self.mHaveNumber >= data.mNumber then
     
  -- end
  mCommonLongClick.LuaNew(self.mIconBtn.gameObject,2,data.mID,0,0.5);
end

function CommonGoodsNeedItemView:OnClickIcon()
	local data = self.mData;
    if self.mHaveNumber <  data.mNumber then
       --mBagController:OpenGetView(data);
    end
end

function CommonGoodsNeedItemView:ShowGoodsNumber( number )
  local textNumber = self.mTextNumber;
	local data = self.mData;
  local haveNumber = self:GetGoodsCurrentNum( data );
  self.mHaveNumber = haveNumber;
  self.mIconGray:SetGray(haveNumber < data.mNumber);
  self.mBgGray:SetGray(haveNumber < data.mNumber);
  self.mKuangGray:SetGray(haveNumber < data.mNumber);
	if textNumber ~= nil then
		local numberStr = haveNumber.."/"..data.mNumber;
		local color = haveNumber < data.mNumber and mGlobalUtil.Colors[7] or mGlobalUtil.Colors[2];
		textNumber.text = string.format(color,numberStr);
	end
end

function CommonGoodsNeedItemView:GetGoodsCurrentNum( data )
    local bagModel = mGameModelManager.BagModel;
    return bagModel:GetGoodsNumberGoodsId(data.mID);
end

return CommonGoodsNeedItemView