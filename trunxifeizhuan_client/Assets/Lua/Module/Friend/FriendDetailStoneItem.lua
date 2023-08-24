local mLuaClass = require "Core/LuaClass"
local mUIGray = require "Utils/UIGray"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mGoodsIconPath = mResourceUrl.goods_icon;
local FriendDetailStoneItem = mLuaClass("FriendDetailStoneItem",mLayoutItem);
local mSuper = nil;

function FriendDetailStoneItem:InitViewParam()
	return {
		["viewPath"] = "ui/friend/",
		["viewName"] = "friend_detail_skill_item_view",
	};
end

function FriendDetailStoneItem:Init( )
	self.mImageIcon = self:FindComponent('Icon', 'RawImage');
	self.mImageBord = self:FindComponent('Back', 'RawImage');

	self.mLoadedIcon = function (icon) self:OnLoadedIcon(icon); end
	self.mLoadedBord = function (icon) self:OnLoadedBord(icon); end

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function FriendDetailStoneItem:OnViewShow( )
	
end

function FriendDetailStoneItem:OnUpdateData()
	local  data = self.mData;
	mUITextureManager.LoadTexture(mGoodsIconPath, data.mSysVO.icon,self.mLoadedIcon);
end

function FriendDetailStoneItem:OnLoadedIcon(icon)
	self.mImageIcon.texture = icon;
end

function FriendDetailStoneItem:OnLoadedBord(icon)
	self.mImageBord.texture = icon;
end

return FriendDetailStoneItem;