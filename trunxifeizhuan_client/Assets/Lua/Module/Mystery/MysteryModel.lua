local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mSortTable = require "Common/SortTable"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mMysteryVO = require "Module/Mystery/MysteryVO"
local MysteryModel = mLuaClass("MysteryModel",mBaseModel);

function MysteryModel:OnLuaNew()
	self.mDataSoure = mSortTable.LuaNew(nil,nil,true);
	self.mIsEverGetList = false;
	self.mSelectData = nil;
	self.mTime = 0;
end

function MysteryModel:OnRecvList(pbShopMysteryList)
	self.mDataSoure:ClearDatas(true);
	self.mTime = pbShopMysteryList.timestamp;
	for k,v in ipairs(pbShopMysteryList.list) do
		local mysteryVO = mMysteryVO.LuaNew(v);
		self.mDataSoure:AddOrUpdate(mysteryVO.uid,mysteryVO);
	end
	self:Dispatch(self.mEventEnum.ON_GET_MYSTERY_LIST);
end

function MysteryModel:OnRecvBuy(pbResult)
	local itemData = self.mSelectData;
	if itemData ~= nil then
		itemData.buy_tag = 1;
		self.mDataSoure:AddOrUpdate(itemData.uid,itemData);
	end
end

return MysteryModel;