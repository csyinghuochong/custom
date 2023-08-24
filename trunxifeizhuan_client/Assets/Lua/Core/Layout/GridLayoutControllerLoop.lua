local mLuaClass = require "Core/LuaClass"
local mLayoutController = require "Core/Layout/LayoutControllerLoop"
local LayoutController = mLuaClass("GridLayoutControllerLoop",mLayoutController);
local mVector3 = Vector3;
local mVector2 = Vector2;
local mMathFloor = math.floor;
local mMathCeil = math.ceil;
local mMathMax = math.max;
local mMathFmod = math.fmod;

function LayoutController:SetItemInfo(itemWidth,itemHeight,spacingX,spacingY,rowCount,columnCount)
	self.mItemWidth = itemWidth;
	self.mItemHeight = itemHeight;
	self.mSpacingX = spacingX;
	self.mSpacingY = spacingY;
	self.mItemWidthAndSpace = itemWidth + spacingX;
	self.mItemHeightAndSpace = itemHeight + spacingY;
	self.mRowCount = rowCount;
	self.mColumnCount = columnCount;
	self.mPageItemCount = rowCount * columnCount;
end

function LayoutController:SetContainerSize()
	local selfSortTable = self.mSortTable;
	local sortData = selfSortTable.mSortTable;
	local count = #sortData;

	if count == 0 then
		return false;
	end

	self.mScrollRect.velocity = mVector2.zero;
	self.mContainerWidth = mMathMax(self.mItemWidthAndSpace * self.mColumnCount - self.mSpacingX,self.mContentSizeDelta.x);
	self.mContainerHeight = mMathMax(self.mItemHeightAndSpace * mMathCeil(count / self.mColumnCount) - self.mSpacingY,self.mContentSizeDelta.y);
	self.mRectTransform.sizeDelta = mVector2.New(self.mContainerWidth,self.mContainerHeight);
	self.mStartPos = -(self.mContainerHeight/2 - self.mContentSizeDelta.y/2);
	self.mContainerTransform.localPosition = mVector3(0,self.mStartPos);
	self.mMoveConstX = -self.mContainerWidth / 2 + self.mItemWidth /2;
	self.mMoveConstY = self.mContainerHeight / 2 - self.mItemHeight /2;
	self.mPageCountconst = self.mPageItemCount + self.mColumnCount * 2;
	return true;
end

function LayoutController:GetPageCount()
	return self.mPageCountconst;
end

function LayoutController:GetMoveIndex()
	local moveOffset =  self.mContainerTransform.localPosition.y - self.mStartPos;
	if moveOffset < 0 then
		return 1;
	end

	local moveItemIndex = (mMathFloor(moveOffset / self.mItemHeightAndSpace) - 1) * self.mColumnCount;
	if moveItemIndex< 1 then
		moveItemIndex = 1;
	end
	return moveItemIndex;
end

function LayoutController:SetChildPos(transform,index)
	local x = self.mMoveConstX + self.mItemWidthAndSpace * mMathFmod(index - 1,self.mColumnCount);
	local y = self.mMoveConstY - self.mItemHeightAndSpace * mMathFloor(( index - 1)/self.mColumnCount);

	transform.localPosition = mVector3.New(x,y,0);
end


return LayoutController;