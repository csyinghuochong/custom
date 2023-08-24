local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mQueueWindow = require "Core/QueueWindow"
local mGameModelManager = require "Manager/GameModelManager"
local mModelShowView = require "Module/Story/ModelRenderTexture"
local mFollowerFeatureView = require "Module/Lead/LeadFeatureView"
local mCommonTabView = require "Module/CommonUI/TabView/CommonTabView"
local mGameTimer = require "Core/Timer/GameTimer"
local LeadView = mLuaClass("LeadView", mQueueWindow);
local mString = require 'string'

function LeadView:InitViewParam()
	return {
		["viewPath"] = "ui/lead/",
		["viewName"] = "lead_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
		["PlayAnimation"] = true,
		["cost"] = {"gold","silver","dress_coin"},
	};
end

function LeadView:Init()
	self:InitSubView();
	self:AddListener();
end

function LeadView:AddListener( )
	self:FindAndAddClickListener("c_bg/Button_close",function() self:ReturnPrevQueueWindow() end);
	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_UPDATE_EQUIPED_FASHIONS, function(fashions) self:OnReplaceSuit(fashions); end,true);
	self:RegisterEventListener(mEventEnum.ON_REPLACE_FASHION, function(fashion) self:OnReplace(fashion); end,true);
	self:RegisterEventListener(mEventEnum.ON_CLICK_BFASHION_ITEM, function(item) self:OnReplace(item.mData); end,true);
end

function LeadView:OnReplaceSuit(fashions)
	self.mModelShowView:ReplaceSuit(fashions);
end

function LeadView:OnReplace(fashion)
	self.mModelShowView:Replace(fashion);
end

function LeadView:InitSubView()
	local buttonList = {};
	local mPath = 'tabView/buttonView/Button%d'
	for i = 1, 4 do
		buttonList[i] = self:Find(mString.format(mPath, i));
	end
	self.mButtonList = buttonList;

	local view_vo_list = {
		{luaClass="Module/Lead/LeadInfoView"},
		{luaClass="Module/Lead/LeadSkillView"},
		{luaClass="Module/Lead/LeadTrainView"},
		{luaClass="Module/Lead/LeadFashionView"},
	}

	self.mFollowerData = mGameModelManager.FollowerModel:GetLeadVO();
	local getDataBack = function()
		return self.mFollowerData;
	end
	local clickButtonBack = function ( index )
		self:OnClickButtonItem(index);
	end
	self.mTabView = mCommonTabView.LuaNew(self:Find('tabView'), view_vo_list, clickButtonBack, getDataBack);
	self.mTabView:OnClickToggleButton(1, false);

	local modelView = mModelShowView.LuaNew(self:Find("model"),true,600,600);
	modelView:OnUpdateVO( self.mFollowerData );	
	self.mModelShowView = modelView;
	self.mFollowerFeatureView =  mFollowerFeatureView.LuaNew(self:Find('featureView').gameObject);
end

function LeadView:OnViewShow(logicParams)
	self.mTabView:ShowView();

	if logicParams ~= nil and logicParams.jumpParams ~= nil then
       self.mTabView:OnClickToggleButton((logicParams.jumpParams), false);
	end

	local index = self.mTabView.mSelectIndex;
	self:OnClickButtonItem( index );
end

local LeadCostList = {{cost={}},{cost={}},{cost={}},{cost={"gold","silver","dress_coin"}}};
function LeadView:CheckCostView( index )
	self:HandleWindowCostUI(1,LeadCostList[index]);
end

function LeadView:OnViewHide()
	self.mTabView:HideView();
	self.mModelShowView:HideView();
	self.mFollowerFeatureView:HideView();
end

function LeadView:Dispose()
	self.mTabView:CloseView();
	self.mModelShowView:Dispose();
	self.mFollowerFeatureView:CloseView();
end

function LeadView:OnClickButtonItem(index)
	self:CheckCostView( index );
	self:CheckShowSubView(index);
end

function LeadView:CheckShowSubView(selectIndex)
	local data = self.mFollowerData;
	local modelView = self.mModelShowView;
	local featureViewView = self.mFollowerFeatureView;

	local showModel = false;
	if selectIndex == 2 then
		showModel = false;
	else
		showModel = true;
	end

	if showModel then
		modelView:ShowView();
		modelView:ReplaceSuit(data:GetEquipedFashions());
		featureViewView:ShowView();
		featureViewView:OnUpdateUI(data);
	else
		modelView:HideView();
		featureViewView:HideView();
	end
end

return LeadView;