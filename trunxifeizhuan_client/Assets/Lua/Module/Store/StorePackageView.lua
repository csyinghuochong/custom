local mLuaClass = require "Core/LuaClass"
local mLayoutController = require "Core/Layout/LayoutController"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local mGameModelManager = require "Manager/GameModelManager"
local mSortTable = require "Common/SortTable"
local mStoreVO = require "Module/Store/StoreVO"
local mStoreController = require "Module/Store/StoreController"
local StorePackageView = mLuaClass("StorePackageView",mCommonTabBaseView);

function StorePackageView:InitViewParam()
	return {
		["viewPath"] = "ui/store/",
		["viewName"] = "store_package_view",
	};
end

function StorePackageView:Init()
	local parent = self:Find("scrollView/Grid");
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Store/StoreGoodsItem");

	self:RegisterEventListener(self.mEventEnum.ON_CREATE_STORE_ITEM,function(data)self:CreateStoreItem(data);end,false);
end

function StorePackageView:OnUpdateUI(data)
	local model = mGameModelManager.StoreModel;
	model.mFirstType = 3;
	if not model.mStoreVoList[3]:GetStoreState(0) then
		mStoreController:SendGetStoreGoodsList(model.mFirstType,0);
	end
	self.mGridEx:UpdateDataSource(model.mPackageDataSoure);
end

function StorePackageView:CreateStoreItem(data)
	local model = mGameModelManager.StoreModel;
	if model.mFirstType ~= 3 then
		return;
	end
	local data = model.mStoreVoList[3];
	self.mGridEx:UpdateDataSource(data.mGoodsDataSoureTable[data.mSecondType]);
end

function StorePackageView:Dispose( )
	self.mGridEx:Dispose();
end

return StorePackageView;