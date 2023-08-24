local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mEventEnum = require "Enum/EventEnum"
local mSortTable = require "Common/SortTable"
local mStoreVO = require "Module/Store/StoreVO"
local mStoreTypeVO = require "Module/Store/StoreTypeVO"
local mEventDispatcher = require "Events/EventDispatcher"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local StoreModel = mLuaClass("StoreModel",mBaseModel);
local mLanguageUtil = require "Utils/LanguageUtil"
local mLgBuySuccess = mLanguageUtil.store_buy_success;
local mLgBuyFail = mLanguageUtil.store_buy_fail;
local mTable = table;
local mGameModelManager = require "Manager/GameModelManager"

local EXP = 1;
local COIN = 2;
local GOLD = 3;
local WISDOM_COIN = 4;
local ARENA_COIN = 5;
local DRESS_COIN = 6;
local DEVOTE_COIN = 7;
local HOUSE_COIN = 8;

function StoreModel:OnLuaNew()
	self.mFirstType = 1;

	local voList = {};
	for i =1, 4 do
		voList[i] = mStoreTypeVO.LuaNew(i);
	end
	self.mStoreVoList = voList;
end

function StoreModel:OnRecvStoreList(pbShopList)
	self:StoreUpdate(pbShopList,true);
	self:Dispatch(mEventEnum.ON_CREATE_STORE_ITEM,nil);
end

function StoreModel:OnRecvStoreBuyStatus(pbResult)
	if pbResult.result == 1 then
		mCommonTipsView.Show(mLgBuySuccess);
	else
		mCommonTipsView.Show(mLgBuyFail);
	end
end

function StoreModel:OnRecvStoreItemUpdate(pbShopList)
	self:StoreUpdate(pbShopList,false);
end

function StoreModel:StoreUpdate(pbShopList,isChangeState)
	local list = pbShopList.list;
	local firstType = pbShopList.first_type;
	local secondType = pbShopList.second_type;
	if list ~= nil then
		local storeVoList = self.mStoreVoList;
		storeVoList[firstType]:StoreUpdate(secondType,pbShopList,isChangeState);
	end
end

function StoreModel:GetIsEnoughSource(source_type,num)
	local mPlayerData = mGameModelManager.RoleModel.mPlayerBase;
	local priceTable = {};
	priceTable[EXP] = mPlayerData.exp;
	priceTable[COIN] = mPlayerData.coin;
	priceTable[GOLD] = mPlayerData.gold;
	priceTable[WISDOM_COIN] = mPlayerData.wisdom_coin;
	priceTable[ARENA_COIN] = mPlayerData.arena_coin;
	priceTable[DRESS_COIN] = mPlayerData.dress_coin;
	priceTable[DEVOTE_COIN] = mPlayerData.devote_coin;
	priceTable[HOUSE_COIN] = mPlayerData.house_coin;
	return priceTable[source_type] >= num;
end

return StoreModel;