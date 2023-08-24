local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local CampDungeonFollowerItemView = mLuaClass("CampDungeonFollowerItemView", mLayoutItem);
local mSuper = nil;
local mColor = Color;
local mRoleIconPath = mResourceUrl.role_icon

function CampDungeonFollowerItemView:InitViewParam()
	return {
		["viewPath"] = "ui/camp_dungeon/",
		["viewName"] = "camp_dungeon_follower_item_view",
	};
end

function CampDungeonFollowerItemView:Init( )
	self.mFollowerIcon = self:FindComponent("follower/Icon","RawImage");
	self.mFollowerIcon.color = mColor.clear;
	self.mFollowerBack = self:FindComponent("follower/Back","Image");
	self.mFollowerBord = self:FindComponent("follower/Bord","Image");
	self.mTransSlider = self:Find("slider");

	self.mTextRank = self:FindComponent("rank","Text");
	self.mTextName = self:FindComponent("name","Text");
	self.mTextPer = self:FindComponent("per","Text");

	self.mLoadedIcon = function (icon)
		self:OnLoadedIcon(icon);
	end
	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function CampDungeonFollowerItemView:OnViewShow( )
	
end

function CampDungeonFollowerItemView:OnUpdateData()
	self:ExternalUpdate(self.mData);
end

--外部调用
function CampDungeonFollowerItemView:ExternalUpdate(data)
	if data ~= nil then
		local configOffice = data.mConfigSysOffice;
		local configActor = data.mConfigSysActor;
		self.mTextName.text = configActor.name;
		self.mTextRank.text = data.rank;
		self.mTextPer.text = (data.rate*100).."%";
		local width = 90*data.rate;
		self.mTransSlider.sizeDelta = Vector2(width,17);

		local position = self.mPosition;
		if position ~= configActor.position then
			self.mPosition = configActor.position;
			local iconFrame = "common_bag_iconframe_"..configActor.position;
			self.mGameObjectUtil:SetImageSprite(self.mFollowerBack,iconFrame.."s");
			self.mGameObjectUtil:SetImageSprite(self.mFollowerBord,iconFrame);
		end

		mUITextureManager.LoadTexture(mRoleIconPath, configOffice.mini_icon,self.mLoadedIcon);
	end
end

function CampDungeonFollowerItemView:OnLoadedIcon(icon)
	self.mFollowerIcon.texture = icon;
	self.mFollowerIcon.color = mColor.white;
end

return CampDungeonFollowerItemView;