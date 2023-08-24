local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mGameTimer = require "Core/Timer/GameTimer"
local mActivityModel = require "Module/Activity/ActivityModel"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local CSharpInterface = Com.Game.Manager.CSharpToLuaInterface;
local SysSoundConst = Assets.Scripts.Com.Game.Config.SysSoundConst;
local mSpecialButton = Assets.Scripts.Com.Game.Mono.UI.SpecialButton;
local ActivityController = require "Module/Activity/ActivityController"
local MainSceneControl = Com.Game.Manager.CSharpToLuaInterface.GetMainSceneControl();
local mActivityOpenServerVO = require "Module/ActivityOpenServer/ActivityOpenServerVO";
local mActivityOpenServerType = require "Module/ActivityOpenServer/ActivityOpenServerType"
local mActivityOpenServerModel = require 'Module/ActivityOpenServer/ActivityOpenServerModel';
local mCommonGoodsItem = Assets.Scripts.Com.Game.Module.CommonComponent.CommonGoodsItem;
local ActivationCodeView = mLuaClass("ActivationCodeView",mBaseView);
local UIManager = Com.Game.Manager.CSharpToLuaInterface.GetUIManager();
local mString = require 'string'
local mMath = require 'math'
local mVector3 = Vector3;

function ActivationCodeView:InitViewParam()
	return {
		["viewPath"] = "UI/Activity/ActivationCodeView",
		["viewName"] = "ActivationCodeView",
		["ParentLayer"] = UIManager.mNormalLayer1.transform,
	};
end

function ActivationCodeView:Init()
    self.mTextInput = self:FindComponent('Input/Label', "UILabel");

    CSharpInterface.GameUIEventListenerGet(self:FindChild('get_btn'), function ()
            self:OnClickExchangeButton();
    end, SysSoundConst.S_UI_OPEN_VIEW);
end

function ActivationCodeView:OnViewShow()
    mActivityModel.mRecvExchangeActivationCode = function (  )
       self:OnRecvExchangeActivationCode();
    end
end

function ActivationCodeView:OnViewHide()
    mActivityModel.mRecvExchangeActivationCode = nil;
end

function ActivationCodeView:OnRecvExchangeActivationCode(  )
    self.mTextInput.text = '';
end

function ActivationCodeView:HaveInvalidChar(str)
    local text, index = mString.gsub(str, "%W", "")

    local temp = "";
    for s in mString.gmatch(str, "[%W]") do
        temp = temp..s;
    end

    return mString.len(temp) > 0;
end

function ActivationCodeView:OnClickExchangeButton( )
    local code = self.mTextInput.text;
  
    if code == nil or code == "" or mString.len(code) < 1 then
        mCommonTipsView.ShowTip("激活码不能为空");
    elseif self:HaveInvalidChar(code) then
        mCommonTipsView.ShowTip("激活码不能含有非法字符");
    else
        ActivityController:SendExchangeActivationCode(code);
    end
end

return ActivationCodeView;