local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mResourceUrl = require("AssetManager/ResourceUrl")
local mUITextureManager = require "Manager/UITextureManager"
local mGoodsIconPath = mResourceUrl.goods_icon;
local mCommonLongClick = require "Module/CommonUI/CommonLongClick"
local FollowerTalentSuitItem = mLuaClass("FollowerTalentSuitItem",mBaseView);
local mString = require 'string'
local mSuper = nil;
local mColor = Color;

function FollowerTalentSuitItem:OnLuaNew( go , index, callBack )
	self.mIndex = go;
	self.mCallBack = callBack;

	mSuper = self:GetSuper(mBaseView.LuaClassName);
    mSuper.OnLuaNew(self,go);
end

function FollowerTalentSuitItem:Init()
	self.mTextNumber = self:FindComponent('Text', 'Text');
	self.mImageIcon =self:FindComponent('icon', 'RawImage');
	self.mTextName = self:FindComponent('Text_name', 'Text');
	self.mImageIcon.color = mColor.clear;

	local callBack = function() self:ClickTalentItem() end;
	local listener = self:FindComponent('icon', 'GameUIPointerHandler');
	listener.onPointerDown = function ()
     	self:OnPointerDown( );
    end
    listener.onPointerExit = function ()
   		self:OnPointerExit( );
    end

	self.mLoadedIcon = function(icon)
		self:LoadIconCallback(icon);
	end
end

function FollowerTalentSuitItem:UpdateUI()
	local data = self.mData;
	self.mTextName.text = data:GetName();
	self.mTextNumber.text = data:GetNumber();
	mUITextureManager.LoadTexture(mGoodsIconPath, data:GetIcon(), self.mLoadedIcon);

end

function FollowerTalentSuitItem:OnPointerDown()
	self.mCallBack( self.mData, 1 )
end

function FollowerTalentSuitItem:OnPointerExit()
	self.mCallBack( self.mData, 0 )
end

function FollowerTalentSuitItem:ExternalUpdateData(data)
	self.mData = data;

	self:UpdateUI();
end

function FollowerTalentSuitItem:ClickTalentItem(data)

end

function FollowerTalentSuitItem:LoadIconCallback(icon)
	self.mImageIcon.texture = icon;
	self.mImageIcon.color = mColor.white;
end

return FollowerTalentSuitItem;