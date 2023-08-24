local mLuaClass = require "Core/LuaClass"
local mEventEnum = require "Enum/EventEnum"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mCommonGoodsVO = require"Module/CommonUI/CommonGoodsVO";
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView";
local CommonAwardShowItemView = mLuaClass("CommonAwardShowItemView",mCommonGoodsItemView);
local mSuper = nil;
local mColor = Color

function CommonAwardShowItemView:InitViewParam()
	return {
		["viewPath"] = "ui/common/",
		["viewName"] = "common_award_show_item_view",
	};
end

function CommonAwardShowItemView:Init()
	self.mTextName = self:FindComponent("Name","Text");
	self.mTextDesc = self:FindComponent("Desc","Text");

	local textNumber = self:Find('Text');
	if textNumber ~= nil then
		self.mTextNumber = textNumber:GetComponent('Text');
	end
	local textName = self:Find('Text_name');
	if textName ~= nil then
		self.mTextName = textName:GetComponent('Text');
	end
    local btn = self:FindComponent("Icon/icon", "Button");
    if btn ~= nil then
    	self.mIconBtn = btn;
       btn.onClick:AddListener(function() self:OnClickIcon() end);
    end
	self.mGoodsBgIcon = self:FindComponent("bg", 'Image');
    self.mGoodsKuang = self:FindComponent("kuang", 'Image');
	self.mGoodsIcon = self:FindComponent('Icon/icon', 'RawImage');
	self.mGoodsIcon.color = mColor.clear;
	self.mLoadedIcon = function (icon)
		self:OnLoadedIcon(icon);
	end

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function CommonAwardShowItemView:OnUpdateData()
	local data = self.mData;
	self:ExternalUpdate(data.mGoodsData);
	self.mTextName.text = data.mGoodsData.mSysVO.goods_name;
	self.mTextDesc.text = data.mGoodsData.mSysVO.desc;
end

return CommonAwardShowItemView;