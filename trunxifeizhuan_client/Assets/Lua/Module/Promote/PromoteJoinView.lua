local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mQueueWindow = require "Core/QueueWindow"
local mLanguageUtil = require "Utils/LanguageUtil"
local mPromoteJoinVO = require "Module/Promote/PromoteJoinVO"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonGoodsVO = require"Module/CommonUI/CommonGoodsVO";
local mConfigSyspromote = require "ConfigFiles/ConfigSyspromote";
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mPromoteController = require "Module/Promote/PromoteController"
local ModelRenderTexture = require "Module/Story/ModelRenderTexture"
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView";
local PromoteJoinView = mLuaClass("PromoteJoinView",mQueueWindow);
local mTable = require 'table'
local mString = require 'string'

function PromoteJoinView:InitViewParam()
	return {
		["viewPath"] = "ui/promote/",
		["viewName"] = "promote_join_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function PromoteJoinView:Init()
	self:InitSubView(  );

	self:FindAndAddClickListener("button_ok", function() self:OnClickExamButton() end);
	self:FindAndAddClickListener("Button_close",function() self:ReturnPrevQueueWindow() end);
end

function PromoteJoinView:InitSubView(  )
	local text_condition = {};
	local goods_list = {};
	for i = 1, 2 do
		text_condition[i] = self:FindComponent('Text_condition'..i, 'Text');
	end
	for i = 1, 3 do
		goods_list[i] = mCommonGoodsItemView.LuaNew(self:Find('goods_item'..i).gameObject);
	end
	self.mGoodsItemList = goods_list;
	self.mTextItemCondition = text_condition;
	self.mTextConditionStr = self:FindComponent('Text_2', 'Text');
	self.mPromoteExamNpcView = ModelRenderTexture.LuaNew(self:Find('model'));
	self.mPromoteExamNpcView:OnUpdateUI('r_200111');
end

function PromoteJoinView:ShowExamContion(  )
	local valid_num = 0;
	local text_condition = self.mTextItemCondition;
	local conditions = mPromoteJoinVO:GetExamCondition();
	local totalNumber = #conditions;
	for k, v in pairs(text_condition) do
		local l_condition = conditions[k];
		if l_condition then
			v.text = l_condition.desc;
			valid_num = valid_num + ( l_condition.state and 1 or 0 );
		else
			v.text = '';
		end
	end
	self.mTextConditionStr.text = mString.format( '%s (%d/%d)', self:GetNextOfficeName(), valid_num, totalNumber );
	self.mCanExam = valid_num >= totalNumber;
end

function PromoteJoinView:GetNextOfficeName(  )
	local RoleModel = mGameModelManager.RoleModel;
	local vo = mConfigSyspromote[RoleModel:GetOffice() + 1 ];
	local sex = RoleModel.mPlayerBase.sex;
	return sex == 1 and  vo.man_name or vo.woman_name;
end

function PromoteJoinView:ShowCostGoods(  )
	local cost = mConfigSyspromote[mGameModelManager.RoleModel:GetOffice() ].cost;
	local goods_list = self.mGoodsItemList;
	for k, v in pairs(goods_list) do
		local vo = cost[k];
		if vo ~= nil then
			v:ShowView();
			v:ExternalUpdate(mCommonGoodsVO.LuaNew(vo.goods_id, vo.goods_number));
		else
			v:HideView();
		end
	end
end

function PromoteJoinView:OnViewShow()
	self:ShowCostGoods(  );
	self:ShowExamContion(  );

	self.mPromoteExamNpcView:ShowView();
end

function PromoteJoinView:OnViewHide( )
	self.mPromoteExamNpcView:HideView();
end

function PromoteJoinView:Dispose( )
	self.mPromoteExamNpcView:Dispose();
end

function PromoteJoinView:OnClickExamButton(  )
	if self.mCanExam then
		mPromoteController:SendJoinExam();
	else
		mCommonTipsView.Show( mLanguageUtil.promote_exam_not_active )
	end
end

return PromoteJoinView;