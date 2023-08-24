local mLuaClass = require "Core/LuaClass"
local mGameModelManager = require "Manager/GameModelManager"
local TalentAttributeItem = require "Module/Talent/TalentAttributeItem"
local mFollowerController = require "Module/Follower/FollowerController"
local mFollowerItemView = require "Module/CommonUI/CommonFollowerItemView"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local FollowerBreakLevelView = mLuaClass("FollowerBreakLevelView", mCommonTabBaseView);
local mLanguageUtil = require "Utils/LanguageUtil"
local mString = string;

function FollowerBreakLevelView:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_break_level_view",
	};
end

function FollowerBreakLevelView:Init()
	self:SetParent(self.mGoParent);
	
	self.mSlider = self:FindComponent('Slider', 'Slider');
	self.mTextExp = self:FindComponent('Text_exp', 'Text');
	self.mTextCost = self:FindComponent('Text_cost', 'Text');
	self.mTextLevel1 = self:FindComponent('Text_lv_1', 'Text');
	self.mTextLevel2 = self:FindComponent('Text_lv_2', 'Text');

	self.mFollowerItem1 = mFollowerItemView.LuaNew(self:Find('retinue_1').gameObject);
	self.mFollowerItem2 = mFollowerItemView.LuaNew(self:Find('retinue_2').gameObject);

	local attri_list = {};
	local mPath = 'attri%d';
	for i = 1, 3 do
		attri_list[i] = TalentAttributeItem.LuaNew(self:Find(mString.format(mPath, i)).gameObject);
	end
	self.mAttriList = attri_list;

	self:FindAndAddClickListener('Guide_Break_Up', function() self:OnClickButton() end, nil , 0.3);
end

function FollowerBreakLevelView:OnClickButton(  )
	local data = self.mData;
	local upCost = data:GetUpgradeNeed();
	local yueLi = mGameModelManager.RoleModel:GetYueLi();
	mFollowerController:SendFollowerUpLevel(data.mUID, yueLi >= upCost and upCost or yueLi);
end

function FollowerBreakLevelView:OnUpdateUI(data)
	self.mData = data;
	
	self:UpdateSubView(data);
	self:ShowAttribute(data);
end

function FollowerBreakLevelView:UpdateSubView( data )
	self.mFollowerItem1:ExternalUpdateData(data);
	self.mFollowerItem2:ExternalUpdateData(data:GetNextLevelClone());

	self.mTextExp.text =  data:GetExpStr( );
	self.mSlider.value = data:GetExpRate( );
	self.mTextCost.text = data:GetUpgradeNeed();
	self.mTextLevel1.text = data:GetLevel();
	self.mTextLevel2.text = data:GetLevel() + 1;
end

function FollowerBreakLevelView:ShowAttribute( data )
	local bentiAttr = data:GetBenTiAttri( );
	local attriList = self.mAttriList;
	for k, v in pairs(attriList) do
		local cur = bentiAttr[k];
		local nex = cur + data:GetUpAddAttri(k);
		v:UpdateUITo(k, cur, nex);
	end
end

function FollowerBreakLevelView:Dispose( )
	
end

return FollowerBreakLevelView;