local mLuaClass = require "Core/LuaClass"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mCommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local mFollowerController = require "Module/Follower/FollowerController"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local mConfigSysfollower_train = require "ConfigFiles/ConfigSysactor_train"
local CommonGoodsNeedItemView = require "Module/CommonUI/CommonGoodsNeedItemView"
local LeadTrainView = mLuaClass("LeadTrainView",mCommonTabBaseView);
local mString = require 'string'

function LeadTrainView:InitViewParam()
	return {
		["viewPath"] = "ui/lead/",
		["viewName"] = "lead_train_view",
	};
end

function LeadTrainView:Init()
	self.mTransStrength = self:Find('strength/Image_exp');
	self.mTransAttack = self:Find('attack/Image_exp');
	self.mTransDefense = self:Find('defense/Image_exp');
	self.mTextStrength = self:FindComponent('strength/Text_add', 'Text');
	self.mTextAttack = self:FindComponent('attack/Text_add', 'Text');
	self.mTextDefense = self:FindComponent('defense/Text_add', 'Text');
	self.mTextStrengthRate = self:FindComponent('strength/Text_value', 'Text');
	self.mTextAttackRate = self:FindComponent('attack/Text_value', 'Text');
	self.mModelDefenseRate =self:FindComponent('defense/Text_value', 'Text');

	self.mImageSelect1 = self:Find('Button_general/select').gameObject;
	self.mImageSelect2 = self:Find('Button_advance/select').gameObject;
	self.mImageGeneral = self:Find('Button_general');
	self.mImageAdvance = self:Find('Button_advance');

	self.mGoodsItem = CommonGoodsNeedItemView.LuaNew(self:Find('view1/goods').gameObject);

	self:FindAndAddClickListener("Button_general", function() self:OnClickGeneralTrain() end,"ty_0204");
	self:FindAndAddClickListener("Button_advance", function() self:OnClickAdvancedTrain() end,"ty_0204");
	self:FindAndAddClickListener("view1/Button", function() self:OnClickTrainOne() end);

	self:FindAndAddClickListener("view2/button_giveup", function() self:OnClickGiveUp() end);
	self:FindAndAddClickListener("view2/button_save", function() self:OnClickSave() end);

	self.mView1 = self:Find('view1').gameObject;
	self.mView2 = self:Find('view2').gameObject;

	self.mButtonGiveUp = self:Find('view2/button_giveup').gameObject;
	self.mButtonSave = self:Find('view2/button_save');

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_LEAD_TRAIN, function(vo)
		self:OnUpdateUI(vo);
	end, true);

	self:RegisterEventListener(mEventEnum.ON_LEAD_TRAIN_OP, function(vo)
		self:OnUpdateUI(vo);
	end, true);
end

function LeadTrainView:OnUpdateUI(data)
	self.mData = data;
	
	local train_type =self.mTrainType;
	if train_type == nil or train_type == 1 then
		self:OnClickGeneralTrain();
	else
		self:OnClickAdvancedTrain();
	end

	self:UpdateTrainAttr(data);
end

local mColor_1 = Color.New(36 / 255, 167 / 255, 109 / 255);
local mColor_2 = Color.New(238 / 255, 85 / 255, 92 / 255);
local mVector_1 = Vector3.New(291.7, -232.5, 0);
local mVector_2 = Vector3.New(204.3, -232.5, 0);
function LeadTrainView:UpdateTrainAttr( data )
	local wait_op = data.mWaitOperate == true;
	self.mView1:SetActive(not wait_op);
	self.mView2:SetActive(wait_op);

	local text1 = self.mTextStrength;
	local text2 = self.mTextAttack;
	local text3 = self.mTextDefense;
	if wait_op then
		local temp_attri = data.mTrainTemp;
		local train_attri = data:GetTrainInfo();

		local value1 = temp_attri[1] - train_attri[1];
		local value2 = temp_attri[2] - train_attri[2];
		local value3 = temp_attri[3] - train_attri[3];
		text1.text = (value1 >= 0 and '+' or '')..value1;
		text2.text = (value2 >= 0 and '+' or '')..value2;
		text3.text = (value3 >= 0 and '+' or '')..value3;

		text1.color = value1 >= 0 and mColor_1 or mColor_2;
		text2.color = value2 >= 0 and mColor_1 or mColor_2;
		text3.color = value3 >= 0 and mColor_1 or mColor_2;

		local train_type = self.mTrainType;
		self.mButtonGiveUp:SetActive(train_type == 1);
		self.mButtonSave.localPosition = train_type == 1 and mVector_1 or mVector_2;
	else
		text1.text = '';
		text2.text = '';
		text3.text = '';
	end
end

function LeadTrainView:OnClickGiveUp(  )
	mFollowerController:SendTrainOperation(self.mTrainType, 0);
end

function LeadTrainView:OnClickSave(  )
	mFollowerController:SendTrainOperation(self.mTrainType, 1);
end

function LeadTrainView:SetSelectType(train_type, parent)
	self.mTrainType = train_type;

	self:UpdateCost(train_type);
	self:UpdateSelectState(train_type);
	self:UpdateAddAttribute();
end

function LeadTrainView:OnClickAdvancedTrain()
	self:SetSelectType(2, self.mImageAdvance);
end

function LeadTrainView:OnClickGeneralTrain()
	self:SetSelectType(1, self.mImageGeneral);
end

function LeadTrainView:UpdateSelectState(train_type)
	self.mImageSelect1:SetActive(train_type == 1);
	self.mImageSelect2:SetActive(train_type == 2);
end

function LeadTrainView:UpdateAddAttribute()
	local data = self.mData;
	local star_vo = data:GetTrainLimit();
	local train_attri = data:GetTrainInfo();

	self.mTextStrengthRate.text = mString.format('%d/%d', train_attri[1], star_vo.train_health);
	self.mTextAttackRate.text = mString.format('%d/%d', train_attri[2], star_vo.train_attack);
	self.mModelDefenseRate.text = mString.format('%d/%d', train_attri[3], star_vo.train_defense);
	local rate1 = train_attri[1] / star_vo.train_health;
	local rate2 = train_attri[2] / star_vo.train_attack;
	local rate3 = train_attri[3] / star_vo.train_defense;
	self.mTransStrength.localScale = Vector3.New(rate1 > 1 and 1 or rate1, 1, 1);
	self.mTransAttack.localScale = Vector3.New(rate2 > 1 and 1 or rate2, 1, 1);
	self.mTransDefense.localScale = Vector3.New(rate3 > 1 and 1 or rate3, 1, 1);
end

--1普通一次2精华一次3精华十次
function LeadTrainView:UpdateCost(train_type)
	local cost_one = mConfigSysfollower_train[train_type].cost;
	self.mGoodsItem:ExternalUpdate(mCommonGoodsVO.LuaNew(cost_one[1].goods_id, 1));
end

function LeadTrainView:OnClickTrainOne()
	self:SendRoleTrain(self.mTrainType);
end

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgGoodsNoEnough = mLanguageUtil.common_goods_no_enough;
function LeadTrainView:SendRoleTrain( train_type )
	local cost = mConfigSysfollower_train[train_type].cost;
	if mGameModelManager.BagModel:CheckGoodsIsEnough(cost) then
		mFollowerController:SendRoleTrain(train_type);
	else
		mCommonTipsView.Show(mLgGoodsNoEnough);
	end
end

return LeadTrainView;
