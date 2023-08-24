local mLuaClass = require "Core/LuaClass"
local TalentStrengthView = require "Module/Talent/TalentStrengthView"
local TalentStrengthMaxView = require "Module/Talent/TalentStrengthMaxView"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local TalentStrengthInterface = mLuaClass("TalentStrengthInterface", mCommonTabBaseView);
local mLanguageUtil = require "Utils/LanguageUtil"

function TalentStrengthInterface:Init()
	local trans = self.mTransform;
	local view1 = TalentStrengthView.LuaNew( );
	local view2 = TalentStrengthMaxView.LuaNew( );
	view1.mGoParent = trans;
	view2.mGoParent = trans;
	self.mView1 = view1;
	self.mView2 = view2;
	
	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_FOLLOWER_UP_EXP, function(vo)
		self:OnUpdateUI(vo);
	end, true);

	self:RegisterEventListener(mEventEnum.ON_UP_TALENT_SUCCEED, function( vo )
     	self:OnStrengthTalent( vo );
    end, true);
end

function TalentStrengthInterface:OnUpdateUI(data)
	if data == nil then
		return;
	end
	self:UpdateSubView( data );

	local inter_view = self.mInterView;
	if inter_view.mIsShow and inter_view.mGameObject ~=nil then
		inter_view:OnUpdateUI(data);
	else
		inter_view:ShowView(data);
	end
end

function TalentStrengthInterface:UpdateSubView( data )
	local inter_view = nil;
	if data:IsStrengthMax() then
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

function TalentStrengthInterface:OnStrengthTalent( data )
	self:UpdateSubView( data );
	if data:IsStrengthMax() then
		self.mInterView:ShowView(data);
	else
		self.mInterView:OnStrengthTalent( data );
	end
end

function TalentStrengthInterface:OnViewHide()
	self.mInterView:OnViewHide();
end

function TalentStrengthInterface:Dispose( )
	self.mView1:CloseView();
	self.mView2:CloseView();
end

return TalentStrengthInterface;