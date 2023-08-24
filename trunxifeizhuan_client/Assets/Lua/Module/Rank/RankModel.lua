local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mSortTable = require "Common/SortTable"
local mEventDispatcher = require "Events/EventDispatcher"
local mEventEnum = require "Enum/EventEnum"
local mRankVO = require "Module/Rank/RankVO"
local RankModel = mLuaClass("RankModel",mBaseModel);

function RankModel:OnLuaNew()
	self.mType = 1;
	self.mPageNum = 10;							--每次拿排行榜的页数
	self.mPageNowTable = {1,1,1,1,1};			--记录每个切页的排行榜当前翻到第几页
	self.mPageAllTable = {0,0,0,0,0};			--记录每个切页的排行榜各自总共有多少页
	self.mDataSoure = mSortTable.LuaNew(function(a,b) return a.rank < b.rank end,nil,true);
	self.mTypeEnum = {COMBAT=1;POSITION=2;FOLLOWERNUM=3;SIXFOLLOWER=4;SUPERFOLLOWER=5;MANSION=6;}
end

function RankModel:OnRecvRankList(pbRankData)
	local list = pbRankData.rank_list;
	if list ~= nil then
		self.mPageAllTable[pbRankData.type] = pbRankData.total_page;
		if self.mPageNowTable[pbRankData.type] > pbRankData.total_page then
			self.mPageNowTable[pbRankData.type] = pbRankData.total_page;
		end
		local data_soure = self.mDataSoure;
		for k,v in ipairs(list) do
			local rankVO = mRankVO.LuaNew(v,pbRankData.type);
			data_soure:AddOrUpdate(rankVO.rank,rankVO);
		end
		mEventDispatcher:Dispatch(mEventEnum.ON_CHANGE_SELF_RANK_VALUE,pbRankData);
	end
end

return RankModel;