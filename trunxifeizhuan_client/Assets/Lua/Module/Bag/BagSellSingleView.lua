local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBagController = require "Module/Bag/BagController"
local mConfigSysgoods = require "ConfigFiles/ConfigSysgoods"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView";
local mCommonSliderButton = require "Module/CommonUI/CommonSliderButton"
local mEventEnum = require "Enum/EventEnum"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"

local BagSellSingleView = mLuaClass("BagSellSingleView", mQueueWindow);

function BagSellSingleView.Show(table)
    mUIManager:HandleUI(mViewEnum.BagSellSingleView, 1, table);
end

function BagSellSingleView:InitViewParam()
	return {
		["viewPath"] = "ui/bag/",
		["viewName"] = "bag_sell_single_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.transparent_clickable,
	};
end

function BagSellSingleView:Init()
    self:FindAndAddClickListener("cancel",function () self:OnClickHideView() end);
    self:FindAndAddClickListener("sell",function () self:OnClickSellButton() end);
    self.mCoinNumber = self:FindComponent('num', 'Text');
    self.mDesc = self:FindComponent("desc","Text");

    self:RegisterEventListener(mEventEnum.ON_SELL_GOODS_RESULT, function()
        self:OnClickHideView();
        self:PlaySoundName("ty_0210")
    end, true);
end

function BagSellSingleView:OnClickSellButton()
    local callback = self.mLogicParams.callback;
    if callback ~= nil then
        callback();
    end
end

function BagSellSingleView:OnViewShow(logicParams)
    self.mLogicParams = logicParams;
    self.mCoinNumber.text = logicParams.price;
    self.mDesc.text = string.gsub(logicParams.desc,"\\n","\n");
end

return BagSellSingleView;