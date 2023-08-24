local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mColor = Color;

local AreaItemView = mLuaClass("AreaItemView",mLayoutItem);
local mSuper = nil;

function AreaItemView:InitViewParam()
	return {
		["viewPath"] = "ui/login/",
		["viewName"] = "area_item_view",
	};
end

function AreaItemView:Init()
	self.mSelected = false;

	self.mTextAreaName = self:FindComponent('Text', 'Text');
	self.mImageOn = self:Find("image_on").gameObject;
	self.mImageOff = self:Find("image_off").gameObject;

	local callBack = function() self:ClickAreaItem() end;
	self:FindAndAddClickListener("image_on", callBack);
	self:FindAndAddClickListener("image_off", callBack);

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function AreaItemView:OnUpdateData()
	self.mTextAreaName.text = self.mData.mArenaName;
end

function AreaItemView:OnSelected(value)
	self.mTextAreaName.color = value and mColor.white or mColor.New(160 / 255, 79 / 255, 64 / 255);
	self.mImageOn:SetActive(not value);
	self.mImageOff:SetActive(value);
end

function  AreaItemView:ClickAreaItem()
	self:SetSelected(true);

	local data = self.mData;
	local callback = data.mCallBack;

	if(callback ~= nil) then
		callback(data.mID);
	end
end

return AreaItemView;