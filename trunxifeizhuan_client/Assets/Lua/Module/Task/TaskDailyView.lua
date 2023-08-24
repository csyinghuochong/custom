local mLuaClass = require "Core/LuaClass"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local mLayoutController = require "Core/Layout/LayoutController"
local mGameModelManager = require "Manager/GameModelManager"
local TaskDailyView = mLuaClass("TaskDailyView",mCommonTabBaseView);

function TaskDailyView:InitViewParam()
	return {
		["viewPath"] = "ui/task/",
		["viewName"] = "task_normal_view",
	};
end

function TaskDailyView:Init()
    self.mTaskGridEx = mLayoutController.LuaNew(self:Find("taskScrollView/Grid"), require "Module/Task/TaskItemView");
    self.mTaskGridEx:ResetAfterRefresh(true);
end

function TaskDailyView:OnUpdateUI(data)
	local taskListWithType = mGameModelManager.TaskModel.mTaskListWithType;
	if taskListWithType ~= nil then
	    local dataSoure = taskListWithType[1];
	    self.mTaskGridEx:UpdateDataSource(dataSoure);
	end
end

function TaskDailyView:Dispose()
	local grid_ex = self.mTaskGridEx;
	if grid_ex ~= nil then
		grid_ex:Dispose();
		self.mTaskGridEx = nil;
	end
end

return TaskDailyView;