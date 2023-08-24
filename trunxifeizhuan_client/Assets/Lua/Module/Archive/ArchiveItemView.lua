local mLuaClass = require "Core/LuaClass"
local mGlobalUtil = require "Utils/GlobalUtil"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mConfigSysactor = require "ConfigFiles/ConfigSysactor"
local mConfigSysfollower_office_up = require "ConfigFiles/ConfigSysfollower_office_up"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mGameModelManager = require "Manager/GameModelManager"
local ArchiveItemView = mLuaClass("ArchiveItemView",mLayoutItem);
local mColor = Color;
local mSuper = nil;
local mIconPath = mResourceUrl.role_icon

function ArchiveItemView:InitViewParam()
	return {
		["viewPath"] = "ui/archive/",
		["viewName"] = "archive_item_view",
	};
end

function ArchiveItemView:Init()
	self.mImageIcon =self:FindComponent('icon', 'RawImage');
	self.mGoodsBgIcon = self:FindComponent("bg", 'Image');
    self.mGoodsKuang = self:FindComponent("kuang", 'Image');
    self.mGoBlack = self:Find("black").gameObject;

	local star_list = {};
	for i = 1, mGlobalUtil.FollowerStar do
		local go = self:Find('star/'..i).gameObject;
		star_list[i] = go;
	end
	self.mStarList = star_list;
	local button = self:FindComponent('icon', 'Button');
	local callBack = function() self:ClickFollowerItem() end;
	if button ~= nil then
		self:FindAndAddClickListener('icon', callBack,"ty_0204");
	end
	self.mLoadedIcon = function(icon)
		self:LoadIconCallback(icon);
	end

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function ArchiveItemView:OnUpdateData()
	self:UpdateUI();
end

function ArchiveItemView:UpdateUI()
	self.mImageIcon.color = mColor.clear;
	local data = self.mData;
	local config = mConfigSysactor[data.id];
	local star = config.star;
	for k, v in pairs( self.mStarList ) do
		v:SetActive(k <= star);
	end
	local position = self.mPosition;
	if position ~= config.position then
		self.mPosition = config.position;
		self.mGameObjectUtil:SetImageSprite(self.mGoodsBgIcon,"common_bag_iconframe_"..config.position.."s");
	    self.mGameObjectUtil:SetImageSprite(self.mGoodsKuang,"common_bag_iconframe_"..config.position);
	end

    local configOffice = mConfigSysfollower_office_up[data.id.."_1"];
	mUITextureManager.LoadTexture(mIconPath,configOffice.mini_icon,self.mLoadedIcon);

	if data.num > 0 then
		self.mGoBlack:SetActive(false);
	else
		self.mGoBlack:SetActive(true);
	end
end

function ArchiveItemView:ExternalUpdateData(data)
	self.mData = data;

	self:UpdateUI();
end

function ArchiveItemView:LoadIconCallback(icon)
	self.mImageIcon.texture = icon;
	self.mImageIcon.color = mColor.white;
end

function ArchiveItemView:ClickFollowerItem()
	local data = self.mData;
	local id = data.id;
	mUIManager:HandleUI(mViewEnum.ArchiveShowView,1,id);
	local model = mGameModelManager.ArchiveModel;
	model.mNowIndex = data.mSortTableIndex;
end

return ArchiveItemView;