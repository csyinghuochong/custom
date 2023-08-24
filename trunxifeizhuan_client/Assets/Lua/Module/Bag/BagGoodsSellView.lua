local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBagController = require "Module/Bag/BagController"
local mConfigSysgoods = require "ConfigFiles/ConfigSysgoods"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView";
local mCommonSliderButton = require "Module/CommonUI/CommonSliderButton"
local mEventEnum = require "Enum/EventEnum"

local BagGoodsSellView = mLuaClass("BagGoodsSellView", mQueueWindow);

function BagGoodsSellView:InitViewParam()
	return {
		["viewPath"] = "ui/bag/",
		["viewName"] = "bag_sell_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.transparent_clickable,
	};
end

function BagGoodsSellView:Init()
    self:FindAndAddClickListener("cancel",function () self:OnClickHideView() end);
    self:FindAndAddClickListener("sell",function () self:OnClickSellButton() end);
    self.mSellIcon = self:FindComponent("coin/icon","Image");
    self.mCoinNumber = self:FindComponent('coin/num', 'Text');
    self.mGoods = mCommonGoodsItemView.LuaNew(self:Find('goods').gameObject);
    self.mName = self:FindComponent("name","Text");
    local sliderChangeBack = function ( value )
        self:OnValueChange(value);
    end
    local go = self:Find("Slider").gameObject;
    self.mSlider = mCommonSliderButton.LuaNew(go,sliderChangeBack);

    self:RegisterEventListener(mEventEnum.ON_SELL_GOODS_RESULT, function()
        self:OnClickHideView();
        self:PlaySoundName("ty_0210")
    end, true);
end

function BagGoodsSellView:OnClickSellButton()
    local data = self.mLogicParams;
	mBagController:SendSellGoods(data.mSysVO.type, data.mGoodsUID,self.mValue);--物品唯一ID
end

function BagGoodsSellView:OnViewShow(logicParams)
    self.mLogicParams = logicParams;
    local configData = logicParams.mSysVO;
    self.mValue = logicParams.mNumber;
    self.mSlider:SetInfo(logicParams.mNumber,1,logicParams.mNumber);
    self.mGoods:ExternalUpdate(logicParams);
    self.mGameObjectUtil:SetImageSprite(self.mSellIcon,mGameModelManager.BagModel:GetSellIconByType( configData.currency ) );
    self:SetInfo(logicParams.mNumber,logicParams);
end

function BagGoodsSellView:SetInfo(value,data)
    self.mName.text = data.mSysVO.goods_name.."X"..value;
    self.mCoinNumber.text = data.mSysVO.sell_price * value;
    self.mValue = value;
end

function BagGoodsSellView:OnValueChange(value)
    if self.mLogicParams == nil then
        return;
    end
    self:SetInfo(value,self.mLogicParams);
end


return BagGoodsSellView;