local mLuaClass = require "Core/LuaClass"
local mLeadBaseVO = require "Module/Lead/LeadBaseVO"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonGoodsVO = require"Module/CommonUI/CommonGoodsVO";
local mFollowerController = require "Module/Follower/FollowerController"
local LeadSkillHuangqinView = require "Module/Lead/LeadSkillHuangqinView"
local LeadSkillDonggongView = require "Module/Lead/LeadSkillDonggongView"
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView";
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local mCommonToggleButton = require 'Module/CommonUI/TabView/CommonToggleButton';
local LeadSkillView = mLuaClass("LeadSkillView", mCommonTabBaseView);
local mString = require "string";
local mSuper;

function LeadSkillView:InitViewParam()
	return {
		["viewPath"] = "ui/lead/",
		["viewName"] = "lead_skill_view",
	};
end

function LeadSkillView:Init()
	local trans = self.mTransform;
	self.mView1 = LeadSkillHuangqinView.LuaNew(1, trans, self);
	self.mView2 = LeadSkillDonggongView.LuaNew(2, trans, self);
	self.mEffectNode = self:Find("effect");

	local clickPowerBack = function(index)
		self:OnClickPower(index);
	end

	local power_btns = {};
	for i = 1, 5 do
		power_btns[i] = mCommonToggleButton.LuaNew(i, self:Find('buttonView/Button'..i).gameObject, clickPowerBack);
	end
	self.mPowerButtonList = power_btns;

	self.mTextCostNumber = self:FindComponent('goods1/Text', 'Text')
	local costItem =  mCommonGoodsItemView.LuaNew(self:Find('goods1').gameObject);
	costItem:ExternalUpdate(mCommonGoodsVO.LuaNew(mConfigSysglobal_value[mConfigGlobalConst.SKILL_UPGRADE_COST], 1));

	self:FindAndAddClickListener("button_up", function() self:OnClickUpgrade() end, nil, 0.3);

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_GOODS_UPDATE, function()
         self:UpdateLeftCost();
    end, true);
    self:RegisterEventListener(mEventEnum.ON_LEAD_SKILL_CHANGE, function(vo)
		self:OnUpdateUI(vo);
	end, true);
end

local mUpEffectPath = 'ui_follower_skill_view_image_4';
local mMainLayer = mMainLayer
function LeadSkillView:GetUpEffect(  )
	local effect = self.mLoadEffect;
	if not effect then
		self.mLoadEffect = true;
        self:AddUIEffect(mUpEffectPath, self.mEffectNode,mMainLayer);
	end
	return self.mEffectNode;
end

function LeadSkillView:OnClickPower(power)
	if self.mPowerID == power then
		return;
	end
	local lead_vo = self.mData;
	local index =  lead_vo:GetSkillLineByPower(power);
	mFollowerController:SendLeadSkillChange(power, index);
end

function LeadSkillView:OnClickUpgrade()
	mFollowerController:SendLeadSkillOpen(self.mPowerID);
end

function LeadSkillView:UpdateSkillView(data)
	local power = data:GetPowerID();
	local skill_system = mLeadBaseVO:GetSkillSystemByPower(power);

	local inter_view = nil;
	if skill_system == 1 then
		inter_view = self.mView1;
	else
		inter_view = self.mView2;
	end

	local last_view = self.mInterView;
	if inter_view ~= last_view then
		if last_view ~= nil then
			last_view:HideView();
		end
		self.mInterView = inter_view;
	end

	if inter_view.mIsShow and inter_view.mGameObject ~=nil then
		inter_view:OnUpdateUI(data);
	else
		inter_view:ShowView(data);
	end
end

function LeadSkillView:UpdatePowerButton( data )
	local btns = self.mPowerButtonList;
	local last_power = self.mPowerID;
	local cur_power = data:GetPowerID();
	if  last_power ~= cur_power then
		if last_power ~= nil then
			btns[last_power]:SetSelected(false);
		end
		btns[cur_power]:SetSelected(true);
	end
	self.mPowerID = cur_power;
end

function LeadSkillView:UpdateLeftCost(  )
	local goods_id = mConfigSysglobal_value[mConfigGlobalConst.SKILL_UPGRADE_COST];
	local bagModel = mGameModelManager.BagModel;
	local left_number = bagModel:GetGoodsNumberGoodsId(goods_id,bagModel.mTypeEnum.ConSumeType);
	self.mTextCostNumber.text = mString.format('%d/1', left_number);
end

function LeadSkillView:OnUpdateUI(data)
	self.mData = data;

	self:UpdateLeftCost();
	self:UpdatePowerButton(data);
	self:UpdateSkillView(data);
	self.mEffectNode.gameObject:SetActive( false );
end

function LeadSkillView:Dispose(  )
	self.mView1:CloseView( );
	self.mView2:CloseView( );
	self.mLoadEffect = nil;
end

return LeadSkillView;