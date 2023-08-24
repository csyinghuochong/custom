local mLuaClass = require "Core/LuaClass"
local CombatView = require "Module/Combat/CombatView"
local mArenaCombatKingView = require "Module/Arena/Combat/ArenaCombatKingView"
local ArenaCombatView = mLuaClass("ArenaCombatView",CombatView);
local mSuper;

function  ArenaCombatView:Init()
    local kingView = mArenaCombatKingView.LuaNew();
	kingView:SetViewParent( self:Find('topRight') );
	self.mKingView = kingView;

	mSuper = self:GetSuper(CombatView.LuaClassName);
    mSuper.Init(self);
end

function ArenaCombatView:OnViewShow(logicParams)
	mSuper.OnViewShow(self, logicParams);

	self.mKingView:ShowView();
end

function ArenaCombatView:OnViewHide( logicParams )
	mSuper.OnViewHide(self, logicParams);

	self.mKingView:HideView();
end

function ArenaCombatView:Dispose()
	mSuper.Dispose(self);

	self.mKingView:CloseView();
end

return ArenaCombatView;