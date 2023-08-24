local mLuaClass = require "Core/LuaClass"
local mBattleArrayView = require "Module/BattleArray/BattleArrayView"
local mEndlessSihaiBuffView = require "Module/EndlessDungeon/Gongshensihai/EndlessSihaiBuffView"
local mTable = require 'table'
local EndlessGongshensihaiArrayView = mLuaClass("EndlessGongshensihaiArrayView",mBattleArrayView);
local mSuper;

function EndlessGongshensihaiArrayView:InitViewParam()
	return {
		["viewPath"] = "ui/endless_dungeon/",
		["viewName"] = "endless_battle_array_view",
		["ParentLayer"] = mMainLayer,
		["cost"] = {"strength"},
	};
end

function EndlessGongshensihaiArrayView:Init()
	mSuper = self:GetSuper(mBattleArrayView.LuaClassName);
    mSuper.Init(self);
    self.mEndlessSihaiBuffView = mEndlessSihaiBuffView.LuaNew(self:Find('BuffNode'));
    
end

function EndlessGongshensihaiArrayView:OnViewShow(logicParams)
    mSuper.OnViewShow(self,logicParams);
    self.mEndlessSihaiBuffView:ShowView();
end

function EndlessGongshensihaiArrayView:Dispose()
	mSuper.Dispose(self);
	self.mEndlessSihaiBuffView:CloseView();
end

return EndlessGongshensihaiArrayView;