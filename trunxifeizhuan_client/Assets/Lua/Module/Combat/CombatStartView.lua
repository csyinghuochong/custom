local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mGameTimer = require "Core/Timer/GameTimer"
local CombatStartView = mLuaClass("CombatStartView",mBaseWindow);
local mColor = Color;

function CombatStartView:InitViewParam()
	return {
		["viewPath"] = "ui/combat/",
		["viewName"] = "combat_start_view",
		["ParentLayer"] = mBattleLayer1,
	};
end

function CombatStartView:Init()
	
end

function CombatStartView:OnViewShow()
	mGameTimer.SetTimeout(3, function()
		self:HideView();
	end);
	self:Dispatch(self.mEventEnum.BEFORE_BEGIN_COMBAT);
end

function CombatStartView:OnViewHide( )
	self:Dispatch(self.mEventEnum.ON_COMBAT_START);
end

return CombatStartView;