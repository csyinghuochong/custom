local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mRoleIconPath = mResourceUrl.role_icon;
local mConfigSyspromote = require "ConfigFiles/ConfigSyspromote"
local RankItem = mLuaClass("RankItem",mLayoutItem);
local mSuper = nil;
local mColor = Color;

function RankItem:InitViewParam()
	return {
		["viewPath"] = "ui/rank/",
		["viewName"] = "rank_item_view",
	};
end

function RankItem:Init( )
	self.mTextRank = self:FindComponent("Left/RankText","Text");
	self.mTextName = self:FindComponent("Name","Text");
	self.mTextLv = self:FindComponent("Left/Lv","Text");
	self.mTextValue = self:FindComponent("Value","Text");

	self.mGameImgRank = self:FindComponent("Left/Rank","Image");
	self.mGameImgBack = self:FindComponent("Left/Back","Image");
	self.mGameImgBord = self:FindComponent("Left/Bord","Image");
	self.mImgIcon = self:FindComponent('Left/Head','RawImage');
	self.mImgIcon.color = mColor.clear;

	self:FindAndAddClickListener("Back",function()self:OnClickItem();end);

	self.mLoadedIcon = function(icon) self:OnLoadedIcon(icon); end

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function RankItem:OnClickItem()
	local mEvent = self.mEventEnum;
	local data = self.mData;
	self:Dispatch(mEvent.ON_ITEM_SELECT_RANK,data);
end

function RankItem:OnViewShow()
	
end

function RankItem:OnUpdateData()
	local data = self.mData;
	if data.rank > 3 then
		self.mGameImgRank.gameObject:SetActive(false);
		self.mTextRank.gameObject:SetActive(true);
		self.mTextRank.text = data.rank;
	else
		self.mGameImgRank.gameObject:SetActive(true);
		self.mTextRank.gameObject:SetActive(false);
		self.mGameObjectUtil:SetImageSprite(self.mGameImgRank,"ranking_icon_"..data.rank);
	end
	self.mTextName.text = data.name;
	self.mTextLv.text = data.lv;
	
	if data.sex == 2 then
		mUITextureManager.LoadTexture(mRoleIconPath, "role_10201",self.mLoadedIcon);
	else
		mUITextureManager.LoadTexture(mRoleIconPath, "role_10103",self.mLoadedIcon);
	end

	local position = self.mPosition;
	if position ~= data.position then
		if data.position >= 7 then
			self.mGameObjectUtil:SetImageSprite(self.mGameImgBack,"common_bag_iconframe_7s");
			self.mGameObjectUtil:SetImageSprite(self.mGameImgBord,"common_bag_iconframe_7");
		else
			self.mGameObjectUtil:SetImageSprite(self.mGameImgBack,"common_bag_iconframe_"..data.position.."s");
			self.mGameObjectUtil:SetImageSprite(self.mGameImgBord,"common_bag_iconframe_"..data.position);
		end
		self.mPosition = data.position;
	end

	self:UpdateSubUI( data );
end

function RankItem:UpdateSubUI( data )
	if data.type == 2 then
		if data.sex == 2 then
			self.mTextValue.text = mConfigSyspromote[data.position].woman_name;
		else
			self.mTextValue.text = mConfigSyspromote[data.position].man_name;
		end
	else
		self.mTextValue.text = data.value;
	end
end

function RankItem:OnLoadedIcon(icon)
	self.mImgIcon.texture = icon;
	self.mImgIcon.color = mColor.white;
end

return RankItem;