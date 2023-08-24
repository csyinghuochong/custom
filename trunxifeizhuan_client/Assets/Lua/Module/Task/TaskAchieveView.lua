local mLuaClass = require "Core/LuaClass"
local mTaskDailyView = require "Module/Task/TaskDailyView"
local mGameModelManager = require "Manager/GameModelManager"
local TaskAchieveView = mLuaClass("TaskAchieveView",mTaskDailyView);

function TaskAchieveView:OnUpdateUI(data)
    local taskListWithType = mGameModelManager.TaskModel.mTaskListWithType;
	if taskListWithType ~= nil then
	    local dataSoure = taskListWithType[2];
	    self.mTaskGridEx:UpdateDataSource(dataSoure);
	end
end

return TaskAchieveView;