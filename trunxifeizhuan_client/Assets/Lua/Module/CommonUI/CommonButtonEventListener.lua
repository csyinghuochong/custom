local mLuaClass = require "Core/LuaClass"
local mCommonPressButton = require "Module/CommonUI/CommonPressButton"
local CommonButtonEventListener = mLuaClass("CommonButtonEventListener",mCommonPressButton);
local Time = Time;

function CommonButtonEventListener:OnLuaNew(obj, holdDelay,pressCallback,holdCallback,clickCallback)
	self.mHoldDelay = holdDelay;
  self.mObj = obj;

  self.mPressCallback = pressCallback;
  self.mHoldCallback = holdCallback;
  self.mClickCallback = clickCallback;
	self.mIsDown = false;
	self:Init();
end

function CommonButtonEventListener:AddListeners(listener)
  listener.onClick = function ()
      self:OnPointerClick();
    end 
end

function CommonButtonEventListener:OnUpdate()
    if self.mIsDown then
       if Time.time - self.mLastDownTime > self.mHoldDelay then
          self.mLastDownTime = Time.time;
          self:ExcuteHoldEvent();
       end
    end
end

function CommonButtonEventListener:ExcuteHoldEvent()
  local holdCallback = self.mHoldCallback;
    if holdCallback then
      holdCallback();
    end
end

function CommonButtonEventListener:ExcutePressEvent(state)
  local pressCallback = self.mPressCallback;
  if pressCallback then
    pressCallback(state);
  end
end

function CommonButtonEventListener:OnPointerClick()
  local clickCallback = self.mClickCallback;
  if clickCallback then
    clickCallback();
  end
end

function CommonButtonEventListener:OnPointerDown()
  self.mIsDown = true;
  self:ExcutePressEvent(true);
  self.mLastDownTime = Time.time;
end

function CommonButtonEventListener:OnPointerUp()
  self.mIsDown = false;
  self:ExcutePressEvent(false);
end

function CommonButtonEventListener:OnPointerExit()
  
  if self.mNotCallOnExit then
    return;
  end
  
  if self.mIsDown then
    self.mIsDown = false;
    self:ExcutePressEvent(false);
  end

end

return CommonButtonEventListener;