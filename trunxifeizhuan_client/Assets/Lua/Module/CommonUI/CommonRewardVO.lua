local BaseLua = require "Core/BaseLua"
local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mConfigSysgoods = require "ConfigFiles/ConfigSysgoods"
local mCommonGoodsVO = require"Module/CommonUI/CommonGoodsVO";
local mGameModelManager = require "Manager/GameModelManager"
local mCombatModelManager = require "Module/Combat/CombatModelManager"
local CommonRewardVO = mLuaClass("CommonRewardVO",BaseLua);

function CommonRewardVO:OnLuaNew()
end

local mGoodsExpID   = 1000001;
local mGoodsArenaID = 1000005;
function CommonRewardVO:InitDungeonReward( goods_list )
	if goods_list == nil then
		return;
	end

	local items = {};
	for i,v in ipairs(goods_list) do
		local goods_id = v.goods_id;
		if goods_id ~= mGoodsExpID then
			local vo = mConfigSysgoods[goods_id];
			if vo == nil then
				error( 'vo == nil: '..goods_id);
			end
			local itemType = 1;
			if vo.type ~= 1 then
				itemType = 2;
			end

			local list = items[itemType];
			if not list then
				list = {};
				list.mCount = 0;
				items[itemType] = list;
			end

			local item = list[vo];
			if not item then
				item = {mGoodsId = goods_id,mNumber = v.goods_num,mGoodsVo = vo};
				local count = list.mCount + 1 ;
				list[vo] = item;
				list[count] = item;
				list.mCount = count;
			else
				item.mNumber = item.mNumber + v.goods_num;
			end
		end
	end
	self.mItems = items;
end

function CommonRewardVO:InitDungeonRewardTalents( talent_list )
	if talent_list == nil or #talent_list == 0 then
		self.mTalents = nil;
		return;
	end

	local talents = {};
	for k,v in ipairs(talent_list) do
		local data = {id=k,type=v.type,color=v.color,star_level=v.star_level,pos=v.pos,talent_type=v.talent_type};
		talents[k] = data;
	end

	self.mTalents = talents;
end

function CommonRewardVO:InitCommonVo(goods_list)
	self.mItems = {};
	self.mGoodsData = mSortTable.LuaNew();
	if goods_list == nil then
		return;
	end

	local list = self.mItems;
	list.mCount = 0;
	local goods_data = self.mGoodsData;
	for k, v in ipairs(goods_list) do

		local vo = mConfigSysgoods[v.goods_id];

		if vo.type == 1 then
			local item = list[vo];
			if not item then
				item = {mGoodsId = v.goods_id,mNumber = v.goods_num,mGoodsVo = vo};
				local count = list.mCount + 1 ;
				list[vo] = item;
				list[count] = item;
				list.mCount = count;
			else
				item.mNumber = item.mNumber + v.goods_num;
			end
		else
			local goods_vo = mConfigSysgoods[v.goods_id];
			if goods_vo ~= nil and goods_vo.type ~= 1 then
				goods_data:AddOrUpdate(k, mCommonGoodsVO.LuaNew(v.goods_id, v.goods_num));
			end
		end
	end
end

function CommonRewardVO:InitConfigReward( drop )
	
end

function CommonRewardVO:InitPromoteArenaReward( pbReward, result )
	local items = {};
	local vo = mConfigSysgoods[mGoodsArenaID];
	if vo then
		local itemType = 1;
		if vo.type ~= 1 then
			itemType = 2;
		end

		local list = items[itemType];
		if not list then
			list = {};
			list.mCount = 1;
			items[itemType] = list;
		end
		local data = {mGoodsId = mGoodsArenaID,mNumber = pbReward.arena_coin,mGoodsVo = vo};
		table.insert(list,data);
	end

	self.mItems = items;
	self.mPbReward = pbReward;
	self.mBattleResult = result;
end

return CommonRewardVO;