local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mSortTable = require "Common/SortTable"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mLanguageUtil = require "Utils/LanguageUtil"
local mEventEnum = require "Enum/EventEnum"
local mTaskConfig = require "ConfigFiles/ConfigSystask"
local mTaskVO = require "Module/Task/TaskVO"
local TaskModel = mLuaClass("TaskModel",mBaseModel);
local mipairs = ipairs

function TaskModel:OnLuaNew()
    self.mTaskEnum = {DailyTask = 1;AchieveTask = 2,SurpriseTask = 3};
end

function TaskModel:RecvTaskData(pbTaskList)
	local taskListWithType = {};
	for i=1,3 do
		taskListWithType[i] = mSortTable.LuaNew(function(a, b) return self:Sort(a, b) end, nil, true);
	end
	for i,v in mipairs(pbTaskList.list) do

		local taskSysVO = mTaskConfig[v.id];
		local taskType = taskSysVO.type;
    local taskVO = mTaskVO.LuaNew(v.id,v.status,v.progress,taskSysVO,v.time_remain);
    taskListWithType[taskType]:AddOrUpdate(v.id,taskVO);
	end
	self.mTaskListWithType = taskListWithType;
end

function TaskModel:DeleteTask(id)
   local taskListWithType = self.mTaskListWithType;
   if taskListWithType == nil then
      return;
   end
   local taskSysVO = mTaskConfig[id];
   local taskType = taskSysVO.type;
   
   if taskType == self.mTaskEnum.SurpriseTask then
      if taskListWithType[taskType].mSortTable[1] ~= nil then
         self:Dispatch(mEventEnum.ON_SURPRISE_TASK_COMPLETE);
      end
   end
   taskListWithType[taskType]:RemoveKey(id);
end

function TaskModel:UpdateTaskData(pbTaskList)
  local taskListWithType = self.mTaskListWithType;
  if taskListWithType == nil then
     return;
  end
  for i,v in mipairs(pbTaskList.list) do
    local taskSysVO = mTaskConfig[v.id];
    local taskType = taskSysVO.type;
    if taskType == self.mTaskEnum.SurpriseTask then
       if taskListWithType[taskType].mSortTable[1] == nil then
          --mCommonTipsView.Show(mLanguageUtil.task_surprise_get);
          self.mNewSurprise = true;
       end
    end
    local taskVO = taskListWithType[taskType]:GetValue(v.id);
    if taskVO ~= nil then
       taskVO.mProgress = v.progress;
       taskVO.mStatus = v.status;
       taskListWithType[taskType]:AddOrUpdate(v.id,taskVO);
       if taskType == self.mTaskEnum.SurpriseTask then
          self:Dispatch(mEventEnum.ON_SURPRISE_TASK_UPDATE,taskVO);
       end
       
    else
       taskListWithType[taskType]:AddOrUpdate(v.id,mTaskVO.LuaNew(v.id,v.status,v.progress,taskSysVO,v.time_remain));
    end
  end
end

function TaskModel:Sort(a, b)
	local aStatus = a.mStatus;
	local bStatus = b.mStatus;
	if aStatus == 1 and bStatus ~= 1 then
       return true;
	elseif aStatus ~= 1 and bStatus == 1 then
	     return false;
	else
       if aStatus == bStatus then
          return a.mTaskId < b.mTaskId;
       else
          return aStatus < bStatus;
       end
	end
end

function TaskModel:CheckRedPoint()
   local redPoint = {false,false,false};
   local taskListWithType = self.mTaskListWithType;
   for i,v in mipairs(taskListWithType) do
       for j,value in mipairs(v.mSortTable) do
           if value.mStatus == 1 then
              redPoint[i] = true;
              break;
           end
       end
   end
   return redPoint;
end

--获取打开的标签
function TaskModel:GetOpenTab()
  local taskEnum = self.mTaskEnum;
  local taskListWithType = self.mTaskListWithType;
  if self.mNewSurprise then
     self.mNewSurprise = false;
     return taskEnum.SurpriseTask;
  end
  if taskListWithType[taskEnum.SurpriseTask].mSortTable[1] ~= nil and taskListWithType[taskEnum.SurpriseTask].mSortTable[1].mStatus == 1 then
     return taskEnum.SurpriseTask;
  else
     if taskListWithType[taskEnum.AchieveTask] ~= nil then
        for i,v in mipairs(taskListWithType[taskEnum.AchieveTask].mSortTable) do
            if v.mStatus == 1 then
               return taskEnum.AchieveTask;
            end
        end
     end
  end
  return taskEnum.DailyTask;
end

return TaskModel;