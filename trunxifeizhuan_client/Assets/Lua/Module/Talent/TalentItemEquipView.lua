local mUIGray = require "Utils/UIGray"
local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local TalentItemEquipView = mLuaClass("TalentItemEquipView", mLayoutItem);
local mColor = Color;
local mSuper = nil;

function TalentItemEquipView:Init( )
	local star_list = {};
	for i = 1, 6 do
		local go = self:Find('star/'..i).gameObject;
		star_list[i] = go;
	end
	self.mStarList = star_list;

	local textLevel = self:Find('Text');
	if textLevel ~= nil then
		self.mTextLevel = textLevel:GetComponent('Text');
	end
    local btn = self:FindComponent("color", "Button");
    if btn ~= nil then
      	btn.onClick:AddListener(function() self:OnClickIcon() end);
    end

    self.mObjectBg = self:Find( 'bg2' ).gameObject;
  
	self.mGoodsIcon = self:FindComponent('icon', 'RawImage');
	self.mGoodsIcon.color = mColor.clear;
	self.mLoadedIcon = function (icon)
		self:OnLoadedIcon(icon);
	end

	self:InitGameImage( );

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function TalentItemEquipView:InitGameImage( )
 	self.mGoodsColor = self:FindComponent("color", 'Image');
end

function TalentItemEquipView:OnViewShow( )
	
end

function TalentItemEquipView:OnUpdateData()
	self:ExternalUpdate(self.mData);
end

--外部调用
function TalentItemEquipView:ExternalUpdate(data)
	if data == nil then
		return;
	end
	self.mData = data;
	local textLevel = self.mTextLevel;
	if textLevel ~= nil then
		local level = data:GetLevel( );
		self.mObjectBg:SetActive( level > 0 );
		if level > 0 then
			textLevel.text = '+'..data:GetLevel( );
		else
			textLevel.text = '';
		end
	end
	local star = data:GetStar();
	local talent = data:GetGoodsType() == 1;
	for k, v in pairs( self.mStarList ) do
		v:SetActive(k <= star and talent);
	end

   	self:UpdateGameImage( data );

	mUITextureManager.LoadTexture(data:GetIconPath(), data:GetIcon(), self.mLoadedIcon);
end

function TalentItemEquipView:UpdateGameImage( data )
	self.mGameObjectUtil:SetImageSprite(self.mGoodsColor, data:GetColorIcon( ));
end

function TalentItemEquipView:OnLoadedIcon(texture)
	if self.mIsDestory then
		return;
	end
	local icon = self.mGoodsIcon;
	icon.texture = texture;
	icon.color = mColor.white;
end

function TalentItemEquipView:OnClickIcon()
	self:Dispatch(self.mEventEnum.ON_SELECT_EQUIP_ITEM, self.mData);
end

return TalentItemEquipView;