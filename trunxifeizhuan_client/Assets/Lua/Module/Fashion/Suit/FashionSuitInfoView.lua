local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local FashionSuitInfoView = mLuaClass("FashionSuitInfoView", mBaseView);

local FashionAttributeItemView = require"Module/Fashion/FashionAttributeItemView"
local ipairs = ipairs;
local string = string;
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"

local CommonItemsView = require"Module/Fashion/Common/CommonItemsView"
local mFashionController = require"Module/Fashion/FashionController"
local mUIGray = require "Utils/UIGray"

local mGameModelManager = require "Manager/GameModelManager"

function FashionSuitInfoView:Init()

	self.mNameText = self:FindComponent("suit_name","Text");
	self.mDescribeText = self:FindComponent("suit_describe","Text");
	self.mSkillText = self:FindComponent("skill/describe","Text");
	self.mAffectText = self:FindComponent("affect/describe","Text");

	self.mAttributeItemViews = CommonItemsView.InitItemViews(self:Find("attributes/item_list"),"Module/Fashion/FashionAttributeItemView");

	self.mComponentViews = CommonItemsView.InitItemViews(self:Find("components/item_list"),"Module/Fashion/Suit/FashionSuitComponentView");

	local clickCallback = function ()
		self:OnClickReplaceSuit();
	end
	self:FindAndAddClickListener("Button",clickCallback);
	local btnGraphic = self:FindComponent('Button/on_normal',"Graphic");
	self.mButtonGray = mUIGray.LuaNew():InitGraphic(btnGraphic);
	self.mButtonGraphic = btnGraphic;	
end

function FashionSuitInfoView:Dispose()
	self.mAttributeItemViews:Dispose();
	self.mComponentViews:Dispose();

	self.mAttributeItemViews = nil;
	self.mComponentViews = nil;
end

function FashionSuitInfoView:OnUpdateFashion(fashion)
	local data = self.mData;
	if data then
		self:OnUpdateData(data);
	end 
end

function FashionSuitInfoView:OnClickReplaceSuit()

	local components = self.mComponentViews.mViews;
	local fashions = {}
	for k,v in pairs(components) do
		local fashion = v.mData;
		if fashion.mActived == false then
			return;
		end
		fashions[k] = fashion;
	end

	local equipedFashions = mGameModelManager.FashionModel:GetEquipedFashions();
	for i,v in ipairs(fashions) do
		if v ~= equipedFashions[i] then
			change = true;
		end
	end
	if change then
		mFashionController:SendEquipFashions(fashions);
	end
end

function FashionSuitInfoView:OnViewShow(data)
	self.mData = data;
	self:OnUpdateData(data);
end

function FashionSuitInfoView:OnUpdateData(data)
	local config = data.mConfig;
	local id = data.mId;

	self.mNameText.text = config.name;
	self.mDescribeText.text = config.describe;
	self.mSkillText.text = config.skill_describe;
	self.mAffectText.text =  config.affect_describe;

	self.mAttributeItemViews:ShowView(data:GetAttributes());

	local isTotalActived = true;
	local componentViews = self.mComponentViews;
	local components = data.mConfig.components;
	local mFashionModel = mGameModelManager.FashionModel;
	for i,v in ipairs(components) do
		local fashion = mFashionModel:GetFashion(v);
		if fashion.mActived == false then
			isTotalActived = false;
		end
		componentViews:UpdateItemViewByIndex(i,fashion);
	end

	self.mButtonGray:SetGray(isTotalActived == false);
	self.mButtonGraphic.raycastTarget = isTotalActived; 
end


return FashionSuitInfoView;