local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mLayoutController = require "Core/Layout/LayoutController"
local mModelShowView = require "Module/Story/ModelRenderTexture"
local mChildTrain = require "Module/Child/ChildTrain"
local mChildAdvance = require "Module/Child/ChildAdvance"
local mCommonToggleGroup = require "Module/CommonUI/TabView/CommonToggleGroup"
local mVector2 = Vector2;
local ChildTrainView = mLuaClass("ChildTrainView", mQueueWindow);

function ChildTrainView:InitViewParam()
	return {
		["viewPath"] = "ui/child/",
		["viewName"] = "child_train_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function ChildTrainView:Init()
	self.mGoTrain = self:Find("RightTrain").gameObject;
	self.mTrain = mChildTrain.LuaNew(self.mGoTrain);
	self.mGoAdvance = self:Find("RightAdvance").gameObject;
	self.mAdvance = mChildAdvance.LuaNew(self.mGoAdvance);
	self:InitLeft();
	self:FindAndAddClickListener("c_bg/Button_close",function() self:ReturnPrevQueueWindow(); end);
	local trans = self:Find("tabView/buttonView");
	self.mToggleGroup = mCommonToggleGroup.LuaNew(trans,function(index)self:OnClickToggle(index);end);

	local mEvent = self.mEventEnum;
	self:RegisterEventListener(mEvent.ON_CHILD_SELECT,function(data)self:OnSelectChild(data);end, true);
end

function ChildTrainView:OnSelectChild(data)
	local model = mGameModelManager.ChildModel;
	model.mSelectData = data;
	self.mTextName.text = data.name;
	local nameWidth = self.mTextName.preferredWidth + 50;
	self.mTranceNameBack.sizeDelta = mVector2(nameWidth,38);
	self.mTextType.text = data:GetChildType();
	self.mModelShowView:OnUpdateVO(data);
	self.mTrain:SetInfo(data);
	self.mAdvance:SetInfo(data);
end

function ChildTrainView:InitLeft()
	local model = mGameModelManager.ChildModel;
	local parent = self:Find("Left/List/scrollView/Grid");
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Child/ChildItemView");
	self.mGridEx:UpdateDataSource(model.mDataSoureChild);
	self.mGridEx:SetSelectedViewTop(true);
	self.mModelShowView = mModelShowView.LuaNew(self:Find("Left/Player/model"));
	self:FindAndAddClickListener("Left/List/BtnAll",function() self:OnClickBtnAll(); end);
	self.mTextName = self:FindComponent("Left/Player/name","Text");
	self.mTranceNameBack = self:Find("Left/Player/nameBack");
	self.mTextType = self:FindComponent("Left/Player/type","Text");
	self.mImgIcon = self:FindComponent("Left/Player/icon","GameImage");

	local data = model.mDataSoureChild.mSortTable[1];
	if data ~= nil then
		self.mGridEx:SetViewSelectedByKey(data.id,true);
		self:OnSelectChild(data);
	end
end

function ChildTrainView:OnClickBtnAll()
	print("ALL");
end

function ChildTrainView:OnClickToggle(index)
	self.mGoTrain:SetActive(index == 1);
	self.mGoAdvance:SetActive(index == 2);
end

function ChildTrainView:OnViewShow(param)
	self.mModelShowView:ShowView();
end

function ChildTrainView:OnViewHide()
	self.mModelShowView:HideView();
end

function ChildTrainView:Dispose()
	self.mModelShowView:Dispose();
end

return ChildTrainView;