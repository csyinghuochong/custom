local mLuaClass = require "Core/LuaClass"
local mBaseController = require "Core/BaseController"
local mGameModelManager= require "Manager/GameModelManager"
local StoreController = mLuaClass("StoreController",mBaseController);

--协议处理--
function StoreController:AddNetListeners()
	local s2c = self.mS2C;
	s2c:SHOP_LIST(function(pbShopList)
		mGameModelManager.StoreModel:OnRecvStoreList(pbShopList);
	end);

	s2c:SHOP_BUY(function(pbResult)
		mGameModelManager.StoreModel:OnRecvStoreBuyStatus(pbResult);
	end);

	s2c:SHOP_UPDATE(function(pbShopList)
		mGameModelManager.StoreModel:OnRecvStoreItemUpdate(pbShopList);
	end);
end

--事件处理--
function StoreController:AddEventListeners()
	
end

--获取商城列表--
function StoreController:SendGetStoreGoodsList(firstType,secondType)
	self.mC2S:SHOP_LIST(firstType,secondType,true);
end

--购买商城道具--
function StoreController:SendBuyStoreGood(id,count)
	local model = mGameModelManager.StoreModel;
	local firstType = model.mFirstType;
	self.mC2S:SHOP_BUY(firstType,model.mStoreVoList[firstType].mSecondType,id,count);
end

local mStoreControllerInstance = StoreController.LuaNew();
return mStoreControllerInstance;