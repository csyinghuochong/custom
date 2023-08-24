local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mGameModelManager = require "Manager/GameModelManager"
local FashionInfoView = mLuaClass("FashionInfoView", mBaseWindow);
local FashionBaseItemView = require"Module/Fashion/FashionBaseItemView"
local FashionAttributeItemView = require"Module/Fashion/FashionAttributeItemView"
local ipairs = ipairs;
local mAlertView = require "Module/CommonUI/AlertView"
local mFashionBuyTipView = require "Module/Fashion/FashionBuyTipView"
local mFashionController = require"Module/Fashion/FashionController"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mUIGray = require "Utils/UIGray"
local mLanguage = require "Utils/LanguageUtil"
local CommonItemsView = require"Module/Fashion/Common/CommonItemsView"
local Vector3 = Vector3;
local mVector3Zero = Vector3.zero;
local mDefaultPosition = Vector3.New(-200,-20,0);
local Screen = UnityEngine.Screen;

local mShowParams = {};

function FashionInfoView.Show(fashion,position,withoutButtons)
	mShowParams.mTarget = nil;
	mShowParams.mPosition = position or mDefaultPosition;
	mShowParams.mFashion = fashion;
	mShowParams.mWithoutButtons = withoutButtons;
	mUIManager:HandleUI(mViewEnum.FashionInfoView, 1, mShowParams);
end

function FashionInfoView.ShowWith(fashion,target,withoutButtons)
	mShowParams.mTarget = target;
	mShowParams.mFashion = fashion;
	mShowParams.mWithoutButtons = withoutButtons;
	mUIManager:HandleUI(mViewEnum.FashionInfoView, 1, mShowParams);
end

function FashionInfoView.Hide()
	mUIManager:HandleUI(mViewEnum.FashionInfoView, 0);
end

function FashionInfoView:InitViewParam()
	return {
		["viewPath"] = "ui/fashion/",
		["viewName"] = "fashion_info_view",
		["ParentLayer"] = mMainLayer1,
	};
end

function FashionInfoView:Init()

	self.mNameText = self:FindComponent("infoView/fashion_item_frame/fashion_name","Text");
	self.mScoreText = self:FindComponent("infoView/fashion_item_frame/fashion_score","Text");

	self.mBaseAttributeView=  FashionAttributeItemView.LuaNew(self:Find("infoView/fashion_item_frame/attribute").gameObject);
	self.mFashionView = FashionBaseItemView.CreateAt(self:Find('infoView/fashion_item_frame/item_view'));
	self.mStyleItemViews = CommonItemsView.CreateItemViews(self:Find("infoView/style_attributes/attributes"),"Module/Fashion/FashionStyleItemView",4);
	self.mAttributeItemViews = CommonItemsView.InitItemViews(self:Find("infoView/combat_attributes/attributes"),"Module/Fashion/FashionAttributeItemView");

	self.mStyleView = self:Find("infoView/style_attributes");
	self.mAttributeView = self:Find("infoView/combat_attributes").gameObject;
	self.mUseView = self:FindComponent("infoView/style_attributes/uses","Text");

	self:InitButtons();

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_UPDATE_FASHION_INFO, function(data) self:UpdateData(data); end,true);
	self:RegisterEventListener(mEventEnum.ON_SELECT_SUIT_COMPONENT, function(item) self:UpdateData(item.mData); end,true);
end

function FashionInfoView:Dispose()

	self.mBaseAttributeView:CloseView();
	self.mFashionView:CloseView();
	self.mStyleItemViews:Dispose();
	self.mAttributeItemViews:Dispose();

	self.mFashionView = nil;
	self.mBaseAttributeView = nil;
	self.mStyleItemViews = nil;
	self.mAttributeItemViews = nil;
end

function FashionInfoView:InitButtons()

	local closeBtn = self:Find("Close").gameObject;
	local leftBtn = self:Find("Button1").gameObject;
	local rightBtn = self:Find("Button2").gameObject;

	self:AddBtnClickListener(closeBtn, function ()
		self:Dispatch(self.mEventEnum.ON_CLOSE_FASHION_INFO);
		self:HideView();
	end);

	self.mButtonLeftText = self:FindComponent("Button1/text","Text");
	self.mButtonRightText = self:FindComponent("Button2/text","Text");

	self:AddBtnClickListener(leftBtn,function() self:OnClickButton1() end);
	self:AddBtnClickListener(rightBtn,function() self:OnClickButton2() end);

	local btnGraphic = self:FindComponent('Button2/icon',"Graphic");

	self.mRightButtonGray = mUIGray.LuaNew():InitGraphic(btnGraphic);
	self.mRightButtonGraphic = btnGraphic;

	self.mCloseButton = closeBtn;
	self.mLeftButton = leftBtn;
	self.mRightButton = rightBtn;
end

function FashionInfoView:ToggleButtons(show)
	self.mCloseButton:SetActive(show);
	self.mLeftButton:SetActive(show);
	self.mRightButton:SetActive(show);
end

function FashionInfoView:OnClickButton1()
	local data = self.mData;
	if data then
		if self:IsEquiped(data) then
			data = mGameModelManager.FashionModel:GetDefaultFashion(nil,data.mPosition);
		end
		self:Dispatch(self.mEventEnum.ON_REPLACE_FASHION,data);
	end
end

function FashionInfoView:OnClickButton2()
	local data = self.mData;
	if data.mActived then
		mUIManager:HandleUI(mViewEnum.FashionUpGradeView,1,data);
	else
		local from = data.mConfig.from;
		if from == 1 then
			self:Combine(data);
		elseif from == 2 then
			self:Buy(data);
		elseif from == 3 then
			mCommonTipsView.Show(mLanguage.fashion_from_dungeon);
		elseif from == 4 then
			mCommonTipsView.Show(mLanguage.fashion_from_huodong);
		end
	end
end

local mBuyParams = {};
--购买
function FashionInfoView:Buy(data)

	local config = data.mConfig;
	local callback = function ()
		mFashionController:SendGetFashion(data);
	end

	mBuyParams.title = mLanguage.fashion_buy_tip_tittle;
	mBuyParams.desc1 = config.describe;
	mBuyParams.desc2 = config.name;
	mBuyParams.btnName = config.cost[1].number;
	mBuyParams.CallBack = callback;
	mBuyParams.goods = data;
	mFashionBuyTipView.Show(mBuyParams);
end
local mCombineParams = {};
--合成
function FashionInfoView:Combine(data)

	local config = data.mConfig;
	local callback = function ()
		mFashionController:SendGetFashion(data);
	end
	mCombineParams.title = mLanguage.fashion_combine_tip_tittle;
	mCombineParams.desc1 = mLanguage.fashion_combine_tip;
	mCombineParams.desc2 = config.name;
	mCombineParams.showMidLine = true;
	mCombineParams.CallBack = callback;
	mAlertView.Show(mCombineParams);
end

function FashionInfoView:UpdateData(data)
	self.mData = data;
	self:OnUpdateData(data);
end

function FashionInfoView:GetPositionAt(target)
    local sizeDelta = self:Find("infoView/bg"):GetComponent('RectTransform').sizeDelta;
    local parentSize = target:GetComponent('RectTransform').sizeDelta;
    local camera = mUIManager.mCanvasTrans:GetComponent('Canvas').worldCamera;
    local screenPoint = camera:WorldToScreenPoint(target.position);
    local localPosition = target.localPosition;
    --位置从右上，右下，左上，左下顺序判断
    local screenVector = mVector3Zero;
    screenVector.z = screenPoint.z;
    local x = Screen.width - (sizeDelta.x+parentSize.x/2)*(Screen.width/mUIManager:GetDeviceWidth());
    local y = Screen.height - (sizeDelta.y+parentSize.y/2)*(Screen.height/mUIManager:GetDeviceHeight());
    local halfX = sizeDelta.x/2 + parentSize.x/2;
    local halfY = sizeDelta.y/2 + parentSize.y/2;
    if screenPoint.x < x and screenPoint.y < y then
       screenVector.x = localPosition.x + halfX - 8;
       screenVector.y = localPosition.y + halfY - 8;
    elseif screenPoint.x < x and screenPoint.y > y then
       screenVector.x = localPosition.x + halfX - 8;
       screenVector.y = localPosition.y - halfY + 8;
    elseif screenPoint.x > x and screenPoint.y < y then
       screenVector.x = localPosition.x - halfX + 8;
       screenVector.y = localPosition.y + halfY - 8;
    elseif screenPoint.x > x and screenPoint.y > y  then
       screenVector.x = localPosition.x - halfX + 8;
       screenVector.y = localPosition.y - halfY + 8;
    else
       screenVector.x = localPosition.x;
       screenVector.y = localPosition.y;
    end

    local parent = target.parent or target;
    return parent:TransformPoint(screenVector);
end

function FashionInfoView:OnViewShow(logicParams)
	self:UpdateData(logicParams.mFashion);

	local target = logicParams.mTarget;
	if target then
		self.mTransform.position = self:GetPositionAt(target);
	else
		self.mTransform.localPosition = logicParams.mPosition;
	end

	self:ToggleButtons(logicParams.mWithoutButtons == nil);
end

local mRightButtonTexts = {
	mLanguage.fashion_info_button_combine,
	mLanguage.fashion_info_button_buy,
	mLanguage.fashion_info_button_explain,
	mLanguage.fashion_info_button_explain
};

function FashionInfoView:IsEquiped(fashion)
	return mGameModelManager.FashionModel:GetTempEquipedFashion(fashion.mPosition) == fashion;
end
function FashionInfoView:UpdateButtons(data)

	if self.mWithoutButtons then
		return;
	end
	local disableRightBtn = false;
	if data.mActived then
		local leftButtonText = self:IsEquiped(data) and mLanguage.fashion_info_button_unsnatch or mLanguage.fashion_info_button_dress;
		self.mButtonLeftText.text = leftButtonText;
		self.mButtonRightText.text = mLanguage.fashion_info_button_grade_up;
	else
		local leftButtonText = self:IsEquiped(data) and mLanguage.fashion_info_button_unsnatch or mLanguage.fashion_info_button_try_dress;
		self.mButtonLeftText.text = leftButtonText;
		self.mButtonRightText.text = mRightButtonTexts[data.mConfig.from];
		disableRightBtn = data:CanGetNow() == false;
	end

	self.mRightButtonGray:SetGray(disableRightBtn);
	self.mRightButtonGraphic.raycastTarget = disableRightBtn == false;
end

local mStyleViewPosY = {20,-20,-40,-60,-80};
function FashionInfoView:OnUpdateData(data)
	local config = data.mConfig;
	self.mNameText.text = config.name;
	self.mScoreText.text = string.format("%d",data.mScore);
	self.mFashionView:ForceShowView(data);
	self:UpdateButtons(data);

	local attributes = data.mAdditionalAttributes;
	local attributeCount = #attributes;

	self.mAttributeItemViews:ShowView(attributes);
	self.mAttributeView:SetActive(attributeCount > 0);

	local styleViews = self.mStyleItemViews;
	local styleViewsRoot = self.mStyleView;
	local position = styleViewsRoot.localPosition;
	position.y = mStyleViewPosY[attributeCount] or 100;
	styleViewsRoot.localPosition = position;

	styleViews:ShowView(data:GetStyles());

	self:UpdateUseView(config.uses,data.mStar);

	self.mBaseAttributeView:ForceShowView(data.mBaseAttribute);
end

local mUseNames = {
	mLanguage.fashion_use_1,
	mLanguage.fashion_use_2,
	mLanguage.fashion_use_3,
	mLanguage.fashion_use_4,
	mLanguage.fashion_use_5,
	mLanguage.fashion_use_6,
	mLanguage.fashion_use_7,
	mLanguage.fashion_use_8,
	mLanguage.fashion_use_9,
	mLanguage.fashion_use_10,
	mLanguage.fashion_use_11,
	mLanguage.fashion_use_12,
	mLanguage.fashion_use_13,
	mLanguage.fashion_use_14,
	mLanguage.fashion_use_15,
	mLanguage.fashion_use_16
}

function FashionInfoView:UpdateUseView(totalUses,star)
	local text = mLanguage.fashion_use;
	for i,v in ipairs(totalUses) do
		local actived_star = v.actived_star;
		local actived = star >= actived_star;
		if actived then
			text = string.format(text.."%s,",mUseNames[v.type]);
		else
			text = string.format(text.."%s"..mLanguage.fashion_active_star..",",mUseNames[v.type],actived_star);
		end
		
	end
	self.mUseView.text = text;
end

return FashionInfoView;