local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local GameTimer = require "Core/Timer/GameTimer"
local mEventEnum = require "Enum/EventEnum"
local CombatBlankScreenView = mLuaClass("CombatBlankScreenView",mBaseWindow);
local mTime = Time;

function CombatBlankScreenView:InitViewParam()
	return {
		["viewPath"] = "ui/combat/",
		["viewName"] = "combat_blank_screen_view",
		["ParentLayer"] = mCommonPopLayer1,
		["ForbitSound"] = true
	};
end

function CombatBlankScreenView:Init()	
	self.mBlankBg = self:FindComponent('Image_bg', 'Image');
end

function CombatBlankScreenView:OnViewShow(  )
	self:ShowBlankScreen();
end

function CombatBlankScreenView:ShowBlankScreen(  )
	self.mGameTimer = GameTimer.HandSetTimeout(3, function (  )
		self:HideView();
	end ,true,true);
end

function CombatBlankScreenView:Dispose(  )
	local timer = self.mGameTimer;
	if timer then
		timer:Dispose();
		self.mGameTimer = nil;
	end
end

return CombatBlankScreenView;