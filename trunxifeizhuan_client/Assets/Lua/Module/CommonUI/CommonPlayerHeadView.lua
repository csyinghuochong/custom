local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mRoleIconPath = mResourceUrl.role_icon;
local mColor = Color
local CommonPlayerHeadView = mLuaClass("CommonPlayerHeadView", mBaseView);
local mSuper = nil;

function CommonPlayerHeadView:OnLuaNew(go)
	mSuper = self:GetSuper(mBaseView.LuaClassName);
	mSuper.OnLuaNew(self, go);
end

function CommonPlayerHeadView:Init()
	self.mImgBack = self:FindComponent('Back','Image');
	self.mImgBord = self:FindComponent('Bord','Image');
	self.mImgIcon = self:FindComponent('Icon','RawImage');
	self.mImgIcon.color = mColor.clear;
	self.mTextLevel = self:FindComponent('Level','Text');

	self.mLoadedIcon = function(icon) self:OnLoadedIcon(icon); end
end

function CommonPlayerHeadView:SetInfo(sex,position,level)
	local Position = self.mPosition;
	if Position ~= position then
		if position >= 7 then
			self.mGameObjectUtil:SetImageSprite(self.mImgBack,"common_bag_iconframe_7s");
			self.mGameObjectUtil:SetImageSprite(self.mImgBord,"common_bag_iconframe_7");
		else
			self.mGameObjectUtil:SetImageSprite(self.mImgBack,"common_bag_iconframe_"..position.."s");
			self.mGameObjectUtil:SetImageSprite(self.mImgBord,"common_bag_iconframe_"..position);
		end
		self.mPosition = position;
	end
	if sex == 1 then
		mUITextureManager.LoadTexture(mRoleIconPath, "role_10103",self.mLoadedIcon);
	else
		mUITextureManager.LoadTexture(mRoleIconPath, "role_10201",self.mLoadedIcon);
	end
	self.mTextLevel.text = level;
end

function CommonPlayerHeadView:SetInfoByPlayerBase( pv_vo  )
	self:SetInfo( pv_vo.sex, pv_vo.position, pv_vo.level );
end

function CommonPlayerHeadView:OnLoadedIcon(icon)
	if self.mIsDestory then
		return;
	end
	self.mImgIcon.texture = icon;
	self.mImgIcon.color = mColor.white;
end

return CommonPlayerHeadView;