local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mDoFileUtil = require "Utils/DoFileUtil";
local mTable = require "table"
local mQueue = require "Common/Queue";
local mpairs = pairs;
local mipairs = ipairs;
local mtostring = tostring;
local mGameObjectUtil = require "Utils/GameObjectUtil"

local mVector3 = Vector3;
local LayoutController = mLuaClass("LayoutController",mBaseLua);

function LayoutController:OnLuaNew(container, itemCls,syncSiblingIndex)
	self.mViews = nil;
	self.mDeactiveViews = mQueue:New();
	self.mContainer = container;
	self.mItemCls = itemCls;

	local containerTransform = container.transform;
	self.mContainerTransform = containerTransform;
	self.mInitPos = containerTransform.localPosition;
	self.mRectTransform = container:GetComponent('RectTransform');

	if containerTransform.childCount >0 then
		self.mSelectedView = containerTransform:GetChild(0);
	end

	self.mSyncSiblingIndex = syncSiblingIndex;
	if syncSiblingIndex then
		self.mTransformViews = {};
	end
end

function LayoutController:SetSelectedViewTop(value)
	self.mSelectedViewTop = value;
end

function LayoutController:RefreshUpdateSortIndex(value)
	self.mRefreshUpdateSortIndex = value;
end

function LayoutController:ResetAfterRefresh(value)
	self.mResetAfterRefresh = value;
end

function LayoutController:ForbidRefresh(value)
	self.mForbidRefresh = value;
end

function LayoutController:SetExternalDataToItems(data)
	self.mExternalItemsData = data;
end

function LayoutController:NotifyItemsUpdate()
	local selfViews = self.mViews;
	if selfViews == nil then
		return;
	end

	for k,v in mpairs(selfViews) do
		v:UpdateData(v.mData);
	end
end

function LayoutController:UpdateDataSource(sortTable,refreshCallBackHandler)
	if not sortTable then
		return;
	end
	if refreshCallBackHandler then
		self.mRefreshCallBackHandler = refreshCallBackHandler;
	end

	self.mForbidRefresh = false;
	sortTable:CheckTriggerSort();
    
	local selfSortTable = self.mSortTable;
	if selfSortTable ~= sortTable then
		if selfSortTable then
			selfSortTable:Clear();
		end
	end

	sortTable:Init(function(index,key,value)
		self:OnAdd(index,key,value);
	end,
	function(index,key,value)
		self:OnRemove(index,key,value);
	end,
	function(index,key,value)
		self:OnUpdate(index,key,value);
	end,
	function()
		self:OnRefresh();
	end);

	self.mSortTable = sortTable;
	self:OnRefresh();
end

function LayoutController:OnAdd(index,key,value)
	self:LoadView(index,key, value,index);
	if self.mSyncSiblingIndex then
		self.SyncSiblingIndex(index + 1);
	end
end

function LayoutController:OnRemove(index,key,value)
	local child = self.mViews[key];

	if not child then
		return;
	end

	self.mViews[key] = nil;
	local deactiveViews = self.mDeactiveViews;
	local childCount = self.mContainerTransform.childCount;

	self:OnChildRemove(child);
	local transform = child.mTransform;
	transform:SetSiblingIndex(childCount - 1);
	deactiveViews:Enqueue(child);

	if self.mSyncSiblingIndex then
		self.SyncSiblingIndex(index);
	end
end

function LayoutController:SyncSiblingIndex(fromIndex)
	local container = self.mContainerTransform;
	local endIndex = container.childCount - 1;
	if endIndex < fromIndex then
		return;
	end

	local selfTransformViews = self.mTransformViews;
	local child;
	for i=fromIndex,endIndex do
		child = selfTransformViews[container:GetChild(i)];

		if child then
			child:OnUpdateSiblingIndex(i);
		end
	end
end

function LayoutController:OnUpdate(index,key,value)
	self.mViews[key]:UpdateData(value);
end

function LayoutController:OnRefresh()
	--self:UnSelectedView();

	if self.mForbidRefresh then
		return;
	end

	if self.mResetAfterRefresh then
		self:Reset();
	end

	local views = self.mViews;
	self.mViews = {};
	self:CreateViews(views);

	if not views then
		return;
	end

	local deactiveViews = self.mDeactiveViews;
	local childCount = self.mContainerTransform.childCount;
	for _,child in mpairs(views) do
		self:OnChildRemove(child);
		local transform = child.mTransform;
		transform:SetSiblingIndex(childCount - 1);
		deactiveViews:Enqueue(child);
	end

	local container = self.mLayoutGroup;
	if(container == nil) then
		container= self.mContainer:GetComponent('LayoutGroup');
		 self.mLayoutGroup = container;
	end

	container:SetLayoutHorizontal();
	container:SetLayoutVertical()
end

function LayoutController:Reset()
	self.mContainerTransform.localPosition = self.mInitPos;
end

--偏移到第几个
function LayoutController:MoveToItemByIndex(index,isHorizontal)
	local childCount = #self.mSortTable.mSortTable;
	local sizeDelta = self.mRectTransform.sizeDelta;
	local position = self.mInitPos:Clone();
	if isHorizontal then
       local offsetX = sizeDelta.x / childCount * index;
       position.x = position.x - offsetX;
       self.mContainerTransform.localPosition = position;
	else
       local offsetY = sizeDelta.y / childCount * index;
       position.y = position.y - offsetY;
       self.mContainerTransform.localPosition = position;
	end
end

function LayoutController:MoveToItemBySize(offsetSize,isHorizontal)
	local position = self.mInitPos:Clone();
	if isHorizontal then
       position.x = position.x - offsetSize;
       self.mContainerTransform.localPosition = position;
	else
       position.y = position.y - offsetSize;
       self.mContainerTransform.localPosition = position;
	end
end

function LayoutController:CreateViews(cacheViews)
	local selfSortTable = self.mSortTable;
	local sortData = selfSortTable.mSortTable;
	local count = #sortData;
	
	if count == 0 then
		local callback = self.mRefreshCallBackHandler;
    	if (callback ~= nil) then
            callback();
            self.mRefreshCallBackHandler = nil;
        end
        return;
	end

	local refreshUpdateSortIndex = self.mRefreshUpdateSortIndex;
	local keyName = selfSortTable.mKeyName;
	for index,value in mipairs(sortData) do

		if refreshUpdateSortIndex then
			value.mSortTableIndex = index; --仅限于刷新的时候使用，有数据删除的话不会更新
		end
		
		self:LoadView(index,value[keyName] or index,value, count,cacheViews);
	end
end

function LayoutController:LoadView(index,key,value, count,cacheViews)
	local child = nil;
	if cacheViews then
		child = cacheViews[key];
		cacheViews[key] = nil;
	end

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
	child:SetData(value,function () self:ChildLoadComplete(child, key, index, count); end,self);
end

function  LayoutController:ChildLoadComplete(child, key, index, count)
	local transform = child.mTransform;
	transform:SetParent(self.mContainerTransform);
	local siblingIndex = index - 1;
	transform:SetSiblingIndex(siblingIndex);
    transform.localScale = mVector3.one;
    transform.localPosition = mVector3.zero;
    child.mGameObject.name = mtostring(key);

    if self.mSyncSiblingIndex then
    	self.mTransformViews[transform]=child;
    	child:OnUpdateSiblingIndex(siblingIndex);
    end

    if(index == count) then
    	local callback = self.mRefreshCallBackHandler;
    	if (callback ~= nil) then
            callback();
            self.mRefreshCallBackHandler = nil;
        end
    end
end

function LayoutController:GetChild(key)
	return self.mViews[key];
end

function LayoutController:GetChildCount()
	return self.mContainerTransform.childCount;
end

function LayoutController:OnChildRemove(child)
	local curSelectedView = self.mCurSelectedView;
	if curSelectedView == child then
		curSelectedView.mSelected = false;
		curSelectedView:OnSelected(false);
		self.mCurSelectedView = nil;
	end

	child:HideView();
	child:OnRemove();
end

function LayoutController:SetViewSelectedByKey(key,value)
	local view = self:GetChild(key);
	self:SetViewSelected(view,value);
end

function LayoutController:UnSelectedView()
	local curSelectedView = self.mCurSelectedView;
	if curSelectedView then
		curSelectedView.mSelected = false;
     	curSelectedView:OnSelected(false);
     	self.mCurSelectedView = nil;

     	local selecView = self.mSelectedView;
     	if selecView ~= nil then
     		selecView.gameObject:SetActive(false);
     	end
	end
end

function LayoutController:SetViewSelected(view,value)
	if not view then
		return;
	end

	if view.mSelected == value then
		return;
	end

	if value then
		self:UnSelectedView();

		self.mCurSelectedView = view;
	end
	
	view.mSelected = value;
	view:OnSelected(value);

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

--移除所有界面，清空所有数据，用于界面隐藏做重置处理
function LayoutController:ClearAllViews()
	local selfSortTable = self.mSortTable;
	if selfSortTable then
		selfSortTable:ClearDatas(true);
	end
end

--显示/隐藏所有界面
function LayoutController:ToggleAllView( toggle )
	local views = self.mViews
	if views then
		for k, v in mpairs(views) do
     		if toggle then
     			v:ShowView();
     		else
     			v:HideView();
     		end
    	end
	end
end

--释放界面跟数据，用于界面关闭
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
end

return LayoutController;