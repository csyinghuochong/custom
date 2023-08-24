local mLuaClass = require "Core/LuaClass"
local mCommonGoodsDetial = require "Module/CommonUI/CommonGoodsDetialView"
local mGameTimer = require "Core/Timer/GameTimer"
local mCommonPressButton = require "Module/CommonUI/CommonPressButton"
local CommonLongClick = mLuaClass("CommonLongClick");

function CommonLongClick:OnLuaNew(obj, type, id, openTime, closeTime)
  self.mObj = obj;
	self.mType = type;
  self.mID = id;
  self.mOpenTime = openTime;
  self.mCloseTime = closeTime;
	self:Init();
end

function CommonLongClick:Init()
    local callBack = function (flag)
      self:OnPressBack(flag);
    end
    mCommonPressButton.LuaNew(self.mObj,self.mOpenTime,callBack);
end

function CommonLongClick:OnPressBack(flag)
  if flag then
    self:ShowDetial(self.mID);
  elseif self.mShow then
    mGameTimer.SetTimeout(self.mCloseTime,function()mCommonGoodsDetial.hide();end);
  end
  self.mShow = flag;
end

function CommonLongClick:ShowDetial(id)
  local table = {mTransform = self.mObj.transform,mConfigID = self.mID,mType = self.mType};
  mCommonGoodsDetial.Show(table);
end

return CommonLongClick;