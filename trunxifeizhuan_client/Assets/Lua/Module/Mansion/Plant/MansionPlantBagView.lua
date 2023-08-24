local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBaseVindow = require "Core/BaseWindow"
local mGameModelManager = require "Manager/GameModelManager"
local mLayoutController = require "Core/Layout/LayoutController"
local MansionController = require "Module/Mansion/MansionController"
local MansionPlantBagView = mLuaClass("MansionPlantBagView", mBaseVindow);
local mIpairs = ipairs;
local mPairs = pairs;

function MansionPlantBagView:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_plant_bag_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
	};
end

function MansionPlantBagView:Init()
	 self.mGoodsSelect = self:Find('scrollView/Grid/setlect');

	local goods_parent = self:Find('scrollView/Grid/');
	self.mGridEx = mLayoutController.LuaNew(goods_parent, require "Module/Mansion/Plant/MansionPlantBagItem");

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_SELECT_PLANT_SEED_ITEM, function(vo)
   		self:OnClickGoodsItem( vo );
   	end, true);
end

function MansionPlantBagView:OnViewShow(logicParams)
	self.mData = logicParams;
	self.mGridEx:UpdateDataSource( self:GetDataSource() );
end

function MansionPlantBagView:OnClickGoodsItem( vo )
	local data = self.mData;
	local typeEnum = MansionController.mPlantTyepEnum;
	MansionController:SendPlantOperate( typeEnum.PlantSeed, data.mID, vo.mID, 0 );

	self:HideView();
end

function MansionPlantBagView:GetDataSource( data )
	local bagModel = mGameModelManager.BagModel;
	return bagModel:GetValidGoodsListWithType(bagModel.mTypeEnum.Seed);
end

function MansionPlantBagView:OnViewHide( )
	
end

function MansionPlantBagView:Dispose( )
	self.mGridEx:Dispose();
	self.mGridEx = nil;
end

return MansionPlantBagView;