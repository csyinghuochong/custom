local mLuaClass = require "Core/LuaClass"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mCombatView = require "Module/Combat/CombatView"
local EndlessShengongmeiyingCombatView = mLuaClass("EndlessShengongmeiyingCombatView",mCombatView);

function EndlessShengongmeiyingCombatView:ShowResultView( result )
	if result == 1 then
		mUIManager:HandleUI(mViewEnum.EndlessMeiyingWinView, 1);
	else
		mUIManager:HandleUI(mViewEnum.EndlessMeiyingFailView, 1);
	end
end

return EndlessShengongmeiyingCombatView;