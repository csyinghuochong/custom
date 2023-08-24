local mLuaClass = require "Core/LuaClass"
local mUIGray = require "Utils/UIGray"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mSkillIconPath = mResourceUrl.skill_icon;
local mCommonGoodsDetial = require "Module/CommonUI/CommonGoodsDetialView"
local mConfigSysskill = require "ConfigFiles/ConfigSysskill"
local FriendDetailSkillItem = mLuaClass("FriendDetailSkillItem",mLayoutItem);
local mSuper = nil;

function FriendDetailSkillItem:InitViewParam()
	return {
		["viewPath"] = "ui/friend/",
		["viewName"] = "friend_detail_skill_item_view",
	};
end

function FriendDetailSkillItem:Init( )
	self.mImageIcon = self:FindComponent('Icon', 'RawImage');

	self.mLoadedIcon = function (icon) self:OnLoadedIcon(icon); end

    self:FindAndAddClickListener("Icon",function () self:OnClickButton() end);
	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function FriendDetailSkillItem:OnViewShow( )

end

function FriendDetailSkillItem:OnClickButton()
	local table = {mTransform = self.mTransform,mConfigID = self.mData.id,mType = 1};
    mCommonGoodsDetial.Show(table);
end

function FriendDetailSkillItem:OnUpdateData()
	local  id = self.mData.id;
	local skillConfig = mConfigSysskill[id];
	mUITextureManager.LoadTexture(mSkillIconPath, skillConfig.icon,self.mLoadedIcon);
end

function FriendDetailSkillItem:OnLoadedIcon(icon)
	self.mImageIcon.texture = icon;
end

return FriendDetailSkillItem;