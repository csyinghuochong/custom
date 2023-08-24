local mLayoutItem = require "Core/Layout/LayoutItem"
local mLuaClass = require "Core/LuaClass"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mConfigSysmonster = require "ConfigFiles/ConfigSysmonster"
local mColor = Color
local CampDungeonMonsterItemView = mLuaClass("CampDungeonMonsterItemView", mLayoutItem);
local mSuper = nil;
local mRoleIconPath = mResourceUrl.role_icon;

function CampDungeonMonsterItemView:InitViewParam()
	return {
		["viewPath"] = "ui/camp_dungeon/",
		["viewName"] = "camp_dungeon_monster_item_view",
	};
end

function CampDungeonMonsterItemView:Init()
	self.mGameImgBack = self:FindComponent('Back','Image');
	self.mGameImgBord = self:FindComponent('Bord','Image');
	self.mImgIcon = self:FindComponent('Icon','RawImage');
	self.mImgIcon.color = mColor.clear;

	self.mLoadedIcon = function(icon) self:OnLoadedIcon(icon); end
	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function CampDungeonMonsterItemView:OnUpdateData()
	local id = self.mData.id;
	local config = mConfigSysmonster[id];
	local position = config.position;
	local icon = config.mini_icon;
	local positionFrame = "common_bag_iconframe_"..position;
	self.mGameObjectUtil:SetImageSprite(self.mGameImgBack,positionFrame.."s");
	self.mGameObjectUtil:SetImageSprite(self.mGameImgBord,positionFrame);
	mUITextureManager.LoadTexture(mRoleIconPath,icon,self.mLoadedIcon);
end

function CampDungeonMonsterItemView:OnLoadedIcon(icon)
	self.mImgIcon.texture = icon;
	self.mImgIcon.color = mColor.white;
end

return CampDungeonMonsterItemView;