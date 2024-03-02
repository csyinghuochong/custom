using System;
using System.Collections.Generic;
using System.Reflection;

namespace ET
{
    [ConsoleHandler(ConsoleMode.Robot)]
    public class RobotConsoleHandler: IConsoleHandler
    {
        public async ETTask Run(ModeContex contex, string content)
        {
            string[] ss = content.Split(" ");
            switch (ss[0])
            {
                case ConsoleMode.Robot:

                    if (ss.Length >= 2)
                    {
                        if (ss[1].Equals("close"))
                        {
                            using (ListComponent<StartSceneConfig> thisProcessRobotScenes = ListComponent<StartSceneConfig>.Create())
                            {
                                List<StartSceneConfig> robotSceneConfigs = StartSceneConfigCategory.Instance.Robots;
                                thisProcessRobotScenes.Add(robotSceneConfigs[0]);

                                StartSceneConfig robotSceneConfig = thisProcessRobotScenes[0];
                                Scene robotScene = Game.Scene.Get(robotSceneConfig.Id);
                                RobotManagerComponent robotManagerComponent = robotScene.GetComponent<RobotManagerComponent>();

                                foreach (var item in robotManagerComponent.Children)
                                {
                                    item.Value.GetComponent<SessionComponent>().Session.Dispose();
                                }

                                Log.Console($"机器人全部下线！");
                                //int robotZone = robotManagerComponent.ZoneIndex++;
                                //Scene robot = await robotManagerComponent.NewRobot(options.Zone, robotZone, options.RobotId);
                                //robot?.AddComponent<BehaviourComponent, int>(options.RobotId);
                                //Log.Console($"create robot {robot.Zone}");
                                //await TimerComponent.Instance.WaitAsync(1000);
                            }
                        }
                    }
                    else
                    {
                        // 获取当前进程的RobotScene
                        using (ListComponent<StartSceneConfig> thisProcessRobotScenes = ListComponent<StartSceneConfig>.Create())
                        {
                            List<StartSceneConfig> robotSceneConfigs = StartSceneConfigCategory.Instance.Robots;
                            thisProcessRobotScenes.Add(robotSceneConfigs[0]);

                            StartSceneConfig robotSceneConfig = thisProcessRobotScenes[0];
                            Scene robotScene = Game.Scene.Get(robotSceneConfig.Id);
                            RobotManagerComponent robotManagerComponent = robotScene.GetComponent<RobotManagerComponent>();

                            Log.Debug($"机器人数量：      {robotManagerComponent.Children.Count}");
                            int[] robotNumber = new int[10];
                            int fubenNumber = 0;
                            foreach (var item in robotManagerComponent.Children)
                            {
                                BehaviourComponent behaviourComponent = item.Value.GetComponent<BehaviourComponent>();
                                if (behaviourComponent == null)
                                {
                                    continue;
                                }
                                Log.Debug($"机器人行为：      {behaviourComponent.Current}");
                                robotNumber[behaviourComponent.RobotConfig.Behaviour]++;
                                MapComponent mapComponent = item.Value.GetComponent<MapComponent>();
                                if (mapComponent.SceneTypeEnum == SceneTypeEnum.LocalDungeon)
                                {
                                    fubenNumber++;
                                }
                            }

                            //1   任务机器人
                            //2   组队副本机器人
                            //3   战场机器人
                            //4   世界boos机器人
                            for (int i = 0; i < robotNumber.Length; i++)
                            {
                                switch (i)
                                {
                                    case 1:
                                        Log.Debug($"任务机器人：      {robotNumber[i]}");
                                        break;
                                    case 2:
                                        Log.Debug($"组队副本机器人：  {robotNumber[i]}");
                                        break;
                                    case 3:
                                        Log.Debug($"战场机器人：      {robotNumber[i]}");
                                        break;
                                    case 4:
                                        Log.Debug($"世界boos机器人：  {robotNumber[i]}");
                                        break;
                                    default:
                                        break;
                                }
                            }
                            Log.Console($"副本数量: {fubenNumber}");

                            //int robotZone = robotManagerComponent.ZoneIndex++;
                            //Scene robot = await robotManagerComponent.NewRobot(options.Zone, robotZone, options.RobotId);
                            //robot?.AddComponent<BehaviourComponent, int>(options.RobotId);
                            //Log.Console($"create robot {robot.Zone}");
                            //await TimerComponent.Instance.WaitAsync(1000);
                        }                 
                    }
                    break;
                case "Run":
                {
                    int caseType = int.Parse(ss[1]);

                    try
                    {
                        RobotLog.Debug($"run case start: {caseType}");
                        await RobotCaseDispatcherComponent.Instance.Run(caseType, content);
                        RobotLog.Debug($"run case finish: {caseType}");
                    }
                    catch (Exception e)
                    {
                        RobotLog.Debug($"run case error: {caseType}\n{e}");
                    }
                    break;
                }
                case "RunAll":
                {
                    FieldInfo[] fieldInfos = typeof (RobotCaseType).GetFields();
                    foreach (FieldInfo fieldInfo in fieldInfos)
                    {
                        int caseType = (int)fieldInfo.GetValue(null);
                        if (caseType > RobotCaseType.MaxCaseType)
                        {
                            RobotLog.Debug($"case > {RobotCaseType.MaxCaseType}: {caseType}");
                            break;
                        }
                        try
                        {
                            RobotLog.Debug($"run case start: {caseType}");
                            await RobotCaseDispatcherComponent.Instance.Run(caseType, content);
                            RobotLog.Debug($"---------run case finish: {caseType}");
                        }
                        catch (Exception e)
                        {
                            RobotLog.Debug($"run case error: {caseType}\n{e}");
                            break;
                        }
                    }
                    break;
                }
            }
            await ETTask.CompletedTask;
        }
    }
}