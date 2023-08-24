local mLuaClass = require "Core/LuaClass"
local FollowerOfficeView = require "Module/Follower/FollowerOfficeView"
local FollowerOfficeMaxView = require "Module/Follower/FollowerOfficeMaxView"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local FollowerOfficeInterface = mLuaClass("FollowerOfficeInterface", mCommonTabBaseView);
local mLanguageUtil = require "Utils/LanguageUtil"


function FollowerOfficeInterface:Init()
	local trans = self.mTransform;
	local view1 = FollowerOfficeView.LuaNew( );
	local view2 = FollowerOfficeMaxView.LuaNew( );
	view1.mGoParent = trans;
	view2.mGoParent = trans;
	self.mView1 = view1;
	self.mView2 = view2;
end

function FollowerOfficeInterface:OnUpdateUI(data)
	self:UpdateSubView( data );
	local inter_view = self.mInterView;

	if inter_view.mIsShow and inter_view.mGameObject ~=nil then
		inter_view:OnUpdateUI(data);
	else
		inter_view:ShowView(data);
	end
end

function FollowerOfficeInterface:UpdateSubView( data )
	local inter_view = nil;

	if data:IsOfficeMax() then
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
end

function FollowerOfficeInterface:OnOfficeUp( data )
	self:UpdateSubView( data );
	local office_max = data:IsOfficeMax();
	local inter_view = self.mInterView;

	if office_max then
		inter_view:ShowView(data);
	else
		inter_view:OnOfficeUp(data);
	end
end

function FollowerOfficeInterface:OnViewHide()
	self.mInterView:OnViewHide();
end

function FollowerOfficeInterface:Dispose( )
	self.mView1:CloseView();
	self.mView2:CloseView();
end

return FollowerOfficeInterface;