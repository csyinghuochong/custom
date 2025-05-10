﻿using System;


namespace ET
{

    [ActorMessageHandler]
    public class C2M_TaskCountryCommitHandler : AMActorLocationRpcHandler<Unit, C2M_CommitTaskCountryRequest, M2C_CommitTaskCountryResponse>
    {
        protected override async ETTask Run(Unit unit, C2M_CommitTaskCountryRequest request, M2C_CommitTaskCountryResponse response, Action reply)
        {
            try
            {
                if (!TaskCountryConfigCategory.Instance.Contain(request.TaskId))
                {
                    Log.Error($"C2M_CommitTaskCountryRequest 1");
                    response.Error = ErrorCode.ERR_ModifyData;
                    reply();
                    return;
                }

                TaskCountryConfig taskCountryConfig = TaskCountryConfigCategory.Instance.Get(request.TaskId);
                int itemItem = taskCountryConfig.RewardItem.Split('@').Length;
                if (unit.GetComponent<BagComponent>().GetBagLeftCell() < itemItem)
                {
                    response.Error = ErrorCode.ERR_BagIsFull;
                    reply();
                    return;
                }
                int errorCode = ErrorCode.ERR_Success;
                TaskComponent taskComponent = unit.GetComponent<TaskComponent>();
                TaskPro taskPro = null;
                for (int i = 0; i < taskComponent.TaskCountryList.Count; i++)
                {
                    if (taskComponent.TaskCountryList[i].taskID != request.TaskId)
                    {
                        continue;
                    }

                    taskPro = taskComponent.TaskCountryList[i];
                    break;
                }

                if (taskPro == null)
                {
                    response.Error = ErrorCode.ERR_TaskCommited;
                    reply();
                    return;
                }
                if (taskPro.taskStatus == (int)TaskStatuEnum.Commited)
                {
                    response.Error = ErrorCode.ERR_TaskCommited;
                    reply();
                    return;
                }

                int checkError = unit.GetComponent<TaskComponent>().CheckGiveItemTask(taskCountryConfig.TargetType, taskCountryConfig.Target, taskCountryConfig.TargetValue, request.BagInfoID, taskPro );
                if (checkError != ErrorCode.ERR_Success)
                {
                    response.Error = checkError;
                    reply();
                    return;
                }

                if (unit.Id == 2341487098982367232 && taskCountryConfig.TaskType == TaskCountryType.Mine)
                {
                    Console.WriteLine($"刀，领取矿场任务奖励  {taskCountryConfig.Id}   {TimeInfo.Instance.ToDateTime(TimeHelper.ServerNow())}");
                }

                taskPro.taskStatus = (int)TaskStatuEnum.Commited;
                if (errorCode != ErrorCode.ERR_Success)
                {
                    response.Error = errorCode;
                    reply();
                    return;
                }

                unit.GetComponent<BagComponent>().OnAddItemData(taskCountryConfig.RewardItem, $"{ItemGetWay.TaskCountry}_{TimeHelper.ServerNow()}");

                if (taskCountryConfig.RewardGold > 0)
                {
                    //添加金币
                    unit.GetComponent<UserInfoComponent>().UpdateRoleMoneyAdd(UserDataType.Gold, taskCountryConfig.RewardGold.ToString(), true, ItemGetWay.TaskCountry);
                }
                //添加活跃
                //unit.GetComponent<UserInfoComponent>().UpdateRoleData(UserDataType.HuoYue, taskCountryConfig.EveryTaskRewardNum.ToString());
                reply();
                await ETTask.CompletedTask;
            }
            catch (Exception ex)
            {
                Log.Debug(ex.ToString());
            }
        }
    }
}
