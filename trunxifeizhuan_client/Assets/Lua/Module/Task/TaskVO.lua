local mLuaClass = require "Core/LuaClass"
local TaskVO = mLuaClass("TaskVO");

function TaskVO:OnLuaNew(taskId,status,progress,sysVO,endTime)
    self.mTaskId = taskId;
    self.mStatus = status;
    self.mProgress = progress;
    self.mSysVO = sysVO;
    self.mEndTime = endTime;   ---惊喜任务结束时间
end

return TaskVO;