local mLuaClass = require "Core/LuaClass"
local mBattleArrayView = require "Module/BattleArray/BattleArrayView"
local mEndlessMeiyingBuffView = require "Module/EndlessDungeon/Shengongmeiying/EndlessMeiyingBuffView"
local mTable = require 'table'
local EndlessShengongmeiyingArrayView = mLuaClass("EndlessShengongmeiyingArrayView",mBattleArrayView);
local mSuper;

function EndlessShengongmeiyingArrayView:InitViewParam()
	return {
		["viewPath"] = "ui/endless_dungeon/",
		["viewName"] = "endless_battle_array_view",
		["ParentLayer"] = mMainLayer,
		["cost"] = {"strength"},
	};
end

function EndlessShengongmeiyingArrayView:Init()
	mSuper = self:GetSuper(mBattleArrayView.LuaClassName);
    mSuper.Init(self);
    self.mEndlessMeiyingBuffView = mEndlessMeiyingBuffView.LuaNew(self:Find('BuffNode'));
    
end

function EndlessShengongmeiyingArrayView:OnViewShow(logicParams)
    mSuper.OnViewShow(self,logicParams);
    self.mEndlessMeiyingBuffView:ShowView();
end

function EndlessShengongmeiyingArrayView:Dispose()
	mSuper.Dispose(self);
	self.mEndlessMeiyingBuffView:CloseView();
end

return EndlessShengongmeiyingArrayView;