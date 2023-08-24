local mLayoutItem = require "Core/Layout/LayoutItem"
local mLuaClass = require "Core/LuaClass"
local mTaskController = require "Module/Task/TaskController"
local mCommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView";
local mEventEnum = require "Enum/EventEnum"
local mCommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local mLanguage = require "Utils/LanguageUtil"
local mStringFormat = string.format
local TaskItemView = mLuaClass("TaskItemView", mLayoutItem);
local mSuper = nil;

function TaskItemView:InitViewParam()
	return {
		["viewPath"] = "ui/task/",
		["viewName"] = "task_normal_item_view",
	};
end

function TaskItemView:Init()
    self.mGoods1 = mCommonGoodsItemView.LuaNew(self:Find('reward1').gameObject);
    self.mGoods2 = mCommonGoodsItemView.LuaNew(self:Find('reward2').gameObject);
    self.mGoods2Obj = self:Find('reward2').gameObject;
    self:FindAndAddClickListener("taskBtn",function () self:OnClickTask() end,nil,1);
    self.mDesc = self:FindComponent('desc', 'Text');
    self.mTarget = self:FindComponent('target', 'Text');
    self.mBtnName = self:FindComponent('taskBtn/btnName', 'Text');
    self.mBtnImage = self:FindComponent("taskBtn", 'Image');
    self.mStatusImage = self:FindComponent("status", 'Image');
    self.mStatusObj = self:Find('status').gameObject;
    self.mDoingObj = self:Find('doing').gameObject;
    self.mBtnObj = self:Find('taskBtn').gameObject;
	  mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	  mSuper.Init(self);
end

function TaskItemView:OnUpdateData()
    local data = self.mData;
    local status = data.mStatus;
    local sysVO = data.mSysVO;
    self.mDesc.text = sysVO.target;
    local tragetStr = sysVO.title;
    local colorFormat = " <color=#36A143>(%d/%d)</color>";
    local noColorFormat = " (%d/%d)";
    self.mDoingObj:SetActive(status == 0 and sysVO.view_params == nil);
    if status == 1 then
       tragetStr = tragetStr..mStringFormat(colorFormat,data.mProgress,data.mProgress);
       self.mBtnName.text = mLanguage.common_btn_get;
       self.mStatusObj:SetActive(false);
       self.mBtnObj:SetActive(true);
       self.mGameObjectUtil:SetImageSprite(self.mBtnImage,"common_button_5");
    else
       tragetStr = tragetStr..mStringFormat(noColorFormat,data.mProgress,sysVO.times);
       self.mBtnObj:SetActive(status ~= 2 and sysVO.view_params ~= nil);
       self.mStatusObj:SetActive(status == 2);
       if status == 2 then
          if sysVO.type == 1 then
             self.mGameObjectUtil:SetImageSprite(self.mStatusImage,"common_mission_complete");
          else
             self.mGameObjectUtil:SetImageSprite(self.mStatusImage,"common_mission_reach");
          end
       else
          if sysVO.view_params ~= nil then
             self.mBtnName.text = mLanguage.common_btn_go;
             self.mGameObjectUtil:SetImageSprite(self.mBtnImage,"common_button_4");
          end
       end
    end
    self.mTarget.text = tragetStr;
    local goodsVO1 = mCommonGoodsVO.LuaNew(sysVO.reward[1].goods_id,sysVO.reward[1].goods_number,nil,true)
    self.mGoods1:ExternalUpdate(goodsVO1);
    self.mGoods2Obj:SetActive(sysVO.reward[2] ~= nil);
    if sysVO.reward[2] ~= nil then
       local goodsVO2 = mCommonGoodsVO.LuaNew(sysVO.reward[2].goods_id,sysVO.reward[2].goods_number,nil,true)
       self.mGoods2:ExternalUpdate(goodsVO2);
    end

end

function TaskItemView:OnClickTask()
	  local data = self.mData;
	  local status = data.mStatus;
	  if status == 1 then
       mTaskController:SubmitTask(data.mTaskId);
	  elseif status == 0 then
       mTaskController:JumpView(data.mSysVO);
	  end
end

return TaskItemView;