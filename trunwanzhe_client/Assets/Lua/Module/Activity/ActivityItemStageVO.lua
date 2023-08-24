local mLuaClass = require "Core/LuaClass"
local mActivityItemBaseVO = require "Module/Activity/ActivityItemBaseVO"
local mConfigSysactive_phase = require "ConfigFiles/ConfigSysactive_phase"
local mCommonGoodsVo = Assets.Scripts.Com.Game.Module.CommonComponent.CommonGoodsVo;
local ActivityItemStageVO = mLuaClass("ActivityItemStageVO", mActivityItemBaseVO);
local ArrayUtil = require "Utils/ArrayUtil"
local mString = require "string"

function ActivityItemStageVO:OnLuaNew(id, activity_type)
    local sys_vo = mConfigSysactive_phase[id];
    self.mSysVO = sys_vo;

    mSuper = self:GetSuper(mActivityItemBaseVO.LuaClassName);
    mSuper.OnLuaNew(self, id, activity_type);
end

function ActivityItemStageVO:GetGoodsList()
    local goods_list = self.mGoodsList;
    if goods_list == nil then
        goods_list = {};
         local vo_list = self.mSysVO.phase_goods;
        for k, v in pairs(vo_list) do
            goods_list[k] = mCommonGoodsVo.New(v.goods_id, v.goods_num, true, 1, false);
        end
        self.mGoodsList = goods_list;
    end
    return goods_list;
end

function ActivityItemStageVO:GetTextTitle()
    local text_title = self.mTextTitle;
    if text_title == nil then
        text_title = mString.format('段位达到[fff66b]%s[-]', self.mSysVO.phase_name);
    end
    return text_title;
end

function ActivityItemStageVO:CanGet()
    local mActivityModel = self:GetActivityModel();
    local login_info = mActivityModel:GetActivityLoginInfo();
    if login_info == nil then
        return false;
    end
    local phase = mActivityModel:GetPhase();
    local power = self.mID;
    return phase >= power and not ArrayUtil:ContainsValue(power, login_info.phase_list);
end

return ActivityItemStageVO;