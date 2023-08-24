local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mEventEnum = require "Enum/EventEnum"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mTaskController = require "Module/Task/TaskController"
local mCommonTabView = require "Module/CommonUI/TabView/CommonTabView"
local mTimeUtil = require "Utils/TimeUtil"
local mGameTimer = require "Core/Timer/GameTimer"
local mColor = Color
local mVector2 = Vector2
local TaskView = mLuaClass("TaskView", mQueueWindow);

function TaskView:InitViewParam()
	return {
		["viewPath"] = "ui/task/",
		["viewName"] = "task_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
		["PlayAnimation"] = true,
		["cost"] = {"gold","silver"},
	};
end

function TaskView:Init()
	self.mObjTab = self:Find('tabView');
	self:RegisterEventListener(mEventEnum.ON_SURPRISE_TASK_COMPLETE, function()
         self:CloseSurprise();
    end, true);
    self:RegisterEventListener(mEventEnum.ON_GET_TASK_LIST, function()
         self:SelectToggle();
    end, true);
    self:RegisterEventListener(mEventEnum.ON_TASK_UPDATE, function()
         self:SetRedPoint();
    end, true);
    self.mSurpriseTab = self:Find("tabView/buttonView/Button3").gameObject;
    self.mGoLine = self:Find("tabView/Line/Image4").gameObject;
    self.mTransLineLast = self:Find("tabView/Line/Image5");
	self:FindAndAddClickListener("c_bg/Button_close",function() self:ReturnPrevQueueWindow(); end);
	self:InitSubView();
end

function TaskView:InitSubView()
	local view_vo_list = {
		{luaClass="Module/Task/TaskDailyView"},
		{luaClass="Module/Task/TaskAchieveView"},
		{luaClass="Module/Task/TaskSurpriseView"},
	}
	self.mTabView = mCommonTabView.LuaNew(self.mObjTab, view_vo_list);
end

function TaskView:OnViewShow(logicParams)
	local tabView = self.mTabView;
	if self.mHaveInit then
       tabView:ShowView();
	end
	self.mSelectTab = logicParams;
    local taskList = mGameModelManager.TaskModel.mTaskListWithType;
    if taskList ~= nil then
       self:SelectToggle();
    else
       mTaskController:SendGetTaskList();
    end
end

function TaskView:SelectToggle()
	local surpriseTask = mGameModelManager.TaskModel.mTaskListWithType[3].mSortTable[1]
	self:SetSurpriseState(surpriseTask ~= nil);
	if self.mSelectTab ~= nil then
       self.mTabView:OnClickToggleButton(self.mSelectTab, false);
	else
       local tab = mGameModelManager.TaskModel:GetOpenTab();
       self.mTabView:OnClickToggleButton(tab, false);
	end
	self:SetRedPoint();
end

function TaskView:SetRedPoint()
	self.mTabView:SetRedPoint(mGameModelManager.TaskModel:CheckRedPoint());
end

function TaskView:OnViewHide(logicParams)
	self.mHaveInit = true;
end

function TaskView:SetSurpriseState(state)
	self.mSurpriseTab:SetActive(state);
	self.mGoLine:SetActive(state);
	if state then
		self.mTransLineLast.anchoredPosition = mVector2(-1.4,-163);
	else
		self.mTransLineLast.anchoredPosition = mVector2(-1.4,-75);
	end
end

function TaskView:CloseSurprise()
	self:SetSurpriseState(false);
	self.mTabView:OnClickToggleButton(1, false);
end

function TaskView:Dispose()
	self.mTabView:CloseView();
	self.mHaveInit = false;
end

return TaskView;