local mLuaClass = require "Core/LuaClass"
local mConfigSysactor = require "ConfigFiles/ConfigSysactor"
local mConfigSysgoods = require "ConfigFiles/ConfigSysgoods"
local mConfigSysskillinfo = require "ConfigFiles/ConfigSysskill_info"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBaseWindow = require "Core/BaseWindow"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local Screen = UnityEngine.Screen;
local mVector2 = Vector2;

local CommonGoodsDetialView = mLuaClass("CommonGoodsDetialView", mBaseWindow);

function CommonGoodsDetialView:InitViewParam()
	return {
		["viewPath"] = "ui/common/",
		["viewName"] = "common_goods_detial_view",
		["ParentLayer"] = mCommonPopLayer2,
		["ForbitSound"] = true
	};
end

function CommonGoodsDetialView:Init()
    self.mNameText = self:Find("GameObject/name"):GetComponent('Text');
    self.mDescText = self:Find("GameObject/desc"):GetComponent('Text');

    self.mTransBg = self:Find("GameObject/bg");
    self.mTransName = self:Find("GameObject/name");
    self.mTransLine = self:Find("GameObject/line");
    self.mTransDesc = self:Find("GameObject/desc");
end

function CommonGoodsDetialView:OnViewShow(logicParams)
    self.mLogicParams = logicParams;
    self:SetInfo();
    self:SetViewPosition();
end

function CommonGoodsDetialView:SetViewPosition()
    local parentTrans = self.mLogicParams.mTransform;
    local object = self:Find("GameObject");
    local sizeDelta = self:Find("GameObject/bg"):GetComponent('RectTransform').sizeDelta;
    local parentSize = parentTrans:GetComponent('RectTransform').sizeDelta;
    local camera = mUIManager.mCanvasTrans:GetComponent('Canvas').worldCamera;
    local screenPoint = camera:WorldToScreenPoint(parentTrans.position);
    local localPosition = parentTrans.localPosition;
    --位置从右上，右下，左上，左下顺序判断
    local screenVector = Vector3.zero;
    screenVector.z = screenPoint.z;
    local x = Screen.width - (sizeDelta.x+parentSize.x/2)*(Screen.width/mUIManager:GetDeviceWidth());
    local y = Screen.height - (sizeDelta.y+parentSize.y/2)*(Screen.height/mUIManager:GetDeviceHeight());
    if screenPoint.x < x and screenPoint.y < y then
       screenVector.x = localPosition.x + sizeDelta.x/2 + parentSize.x/2 - 8;
       screenVector.y = localPosition.y + sizeDelta.y/2 + parentSize.y/2 - 8;
    elseif screenPoint.x < x and screenPoint.y > y then
       screenVector.x = localPosition.x + sizeDelta.x/2 + parentSize.x/2 - 8;
       screenVector.y = localPosition.y - sizeDelta.y/2 - parentSize.y/2 + 8;
    elseif screenPoint.x > x and screenPoint.y < y then
       screenVector.x = localPosition.x - sizeDelta.x/2 - parentSize.x/2 + 8;
       screenVector.y = localPosition.y + sizeDelta.y/2 + parentSize.y/2 - 8;
    elseif screenPoint.x > x and screenPoint.y > y  then
       screenVector.x = localPosition.x - sizeDelta.x/2 - parentSize.x/2 + 8;
       screenVector.y = localPosition.y - sizeDelta.y/2 - parentSize.y/2 + 8;
    else
       screenVector.x = localPosition.x;
       screenVector.y = localPosition.y;
    end

    object:SetParent(parentTrans);
    object.localPosition = screenVector;
    object:SetParent(self.mTransform);
end

function CommonGoodsDetialView:SetInfo()
    local configID = self.mLogicParams.mConfigID;
    local configType = self.mLogicParams.mType;
    if configType == 1 then
       local configSkill = mConfigSysskillinfo[configID];
       if configSkill == nil then
          print("skill_info表里找不到技能ID".. configID);
          return;
       end
       self.mNameText.text = configSkill.name;
       self.mDescText.text = configSkill.desc;
    elseif configType == 2 then
       local configGoods = mConfigSysgoods[configID];
        if configGoods == nil then
          print("goods表里找不到物品ID".. configID);
          return;
       end
       self.mNameText.text = configGoods.goods_name;
       self.mDescText.text = configGoods.desc;
    end

    self:SetPos();
end

function CommonGoodsDetialView:SetPos()
    local bgHeight = self.mDescText.preferredHeight + 75;
    self.mTransBg.sizeDelta = mVector2.New(280,bgHeight);
    self.mTransName.anchoredPosition = mVector2.New(0,bgHeight/2 - 5);
    self.mTransLine.anchoredPosition = mVector2.New(0,bgHeight/2 - 50);
    self.mTransDesc.anchoredPosition = mVector2.New(0,bgHeight/2 - 60);
end

--type 1为技能ID 2为物品ID
function CommonGoodsDetialView.Show(params)
    -- local params = {mTransform = parentTrans,mConfigID = configID,mType = type};
    mUIManager:HandleUI(mViewEnum.CommonGoodsDetialView, 1, params);
end

function CommonGoodsDetialView.hide()
    mUIManager:HandleUI(mViewEnum.CommonGoodsDetialView, 0);
    --self:HideView();
end

return CommonGoodsDetialView;