local mLuaClass = require "Core/LuaClass"
local mGlobalUtil = require "Utils/GlobalUtil"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local CommonFollowerItemView = mLuaClass("CommonFollowerItemView",mLayoutItem);
local mColor = Color;
local mSuper = nil;

function CommonFollowerItemView:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_item_view",
	};
end

function CommonFollowerItemView:Init()
	self.mTextLevel = self:FindComponent('Text', 'Text');
	self.mImageIcon =self:FindComponent('icon', 'RawImage');
	self.mImageIcon.color = mColor.clear;

	local star_list = {};
	for i = 1, mGlobalUtil.FollowerStar do
		local go = self:Find('star/'..i).gameObject;
		star_list[i] = go;
	end
	self.mStarList = star_list;
	self.mStarObj = self:Find('star').gameObject;

	local callBack = function() self:ClickFollowerItem() end;
	local button = self:FindComponent('icon', 'Button');
	if button ~= nil then
		self:FindAndAddClickListener('icon', callBack,"ty_0204");
	end

	local textName = self:Find('Text_name');
	if textName ~= nil then
		self.mTextName = textName:GetComponent('Text');
	end

	local objectSelect =  self:Find( 'on_select' );
	if objectSelect then
		self.mObjectSelect = objectSelect.gameObject;
	end

	local objectLock = self:Find( 'on_lock' );
	if objectLock then
		self.mObjectLock = objectLock.gameObject;
	end

	self.mLoadedIcon = function(icon)
		self:LoadIconCallback(icon);
	end

	self:InitGameImage( );
	
	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function CommonFollowerItemView:InitGameImage(  )
	self.mGoodsBgIcon = self:FindComponent("bg", 'Image');
    self.mGoodsKuang = self:FindComponent("kuang", 'Image');
end

function CommonFollowerItemView:OnUpdateData()
	self:UpdateUI();
end

function CommonFollowerItemView:UpdateUI()
	local data = self.mData;
	if data == nil then
		return;
	end
	local textName = self.mTextName;
	if textName  then
		textName.text = data:GetName();
	end
	local objectLock = self.mObjectLock;
	if objectLock then
		objectLock:SetActive( data.mLockFlag == 1 );
	end
	self.mTextLevel.text = data:GetLevel();

	self:ShowStarList( data );
	self:UpdateGameImage( data );
	mUITextureManager.LoadTexture(data:GetIconPath(), data:GetMiniIcon(),self.mLoadedIcon);
end

function CommonFollowerItemView:ShowStarList( data )
	local star = data:GetStar();
	for k, v in pairs( self.mStarList ) do
		v:SetActive(k <= star);
	end
	self.mStarObj:SetActive(not data:IsLead());
end

function CommonFollowerItemView:UpdateGameImage( data )
    self.mGameObjectUtil:SetImageSprite(self.mGoodsBgIcon, data:GetBgIcon() );
    self.mGameObjectUtil:SetImageSprite(self.mGoodsKuang, data:GetKuangIcon() );
end

function CommonFollowerItemView:ExternalUpdateData(data)
	self.mData = data;
	self:UpdateUI();
end

function CommonFollowerItemView:LoadIconCallback(icon)
	self.mImageIcon.texture = icon;
	self.mImageIcon.color = mColor.white;
end
   
function CommonFollowerItemView:ShowSelectedFlag(selected)
	self.mShowSelectd = selected;
	self.mObjectSelect:SetActive(selected);
end

function CommonFollowerItemView:ClickFollowerItem()
	
end

return CommonFollowerItemView;