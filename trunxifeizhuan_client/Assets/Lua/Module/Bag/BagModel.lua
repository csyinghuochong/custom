local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mBagGoodsVO = require"Module/Bag/BagGoodsVO"
local mSortTable = require "Common/SortTable"
local mEventEnum = require "Enum/EventEnum"
local mConfigSysgoods = require "ConfigFiles/ConfigSysgoods"
local mGameModelManager = require "Manager/GameModelManager"
local mTable = table;
local mipairs = ipairs
local mpairs = pairs;
local tableRemove = table.remove;
local mathFmod = math.fmod;
local BagModel = mLuaClass("BagModel",mBaseModel);

function BagModel:OnLuaNew()
	self.mTypeEnum = {AllType = 1;JadeType = 2,ConSumeType = 3,TalentType = 4,DraftType = 5,Fashion = 6, Seed = 7, Material = 8, Product = 9, Decorate = 10 };
	self.mIsBatch = false;
	self.mBatchTable = {};
	self.mBagTypeTable = {[2]=true, [3]=true,[4]=true,[5]=true,[6]=true,[9]=true};			--记录需要在背包显示的物品类型
	self.mBagShowTypeTable = {[3] = true,[5] = true, [7] = true,[8] = true, [9] = true } --背包系统界面切页显示的类型
	self.mCustomGoodsID = -1;
	self.mMaxGoodsNum = 500;
end

function BagModel:GetSellIconByType( s_type  )
	return 'common_city_icon_'..s_type;
end

function BagModel:IsMansionGoods( goods_type )
	local enum = self.mTypeEnum;
	return goods_type == enum.Seed or goods_type == enum.Material;
end

function BagModel:RecvMansionGoodsList( pbItemList )
	local goodsListWithType = self:GetGoodsListWithType( pbItemList.type );
	for k, v in mipairs(pbItemList.list) do
		local uid = v.id;
		goodsListWithType:AddOrUpdate( uid, mBagGoodsVO.LuaNew(uid,v.item_id, nil, v.count) );
	end

	self:CheckFillBlankGoods();
end

function BagModel:RecvGoodsListResult(pbGoodList)
	local goodslist = mSortTable.LuaNew(function(a, b) return self:Sort(a, b) end, nil, true);
	local goodsListWithType = {};

	local bagShowTypeTable = self.mBagShowTypeTable;
	local typeList = nil;
	for i= 2, 10 do
		typeList = mSortTable.LuaNew(function(a, b) return self:Sort(a, b) end, nil, true);
		goodsListWithType[i] = typeList;

		if bagShowTypeTable[i] then
			typeList.mBlankGoodsList = {};
		end
	end
	if pbGoodList ~= nil then
		local bagTypeTable = self.mBagTypeTable;
       	for k,v in mipairs(pbGoodList.good_list) do
		   local uid = v.id;

		   if uid ~= nil then
              local goods_data = mBagGoodsVO.LuaNew(uid,v.good_id,v.color,v.count,v);
              local goodsType = goods_data.mSysVO.type;
              if bagTypeTable[goodsType] then --判断该类型是否进背包
		         goodslist:AddOrUpdate(uid,goods_data);
		         goodsListWithType[goodsType]:AddOrUpdate(uid,goods_data);
		      end
		   end
	    end
	end
	self.mGoodsList = goodslist;
	self.mGoodsListWithType = goodsListWithType
	mGameModelManager.DraftModel:InitDefaultDraftList();
	mGameModelManager.DraftModel:CheckHaveChipToDraft();--检测碎片合成

	self.mBlankGoodsPool = {};
	self:CheckFillBlankGoods();
end

function BagModel:GetValidGoodsNum(goodslist)
	local list = goodslist.mBlankGoodsList
	if list == nil then
		return #goodslist.mSortTable;
	end
	return self.mMaxGoodsNum - #list;
end

function BagModel:CheckFillBlankGoods()
	local goodslist = nil;
	local blankGoodsNum = 0;
	local goodsNum = nil;
	local fmodNum = nil;
	local addBlankNum = 0;
	local maxBlank = nil;
	local blankGoodsList = nil;
	local goods_data;

	local blankGoodsPool = self.mBlankGoodsPool;
	local poolNum = #blankGoodsPool;
	local maxGoodsNum = self.mMaxGoodsNum;

	local goodsListWithType = self.mGoodsListWithType;
	for k,v in mpairs(self.mBagShowTypeTable) do
		goodslist = goodsListWithType[k];
		blankGoodsList = goodslist.mBlankGoodsList;
		blankGoodsNum = #blankGoodsList;
		goodsNum = #goodslist.mSortTable - blankGoodsNum;
		maxBlank = maxGoodsNum - goodsNum;

		if blankGoodsNum < maxBlank then
			for i=blankGoodsNum,maxBlank - 1 do
				local uid = self.mCustomGoodsID - 1;
				self.mCustomGoodsID = uid;

				if poolNum > 0 then
					goods_data = tableRemove(blankGoodsPool,poolNum);
					poolNum = poolNum - 1;
				else
					goods_data = mBagGoodsVO.LuaNew(uid,-1,0,0,nil);
				end

				goodslist:AddOrUpdate(uid,goods_data);
				
				blankGoodsNum = blankGoodsNum + 1;
				blankGoodsList[blankGoodsNum] = goods_data;
			end
		elseif blankGoodsNum > maxBlank then
			for i=blankGoodsNum,maxBlank + 1,-1 do
				goods_data = tableRemove(blankGoodsList,i);
				goodslist:RemoveValue(goods_data);
				
				poolNum = poolNum + 1;
				blankGoodsPool[poolNum] = goods_data;
			end
		end
	end
end

function BagModel:RecvGoodsListRefresh(pbGoodList)
	if self.mGoodsList == nil then
	   self:RecvGoodsListResult(pbGoodList);
       return;
	end
	local goodslist = self.mGoodsList;
	local goodsListWithType = self.mGoodsListWithType;
	local draftModel = mGameModelManager.DraftModel;
	local bagTypeTable = self.mBagTypeTable;
	
	for k,v in mipairs(pbGoodList.good_list) do
		local uid = v.id;
		if uid ~= nil then
           local goods_data = goodslist:GetValue(uid);
           local changeType = 0;
           local goodsType = 0;
		   if goods_data ~= nil then
		   	  goodsType = goods_data.mSysVO.type;
              if v.count ~= 0 then
                goods_data.mNumber = v.count;
                goods_data.mColor = v.color;
                goods_data.mPbGoodVO = v;
                goodslist:AddOrUpdate(uid,goods_data);
                goodsListWithType[goodsType]:AddOrUpdate(uid,goods_data);
                changeType = 1;
              else
              	local goodid = goods_data.mID;
              	goodsListWithType[goodsType]:RemoveKey(uid);
                goodslist:RemoveKey(uid);
                changeType = 2;
                if goodsType == 5 or goodsType == 3 then
                   draftModel:RemoveChip(goodid);
                end
              end
		   else
              goods_data = mBagGoodsVO.LuaNew(uid,v.good_id,v.color,v.count,v);
              goodsType = goods_data.mSysVO.type;
              if bagTypeTable[goods_data.mSysVO.type] then --判断该类型是否进背包
		         goodslist:AddOrUpdate(uid,goods_data);
		         goodsListWithType[goodsType]:AddOrUpdate(uid,goods_data);
		         changeType = 3;
		      end
		      if goodsType == 3 then
                 draftModel:CheckSpecialItem(v.good_id);
		      end
		   end
		   local params = {mData = goods_data,mType = changeType};
		   self:Dispatch(mEventEnum.ON_BAG_GOODS_REFRESH,params);
		   
		   if goodsType == 5 then
              draftModel:CheckHaveChipToDraft();--检测碎片合成
		   end
		end
	end

	self:CheckFillBlankGoods();
end

function BagModel:Sort(a, b)
	local aColor = a.mColor;
	local bColor = b.mColor;
	if aColor == bColor then
		return a.mGoodsUID < b.mGoodsUID;
	else
		return aColor > bColor
	end
end

function BagModel:GetGoodsListWithType(selectType)
	if selectType == nil then
		return self.mGoodsList;
	end
    return self.mGoodsListWithType[selectType];
end

function BagModel:GetValidGoodsListWithType(selectType)
	local goodslist = self:GetGoodsListWithType( selectType );
	local sortTable = mSortTable.LuaNew(function(a, b) return self:Sort(a, b) end, nil, true);

	for k, v in mipairs( goodslist.mSortTable ) do
		if v.mID == -1 then
			break;
		end
		sortTable:AddOrUpdate( v.mGoodsUID, v );
	end
	return sortTable;
end

--根据道具ID返回goodsVO,不能确定类型的goodsType传1
function BagModel:GetGoodsByGoodsId(goodid,goodsType)
	local list = self:GetGoodsListWithType(goodsType);
	for i,v in mipairs(list.mSortTable) do
		if v.mID == goodid then
		   return v;
	    end
	end
	return nil;
end

function BagModel:GetGoodsNumberGoodsId(goodid,goodsType)
	local num = 0;
	if goodsType == nil then
		goodsType = mConfigSysgoods[ goodid ].type;
	end
	local list = self:GetGoodsListWithType(goodsType);
	for i,v in mipairs(list.mSortTable) do
		if v.mID == goodid then
		   num = num + v.mNumber;
	    end
	end
	return num;
end

function BagModel:CheckGoodsIsEnough( goods_cost )

	if goods_cost == nil then
       return true;
	end
	for i, v in mipairs(goods_cost) do
		local goodsType = mConfigSysgoods[ v.goods_id ].type;
		local goods_number = self:GetGoodsNumberGoodsId(v.goods_id,goodsType);
		local compareNum = v.goods_number;
		if compareNum == nil then
           compareNum = v.goods_num;
		end
		if goods_number < compareNum then
			return false;
		end
	end
	return true;
end

function BagModel:ChangeBatchTable(itemData,isBatch)
	local batchTable = self.mBatchTable;
	if isBatch then
		batchTable[itemData.mGoodsUID] = itemData;
		self.mLastBatchData = itemData;
		self:Dispatch(mEventEnum.ON_BAG_SHOW_INFO,itemData);
	else
		batchTable[itemData.mGoodsUID] = nil;
	end
end

function BagModel:GetBatchNum()
	local num = 0;
	local batchTable = self.mBatchTable;
	for k,v in pairs(batchTable) do
		num = num + v.mNumber;
	end
	return num;
end

function BagModel:GetBatchPrice()
	local price = 0;
	local batchTable = self.mBatchTable;
	for k,v in pairs(batchTable) do
		price = price + v.mNumber*v.mSysVO.sell_price;
	end
	return price;
end

return BagModel;