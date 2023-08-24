local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mResourceUrl = require("AssetManager/ResourceUrl")
local mUITextureManager = require "Manager/UITextureManager"
local mRoleIconPath = mResourceUrl.role_icon;
local MansionServantHeadItemView = mLuaClass("MansionServantHeadItemView",mBaseView);
local mColor = Color;

function MansionServantHeadItemView:Init()
	self.mTextName = self:FindComponent('Text_name', 'Text');

	self.mImageIcon =self:FindComponent('icon', 'RawImage');
	self.mImageIcon.color = mColor.clear;

	self.mLoadedIcon = function(icon)
		self:LoadIconCallback(icon);
	end
end

function MansionServantHeadItemView:UpdateUI( data )
	local vo = data.mSysVO;
	self.mTextName.text = data:GetName();
	mUITextureManager.LoadTexture(mRoleIconPath, vo.mini_icon, self.mLoadedIcon);
end

function MansionServantHeadItemView:LoadIconCallback(icon)
	self.mImageIcon.texture = icon;
	self.mImageIcon.color = mColor.white;
end

return MansionServantHeadItemView;