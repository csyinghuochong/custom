using System;
using System.Collections.Generic;
using System.Linq;

namespace ET
{
    [ConsoleHandler(ConsoleMode.ReloadDll)]
    public class ReloadDllConsoleHandler: IConsoleHandler
    {
        public async ETTask Run(ModeContex contex, string content)
        {
            switch (content)
            {
                case ConsoleMode.ReloadDll:
                    break;
                default:
                    contex.Parent.RemoveComponent<ModeContex>();

                    string[] ss = content.Split(" ");

                    if (ss.Length != 3)
                    {
                        return;
                    }

                    int loadType = int.Parse(ss[1]);    
                    string LoadValue = ss[2];   

                    //Game.EventSystem.Add(DllHelper.GetHotfixAssembly());
                    //Game.EventSystem.Load();

                    List<StartProcessConfig> listprogress = StartProcessConfigCategory.Instance.GetAll().Values.ToList();
                    Log.Console("C2M_Reload_a: listprogress " + listprogress.Count);
                    for (int i = 0; i < listprogress.Count; i++)
                    {
                        List<StartSceneConfig> processScenes = StartSceneConfigCategory.Instance.GetByProcess(listprogress[i].Id);
                        if (processScenes.Count == 0)  // || listprogress[i].Id == 203)
                        {
                            continue;
                        }

                        StartSceneConfig startSceneConfig = processScenes[0];
                        Log.Console("C2M_Reload_a: processScenes " + startSceneConfig);

                        try
                        {
                            long mapInstanceId = StartSceneConfigCategory.Instance.GetBySceneName(startSceneConfig.Zone, startSceneConfig.Name).InstanceId;
                            A2M_Reload createUnit = (A2M_Reload)await ActorMessageSenderComponent.Instance.Call(
                                mapInstanceId, new M2A_Reload() { LoadType = loadType, LoadValue = LoadValue });

                            if (createUnit.Error != ErrorCode.ERR_Success)
                            {
                                Log.Console("C2M_Reload_a: error " + startSceneConfig);
                            }
                        }
                        catch (Exception ex)
                        { 
                            Log.Error(ex);
                        }
                    }
                    break;
            }
            
            await ETTask.CompletedTask;
        }
    }
}