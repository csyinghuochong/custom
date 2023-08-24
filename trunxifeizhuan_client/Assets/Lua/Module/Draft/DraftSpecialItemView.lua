local mLayoutItem = require "Core/Layout/LayoutItem"
local mLuaClass = require "Core/LuaClass"
local mLayoutController = require "Core/Layout/LayoutController"
local DraftSpecialItemView = mLuaClass("DraftSpecialItemView", mLayoutItem);
local mSuper = nil;

function DraftSpecialItemView:InitViewParam()
	return {
		["viewPath"] = "ui/draft/",
		["viewName"] = "draft_special_item_view",
	};
end

function DraftSpecialItemView:Init()
	self.mTitleStr = self:Find("name"):GetComponent('Text');
	local parent = self:Find("Grid");
    self.mDraftGridEx = mLayoutController.LuaNew(parent, require "Module/Draft/DraftSpecialItemItemView");
    mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self); 
end

function DraftSpecialItemView:OnUpdateData()
    local data = self.mData;
    self.mTitleStr.text = data.mTitle;
    self.mDraftGridEx:UpdateDataSource(data.mDataSoure);
end

function DraftSpecialItemView:Dispose()
	self.mDraftGridEx:Dispose();
end

return DraftSpecialItemView;