local mLuaClass = require "Core/LuaClass"
local mGlobalUtil = require "Utils/GlobalUtil"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local TalentItemBaseView = require "Module/Talent/TalentItemBaseView"
local TalentStudyCostItem = mLuaClass("TalentStudyCostItem",mLayoutItem);
local mColor = Color;
local mSuper = nil;

function TalentStudyCostItem:InitViewParam()
	return {
		["viewPath"] = "ui/talent/",
		["viewName"] = "talent_study_cost_item",
	};
end

function TalentStudyCostItem:Init()
	self.mTextAtribute = self:FindComponent( 'Text_add_attri', 'Text' );
	self.mTalentItem1 = TalentItemBaseView.LuaNew( self:Find('talent_1').gameObject );
	self:FindAndAddClickListener("button_bg", function() self:OnClickTalentItem() end);

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function TalentStudyCostItem:OnUpdateData()
	self:UpdateUI();
end

function TalentStudyCostItem:UpdateUI()
	local data = self.mData;
	self.mTextAtribute.text = data:GetOtherAttributeStr( );
	self.mTalentItem1:ExternalUpdate( data );
end

function TalentStudyCostItem:ExternalUpdateData(data)
	self.mData = data;

	self:UpdateUI();
end

function TalentStudyCostItem:OnClickTalentItem()
	self:Dispatch(self.mEventEnum.ON_SELECT_STUDY_ITEM, self.mData);
end

return TalentStudyCostItem;