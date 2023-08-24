local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mConfigSysmonster = require "ConfigFiles/ConfigSysmonster"
local CommonMonsterHeadView = mLuaClass("CommonMonsterHeadView", mBaseView);
local mColor = Color
local mSuper = nil;
local mRoleIconPath = mResourceUrl.role_icon;

function CommonMonsterHeadView:OnLuaNew(go)
	mSuper = self:GetSuper(mBaseView.LuaClassName);
	mSuper.OnLuaNew(self, go);
end

function CommonMonsterHeadView:Init()
	self.mGameImgBack = self:FindComponent('Back','Image');
	self.mGameImgBord = self:FindComponent('Bord','Image');
	self.mImgIcon = self:FindComponent('Icon','RawImage');
	self.mImgIcon.color = mColor.clear;

	self.mLoadedIcon = function(icon) self:OnLoadedIcon(icon); end
end

function CommonMonsterHeadView:SetInfo(id)
	local config = mConfigSysmonster[id];
	local position = config.position;
	local icon = config.mini_icon;
	local positionFrame = "common_bag_iconframe_"..position;
	self.mGameObjectUtil:SetImageSprite(self.mGameImgBack,positionFrame.."s");
	self.mGameObjectUtil:SetImageSprite(self.mGameImgBord,positionFrame);
	mUITextureManager.LoadTexture(mRoleIconPath,icon,self.mLoadedIcon);
end

function CommonMonsterHeadView:OnLoadedIcon(icon)
	self.mImgIcon.texture = icon;
	self.mImgIcon.color = mColor.white;
end

return CommonMonsterHeadView;