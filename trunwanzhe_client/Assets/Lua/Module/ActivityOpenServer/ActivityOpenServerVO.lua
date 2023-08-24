local mLuaClass = require "Core/LuaClass"
local mConfigSysactive_rank = require 'ConfigFiles/ConfigSysactive_rank'
local mConfigSysactive_welfare = require 'ConfigFiles/ConfigSysactive_welfare'
local mCommonGoodsVo = Assets.Scripts.Com.Game.Module.CommonComponent.CommonGoodsVo;
local mDungeonLevelIndexVO = Assets.Scripts.Com.Game.Module.Dungeon.DungeonLevelIndexVO
local mActivityOpenServerType = require "Module/ActivityOpenServer/ActivityOpenServerType"
local ActivityOpenServerVO = mLuaClass("ActivityOpenServerVO");

function ActivityOpenServerVO:OnLuaNew()
	
end

function ActivityOpenServerVO:GetRankRewardList(rank, index)
    local list = {};
    local rank_list = mConfigSysactive_rank[rank];
    local goods_list = nil;
    if index == mActivityOpenServerType.DUNGRON_RANK then
        goods_list = rank_list.dungeon_extra_reward;
    elseif index == mActivityOpenServerType.COMBAT_RANK then
        goods_list = rank_list.combat_extra_reward;
    else
        goods_list = rank_list.arena_extra_reward;
    end

    for k, v in pairs(goods_list) do
        list[k] = mCommonGoodsVo.New(v.goods_id, v.goods_num, true, 1, false);
    end
    return list;
end

function ActivityOpenServerVO:GetWelfareReward(index)
    local list = {};
    local welfare = mConfigSysactive_welfare[index];
    local goods_list = welfare.reward;
    for k, v in pairs(goods_list) do
        list[k] = mCommonGoodsVo.New(v.goods_id, v.goods_num, true, 1, false);
    end 
    return list;
end

function ActivityOpenServerVO:GetWelfareCondition(index)
    local list = {};
    local welfare = mConfigSysactive_welfare[index];
    if index == mActivityOpenServerType.DUNGRON_RANK then
        list[1] = '通关';
        list[2] = mDungeonLevelIndexVO.GetLevelTypeAndIndex(welfare.finish_limit)
    elseif index == mActivityOpenServerType.COMBAT_RANK then
        list[1] = '战力达到';
        list[2] = welfare.finish_limit;
    else
        list[1] = '竞技排名达到';
        list[2] = welfare.finish_limit;
    end
    return list;
end

return ActivityOpenServerVO;