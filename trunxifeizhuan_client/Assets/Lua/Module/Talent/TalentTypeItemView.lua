local mLuaClass = require "Core/LuaClass"
local mGlobalUtil = require "Utils/GlobalUtil"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mGoodsIconPath = mResourceUrl.goods_icon;
local TalentTypeItemView = mLuaClass("TalentTypeItemView",mLayoutItem);
local mColor = Color;
local mSuper = nil;

function TalentTypeItemView:InitViewParam()
	return {
		["viewPath"] = "ui/talent/",
		["viewName"] = "talent_type_item_view",
	};
end

function TalentTypeItemView:Init()
	self.mTextNumber = self:FindComponent('Text', 'Text');
	self.mImageIcon =self:FindComponent('icon', 'RawImage');
	self.mTextName = self:FindComponent('Text_name', 'Text');
	self.mObjectBg = self:Find( 'bg2' ).gameObject;
	self.mImageIcon.color = mColor.clear;

	local callBack = function() self:ClickTalentItem() end;
	local button = self:FindComponent('icon', 'Button');
	if button ~= nil then
		self:FindAndAddClickListener('icon', callBack,"ty_0204");
	end

	self.mLoadedIcon = function(icon)
		self:LoadIconCallback(icon);
	end

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function TalentTypeItemView:OnUpdateData()
	self:UpdateUI();
end

function TalentTypeItemView:UpdateUI()
	if self.mData == nil or self.mGameObject == nil then
		return;
	end
	local data = self.mData;
	self.mTextName.text = data:GetName();
	local number = data:GetNumber();
	self.mTextNumber.text = number > 0 and number or "";
	self.mObjectBg:SetActive( number > 0 );
	mUITextureManager.LoadTexture(mGoodsIconPath, data:GetIcon(), self.mLoadedIcon);
end

function TalentTypeItemView:ExternalUpdateData(data)
	self.mData = data;

	self:UpdateUI();
end

function TalentTypeItemView:LoadIconCallback(icon)
	self.mImageIcon.texture = icon;
	self.mImageIcon.color = mColor.white;
end

function TalentTypeItemView:ClickTalentItem()
	self:Dispatch(self.mEventEnum.ON_SELECT_TYPE_TALENT, self.mData);
end

return TalentTypeItemView;