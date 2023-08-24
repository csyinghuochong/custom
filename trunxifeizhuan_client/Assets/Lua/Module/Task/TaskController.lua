local mLuaClass = require "Core/LuaClass"
local mBaseController = require "Core/BaseController"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mEventEnum = require "Enum/EventEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mTaskConfig = require "ConfigFiles/ConfigSystask"
local mConfigSysgoods = require "ConfigFiles/ConfigSysgoods"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mFunctionOpenManager = require "Module/MainInterface/FunctionOpenManager"
local mConfigSysfunction_openConst = require "ConfigFiles/ConfigSysfunction_openConst"
local TaskController = mLuaClass("TaskController",mBaseController);

function TaskController:AddNetListeners()
    self.mS2C:TASK_LIST(function(pbTaskList)
       mGameModelManager.TaskModel:RecvTaskData(pbTaskList);
       self:Dispatch(mEventEnum.ON_GET_TASK_LIST);
	end);
	self.mS2C:TASK_UPDATE(function(pbTaskList)
       mGameModelManager.TaskModel:UpdateTaskData(pbTaskList);
       self:Dispatch(mEventEnum.ON_TASK_UPDATE);
	end);
	self.mS2C:TASK_DEL(function(pbResult)
       mGameModelManager.TaskModel:DeleteTask(pbResult.result);
       self:Dispatch(mEventEnum.ON_TASK_UPDATE);
	end);
	self.mS2C:TASK_GET_REWARD(function(pbResult)
        local tasksysVO = mTaskConfig[pbResult.result];
        if tasksysVO ~= nil then
           local rewardStr = "";
           for i,v in ipairs(tasksysVO.reward) do
              local goodsName = mConfigSysgoods[v.goods_id].goods_name;
              rewardStr = rewardStr..goodsName.."*"..v.goods_number.." ";
           end
			     mCommonTipsView.Show(rewardStr);
        end
	end);
end

function TaskController:SubmitTask(taskId)
	self.mC2S:TASK_GET_REWARD(taskId,true);
end

function TaskController:SendGetTaskList()
	self.mC2S:TASK_LIST(true);
end

function TaskController:JumpView(tasksysVO)
    local const = tasksysVO.function_open_const;
    if const ~= nil then
      if mFunctionOpenManager:GetFunctionState(mConfigSysfunction_openConst[const]) then
        local viewParams = tasksysVO.view_params;
        if viewParams ~= nil then
    	    local viewName = viewParams[1];
    	    local params = {jumpParams = viewParams[2]};
    	    mUIManager:HandleUI(mViewEnum[viewName],1,params);
        end
      else
        mCommonTipsView.Show(mFunctionOpenManager:GetFunctionOpenLevelStr(mConfigSysfunction_openConst[const]));
      end
    end
end

return TaskController.LuaNew();