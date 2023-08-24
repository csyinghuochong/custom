local mLuaClass = require "Core/LuaClass"
local mLayoutController = require "Core/Layout/LayoutControllerLoop"
local LayoutController = mLuaClass("HorizontalLayoutControllerLoop",mLayoutController);
local mVector3 = Vector3;
local mVector2 = Vector2;

function LayoutController:SetItemInfo(itemWidth,itemHeight,pageItemCount)
	self.mItemWidth = itemWidth;
	self.mItemHeight = itemHeight;
	self.mPageItemCount = pageItemCount;
end

function LayoutController:SetContainerSize()
	local selfSortTable = self.mSortTable;
	local sortData = selfSortTable.mSortTable;
	local count = #sortData;

	self.mContainerWidth = self.mItemWidth * count;
	self.mContainerHeight = self.mItemHeight;
	self.mRectTransform.sizeDelta = mVector2.New(self.mContainerWidth,self.mContainerHeight);
end

function LayoutController:SetChildPos(transform,index)
	transform.localPosition = mVector3.New(-self.mContainerWidth / 2 + self.mItemWidth * ( index - 1) + self.mItemWidth /2,0,0);
end


return LayoutController;