local mLuaClass = require "Core/LuaClass"
local mAlertBaseView = require "Module/CommonUI/AlertBaseView"
local mViewBgEnum = require "Enum/ViewBgEnum"
local AlertView = mLuaClass("AlertView", mAlertBaseView);
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mSuper = nil;
local mVector2 = Vector2

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgOK = mLanguageUtil.friend_info_delete_ok;
local mLgDefaultTitle = mLanguageUtil.alert_default_title

function AlertView.Show(table)
	mUIManager:HandleUI(mViewEnum.AlertView, 1, table);
end

function AlertView:InitViewParam()
	return {
		["viewPath"] = "ui/common/",
		["viewName"] = "alert_view",
		["ParentLayer"] = mPopLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
		["ForbitSound"] = true
	};
end

function AlertView:Init()
	self.mTextName = self:FindComponent("Text/TextName","Text");
	self.mGoMidLine = self:Find("Text/TextLine","Text").gameObject;

	mSuper = self:GetSuper(mAlertBaseView.LuaClassName);
	mSuper.Init(self);
end

function AlertView:OnViewShow(logicParams)
	mSuper = self:GetSuper(mAlertBaseView.LuaClassName);
	mSuper.OnViewShow(self,logicParams);
	self.mTextName.text = logicParams.desc2;
	if logicParams.showMidLine then
		self.mGoMidLine:SetActive(true);
	else
		self.mGoMidLine:SetActive(false);
	end
	local minLineLength;
	if logicParams.isTopLine then
		self.mGoMidLine.transform.anchoredPosition = mVector2(0,48);
		minLineLength = self.mTextDesc1.preferredWidth + 25;
	else
		self.mGoMidLine.transform.anchoredPosition = mVector2(0,13);
		minLineLength = self.mTextName.preferredWidth + 25;
	end
	self.mGoMidLine.transform.sizeDelta = mVector2(minLineLength,30);
end

function AlertView:Dispose()
end

return AlertView;