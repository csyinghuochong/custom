local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mRoleIconPath = mResourceUrl.role_icon;
local mChildStar = require "Module/Child/ChildStar"
local ChildItemView = mLuaClass("ChildItemView", mLayoutItem);
local mSuper = nil;
local mColor = Color;

function ChildItemView:InitViewParam()
	return {
		["viewPath"] = "ui/child/",
		["viewName"] = "child_train_item_view",
	};
end

function ChildItemView:Init( )
	self.mBg = self:FindComponent("Back", 'Image');
    self.mKuang = self:FindComponent("Bord", 'Image');
	self.mIcon = self:FindComponent('Icon', 'RawImage');
	self.mIcon.color = mColor.clear;
	self.mLoadedIcon = function (icon)
		self:OnLoadedIcon(icon);
	end
	self.mStar = mChildStar.LuaNew(self:Find("Star").gameObject);

	local btn = self:FindComponent("Icon","Button");
	if btn ~= nil then
		btn.onClick:AddListener(function() self:OnSelectItem() end);
	end

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function ChildItemView:OnViewShow()
	
end

function ChildItemView:OnUpdateData()
	self:ExternalUpdate(self.mData);
end

--外部调用
function ChildItemView:ExternalUpdate(data)
	if data == nil then
		return;
	end
	self.mData = data;
    self.mGameObjectUtil:SetImageSprite(self.mKuang,data.bord);
    self.mGameObjectUtil:SetImageSprite(self.mBg,data.back);
    self.mStar:SetInfo(data.star_level);
	mUITextureManager.LoadTexture(mRoleIconPath, data:GetIcon(),self.mLoadedIcon);
end

function ChildItemView:OnSelectItem()
	self:SetSelected(true);
end

function ChildItemView:OnSelected(select)
	if select then
		local data = self.mData;
		if data ~= nil then
			local mEvent = self.mEventEnum;
			self:Dispatch(mEvent.ON_CHILD_SELECT,data);
		end
	end
end

function ChildItemView:OnLoadedIcon(icon)
	self.mIcon.texture = icon;
	self.mIcon.color = mColor.white;
end

return ChildItemView;