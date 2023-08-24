local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBattleArrayView = require "Module/BattleArray/BattleArrayView"
local EliteDungeonArrayView = mLuaClass("EliteDungeonArrayView",mBattleArrayView);
local mTable = require 'table'
local mSuper;

function EliteDungeonArrayView:InitViewParam()
	return {
		["viewPath"] = "ui/elite_dungeon/",
		["viewName"] = "elite_dungeon_array_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.gray,
		["cost"] = {"strength"},
	};
end

function EliteDungeonArrayView:ReturnPrevQueueWindow()
	mSuper = self:GetSuper(mBattleArrayView.LuaClassName);
	mSuper.ReturnPrevQueueWindow(self);
	self:Dispatch(self.mEventEnum.ON_ELITE_DUNGEON_SHOW_DETAIL);
end

return EliteDungeonArrayView;