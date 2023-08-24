local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local CommonCountDown = require "Module/CommonUI/CommonCountDown";
local MainArenaBalanceView = require "Module/MainInterface/MainArenaBalanceView"
local ArenaBalanceWaitView = mLuaClass("ArenaBalanceWaitView", mBaseWindow);
local mSuper = nil;

function ArenaBalanceWaitView:InitViewParam()
	return {
		["viewPath"] = "ui/arena/",
		["viewName"] = "arena_balance_wait_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
		["ForbitSound"] = true
	};
end

function ArenaBalanceWaitView:Init()
	local textLastTime = self:FindComponent("Text_time","Text");
	self.mCountDown = CommonCountDown.LuaNew(  textLastTime, nil );
	self:FindAndAddClickListener("BtnOk", function() self:HideView() ; end);

	mSuper = self:GetSuper(mBaseWindow.LuaClassName);
	mSuper.Init(self);
end

function ArenaBalanceWaitView:OnViewShow(logicParams)
	local state, time = MainArenaBalanceView:GetArenaBalanceState( );
	if state == 2 then
		self.mCountDown:ShowView( time );
	end
end

function ArenaBalanceWaitView:OnViewHide(  )
	self.mCountDown:HideView()
end

function ArenaBalanceWaitView:Dispose()
	self.mCountDown:Dispose();
	self.mCountDown = nil;
end

return ArenaBalanceWaitView;