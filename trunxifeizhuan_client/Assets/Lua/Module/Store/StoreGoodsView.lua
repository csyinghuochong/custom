local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mStoreVO = require "Module/Store/StoreVO"
local mGameModelManager = require "Manager/GameModelManager"
local mStoreController = require "Module/Store/StoreController"
local mLayoutController = require "Core/Layout/LayoutController"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local mCommonToggleGroup = require "Module/CommonUI/TabView/CommonToggleGroup"
local StoreGoodsView = mLuaClass("StoreGoodsView",mCommonTabBaseView);

function StoreGoodsView:InitViewParam()
	return {
		["viewPath"] = "ui/store/",
		["viewName"] = "store_goods_view",
	};
end

function StoreGoodsView:Init()
	local parent = self:Find("scrollView/Grid");
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Store/StoreGoodsItem");

	self.mCostList = {{cost={"silver","gold","strength"}},{cost={"silver","gold","wisdom_coin"}},{cost={"silver","gold","arena_coin"}},{cost={"silver","gold","devote_coin"}}};

	local callBack = function( index )
		self:OnClickTypeButton(index);
	end
	local go = self:Find('Toggle');
	self.mToggleGroup = mCommonToggleGroup.LuaNew(go,callBack,1);
	self:RegisterEventListener(self.mEventEnum.ON_CHANGE_STORE_PAGE,function(data)self:ChangePage(data);end,false);
	self:RegisterEventListener(self.mEventEnum.ON_CREATE_STORE_ITEM,function(data)self:CreateStoreItem(data);end,false);
	self.mStoreType = 1;
end

function StoreGoodsView:ToggleButton( index, show )
	self:Find( 'Toggle/Button'..index ).gameObject:SetActive( show );
end

function StoreGoodsView:ChangePage(data)
	self.mToggleGroup:OnClickToggleButton(data,true);
end

function StoreGoodsView:OnClickTypeButton(index)
	self.mGridEx:Reset();
	local model = mGameModelManager.StoreModel;
	model.mStoreVoList[self.mStoreType].mSecondType = index;
	self:CheckData();
end

function StoreGoodsView:CheckData()
	local model = mGameModelManager.StoreModel;
	model.mFirstType = self.mStoreType;
	local data = model.mStoreVoList[self.mStoreType];
	if not data:GetStoreState(data.mSecondType) then
		mStoreController:SendGetStoreGoodsList(model.mFirstType,data.mSecondType);
	end
	self.mGridEx:UpdateDataSource(data.mGoodsDataSoureTable[data.mSecondType]);
	self:UpdateCostUI( data );
end

function StoreGoodsView:UpdateCostUI( data  )
	self:HandleWindowCostUI(1,self.mCostList[data.mSecondType]);
end

function StoreGoodsView:CreateStoreItem(data)
	local model = mGameModelManager.StoreModel;
	if model.mFirstType ~= self.mStoreType then
		return;
	end
	local data = model.mStoreVoList[self.mStoreType];
	self.mGridEx:UpdateDataSource(data.mGoodsDataSoureTable[data.mSecondType]);
end

function StoreGoodsView:OnUpdateUI(data)
	self:CheckData();
end

function StoreGoodsView:Dispose( )
	self.mGridEx:Dispose();
end

return StoreGoodsView;