local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mDoFileUtil = require "Utils/DoFileUtil";
local mTable = require "table"
local mQueue = require "Common/Queue";

local mVector3 = Vector3;
local LayoutController = mLuaClass("LayoutController",mBaseLua);

function LayoutController:OnLuaNew(container, itemCls,UIPanel)
	self.mViews = nil;
	self.mDeactiveViews = mQueue:New();
	self.mContainer = container;
	container.hideInactive = true;
	self.mItemCls = itemCls;
	self.mContainerTransform = container.transform;
	self.mUIPanel = UIPanel or self.mContainerTransform.parent.gameObject:GetComponent("UIPanel");
	self.mUIPanelTransform = self.mUIPanel.transform;
	self.mUIPanelRawStartPos = self.mUIPanelTransform.localPosition;
	self.mUIPanelClipOffset = self.mUIPanel.clipOffset;
end

function LayoutController:UpdateDataSource(sortTable,refreshCallBackHandler)
	if not sortTable then
		return;
	end

	if refreshCallBackHandler then
		self.mRefreshCallBackHandler = refreshCallBackHandler;
	end

	local selfSortTable = self.mSortTable;
	if selfSortTable == sortTable then
		self:OnRefresh();
		return;
	end

	if selfSortTable then
		selfSortTable:Clear();
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
end

function LayoutController:OnRemove(index,key,value)
	local child = self.mViews[key];

	if not child then
		return;
	end
	local deactiveViews = self.mDeactiveViews;
	local childCount = self.mContainerTransform.childCount;

	child:HideView();
	child:OnRemove();
	local transform = child.mTransform;
	transform:SetSiblingIndex(childCount - 1);
	deactiveViews:Enqueue(child);

	self.mContainer:Reposition();
end

function LayoutController:OnUpdate(index,key,value)
	self.mViews[key]:UpdateData(value);
end

function LayoutController:OnRefresh()
	self.mUIPanelTransform.localPosition = self.mUIPanelRawStartPos;
	self.mUIPanel.clipOffset = self.mUIPanelClipOffset;

	local sprintPanel = self.mSprintPanel;
	if not sprintPanel then
		sprintPanel = self.mUIPanel:GetComponent("SpringPanel");
		self.mSprintPanel = sprintPanel;
	end

	if sprintPanel ~= nil then
		sprintPanel.target = self.mUIPanelRawStartPos;
		sprintPanel.enabled = false;
	end

	local views = self.mViews;
	self.mViews = {};
	self:CreateViews(views);

	if not views then
		return;
	end

	local deactiveViews = self.mDeactiveViews;
	local childCount = self.mContainerTransform.childCount;
	for _,child in pairs(views) do
		child:HideView();
		child:OnRemove();
		local transform = child.mTransform;
		transform:SetSiblingIndex(childCount - 1);
		deactiveViews:Enqueue(child);
	end

	self.mContainer:Reposition();
end

function LayoutController:CreateViews(cacheViews)
	local selfSortTable = self.mSortTable;
	local sortData = selfSortTable.mSortTable;
	local count = #sortData;
	local keyName = selfSortTable.mKeyName;

	self.mLoadIndex = 0;
	for index,value in ipairs(sortData) do
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
	transform:SetSiblingIndex(index - 1);
    transform.localScale = mVector3.one;
    transform.localPosition = mVector3.zero;
    child.mGameObject.name = tostring(key);

    self.mLoadIndex = self.mLoadIndex + 1;
    if(self.mLoadIndex == count) then
    	self.mContainer:Reposition();
    	
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

function LayoutController:SetViewSelected(view)
	for k, v in pairs(self.mViews) do
     	if v.mSelected and v ~= view then
     		v:SetSelected(false);
     		return;
     	end
    end
end

function LayoutController:Dispose()
	local selfSortTable = self.mSortTable;
	if selfSortTable then
		selfSortTable:Clear();
	end

    for k, v in pairs(self.mViews) do
     	v:CloseView();
    end

    for k, v in pairs(self.mDeactiveViews.mData) do
     	v:CloseView();
    end
end

return LayoutController;