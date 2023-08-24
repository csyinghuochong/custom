local mLuaClass = require "Core/LuaClass"
local LayoutItem = require "Core/Layout/LayoutItem"
local FashionSuitItemView = mLuaClass("FashionSuitItemView", LayoutItem);

local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mIconPath = mResourceUrl.goods_icon;

function FashionSuitItemView:InitViewParam()
	return {
		["viewPath"] = "ui/fashion/",
		["viewName"] = "fashion_suit_item",
	};
end

function FashionSuitItemView:Init()
	
	local clickCallback = function ()
		self:OnClick();
	end
	self:FindAndAddClickListener("bg", clickCallback);

	self.mSuitIcon = self:FindComponent("icon","RawImage");

	self.mLoadedIcon = function (tex)
		self:OnLoadedIcon(tex);
	end

	self:UpdateData(self.mData);
end


function FashionSuitItemView:OnClick()
	self:SetSelected(true);
end

function FashionSuitItemView:OnLoadedIcon(tex)
	self.mSuitIcon.texture = tex;
end

function FashionSuitItemView:OnUpdateData()

	local icon = self.mData.mIcon;
	if icon and icon ~= "" then
		mUITextureManager.LoadTexture(mIconPath, icon,self.mLoadedIcon);
	end
end

function FashionSuitItemView:OnSelected(value)
	self:Dispatch(self.mEventEnum.ON_SELECT_SUIT_ITEM,self);
end

return FashionSuitItemView;