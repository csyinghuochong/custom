local mLuaClass = require "Core/LuaClass"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local LeadFashionView = mLuaClass("LeadFashionView",mCommonTabBaseView);
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local LayoutController = require "Core/Layout/LayoutController"
local MainFashionItemView = require"Module/Fashion/Main/MainFashionItemView"
local FashionInfoView = require"Module/Fashion/FashionInfoView"
local CommonItemsView = require"Module/Fashion/Common/CommonItemsView"
local mFashionController = require"Module/Fashion/FashionController"
local mGameModelManager = require "Manager/GameModelManager"

function LeadFashionView:InitViewParam()
	return {
		["viewPath"] = "ui/lead/",
		["viewName"] = "lead_fashion_view",
	};
end

function LeadFashionView:Init()
	self:FindAndAddClickListener("buttons/Button1",function() self:OpenFashionSuitView() end);
	self:FindAndAddClickListener("buttons/Button3",function() self:OpenFashionView() end);
	self:FindAndAddClickListener("buttons/Button4",function() self:SaveFashionSuit() end);

	self.mSlotViews = CommonItemsView.InitItemViews(self:Find('toogleView/buttonView'),"Module/Fashion/Main/FashionSlotView");
	
	local mEventEnum = self.mEventEnum;

	self:RegisterEventListener(mEventEnum.ON_REPLACE_FASHION, function(fashion) self:OnClickReplace(fashion); end,true);
	self:RegisterEventListener(mEventEnum.ON_CLOSE_FASHION_INFO, function() self:OnCloseFashionInfoView(); end,true);

	self:RegisterEventListener(mEventEnum.ON_UPDATE_EQUIPED_FASHIONS, function(fashions) self:OnReplaceSuit(fashions); end,true);
	self:RegisterEventListener(mEventEnum.ON_CLICK_BFASHION_ITEM, function(item) self:OnClickFashion(item.mData); end,true);

	self:RegisterEventListener(mEventEnum.ON_HOLD_FASHION_SLOT_ITEM, function(slot) self:OnHoldSlot(slot); end,true);
	self:RegisterEventListener(mEventEnum.ON_SELECT_FASHION_SLOT_ITEM, function(slot) self:OnClickSlot(slot); end,true);

	self:RegisterEventListener(mEventEnum.ON_UPDATE_FASHION_INFO, function(fashion) self:OnUpdateFashion(fashion); end,true);
end

function LeadFashionView:OnClickReplace(fashion)
	self:OnReplace(fashion);
	self:UnSelectFashion();
end

function LeadFashionView:OnReplaceSuit(fashions)
	self.mSlotViews:ShowView(fashions);
end

function LeadFashionView:OnCloseFashionInfoView()
	self:UnSelectFashion();
end

function LeadFashionView:OnUpdateUI(data)

	self.mFollowerData = data;
	self.mSlotViews:ShowView(mGameModelManager.FashionModel:GetEquipedFashions());
	self:ShowItemListView(0,true);
	mGameModelManager.FashionModel:ClearTempEquipedFashions();
end

function LeadFashionView:OnViewHide()
	self:UnSelectFashion();
	mGameModelManager.FashionModel:ClearTempEquipedFashions();
end

function LeadFashionView:OpenFashionView()
	mUIManager:HandleUI(mViewEnum.FashionUpGradeView,1);
end

function LeadFashionView:OpenFashionSuitView()
	mUIManager:HandleUI(mViewEnum.FashionSuitView,1);
end

function LeadFashionView:SaveFashionSuit()

	local equipedFashions = mGameModelManager.FashionModel:GetEquipedFashions();
	local tempFashions = mGameModelManager.FashionModel:GetTempEquipedFashions();
	local fashions = {}
	local change = nil;

	for i,v in ipairs(tempFashions) do
		if v.mActived then
			fashions[i] = v;

		end
		if v ~= equipedFashions[i] then
			change = true;
		end
	end

	if change then
		mFashionController:SendEquipFashions(fashions);
	end

end

function LeadFashionView:SetSelectFashion(fashion)
	local itemListView = self.mItemListView;
	if itemListView then
		itemListView:SetViewSelectedByKey(fashion.mId,true);
	end
end

function LeadFashionView:UnSelectFashion()
	local itemListView = self.mItemListView;
	if itemListView then
		itemListView:UnSelectedView();
	end
end

function LeadFashionView:OnReplace(fashion)
	self.mSlotViews:UpdateItemViewByIndex(fashion.mPosition,fashion);
	mGameModelManager.FashionModel:SetTempFashion(fashion);
end

function LeadFashionView:OnClickSlot(slot)
	self:ShowItemListView(slot.mIndex);
end

function LeadFashionView:OnHoldSlot(slot)
	self:SetSelectFashion(slot.mData,true);
end

function LeadFashionView:OnClickFashion(fashion)
	self:OnReplace(fashion);
	self:UnSelectFashion();
end

function LeadFashionView:OnUpdateFashion(fashion)
	local view = self.mSlotViews:GetItemView(fashion.mPosition);
	if view and view.mData == fashion then
		view:ForceShowView(fashion);
	end
end

function LeadFashionView:ShowItemListView(index,forceUpdate)
	
	local fashionDataSource = mGameModelManager.FashionModel:GetFashionDataSource();
	local dataSource = fashionDataSource[index];
	local itemListView = self.mItemListView;
	if not itemListView then
		itemListView = LayoutController.LuaNew(self:Find("bagView/item_list/Content"),MainFashionItemView);
		itemListView:SetSelectedViewTop(true);
		self.mItemListView = itemListView;
	end

	if dataSource then
		itemListView:UpdateDataSource(dataSource);
		if forceUpdate then
			--itemListView:NotifyItemsUpdate();
		end
	end
end

function LeadFashionView:Dispose()
	self.mItemListView:Dispose();
	self.mSlotViews:Dispose();
	self.mItemListView = nil;
	self.mSlotViews = nil;
end

return LeadFashionView;