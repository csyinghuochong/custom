local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mViewEnum = require "Enum/ViewEnum"
local mLayoutController = require "Core/Layout/LayoutController"
local mUIManager = require "Manager/UIManager"
local mSortTable = require "Common/SortTable"
local mItemPathVO = require"Module/Bag/ItemPathVO"
local mEventEnum = require "Enum/EventEnum"

local ItemGetView = mLuaClass("ItemGetView", mBaseWindow);

function ItemGetView:InitViewParam()
	return {
		["viewPath"] = "ui/bag/",
		["viewName"] = "item_get_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.transparent_clickable,
	};
end

function ItemGetView:Init()
    local grid_parent = self:Find('scrollView/Grid');
	self.mPathGridEx = mLayoutController.LuaNew(grid_parent, require "Module/Bag/ItemPathView");
	self:RegisterEventListener(mEventEnum.ON_GET_GOODS_PATH, function(data)
		self:OnClickPath(data);
	end, true);
	self.mText = self:Find("Text");
	self.mGrid = grid_parent;
end

function ItemGetView:OnViewShow(logicParams)
    self.mLogicParams = logicParams;
    local data_soure = mSortTable.LuaNew();
    local getPathList = logicParams.mSysVO.get_path;
    self.mText.gameObject:SetActive(getPathList == nil);
    self.mGrid.gameObject:SetActive(getPathList ~= nil);
    if getPathList == nil then
       return;
    end
    for k,v in pairs(getPathList) do
		data_soure:AddOrUpdate(k, mItemPathVO.LuaNew(v));
    end

	self.mPathGridEx:UpdateDataSource(data_soure);
	self.mPathGridEx:Reset();
end

function ItemGetView:OnClickPath(data)
	local sysVOParams = data.mSysVO.view_params;
	if sysVOParams == nil then
	   return;

	end
    local viewName = sysVOParams[1];
    local params = {jumpParams = sysVOParams[2]};

    mUIManager:HandleUI(mViewEnum[viewName],1,params);
	self:HideView();
end

function ItemGetView:Dispose()
	local grid_ex = self.mPathGridEx;
	if grid_ex ~= nil then
		grid_ex:Dispose();
	end
end

return ItemGetView;