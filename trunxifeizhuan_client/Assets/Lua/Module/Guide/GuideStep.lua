local mLuaClass = require "Core/LuaClass"
local mUpdateManager = require "Manager/UpdateManager"
local mGuideObject = require "Module/Guide/GuideObject"
local mGameModelManager = require "Manager/GameModelManager"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mEventEnum = require "Enum/EventEnum"
local GameObject = UnityEngine.GameObject;
local mCombatModelManager = require "Module/Combat/CombatModelManager"
local mEventDispatcherInterface = require "Events/EventDispatcherInterface"
local mIpairs = ipairs
local mTable = table
local mGuideController = require "Module/Guide/GuideController"
local GuideStep = mLuaClass("GuideStep",mEventDispatcherInterface);

function GuideStep:OnLuaNew(guideStepVO,guide_id,step,callBack)
	  self.mCallBack = callBack;
	  self.mGuide_id = guide_id;
    self.mStepVO = guideStepVO;
    self.mListener = function() self:OnClickBack() end;
    self.mNextStepListener = function() self:OnRunNextStep() end;
    self.mPickMonsterListener = function() self:OnPickMonster() end;
    self.mHideGuideDescListener = function () self:HideGuideDesc() end;
    self.mAddListener = false;
    self.mHaveFind = true;
    self:AddEventListener(mEventEnum.ON_HIDE_GUIDE_DESC,self.mHideGuideDescListener);
    self:OpenGuide(step);
    mUpdateManager:AddUpdate(self);
end

function GuideStep:OnUpdate()
    if self.mHaveFind == false then
       local guideStep = self.mGuideStep;
       local obj = mUIManager.mCanvasTrans.gameObject;

       for i,v in mIpairs(guideStep.button) do
           if obj == nil then
              return;
           end
           obj = obj.Find(v);
       end
       if obj == nil then
          return;
       end
       if guideStep.type_id ~= 0 then
           if obj.transform.childCount > guideStep.type_id - 1 then
              local trans = obj.transform:GetChild(guideStep.type_id - 1);
              obj = trans.gameObject;
           end
       end
       if obj ~= nil then
           self.mGuideObj = mGuideObject.LuaNew(obj);
           self.mHaveFind = true;
           self:RunGuide();
       end
    end
end

function GuideStep:GetDataByStep(step)
    local stepVO = self.mStepVO;
    for k,v in ipairs(stepVO.steps) do
      if v.index == step then
          return v;
      end
    end
end

function GuideStep:OpenGuide(step)
    self.mStep = step;
    local guideStep = self:GetDataByStep(step);
    self.mGuideStep = guideStep;
    if guideStep.button == nil or guideStep.button == "" then
        self:RunGuide();
    else
        self.mHaveFind = false;
    end
end

function GuideStep:RunGuide()
    local guideStep = self.mGuideStep;
    if guideStep.guide_desc ~= nil and guideStep.guide_desc ~= "" then
       mUIManager:HandleUI(mViewEnum.GuideView,1,{step = guideStep});
    else
       self:ShowEffect();
    end
end

function GuideStep:ShowEffect()
    local guideObj = self.mGuideObj;
    guideObj:SetTop();
    guideObj:AddClickListener(self.mListener);
    local guideStep = self.mGuideStep;
    if guideStep.eventListener == 1 then
       self.mAddListener = true;
       self:AddEventListener(mEventEnum.ON_RUN_NEXT_STEP,self.mNextStepListener);
    end
    local param = {object = guideObj,step = guideStep};
    mUIManager:HandleUI(mViewEnum.GuideEffectView,1,param);
end

function GuideStep:HideGuideDesc()
    local guideStep = self.mGuideStep;
    if guideStep.button == nil or guideStep.button == "" then --没有选择button暂时都是找怪
       local actor = mCombatModelManager.mCurrentModel:GetCampMonster();
       local monsterObj = actor:GetGameObject();
       self:AddEventListener(mEventEnum.ON_PICK_ACTOR,self.mPickMonsterListener);
       local param = {object = monsterObj,step = guideStep,is3D = true};
       mUIManager:HandleUI(mViewEnum.GuideEffectView,1,param);
    else
       self:ShowEffect();
    end
end

function GuideStep:OnClickBack()
	  mUIManager:HandleUI(mViewEnum.GuideEffectView,0);
    local obj = self.mGuideObj;
    obj:SetNormal();
    obj:RemoveClickListener(self.mListener);
    if self.mAddListener == false then
       self:CheckNextStep();
    end
end

function GuideStep:OnRunNextStep()
	  mUIManager:HandleUI(mViewEnum.GuideEffectView,0);
    self:RemoveEventListener(mEventEnum.ON_RUN_NEXT_STEP,self.mNextStepListener);
    self.mAddListener = false;
    self.mGuideObj:SetNormal();
    self:CheckNextStep();
end

--战斗选怪用到
function GuideStep:OnPickMonster()
	  mUIManager:HandleUI(mViewEnum.GuideEffectView,0);
    self:RemoveEventListener(mEventEnum.ON_PICK_ACTOR,self.mPickMonsterListener);
    self:RunEnd();
    local step = self.mStep + 1;
    mGuideController:SendFinishGuide(self.mGuide_id,self.mStep);
end

function GuideStep:CheckNextStep()
    local step = self.mStep + 1;
    mGuideController:SendFinishGuide(self.mGuide_id,self.mStep);
    if step > self.mStepVO.last_step then
        self:RunEnd();
    else
        self:OpenGuide(step);
    end
end

function GuideStep:RunEnd()
	  mUpdateManager:RemoveUpdate(self);
	  self:RemoveEventListener(mEventEnum.ON_HIDE_GUIDE_DESC,self.mHideGuideDescListener);
	  local callBack = self.mCallBack;
	  if callBack ~= nil then
       callBack();
	  end
end

return GuideStep