local mLuaClass = require "Core/LuaClass"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local mLanguage = require "Utils/LanguageUtil"
local mLayoutController = require "Core/Layout/LayoutController"
local mGameModelManager = require "Manager/GameModelManager"
local mTaskController = require "Module/Task/TaskController"
local mCommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local mEventEnum = require "Enum/EventEnum"
local mSortTable = require "Common/SortTable"
local mStringFormat = string.format
local mTimeUtil = require "Utils/TimeUtil"
local mGameTimer = require "Core/Timer/GameTimer"
local TaskSurpriseView = mLuaClass("TaskSurpriseView",mCommonTabBaseView);

function TaskSurpriseView:InitViewParam()
	return {
		["viewPath"] = "ui/task/",
		["viewName"] = "task_surprise_view",
	};
end

function TaskSurpriseView:Init()
    self.mNameStr = self:FindComponent('name','Text');
    self.mDescStr = self:FindComponent('desc','Text');
    self.mTargetStr = self:FindComponent('target','Text');
    self.mBtnImage = self:FindComponent("taskBtn", 'Image');
    self.mBtnName = self:FindComponent('taskBtn/btnName', 'Text');
    self.mDoingObj = self:Find('doing').gameObject;
    self.mBtnObj = self:Find('taskBtn').gameObject;
    self.mTimeStr = self:FindComponent("time","Text");
    self:RegisterEventListener(mEventEnum.ON_SURPRISE_TASK_UPDATE, function(data)
		self:UpdateTask(data);
	end, true);
    self:FindAndAddClickListener("taskBtn",function () self:OnClickTaskBtn() end,nil,1);
    self.mRewardGridEx = mLayoutController.LuaNew(self:Find("rewardGrid"), require "Module/CommonUI/CommonGoodsItemView");
end

function TaskSurpriseView:OnUpdateUI(data)
	local surpriseData = mGameModelManager.TaskModel.mTaskListWithType[3].mSortTable[1];
	local sysVO = surpriseData.mSysVO;

	self.mDescStr.text = sysVO.desc;
	self.mNameStr.text = sysVO.title;
  	
  	local dataSoure = mSortTable.LuaNew();
  	for i,v in ipairs(sysVO.reward) do
    	dataSoure:AddOrUpdate(i,mCommonGoodsVO.LuaNew(v.goods_id,v.goods_number,nil,true));
  	end
  	self.mRewardGridEx:UpdateDataSource(dataSoure);
  	self:UpdateTask(surpriseData);
end

function TaskSurpriseView:UpdateTask(surpriseData)
	self.mSurpriseData = surpriseData;
	local sysVO = surpriseData.mSysVO;
	local status = surpriseData.mStatus;
	local tragetStr = sysVO.target;
	local colorFormat = " <color=#36A143>(%d/%d)</color>";
  	local noColorFormat = " (%d/%d)";
  	self.mDoingObj:SetActive(status == 0 and sysVO.view_params == nil);
	if status == 1 then
	   tragetStr = tragetStr..mStringFormat(colorFormat,surpriseData.mProgress,surpriseData.mProgress);
       self.mGameObjectUtil:SetImageSprite(self.mBtnImage,"common_button_2");
       self.mBtnName.text = mLanguage.common_btn_get;
	elseif status == 0 then
	   self.mBtnObj:SetActive(sysVO.view_params ~= nil);
	   tragetStr = tragetStr..mStringFormat(noColorFormat,surpriseData.mProgress,sysVO.times);
       self.mGameObjectUtil:SetImageSprite(self.mBtnImage,"common_button_1");
       self.mBtnName.text = mLanguage.common_btn_go;
	end
	self.mTargetStr.text = tragetStr;
	self:OnSetTime(surpriseData.mEndTime);
end

function TaskSurpriseView:OnSetTime(endTime)
	if endTime ~= nil then
		if endTime < mGameModelManager.LoginModel:GetCurrentTime() then
            self.mTimeStr.text = "00:00:00";
		else
            self:OnTimerInterval();
    	    local timerInterval = self.mTimerInterval;
		    if timerInterval == nil then
	   		   self.mTimerInterval = mGameTimer.SetInterval(1, function() self:OnTimerInterval() end);
	   	    else
	   		   timerInterval:ReStart();
		    end
		end
	end
end

function TaskSurpriseView:OnTimerInterval()
    local time = self.mSurpriseData.mEndTime - mGameModelManager.LoginModel:GetCurrentTime();
    self.mTimeStr.text = mTimeUtil:TransToHourMinSec(time);
    if time <= 0 and self.mTimerInterval ~= nil then
       	local time_interval = self.mTimerInterval;
		if time_interval ~= nil then
       		time_interval:Dispose();
       		self.mTimerInterval = nil;
		end
    end
end

function TaskSurpriseView:OnClickTaskBtn()
	local data = self.mSurpriseData;
	local status = data.mStatus;
	if status == 1 then
       mTaskController:SubmitTask(data.mTaskId);
	elseif status == 0 then
       mTaskController:JumpView(data.mSysVO);
	end
end

function TaskSurpriseView:OnViewHide()
	local time_interval = self.mTimerInterval;
	if(time_interval ~= nil) then	
       time_interval:Stop();
	end
end

function TaskSurpriseView:Dispose()
	local grid_ex = self.mRewardGridEx;
	if grid_ex ~= nil then
		grid_ex:Dispose();
		self.mRewardGridEx = nil;
	end
	local time_interval = self.mTimerInterval;
	if(time_interval ~= nil) then	
		time_interval:Dispose();
		self.mTimerInterval = nil;
	end
end

return TaskSurpriseView;