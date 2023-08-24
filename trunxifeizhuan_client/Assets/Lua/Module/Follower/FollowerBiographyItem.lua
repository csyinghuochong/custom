local mUIGray = require "Utils/UIGray"
local mLuaClass = require "Core/LuaClass"
local mLanguage = require "Utils/LanguageUtil"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mCommonTabView = require "Module/CommonUI/TabView/CommonTabView"
local mFollowerController = require "Module/Follower/FollowerController"
local FollowerBiographyItem = mLuaClass("FollowerBiographyItem",mLayoutItem);
local mSuper = nil;

function FollowerBiographyItem:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_biography_item",
	};
end

function FollowerBiographyItem:Init( )
	self.mTextName = self:FindComponent('Text_name', 'Text');
	self.PassState = self:Find('Image_pass').gameObject;

	self:AddBtnClickListener(self.mGameObject,function() self:OnClick() end);
	self.mUIGray = mUIGray.LuaNew():InitGoGraphics(self.mGameObject);
	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function FollowerBiographyItem:OnClick()
	local data = self.mData;

	if data:IsOpen() then
		mFollowerController:OnClickChallengeDungeon(data.mID, data.mFollowerID);
	elseif data:IsPass() then
		mCommonTabView.Show( mLanguage.follower_biography_tip1 );
	else
		mCommonTabView.Show( mLanguage.follower_biography_tip2 );
	end
end

function FollowerBiographyItem:OnViewShow( )
	
end

function FollowerBiographyItem:OnUpdateData()
	local data = self.mData;

	self.mTextName.text = data:GetDungeonName( );
	self.mUIGray:SetGray(not data:IsOpen());
	self.PassState:SetActive(data:IsPass());
end

return FollowerBiographyItem;