local mLuaClass = require "Core/LuaClass"
local mUpdateManager = require "Manager/UpdateManager"
local CommonPressButton = mLuaClass("CommonPressButton");
local mGameUIPointerHandler = GameUIPointerHandler;

function CommonPressButton:OnLuaNew(obj, delay,callback)
	self.mDelay = delay;
  self.mObj = obj;
	self.mCallback = callback;
	self.mIsDown = false;
	self:Init();
end

function CommonPressButton:Init()
    local listener = mGameUIPointerHandler.Get(self.mObj);

    listener.onPointerExit = function ()
      mUpdateManager:RemoveUpdate(self);
    	self:OnPointerExit();
    end
    listener.onPointerUp = function ()
      mUpdateManager:RemoveUpdate(self);
    	self:OnPointerUp();
    end
    listener.onPointerDown = function ()
      mUpdateManager:AddUpdate(self);
    	self:OnPointerDown();
    end 
    
    self:AddListeners(listener);
end

function CommonPressButton:AddListeners(listener)
end

function CommonPressButton:OnUpdate()
    if self.mIsDown then
       if Time.time - self.mLastDownTime > self.mDelay then
          self.mLastDownTime = Time.time;
          if self.mCallback ~= nil then
             self.mCallback(self.mIsDown);
          end
       end
    end
end

function CommonPressButton:OnPointerDown()
	self.mIsDown = true;
	self.mLastDownTime = Time.time;
end

function CommonPressButton:OnPointerUp()
	self.mIsDown = false;
	if self.mCallback ~= nil then
       self.mCallback(self.mIsDown);
    end
end

function CommonPressButton:OnPointerExit()
  
	self.mIsDown = false;

  if self.mNotCallOnExit then
    return;
  end

	if self.mCallback ~= nil then
       self.mCallback(self.mIsDown);
    end
end

return CommonPressButton;