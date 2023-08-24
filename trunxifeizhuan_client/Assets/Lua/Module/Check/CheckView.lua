local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mModelShowView = require "Module/Story/ModelRenderTexture"
local mConfigSyspromote = require "ConfigFiles/ConfigSyspromote"
local mCommonPlayerHeadView = require "Module/CommonUI/CommonPlayerHeadView"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mConfigSysexp = require "ConfigFiles/ConfigSysexp"
local mGameModelManager = require "Manager/GameModelManager"
local CheckView = mLuaClass("CheckView", mQueueWindow);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgCombat = mLanguageUtil.common_combat;
function CheckView:InitViewParam()
	return {
		["viewPath"] = "ui/check/",
		["viewName"] = "check_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function CheckView:Init()
	self.mGoModel = self:Find('model').gameObject;

	self.mModelShowView = mModelShowView.LuaNew(self:Find('model'));
	self.mTextCombat = self:FindComponent('c_bg1/Text_combat','Text');

	self:InitBasic();

	self:FindAndAddClickListener("c_bg/Button_close",function()self:OnClickClose();end);
end

function CheckView:InitBasic()
	self.mGoPlayer = self:Find('featureView/Basic/Player').gameObject;
	self.mTextName = self:FindComponent('featureView/Basic/TextGroup/Text_name','Text');
	self.mTextGuanping = self:FindComponent('featureView/Basic/TextGroup/Text_guanping','Text');
	self.mTextExp = self:FindComponent('featureView/Basic/TextGroup/Text_exp','Text');
	self.mTextFenghao = self:FindComponent('featureView/Basic/TextGroup/Text_fenghao','Text');
	self.mTextPaixi = self:FindComponent('featureView/Basic/TextGroup/Text_paixi','Text');
	self.mTextFudi = self:FindComponent('featureView/Basic/TextGroup/Text_fudi','Text');
	self.mTextPeiou = self:FindComponent('featureView/Basic/TextGroup/Text_peiou','Text');

	self.mSliderBasicExp = self:FindComponent("featureView/Basic/Slider_exp/Slider","Slider");

	self:FindAndAddClickListener("featureView/Basic/BtnGroup/scrollViewBtn/Grid/Btn_property",function()self:OnClickProperty();end);
	self:FindAndAddClickListener("featureView/Basic/BtnGroup/scrollViewBtn/Grid/Btn_follower",function()self:OnClickFollower();end);
	self:FindAndAddClickListener("featureView/Basic/BtnGroup/scrollViewBtn/Grid/Btn_combat",function()self:OnClickCombat();end);
end

function CheckView:OnClickClose()
	self:ReturnPrevQueueWindow();
end

function CheckView:OnClickProperty()
	mUIManager:HandleUI(mViewEnum.CheckPropertyView,1,self.mData);
end

function CheckView:OnClickFollower()
	mUIManager:HandleUI(mViewEnum.CheckFollowerView,1,self.mData);
end

function CheckView:OnClickCombat()
	mUIManager:HandleUI(mViewEnum.CheckBowlderView,1,self.mData);
end

function CheckView:OnViewShow(data)
	local Data；
	if data ~= nil then
		Data = data;
		self.mData = data;
	else
		Data = self.mData;
	end
	self:CreateLeft(Data);
	self:CreateBasic(Data);
end

function CheckView:CreateLeft(data)
	self.mGoModel:SetActive(true);
	self.mModelShowView:OnUpdateLead(data.sex );
	self.mTextCombat.text = mLgCombat..data.combat;
end

function CheckView:CreateBasic(data)
	local goPlayer = self.mGoPlayer;
	local playerHeadView = mCommonPlayerHeadView.LuaNew(goPlayer);
	playerHeadView:SetInfo(data.sex,data.position,data.level);

	self.mTextName.text = data.name;
	self.mTextGuanping.text = self:GetPositionStr(data.sex,data.position);
	self.mTextFenghao.text = "";
	self.mTextPaixi.text = "";
	self.mTextFudi.text = "";
	self.mTextPeiou.text = "";

	local playerVO = mGameModelManager.CheckModel.mPlayerVO;
	self.mTextExp.text = playerVO.mExp..'/'..self:GetPlayerMaxExp(data.level);
	self.mSliderBasicExp.value = (playerVO.mExp/self:GetPlayerMaxExp(data.level)) * 100;
end

function CheckView:GetPositionStr(sex,position)
	if sex == 1 then
		return mConfigSyspromote[position].man_name;
	else
		return mConfigSyspromote[position].woman_name;
	end
end

function CheckView:GetPlayerMaxExp(level)
	return mConfigSysexp[level].lead_exp;
end

function CheckView:OnViewHide()
	self.mModelShowView:HideView();
end

function CheckView:Dispose()
	
end

return CheckView;