local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum";
local mUIManager = require "Manager/UIManager"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBaseVindow = require "Core/BaseWindow"
local MansionController = require "Module/Mansion/MansionController"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local mCommonPlayerHeadView = require "Module/CommonUI/CommonPlayerHeadView"
local MansionBaseInfoView = mLuaClass("MansionBaseInfoView", mBaseVindow);

function MansionBaseInfoView:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_base_info_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
	};
end

function MansionBaseInfoView:Init()
	self.mTextName = self:FindComponent('Text_name', 'Text');
	self.mTextLevel = self:FindComponent('Text_level', 'Text');
	self.mTextTotalMoney = self:FindComponent('Text_total_money', 'Text');
	self.mTextTodayRoom = self:FindComponent('Text_today_boom', 'Text');
	self.mTextTodayMoney = self:FindComponent('Text_today_money', 'Text');

	self.mSlider = self:FindComponent('Slider', 'Slider');
	local textCost = self:FindComponent('bottom/Text_alter_cost', 'Text');
	textCost.text = mConfigSysglobal_value[mConfigGlobalConst.MANSION_CHANGE_NAME_GOLD];

	self.mPlayerItem = mCommonPlayerHeadView.LuaNew(self:Find('player_item').gameObject);

	self:FindAndAddClickListener('bottom/button_atler_name',function() self:OnClickAlterName() end);
	self.mBottom = self:Find('bottom').gameObject;
end

function MansionBaseInfoView:OnViewShow( data )
	self.mData = data;

	self.mTextName.text = data:GetMansionName();
	self.mTextLevel.text = data:GetMansionLevel();
	self.mTextTotalMoney.text = data:GetTotalMoney();
	self.mTextTodayRoom.text = data:GetTodayBoom();
	self.mTextTodayMoney.text = data:GetTodayMoney();
	self.mSlider.value = data:GetBoomRate();
	self.mPlayerItem:SetInfo(data:GetPlayerItemVO());
	self.mBottom:SetActive(data:IsSelfMansion());
end

function MansionBaseInfoView:OnClickAlterName( )
	local data = {};
	data.mCost = mConfigSysglobal_value[mConfigGlobalConst.MANSION_CHANGE_NAME_GOLD];
	data.mCallBack = function ( name )
		MansionController:SendAlterMansionName(name);
	end
	mUIManager:HandleUI(mViewEnum.CommonAlterNameView, 1, data);
end

return MansionBaseInfoView;