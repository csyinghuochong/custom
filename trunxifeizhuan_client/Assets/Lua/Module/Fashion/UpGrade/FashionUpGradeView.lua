local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local FashionUpGradeView = mLuaClass("FashionUpGradeView", mQueueWindow);
local mCommonTabView = require "Module/CommonUI/TabView/CommonTabView"
local mCommonToggleGroup = require "Module/CommonUI/TabView/CommonToggleGroup"
local LayoutController = require "Core/Layout/LayoutController"
local UpGradeFashionItemView = require"Module/Fashion/UpGrade/UpGradeFashionItemView"
local mGameModelManager = require "Manager/GameModelManager"

function FashionUpGradeView:InitViewParam()
	return {
		["viewPath"] = "ui/fashion/",
		["viewName"] = "fashion_upgrade_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
		["cost"] = {"gold","silver","dress_coin"},
	};
end

local mSubViews = 
{
	{luaClass = "Module/Fashion/UpGrade/FashionLevelUpView"} ;
	{luaClass = "Module/Fashion/UpGrade/FashionQualityUpView"} ;
	{luaClass = "Module/Fashion/UpGrade/FashionStarUpView"} ;
	{luaClass = "Module/Fashion/UpGrade/FashionOpenLightView"} ;
}


function FashionUpGradeView:Init()
	self:FindAndAddClickListener("c_bg/Button_close",function() self:ReturnPrevQueueWindow() end);
	local go = self:Find('toggleView/buttonView');
	local callBack = function (index)
		self:ShowItemListView(index);
	end
	self.mToggleGroup = mCommonToggleGroup.LuaNew(go,callBack);

	local getDataCallback = function ()
		return self.mSelectFashion;
	end

	self.mTabView = mCommonTabView.LuaNew(self:Find('tabView'), mSubViews, nil, getDataCallback);

	self:RegisterEventListener(self.mEventEnum.ON_SELECT_SFASHION_ITEM, function(item) self:OnSelectFashion(item.mData,item.mSelected); end,true);
	self:RegisterEventListener(self.mEventEnum.ON_UPDATE_FASHION_INFO, function(fashion) self:OnUpdateFashion(fashion); end,true);
end

function FashionUpGradeView:ShowItemListView(index,selectedIndex)

	local fashionDataSource = mGameModelManager.FashionModel:GetActivedFashionDataSource();
	local dataSource = fashionDataSource[index];
	local itemListView = self.mItemListView;
	if not itemListView then
		itemListView = LayoutController.LuaNew(self:Find("bagView/item_list/Content"),UpGradeFashionItemView);
		itemListView:SetSelectedViewTop(true);
		self.mContainer = itemListView.mContainer.gameObject;
		self.mItemListView = itemListView;
	end

	self.mContainer:SetActive(dataSource~=nil);
	
	if dataSource then
		local callBack = function ()
		    if selectedIndex then
		    	itemListView:SetViewSelectedByKey(selectedIndex,true);
		    else
		    	local first = dataSource.mSortTable[1];
				if first and first.mActived then
					itemListView:SetViewSelectedByKey(first.mId,true);
				else
					itemListView:UnSelectedView();
				end
			end
		end
		itemListView:UpdateDataSource(dataSource,callBack);
	end
end

function FashionUpGradeView:OnSelectFashion(fashion,flag)
	if flag then
		self.mSelectFashion = fashion;
		self.mTabView:ShowView();
	end
end

function FashionUpGradeView:OnUpdateFashion(fashion)
	local itemListView = self.mItemListView;
	if itemListView then
		itemListView:NotifyItemsUpdate();
	end
end

function FashionUpGradeView:OnViewShow(fashion)
	
	local position = 1;
	local selectedIndex = nil;
	if fashion then
		position = fashion.mPosition;
		selectedIndex = fashion.mId;
	end

	self.mTabView:OnClickToggleButton(1, true);
	self.mToggleGroup:OnClickToggleButton(position,false);
	self:ShowItemListView(position,selectedIndex);
end

function FashionUpGradeView:Dispose()
	self.mItemListView:Dispose();
	self.mItemListView = nil;
	self.mTabView:CloseView();
end

return FashionUpGradeView;