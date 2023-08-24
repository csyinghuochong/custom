local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mDoFileUtil = require "Utils/DoFileUtil";
local mTable = require "table"
local mQueue = require "Common/Queue";
local mpairs = pairs;
local mipairs = ipairs;
local mtostring = tostring;
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mUpdateManager = require "Manager/UpdateManager"

local mVector3 = Vector3;
local mVector2 = Vector2;
local mMathMin = math.min;
local LayoutController = mLuaClass("LayoutControllerLoop",mBaseLua);

function LayoutController:OnLuaNew(container, itemCls)
	self.mViews = nil;
	self.mDeactiveViews = mQueue:New();
	self.mContainer = container.gameObject;
	self.mItemCls = itemCls;

	local containerTransform = container.transform;
	self.mContainerTransform = containerTransform;
	self.mRectTransform = container:GetComponent('RectTransform');
	self.mContentSizeDelta = self.mRectTransform.sizeDelta;
	self.mScrollRect = containerTransform.parent:GetComponent('ScrollRect');

	if containerTransform.childCount >0 then
		self.mSelectedView = containerTransform:GetChild(0);
	end
end

function LayoutController:SetActive(value)
	self.mContainer:SetActive(value);
end

function LayoutController:SetExternalDataToItems(data)
	self.mExternalItemsData = data;
end

function LayoutController:SetSelectedViewTop(value)
	self.mSelectedViewTop = value;
end

function LayoutController:AddLateUpdate()
	mUpdateManager:AddLateUpdate(self);
end

function LayoutController:RemoveLateUpdate()
	mUpdateManager:RemoveLateUpdate(self);
end

function LayoutController:OnLateUpdate()
	self:ShowItems();
end

function LayoutController:UpdateDataSource(sortTable,refreshCallBackHandler)
	if not sortTable then
		return;
	end
	if refreshCallBackHandler then
		self.mRefreshCallBackHandler = refreshCallBackHandler;
	end

	sortTable:CheckTriggerSort();
    
	local selfSortTable = self.mSortTable;
	if selfSortTable == sortTable then
		self:OnRefresh();
		return;
	end
	if selfSortTable then
		selfSortTable:Clear();
	end

	sortTable:Init(nil,
	function(index,key,value)
		--self:OnRemove(index,key,value);
	end,nil,
	function()
		self:OnRefresh();
	end);

	self.mSortTable = sortTable;
	self:OnRefresh();
end

function LayoutController:OnRefresh()
	local enabled = self:SetContainerSize();
	if enabled then
		self.mRefreshViews = true;
		self.mMoveItemIndex = nil;
		self:AddLateUpdate();
	end

	self.mContainer:SetActive(enabled);
end

function LayoutController:SetContainerSize()
end

function LayoutController:GetMoveIndex()
end

function LayoutController:ShowItems()
	local moveItemIndex = self:GetMoveIndex();
	if moveItemIndex == self.mMoveItemIndex then
		return;
	end
	self.mMoveItemIndex = moveItemIndex;

	local views = self.mViews;
	self.mViews = {};
	self:CreateViews(moveItemIndex,views);

	self:SetViewsDeactive(views);
end

function LayoutController:SetViewsDeactive(views)
	if not views then
		return;
	end

	local deactiveViews = self.mDeactiveViews;
	local childCount = self.mContainerTransform.childCount;
	for _,child in mpairs(views) do
		self:OnChildRemove(child);
		local transform = child.mTransform;
		deactiveViews:Enqueue(child);
	end
end

function LayoutController:OnChildRemove(child)
	child:HideView();
	child:OnRemove();
end

function LayoutController:GetPageCount()
	return self.mPageItemCount;
end

function LayoutController:CreateViews(moveItemIndex,cacheViews)
	local selfSortTable = self.mSortTable;
	local sortData = selfSortTable.mSortTable;
	local keyName = selfSortTable.mKeyName;

	local maxMoveItemIndex = mMathMin(moveItemIndex + self:GetPageCount(),#sortData);
	local refreshViews = self.mRefreshViews;
	for index=moveItemIndex, maxMoveItemIndex do
		local value = sortData[index];
		self:LoadView(index,value[keyName] or index,value, maxMoveItemIndex,cacheViews,refreshViews);
	end
	self.mRefreshViews = false;
end

function LayoutController:LoadView(index,key,value, count,cacheViews,refreshViews)
	local child = nil;

	if cacheViews then
		child = cacheViews[key];
		cacheViews[key] = nil;
	end

	local createChild = child == nil;

	if not child then
		local deactiveViews = self.mDeactiveViews;
		child = deactiveViews:Dequeue();
	end

	if not child then
		child = self.mItemCls.LuaNew();
	end

	local selfViews = self.mViews;
	if selfViews[key] then
		error("LayoutController key error:" .. key);
	end
	
	selfViews[key] = child;

	if createChild or refreshViews then
		child:SetData(value,function () self:ChildLoadComplete(child, key, index, count); end,self);
	end
end

function  LayoutController:ChildLoadComplete(child, key, index, count)
	local transform = child.mTransform;
	transform:SetParent(self.mContainerTransform);
    transform.localScale = mVector3.one;
    self:SetChildPos(transform,index);
    child.mGameObject.name = mtostring(key);

    if(index == count) then
    	local callback = self.mRefreshCallBackHandler;
    	if (callback ~= nil) then
            callback();
            self.mRefreshCallBackHandler = nil;
        end
    end
end

function LayoutController:SetChildPos(transform,index)
end

function LayoutController:GetChildData(key)
	return self.mSortTable.mRawTable[key];
end

function LayoutController:GetChild(key)
	return self.mViews[key];
end

function LayoutController:GetChildByData(data)
	return self:GetChild(data[data.mKeyName]);
end

function LayoutController:SetViewSelectedByKey(key,value)
	local view = self:GetChild(key);

	if view then
		self:SetViewSelected(view,value);
	else
		local data = self:GetChildData(key);
		if data.mLayoutItemSelected == value then
			return;
		end
		if value then
			self:UnSelectedView();
			self.mCurSelectedData = data;
		end
		data.mLayoutItemSelected = value;
	end
end

function LayoutController:UnSelectedView()
	local curSelectedData = self.mCurSelectedData;
	if curSelectedData == nil then
		return;
	end

	local curSelectedView = self:GetChildByData(curSelectedData);
	if curSelectedView then
     	curSelectedView:OnSelected(false);

     	local selecView = self.mSelectedView;
     	if selecView ~= nil then
     		selecView.gameObject:SetActive(false);
     	end
	end

	curSelectedData.mLayoutItemSelected = nil;
	self.mCurSelectedData = nil;
end

function LayoutController:SetViewSelected(view,value)
	if not view then
		return;
	end

	local data = view.mData;

	if data.mLayoutItemSelected == value then
		return;
	end
	if value then
		self:UnSelectedView();
		self.mCurSelectedData = data;
	end
	data.mLayoutItemSelected = value;
	view:OnSelected(value);
	self:ShowSelectedView(view,value);
end

function LayoutController:ShowSelectedView(view,value)
	local selectedView = self.mSelectedView;
	if selectedView then
		selectedView.gameObject:SetActive(value);

		if value then
			mGameObjectUtil:SetParent(selectedView, view.mTransform);

			if self.mSelectedViewTop then
				selectedView:SetAsLastSibling();
			else
				selectedView:SetAsFirstSibling();
			end
		end
	end
end

function LayoutController:Dispose()
	local selfSortTable = self.mSortTable;
	if selfSortTable then
		selfSortTable:Clear();
	end

	local views = self.mViews
	if views then
		for k, v in mpairs(views) do
     	v:CloseView();
    	end
	end

    for k, v in mpairs(self.mDeactiveViews.mData) do
     	v:CloseView();
    end

    self:RemoveLateUpdate();
end

return LayoutController;