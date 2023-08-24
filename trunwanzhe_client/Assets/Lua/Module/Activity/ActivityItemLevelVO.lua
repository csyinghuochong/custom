local mLuaClass = require "Core/LuaClass"
local mConfigSysactive_lv = require "ConfigFiles/ConfigSysactive_lv"
local mActivityItemBaseVO = require "Module/Activity/ActivityItemBaseVO"
local mCommonGoodsVo = Assets.Scripts.Com.Game.Module.CommonComponent.CommonGoodsVo;
local ActivityItemLevelVO = mLuaClass("ActivityItemLevelVO", mActivityItemBaseVO);
local ArrayUtil = require "Utils/ArrayUtil"
local mString = 'string'
local mSuper;

function ActivityItemLevelVO:OnLuaNew(id, activity_type)
    local sys_vo = mConfigSysactive_lv[id];
    self.mSysVO = sys_vo;

    mSuper = self:GetSuper(mActivityItemBaseVO.LuaClassName);
    mSuper.OnLuaNew(self, id, activity_type);
end

function ActivityItemLevelVO:GetGoodsList()
    local goods_list = self.mGoodsList;
    if goods_list == nil then
        goods_list = {};
        local vo_list = self.mSysVO.goods;
        for k, v in pairs(vo_list) do
            goods_list[k] = mCommonGoodsVo.New(v.goods_id, v.goods_num, true, 1, false);
        end
        self.mGoodsList = goods_list;
    end
    return goods_list;
end

function ActivityItemLevelVO:GetTextTitle()
    local text_title = self.mTextTitle;
    if text_title == nil then
        text_title = mString.format('玩家等级达到[fff66b]%d[-]级', self.mID);
    end
    return text_title;
end

function ActivityItemLevelVO:CanGet()
    local mActivityModel = self:GetActivityModel();
    local login_info = mActivityModel:GetActivityLoginInfo();
    if login_info == nil then
        return false;
    end
    local level = self:GetRoleModel():GetPlayerLV();
    local lv = self.mID;
    return level >= lv and not ArrayUtil:ContainsValue(lv, login_info.lv_list);
end

return ActivityItemLevelVO;