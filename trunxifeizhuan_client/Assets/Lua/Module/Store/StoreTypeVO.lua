local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mStoreVO = require "Module/Store/StoreVO"
local StoreTypeVO = mLuaClass("StoreTypeVO");

--商城数据--
function StoreTypeVO:OnLuaNew(s_type)
	self.mIsEverGetGoods = {};
	self.mGoodsDataSoureTable = {};
	self.mSecondType = 1;
end

function StoreTypeVO:StoreUpdate( secondType , pbShopList , isChangeState)
	if isChangeState then
		self.mIsEverGetGoods[secondType] = true;
		self.mSecondType = secondType;
	end

	local data_soure = self.mGoodsDataSoureTable[secondType];
	if data_soure == nil then
		local sortID = function(a,b)return self:Sort(a,b) end;
		data_soure = mSortTable.LuaNew(sortID,nil,true);
	end
	
	for k,v in ipairs(pbShopList.list) do
		local storeVO = mStoreVO.LuaNew(v);
		data_soure:AddOrUpdate(storeVO.id,storeVO);
	end
	self.mGoodsDataSoureTable[secondType] = data_soure;
end

function StoreTypeVO:GetStoreState(secondType)
	return self.mIsEverGetGoods[secondType];
end

function StoreTypeVO:GetSecondType()
	return self.mSecondType;
end

function StoreTypeVO:Sort(a,b)
	return a.id < b.id;
end

return StoreTypeVO;