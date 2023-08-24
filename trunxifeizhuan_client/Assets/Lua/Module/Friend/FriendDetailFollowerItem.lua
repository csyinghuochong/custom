local mUIGray = require "Utils/UIGray"
local mLuaClass = require "Core/LuaClass"
local mLeadBaseVO = require "Module/Lead/LeadBaseVO"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mGoodsIconPath = mResourceUrl.goods_icon;
local FriendDetailFollowerItem = mLuaClass("FriendDetailFollowerItem",mLayoutItem);
local mSuper = nil;

function FriendDetailFollowerItem:InitViewParam()
	return {
		["viewPath"] = "ui/friend/",
		["viewName"] = "friend_detail_skill_item_view",
	};
end

function FriendDetailFollowerItem:Init( )
	self.mImageIcon = self:FindComponent('Icon', 'RawImage');
	self.mImageBord = self:FindComponent('Back', 'RawImage');

	self.mLoadedIcon = function (icon) self:OnLoadedIcon(icon); end
	self.mLoadedBord = function (icon) self:OnLoadedBord(icon); end

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function FriendDetailFollowerItem:OnViewShow( )
	
end

function FriendDetailFollowerItem:OnUpdateData()
	local  data = self.mData;
	mUITextureManager.LoadTexture(mGoodsIconPath, mLeadBaseVO:GetMiniIcon(data.actor),self.mLoadedIcon);
end

function FriendDetailFollowerItem:OnLoadedIcon(icon)
	self.mImageIcon.texture = icon;
end

function FriendDetailFollowerItem:OnLoadedBord(icon)
	self.mImageBord.texture = icon;
end

return FriendDetailFollowerItem;