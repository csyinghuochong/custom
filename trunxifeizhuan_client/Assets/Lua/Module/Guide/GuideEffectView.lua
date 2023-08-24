local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBaseWindow = require "Core/BaseWindow"
local mViewEnum = require "Enum/ViewEnum"
local mCameraController = require "Manager/CameraController"
-- local mUIManager = require "Manager/UIManager"
local mVector3 = Vector3;
local mDGTween = DG.Tweening.ShortcutExtensions;
local mGameLuaInterface = GameLuaInterface;
local Screen = UnityEngine.Screen;

local GuideEffectView = mLuaClass("GuideEffectView", mBaseWindow);

function GuideEffectView:InitViewParam()
	return {
		["viewPath"] = "ui/guide/",
		["viewName"] = "guide_effect_view",
		["ParentLayer"] = mPopLayer,
	};
end

function GuideEffectView:Init()
    self.mEffect = self:Find("effect");
end

function GuideEffectView:OnViewShow(logicParams)
    self.mParams = logicParams;
    local obj = logicParams.object;
    self.mObj = obj;
    local effect = self.mEffect;
    if logicParams.is3D then
       local screenPoint = mCameraController:WorldToScreenPoint(obj.transform.position)
       local position = mUICamera:ScreenToWorldPoint(screenPoint)
       mDGTween.DOMove(effect, position, 1,true);
    else
       self:SetButton(false);
       effect:SetParent(obj.mFindObj.transform);
       mGameLuaInterface.DOLocalMove(effect, Vector3.zero, 1, function() self:OnComplete() end);
       
    end
    mDGTween.DOScale(effect, Vector3.New(0.1,0.1,0.1), 1);
end

function GuideEffectView:SetButton(flag)
    local obj = self.mObj;
    if obj.mBtnComponent ~= nil then
       obj.mBtnComponent.enabled = flag;
    end
end

function GuideEffectView:OnComplete()
    self:SetButton(true);
    local obj = self.mObj;
    obj:SetTop();
    self.mEffect:SetParent(self.mTransform);
end

function GuideEffectView:OnViewHide()
    local effect = self.mEffect;
    if self.mParams.is3D == nil then
       self:SetButton(true);
    end
    effect:SetParent(self.mTransform);
    effect.localScale = Vector3.one;
    effect.localPosition = Vector3.zero;
end

return GuideEffectView