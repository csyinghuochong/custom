local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBaseWindow = require "Core/BaseWindow"
local mViewEnum = require "Enum/ViewEnum"
local mEventEnum = require "Enum/EventEnum"
local mConfigSysnpc = require "ConfigFiles/ConfigSysnpc"
local mModelShowView = require "Module/Story/ModelRenderTexture"
local GuideView = mLuaClass("GuideView", mBaseWindow);

function GuideView:InitViewParam()
	return {
		["viewPath"] = "ui/guide/",
		["viewName"] = "guide_view",
		["ParentLayer"] = mPopLayer,
    ["viewBgEnum"] = mViewBgEnum.gray_clickable,
	};
end

function GuideView:Init()
    self.mModelShowView = mModelShowView.LuaNew(self:Find('guide/model'));
    self.mTips = self:FindComponent('guide/dialogBg/Tips','Text');
    self.mGuideModelTrans = self:Find('guide/model');
end

function GuideView:OnViewShow(logicParams)
    local guideStep = logicParams.step;
    self.mTips.text = guideStep.guide_desc;
    local bustIcon = mConfigSysnpc[5].model;
    self.mModelShowView:ShowView();
    self.mModelShowView:OnUpdateUI(bustIcon, true);
    if guideStep.arrow_offset ~= nil then
       self.mGuideModelTrans.localPosition = Vector3.New(guideStep.arrow_offset[1],guideStep.arrow_offset[2],0);
    end
end

function GuideView:OnViewHide()
    self.mModelShowView:HideView();
    self:Dispatch(mEventEnum.ON_HIDE_GUIDE_DESC);
end

function GuideView:Dispose()
    self.mModelShowView:Dispose();
end

return GuideView