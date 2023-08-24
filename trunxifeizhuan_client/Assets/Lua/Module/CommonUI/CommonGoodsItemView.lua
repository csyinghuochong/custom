local mUIGray = require "Utils/UIGray"
local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mCommonLongClick = require "Module/CommonUI/CommonLongClick"
local mCommonPressButton = require "Module/CommonUI/CommonPressButton"
local mCommonGoodsDetial = require "Module/CommonUI/CommonGoodsDetialView"
local CommonGoodsItemView = mLuaClass("CommonGoodsItemView", mLayoutItem);
local mColor = Color;
local mSuper = nil;

function CommonGoodsItemView:InitViewParam()
	return {
		["viewPath"] = "ui/common/",
		["viewName"] = "common_goods_item_view",
	};
end

function CommonGoodsItemView:OnLuaNew(go,bg,kuang)
	self.mGoodsBgIcon = bg;
	self.mGoodsKuang = kuang;
	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.OnLuaNew(self, go);
end

function CommonGoodsItemView:Init( )
	local textNumber = self:Find('Text');
	if textNumber ~= nil then
		self.mTextNumber = textNumber:GetComponent('Text');
	end
	local textName = self:Find('Text_name');
	if textName ~= nil then
		self.mTextName = textName:GetComponent('Text');
	end
    local btn = self:FindComponent("icon", "Button");
    if btn ~= nil then
    	self.mIconBtn = btn;
       btn.onClick:AddListener(function() self:OnClickIcon() end);
    end
    if self.mGoodsBgIcon == nil then
		self.mGoodsBgIcon = self:FindComponent("bg", 'Image');
	end
	if self.mGoodsKuang == nil then
    	self.mGoodsKuang = self:FindComponent("kuang", 'Image');
    end
	self.mGoodsIcon = self:FindComponent('icon', 'RawImage');
	self.mGoodsIcon.color = mColor.clear;
	self.mLoadedIcon = function (icon)
		self:OnLoadedIcon(icon);
	end

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function CommonGoodsItemView:OnViewShow( )
	
end

function CommonGoodsItemView:OnUpdateData()
	self:ExternalUpdate(self.mData);
end

--外部调用
function CommonGoodsItemView:ExternalUpdate(data)
	if data == nil then
		return;
	end
	self.mData = data;
	local textName = self.mTextName;
	if textName ~= nil then
		textName.text = data:GetGoodsName( );
	end

    self.mGameObjectUtil:SetImageSprite(self.mGoodsKuang,data.mKuang);
    self.mGameObjectUtil:SetImageSprite(self.mGoodsBgIcon,data.mBg);

    self:ShowGoodsNumber(data.mNumber);
	mUITextureManager.LoadTexture(data:GetIconPath(), data.mIcon,self.mLoadedIcon);

    self:AddLongClick(data);
end

local mCommonGoodsVO = require"Module/CommonUI/CommonGoodsVO";
function CommonGoodsItemView:UpdateByIdAndNum( id, number, color, showDetial )
	local data = mCommonGoodsVO.LuaNew( id, number, color, showDetial );
	self:ExternalUpdate( data );
end

function CommonGoodsItemView:AddLongClick(data)
	if data.mShowDetial and self.mIconBtn then
		mCommonLongClick.LuaNew(self.mIconBtn.gameObject,2,data.mID,0,0.5);
	end
end

function CommonGoodsItemView:OnClickIcon()

end

function CommonGoodsItemView:ShowGoodsNumber( number )
	local textNumber = self.mTextNumber;
	if textNumber ~= nil then
		textNumber.text = number ~= 0 and number or "";
	end
end

function CommonGoodsItemView:OnLoadedIcon(textrue)
	if self.mIsDestory then
		return;
	end
	local icon = self.mGoodsIcon;
	icon.texture = textrue;
	icon.color = mColor.white;
end

return CommonGoodsItemView;