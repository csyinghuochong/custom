local mLuaClass = require "Core/LuaClass"
local mActivityItemBaseVO = require "Module/Activity/ActivityItemBaseVO"
local mConfigSysactive_combat = require "ConfigFiles/ConfigSysactive_combat"
local mCommonGoodsVo = Assets.Scripts.Com.Game.Module.CommonComponent.CommonGoodsVo;
local ActivityItemPowerVO = mLuaClass("ActivityItemPowerVO", mActivityItemBaseVO);
local ArrayUtil = require "Utils/ArrayUtil"
local mString = 'string'

function ActivityItemPowerVO:OnLuaNew(id, activity_type)
    local sys_vo = mConfigSysactive_combat[id];
    self.mCombat = sys_vo.combat;
    self.mSysVO = sys_vo;

    mSuper = self:GetSuper(mActivityItemBaseVO.LuaClassName);
    mSuper.OnLuaNew(self, id, activity_type);
end

function ActivityItemPowerVO:GetGoodsList()
    local goods_list = self.mGoodsList;
    if goods_list == nil then
        goods_list = {};
        local vo_list = self.mSysVO.combat_goods;
        for k, v in pairs(vo_list) do
            goods_list[k] = mCommonGoodsVo.New(v.goods_id, v.goods_num, true, 1, false);
        end
        self.mGoodsList = goods_list;
    end
    return goods_list;
end

function ActivityItemPowerVO:GetTextTitle()
    local text_title = self.mTextTitle;
    if text_title == nil then
        text_title = mString.format('战力达到[fff66b]%d[-]', self.mCombat);
    end
    return text_title;
end

function ActivityItemPowerVO:CanGet()
    local mActivityModel = self:GetActivityModel();
    local login_info = mActivityModel:GetActivityLoginInfo();
    if login_info == nil then
        return false;
    end
    local combat = self:GetRoleModel().mPlayerBase.all_combat;
    local power = self.mCombat;
    return combat >= power and not ArrayUtil:ContainsValue(self.mID, login_info.combat_list);
end

return ActivityItemPowerVO;