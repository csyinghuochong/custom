local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local FashionSuitView = mLuaClass("FashionSuitView", mQueueWindow);
local mCommonToggleGroup = require "Module/CommonUI/TabView/CommonToggleGroup"
local LayoutController = require "Core/Layout/LayoutController"
local FashionSuitItemView = require"Module/Fashion/Suit/FashionSuitItemView"
local FashionSuitInfoView = require"Module/Fashion/Suit/FashionSuitInfoView"
local mGameModelManager = require "Manager/GameModelManager"
local ModelRenderTexture = require "Module/Story/ModelRenderTexture"
local FashionInfoView = require"Module/Fashion/FashionInfoView"

function FashionSuitView:InitViewParam()
	return {
		["viewPath"] = "ui/fashion/",
		["viewName"] = "fashion_suit_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function FashionSuitView:Init()
	self:FindAndAddClickListener("c_bg/Button_close",function() self:ReturnPrevQueueWindow() end);
	local go = self:Find('toggleView/buttonView');
	local callBack = function (index)
		self:ShowItemListView(index);
	end
	self.mToggleGroup = mCommonToggleGroup.LuaNew(go,callBack,2);
	self:InitModelView();
	self:InitSuitInfoView();

	local role_name = self:FindComponent("bg2/Text_name","Text");
	role_name.text = mGameModelManager.RoleModel.mPlayerBase.name;
	
	self.mCampText = self:FindComponent("bg2/Image_power","Image");

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_SELECT_SUIT_COMPONENT, function(item) self:OnSelectSuitComponent(item); end,true);
	self:RegisterEventListener(mEventEnum.ON_SELECT_SUIT_ITEM, function(item) self:OnSelectSuit(item); end,true);
	self:RegisterEventListener(mEventEnum.ON_REPLACE_FASHION, function(fashion) self:OnClickReplace(fashion); end,true);
	self:RegisterEventListener(mEventEnum.ON_UPDATE_FASHION_INFO, function(data) self.mSuitInfoView:OnUpdateFashion(data) end,true);
end

function FashionSuitView:InitModelView()
	local modelView = ModelRenderTexture.LuaNew(self:Find("model"));
	modelView:OnUpdateLead( mGameModelManager.RoleModel.mPlayerBase.sex,nil);
	self.mModelView = modelView;
end

function FashionSuitView:InitSuitInfoView()
	self.mSuitInfoView = FashionSuitInfoView.LuaNew(self:Find("infoView").gameObject);
end

function FashionSuitView:OnClickReplace(fashion)
	self.mModelView:Replace(fashion);
	self:HideFashionInfoView();
	mGameModelManager.FashionModel:SetTempFashion(fashion);
end

function FashionSuitView:ShowItemListView(index)

	local suitDataSource = mGameModelManager.FashionModel:GetSuitDataSource();
	local dataSource = suitDataSource[index];
	local itemListView = self.mItemListView;
	if not itemListView then
		itemListView = LayoutController.LuaNew(self:Find("bagView/item_list/Content"),FashionSuitItemView);
		itemListView:SetSelectedViewTop(true);
		self.mItemListView = itemListView;
	end

	if dataSource then
		local first = dataSource.mSortTable[1];
		local callBack = nil;
		if first then
			callBack = function ()
				itemListView:SetViewSelectedByKey(first.mId,true);
			end
		end
		itemListView:UpdateDataSource(dataSource,callBack);
	end
end

function FashionSuitView:OnSelectSuitComponent(item)
	FashionInfoView.Show(item.mData);
end

function FashionSuitView:HideFashionInfoView()
	FashionInfoView.Hide();
end

function FashionSuitView:OnSelectSuit(item)

	if item.mSelected then
		self.mSuitInfoView:ForceShowView(item.mData);
	end
end

function FashionSuitView:OnViewShow()
	local modelView = self.mModelView;
	modelView:ShowView();
	modelView:ReplaceSuit(mGameModelManager.FashionModel:GetEquipedFashions());
	mGameModelManager.FashionModel:ClearTempEquipedFashions();
	self.mGameObjectUtil:SetImageSprite(self.mCampText,mGameModelManager.FollowerModel:GetLeadVO():GetPowerIcon());
	self.mToggleGroup:SwitchToogle(1);
end

function FashionSuitView:OnViewHide()
	self.mModelView:HideView();
	self:HideFashionInfoView();
	mGameModelManager.FashionModel:ClearTempEquipedFashions();
end

function FashionSuitView:Dispose()
	self.mModelView:Dispose();
	self.mItemListView:Dispose();
	self.mItemListView = nil;
end

return FashionSuitView;