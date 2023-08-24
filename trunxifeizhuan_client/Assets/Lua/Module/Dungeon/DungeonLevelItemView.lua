local mUIGray = require "Utils/UIGray"
local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mLanguageUtil = require "Utils/LanguageUtil"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mRoleIconPath = mResourceUrl.role_icon;
local mConfigSysmonster = require "ConfigFiles/ConfigSysmonster"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local DungeonLevelItemView = mLuaClass("DungeonLevelItemView", mBaseView);
local mColor = Color;

function DungeonLevelItemView:Init()
	self.mTextName = self:FindComponent("Text_1","Text");
	self.mImageIcon =self:FindComponent('Image_icon', 'RawImage');
	self.mImageIcon.color = mColor.clear;
	self.mIconGray = mUIGray.LuaNew():InitGoGraphic(self:Find('Image_icon').gameObject);

	self:FindAndAddClickListener("button_1",function() self:OnClickButton(); end);
	self:FindAndAddClickListener("Image_icon",function() self:OnClickButton(); end);
	self.mLoadedIcon = function(icon)
		self:LoadIconCallback(icon);
	end
end

function DungeonLevelItemView:OnUpdateData( data )
	self.mData = data;
	self.mTextName.text = data.mSysVO.dungeon_name;
	local icon = mConfigSysmonster[data.mSysVO.dungeon_boss].mini_icon;
	mUITextureManager.LoadTexture(mRoleIconPath, icon, self.mLoadedIcon);
end

local mLgLevelNoOpenTip = mLanguageUtil.dungeon_level_no_open;
function DungeonLevelItemView:OnClickButton(  )
	local data = self.mData;
	if data:IsOpen( ) then
		self:Dispatch(self.mEventEnum.ON_SELECT_DUNGEON_ITEM, data);
	else
		mCommonTipsView.Show( mLgLevelNoOpenTip );
	end
end

function DungeonLevelItemView:LoadIconCallback(icon)
	self.mImageIcon.texture = icon;
	self.mImageIcon.color = mColor.white;
	self.mIconGray:SetGray(not self.mData:IsOpen( ));
end

return DungeonLevelItemView;