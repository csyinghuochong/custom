using System.Collections.Generic;
using System.Linq;

namespace ET
{
#if SERVER
        [ConsoleHandler(ConsoleMode.Level)]

        public class LevelConsoleHandler : IConsoleHandler
        {
            public async ETTask Run(ModeContex contex, string content)
            {
            switch (content)
            {
                case ConsoleMode.ChaXun:
                    contex.Parent.RemoveComponent<ModeContex>();
                    Log.Console($"C must have chaxun zone username");
                    break;
                default:
                    //level 1
                    string[] chaxunInfo = content.Split(" ");
                    if (chaxunInfo[0] != "level")
                    {
                        Log.Console($"C must have level zone");
                        return;
                    }
                    if (chaxunInfo.Length != 2)
                    {
                        Log.Console($"C must have level zone");
                        return;
                    }

                    int zone = int.Parse(chaxunInfo[1]);

                    List<int> zonlist = new  List<int> {  };

                    if (zone == 0)
                    {
                        List<StartZoneConfig> listprogress = StartZoneConfigCategory.Instance.GetAll().Values.ToList();
                        for (int i = 0; i < listprogress.Count; i++)
                        {
                            if (listprogress[i].Id >= ComHelp.MaxZone)
                            {
                                continue;
                            }
                            if (!StartSceneConfigCategory.Instance.Gates.ContainsKey(listprogress[i].Id))
                            {
                                continue;
                            }
                            zonlist.Add(listprogress[i].Id);
                        }
                    }
                    else
                    {
                        zonlist.Add(zone);
                    }

                    for( int i = 0; i < zonlist.Count; i++ )
                    {
                        int pyzone = StartZoneConfigCategory.Instance.Get(zonlist[i]).PhysicZone;

                        long dbCacheId = DBHelper.GetDbCacheId(pyzone);

                        Dictionary<int,int> levelPlayerCount = new Dictionary<int, int>();  

                        List<UserInfoComponent> userinfoComponentList = await Game.Scene.GetComponent<DBComponent>().Query<UserInfoComponent>(pyzone, d => d.Id > 0);
                        for (int userinfo = 0; userinfo < userinfoComponentList.Count; userinfo++)
                        {
                            UserInfoComponent userInfoComponent = userinfoComponentList[userinfo];
                            if (userInfoComponent.UserInfo.RobotId != 0)
                            {
                                continue;
                            }

                            if (!levelPlayerCount.ContainsKey(userInfoComponent.UserInfo.Lv))
                            {
                                levelPlayerCount.Add(userInfoComponent.UserInfo.Lv, 1);
                            }
                            else
                            {
                                levelPlayerCount[userInfoComponent.UserInfo.Lv]++;
                            }
                            
                        }

                        string levelInfo = $"{pyzone}区玩家等级列表： \n";
                        for(int level = 1; level <= 65; level++)
                        {
                            int levelnumber = 0;
                            levelPlayerCount.TryGetValue(level, out levelnumber);
                            levelInfo = levelInfo + $"等级:{level}  人数:{levelnumber}  \n";
                        }

                        LogHelper.LogWarning(levelInfo, true);
                    }
                    break;
            }

            await ETTask.CompletedTask;

        }
        }
#endif
}
