local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mUITextureManager = require "Manager/UITextureManager"
local mResourceUrl = require "AssetManager/ResourceUrl"
local FaceItem = mLuaClass("FaceItem",mLayoutItem);

local mFaceIconPath = mResourceUrl.face;

function FaceItem:InitViewParam()
	return {
		["viewPath"] = "ui/chat/",
		["viewName"] = "face_item",
	};
end

function FaceItem:Init( )
	self.mImgIcon = self:FindComponent('Face/face','RawImage');
	self:FindAndAddClickListener('Face',function()self:OnClickFace();end);
	self.mLoadedIcon = function(icon) self:OnLoadedIcon(icon); end
	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function FaceItem:OnClickFace()
	local mEvent = self.mEventEnum;
	local data = self.mData;
	self:Dispatch(mEvent.ON_CLICK_FACE,data);
end

function FaceItem:OnUpdateData()
	local data = self.mData;
	mUITextureManager.LoadTexture(mFaceIconPath, data.icon,self.mLoadedIcon);
end

function FaceItem:OnLoadedIcon(icon)
	self.mImgIcon.texture = icon;
	self.mImgIcon.gameObject:SetActive(true);
end

return FaceItem;