local mLuaClass = require "Core/LuaClass"
local mLayoutController = require "Core/Layout/LayoutControllerLoop"
local LayoutController = mLuaClass("VerticalLayoutControllerLoop",mLayoutController);
local mVector3 = Vector3;
local mVector2 = Vector2;
local mMathFloor = math.floor;
local mMathMax = math.max;

function LayoutController:SetItemInfo(itemWidth,itemHeight,spacing,pageItemCount)
	self.mItemWidth = itemWidth;
	self.mItemHeight = itemHeight;
	self.mSpacing = spacing;
	self.mItemHeightAndSpace = itemHeight + spacing;
	self.mPageItemCount = pageItemCount;
end

function LayoutController:SetContainerSize()
	local selfSortTable = self.mSortTable;
	local sortData = selfSortTable.mSortTable;
	local count = #sortData;

	if count == 0 then
		return false;
	end

	self.mScrollRect.velocity = mVector2.zero;

	self.mContainerWidth = self.mItemWidth;
	self.mContainerHeight = mMathMax(self.mItemHeightAndSpace * count - self.mSpacing,self.mContentSizeDelta.y);
	self.mRectTransform.sizeDelta = mVector2.New(self.mContainerWidth,self.mContainerHeight);
	self.mStartPos = -(self.mContainerHeight/2 - self.mContentSizeDelta.y/2);
	self.mContainerTransform.localPosition = mVector3(0,self.mStartPos);
	self.mMoveConst = self.mContainerHeight / 2  - self.mItemHeight /2;

	return true;
end

function LayoutController:GetMoveIndex()
	local moveOffset =  self.mContainerTransform.localPosition.y - self.mStartPos;
	if moveOffset < 0 then
		return 1;
	end

	local moveItemIndex = mMathFloor(moveOffset / self.mItemHeightAndSpace) + 1;
	return moveItemIndex;
end

function LayoutController:SetChildPos(transform,index)
	local y = self.mMoveConst - self.mItemHeightAndSpace * ( index - 1);

	transform.localPosition = mVector3.New(0,y,0);
end


return LayoutController;