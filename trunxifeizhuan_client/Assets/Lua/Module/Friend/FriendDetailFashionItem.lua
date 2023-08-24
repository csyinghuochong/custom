local mLuaClass = require "Core/LuaClass"
local mUIGray = require "Utils/UIGray"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mResourceUrl = require "AssetManager/ResourceUrl"
local FriendDetailFashionItem = mLuaClass("FriendDetailFashionItem",mLayoutItem);
local mSuper = nil;

function FriendDetailFashionItem:InitViewParam()
	return {
		["viewPath"] = "ui/friend/",
		["viewName"] = "friend_detail_skill_item_view",
	};
end

function FriendDetailFashionItem:Init( )
	self.mImageIcon = self:FindComponent('Icon', 'RawImage');
	self.mImageBord = self:FindComponent('Back', 'RawImage');

	self.mLoadedIcon = function (icon) self:OnLoadedIcon(icon); end
	self.mLoadedBord = function (icon) self:OnLoadedBord(icon); end
	
	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function FriendDetailFashionItem:OnViewShow( )
	
end

function FriendDetailFashionItem:OnUpdateData()
	local  data = self.mData;
end

function FriendDetailFashionItem:OnLoadedIcon(icon)
	self.mImageIcon.texture = icon;
end

function FriendDetailFashionItem:OnLoadedBord(icon)
	self.mImageBord.texture = icon;
end

return FriendDetailFashionItem;