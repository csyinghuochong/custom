local mLuaClass = require "Core/LuaClass"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local FashionSubView = mLuaClass("FashionSubView", mCommonTabBaseView);
local FashionVO = require "Module/Fashion/FashionVO"
local FashionBaseItemView = require"Module/Fashion/FashionBaseItemView"
local mFashionController = require"Module/Fashion/FashionController"
local CommonItemsView = require"Module/Fashion/Common/CommonItemsView"
local string = string;
local mGameModelManager = require "Manager/GameModelManager"
local mUIGray = require "Utils/UIGray"
local mLanguage = require "Utils/LanguageUtil"

function FashionSubView:OnAwake()
end

function FashionSubView:Init()

	self:FindAndAddClickListener("view/Button",function() self:DoLevelUp() end);

	local btnGraphic = self:FindComponent('view/Button/icon',"Graphic");
	self.mUpGradeButtonGraphic = btnGraphic;
	self.mUpGradeButtonGray = self:InitGrayGraphic(btnGraphic);
	
	self.mBeforeFashionView = FashionBaseItemView.CreateAt(self:Find('view/fashion_view_before'));
	self.mAfterFashionView = FashionBaseItemView.CreateAt(self:Find('view/fashion_view_after'));
	self.mMaxLevelFashionView = FashionBaseItemView.CreateAt(self:Find('max_level_view/fashion_view'));

	self.mNewFashionVo = FashionVO.LuaNew();
	self:RegisterEventListener(self.mEventEnum.ON_UPDATE_FASHION_INFO, function(data) self:OnUpdateUI(data); end,true);
	self:RegisterEventListener(self.mEventEnum.ON_GOODS_UPDATE, function() self:OnGoodsUpdate(); end,true);


	local viewRoot = self:Find("view").gameObject;
	local maxViewRoot = self:Find("max_level_view").gameObject 

	viewRoot:SetActive(false);
	maxViewRoot:SetActive(false);

	self.mViewRoot = viewRoot;
	self.mMaxViewRoot = maxViewRoot;

	self:OnAwake();
end

function FashionSubView:Dispose()
	self:OnDispose();
	self.mBeforeFashionView:CloseView();
	self.mAfterFashionView:CloseView();
	self.mMaxLevelFashionView:CloseView();

	self.mBeforeFashionView = nil;
	self.mAfterFashionView = nil;
	self.mMaxLevelFashionView = nil;
end

function FashionSubView:OnDispose()
end

function FashionSubView:InitGrayGraphic(graphic)
	return mUIGray.LuaNew():InitGraphic(graphic);
end

function FashionSubView:GetGoodsNumber(id)
	local bag = mGameModelManager.BagModel;
	local goodsVo = bag:GetGoodsByGoodsId(id);
	if goodsVo then
		return goodsVo.mNumber;
	end
	return 0;
end

function FashionSubView:OnGoodsUpdate()
	local data = self.mData;
	if data then
		self:OnUpdateUI(data);
	end
end

function FashionSubView:DoLevelUp()

end

function FashionSubView:IsMaxLevel(data)
	return false;
end

function FashionSubView:GetUpGradeCost(data)
	return nil;
end

function FashionSubView:CanUpGrade(data)

	local info = self:GetUpGradeCost(data);
	if info then
		return data:CheckEnoughGoods(info.cost);
	end

	return false;
end

function FashionSubView:UpdateView(data)
	-- body
end

function FashionSubView:UpdateMaxLevelView(data)
	-- body
end

function FashionSubView:SendLevelUp(use_goods)
    local data = self.mData;
	mFashionController:SendLevelUp(data,use_goods);
end

function FashionSubView:SendStarUp()
    local data = self.mData;
	mFashionController:SendStarUp(data);
end

function FashionSubView:SendQualityUp()
    local data = self.mData;
	mFashionController:SendQualityUp(data);
end

function FashionSubView:SendWash()
    local data = self.mData;
	mFashionController:SendWash(data);
end

function FashionSubView:SendSaveWash(flag)
    local data = self.mData;
	mFashionController:SendSaveWash(data,flag);
end

function FashionSubView:SendXuanguang()
    local data = self.mData;
	mFashionController:SendXuanguang(data);
end

function FashionSubView:UpdateUpGradeButton(data)
	local canUpgrade = self:CanUpGrade(data);
	self.mUpGradeButtonGraphic.raycastTarget = canUpgrade;
	self.mUpGradeButtonGray:SetGray(canUpgrade == false);
end

function FashionSubView:OnUpdateUI(data)
	self.mData = data;
	if not data or data .mActived == false then
		self.mViewRoot:SetActive(false);
		self.mMaxViewRoot:SetActive(false);
		return;
	end

	local isMaxLevel = self:IsMaxLevel(data);
	self.mViewRoot:SetActive(isMaxLevel == false);
	self.mMaxViewRoot:SetActive(isMaxLevel);

	if isMaxLevel then
		self:UpdateMaxLevelView(data);
	else
		self:UpdateView(data);
		self:UpdateUpGradeButton(data);
	end
end

function FashionSubView:ShowUpGradeCostView(data)
	local info = self:GetUpGradeCost(data);
	if info then
		self.mConstItemViews:ShowView(info.cost);
	else
		self.mConstItemViews:HideView();
	end
end

function FashionSubView:InitItemsView(rootName,viewTypeName)
	return CommonItemsView.InitItemViews(self:Find(rootName),viewTypeName);
end

function FashionSubView:CreateItemsView(rootName,viewTypeName,itemCount)
	return CommonItemsView.CreateItemViews(self:Find(rootName),viewTypeName,itemCount);
end

function FashionSubView:UpdateSucceedRateView(rate)
	self.mSucceedRateText.text = string.format(mLanguage.common_succeed_rate..":%d",rate/100).."%";
end

return FashionSubView;