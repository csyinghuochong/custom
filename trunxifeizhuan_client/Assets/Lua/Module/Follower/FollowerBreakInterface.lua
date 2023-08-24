local mLuaClass = require "Core/LuaClass"
local mFollowerBreakView = require "Module/Follower/FollowerBreakView"
local mFollowerBreakMaxView = require "Module/Follower/FollowerBreakMaxView"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local mFollowerBreakLevelView = require "Module/Follower/FollowerBreakLevelView"
local FollowerBreakInterface = mLuaClass("FollowerBreakInterface", mCommonTabBaseView);
local mLanguageUtil = require "Utils/LanguageUtil"

function FollowerBreakInterface:Init()
	local trans = self.mTransform;
	local view1 = mFollowerBreakLevelView.LuaNew( );
	local view2 = mFollowerBreakView.LuaNew( );
	local view3 =  mFollowerBreakMaxView.LuaNew( );
	view1.mGoParent = trans;
	view2.mGoParent = trans;
	view3.mGoParent = trans;
	self.mView1 = view1;
	self.mView2 = view2;
	self.mView3 = view3;

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_FOLLOWER_UP_EXP, function(vo)
		self:OnUpdateUI(vo);
	end, true);
end

function FollowerBreakInterface:OnUpdateUI(data)
	local inter_view = nil;

	if data:IsBreakMax() then
		inter_view = self.mView3;
	elseif data:IsCanBreak() then
		inter_view = self.mView2;
	else
		inter_view = self.mView1;
	end

	local last_view = self.mInterView;
	if inter_view ~= last_view then
		if last_view ~= nil then
			last_view:HideView();
		end
		self.mInterView = inter_view;
	end

	if inter_view.mIsShow and inter_view.mGameObject ~=nil then
		inter_view:OnUpdateUI(data);
	else
		inter_view:ShowView(data);
	end
end

function FollowerBreakInterface:OnViewHide()
	self.mInterView:OnViewHide();
end

function FollowerBreakInterface:Dispose( )
	self.mView1:CloseView();
	self.mView2:CloseView();
	self.mView3:CloseView();
end

return FollowerBreakInterface;