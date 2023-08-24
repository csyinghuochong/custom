local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mGameModelManager = require "Manager/GameModelManager"
local TalentController = require "Module/Talent/TalentController"
local TalentBaseInfoView = require "Module/Talent/TalentBaseInfoView"
local FollowerTalentPopView = mLuaClass("FollowerTalentPopView", mBaseView);
local mSuper = nil;

function FollowerTalentPopView:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_talent_pop_view",
		["ParentLayer"] = mMainLayer1,
	};
end

function FollowerTalentPopView:SetExternalParams( params )
	self.mGoParent = params.parent;
	self.mButtonText1 = params.text1;
	self.mButtonText2 = params.text2;
	self.mCallBack1 = params.callback1;
	self.mCallBack2 = params.callback2;
	self.mCallBack3 = params.callback3;

	if self.mGameObject then
		self:OnUpdateUI(  );
	end
end

function FollowerTalentPopView:Init()
	self.mBaseInfoView = TalentBaseInfoView.LuaNew( self:Find( 'base_view' ).gameObject );
	self:FindAndAddClickListener('Button_1', function() self:OnClickButton1() end);
	self:FindAndAddClickListener('Button_2', function() self:OnClickButton2() end);
	self:FindAndAddClickListener('Button_3', function() self:OnClickButton3() end);
end

function FollowerTalentPopView:OnUpdateUI(  )
	mGameObjectUtil:SetParent( self.mTransform, self.mGoParent );
	local textButton1 = self:FindComponent( 'Button_1/Text', 'Text' );
	local textButton2 = self:FindComponent( 'Button_2/Text', 'Text' );
	textButton1.text = self.mButtonText1;
	textButton2.text = self.mButtonText2;
end

function FollowerTalentPopView:OnViewShow(data)
	self.mData = data;
	self:OnUpdateUI(  );
	self.mBaseInfoView:OnUpdateUI( data );
end

function FollowerTalentPopView:OnClickButton1( )
	self.mCallBack1( self.mData );
end

function FollowerTalentPopView:OnClickButton2( )
	self.mCallBack2( self.mData );
end

function FollowerTalentPopView:OnClickButton3( )
	self.mCallBack3( );
end

function FollowerTalentPopView:Dispose( )
	
end

return FollowerTalentPopView;