local mLuaClass = require "Core/LuaClass"
local mLayoutController = require "Core/Layout/LayoutController"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local mGameModelManager = require "Manager/GameModelManager"
local mSortTable = require "Common/SortTable"
local mStoreVO = require "Module/Store/StoreVO"
local mStoreController = require "Module/Store/StoreController"
local StoreDiamondView = mLuaClass("StoreDiamondView",mCommonTabBaseView);

function StoreDiamondView:InitViewParam()
	return {
		["viewPath"] = "ui/store/",
		["viewName"] = "store_diamond_view",
	};
end

function StoreDiamondView:Init()
	local parent = self:Find("scrollView/Grid");
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Store/StoreGoodsItem");

	self:RegisterEventListener(self.mEventEnum.ON_CREATE_STORE_ITEM,function(data)self:CreateStoreItem(data);end,false);
end

function StoreDiamondView:OnUpdateUI(data)
	local model = mGameModelManager.StoreModel;
	model.mFirstType = 2;
	if not model.mStoreVoList[2]:GetStoreState(0) then
		mStoreController:SendGetStoreGoodsList(model.mFirstType,0);
	end
	self.mGridEx:UpdateDataSource(model.mDiamondDataSoure);
end

function StoreDiamondView:CreateStoreItem(data)
	local model = mGameModelManager.StoreModel;
	if model.mFirstType ~= 2 then
		return;
	end
	local data = model.mStoreVoList[2];
	self.mGridEx:UpdateDataSource(data.mGoodsDataSoureTable[data.mSecondType]);
end

function StoreDiamondView:Dispose( )
	self.mGridEx:Dispose();
end

return StoreDiamondView;