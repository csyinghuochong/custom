local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mModelShowView = require "Module/Story/ModelRenderTexture"
local mFollowerAttributeView = require "Module/Follower/FollowerAttributeView"
local mLayoutController = require "Core/Layout/LayoutController"
local mConfigSyspromote = require "ConfigFiles/ConfigSyspromote"
local mSortTable = require "Common/SortTable"
local mCommonSkillVO = require "Module/CommonUI/CommonSkillVO"
local mGameModelManager = require "Manager/GameModelManager"
local mConfigSysexp = require "ConfigFiles/ConfigSysexp"
local CheckPropertyView = mLuaClass("CheckPropertyView", mQueueWindow);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgCombat = mLanguageUtil.common_combat;
function CheckPropertyView:InitViewParam()
	return {
		["viewPath"] = "ui/check/",
		["viewName"] = "check_property_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function CheckPropertyView:Init()
	self.mGoModel = self:Find('model').gameObject;

	self.mModelShowView = mModelShowView.LuaNew(self:Find('model'));
	self.mTextCombat = self:FindComponent('c_bg1/Text_combat','Text');

	self:InitProperty();

	self:FindAndAddClickListener("c_bg/Button_close",function()self:OnClickClose();end);
end

function CheckPropertyView:InitProperty()
	self.mTextPosition = self:FindComponent('featureView/Property/TextGroup/Text_position','Text');
	self.mAttributeView = mFollowerAttributeView.LuaNew(self:Find('featureView/Property/TextGroup').gameObject);

	local parentSkill = self:Find('featureView/Property/scrollViewSkill/Grid');
	self.mGridSkill = mLayoutController.LuaNew(parentSkill, require 'Module/Check/CheckSkillItem');

	self.mTextExp = self:FindComponent('featureView/Property/TextGroup/Text_exp','Text');
	self.mSliderBasicExp = self:FindComponent("featureView/Property/Slider_exp/Slider","Slider");
end

function CheckPropertyView:OnClickClose()
	self:ReturnPrevQueueWindow();
end

function CheckPropertyView:OnViewShow(data)
	self:CreateLeft(data);
	self:CreateProperty(data);
end

function CheckPropertyView:CreateLeft(data)
	self.mGoModel:SetActive(true);
	self.mModelShowView:OnUpdateLead(data.sex );
	self.mTextCombat.text = mLgCombat..data.combat;
end

function CheckPropertyView:CreateProperty(data)
	self.mTextPosition.text = self:GetPositionStr(data.sex,data.position);
	local playerVO = mGameModelManager.CheckModel.mPlayerVO;
	self.mAttributeView:OnUpdateUI(playerVO);

	local data_soure = mSortTable.LuaNew(nil,nil,true);
	for k,v in ipairs(playerVO.mSkillToIndex) do
		v.mIsDetial = true;
		data_soure:AddOrUpdate(v.mID,v);
	end
	self.mGridSkill:UpdateDataSource(data_soure);

	self.mTextExp.text = playerVO.mExp..'/'..self:GetPlayerMaxExp(data.level);
	self.mSliderBasicExp.value = (playerVO.mExp/self:GetPlayerMaxExp(data.level)) * 100;
end

function CheckPropertyView:GetPositionStr(sex,position)
	if sex == 1 then
		return mConfigSyspromote[position].man_name;
	else
		return mConfigSyspromote[position].woman_name;
	end
end

function CheckPropertyView:GetPlayerMaxExp(level)
	return mConfigSysexp[level].lead_exp;
end

function CheckPropertyView:OnViewHide()
	self.mModelShowView:HideView();
end

function CheckPropertyView:Dispose()
	self.mGridSkill:Dispose();
end

return CheckPropertyView;