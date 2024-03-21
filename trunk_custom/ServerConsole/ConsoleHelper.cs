using System;
using System.Collections.Generic;
using System.Linq;

namespace ET
{
    public static class ConsoleHelper
    {

        public static async ETTask OnStopServer(List<int> zoneList)
        {
            await ETTask.CompletedTask;
#if SERVER
            await TimerComponent.Instance.WaitAsync(1 * TimeHelper.Minute);
            for (int i = 0; i < zoneList.Count; i++)
            {
                List<long> mapids = new List<long>()
                            {
                                 StartSceneConfigCategory.Instance.GetBySceneName(zoneList[i], "PaiMai").InstanceId,
                                 StartSceneConfigCategory.Instance.GetBySceneName(zoneList[i], "Rank").InstanceId,
                                 StartSceneConfigCategory.Instance.GetBySceneName(zoneList[i], "Union").InstanceId,
                            };

                for (int map = 0; map < mapids.Count; map++)
                {
                    A2A_ServerMessageRResponse m2m_TrasferUnitResponse = (A2A_ServerMessageRResponse)await ActorMessageSenderComponent.Instance.Call
                            (mapids[map], new A2A_ServerMessageRequest() { MessageType = NoticeType.StopSever });
                }
            }

            await TimerComponent.Instance.WaitAsync(10 * TimeHelper.Minute);
            for (int i = 0; i < zoneList.Count; i++)
            {
                List<long> mapids = new List<long>()
                            {
                                 StartSceneConfigCategory.Instance.GetBySceneName(zoneList[i], "PaiMai").InstanceId,
                                 StartSceneConfigCategory.Instance.GetBySceneName(zoneList[i], "Rank").InstanceId,
                                 StartSceneConfigCategory.Instance.GetBySceneName(zoneList[i], "Union").InstanceId,
                            };

                for (int map = 0; map < mapids.Count; map++)
                {
                    A2A_ServerMessageRResponse m2m_TrasferUnitResponse = (A2A_ServerMessageRResponse)await ActorMessageSenderComponent.Instance.Call
                            (mapids[map], new A2A_ServerMessageRequest() { MessageType = NoticeType.StopSever });
                }
            }

            Log.Warning("数据落地！");
            Log.Console("数据落地！");
            Console.WriteLine("数据落地！");
#endif
        }


        public static async ETTask StopServerConsoleHandler(string content)
        {
            await ETTask.CompletedTask;
#if SERVER

            string[] ss = content.Split(" ");
            if (ss.Length < 4)
            {
                Log.Console($"C must zone");
                return;
            }
            //stopserver 0 0 tcg452241 0 
            //stopserver 0 /  0[停] 0[开] 0[序] 0
            List<int> zoneList = new List<int> { };
            if (ss[1] == "0")
            {
                zoneList = ServerMessageHelper.GetAllZone();
            }
            else
            {
                zoneList.Add(int.Parse(ss[1]));
            }

            if (ss[2] == "0")  //0全部广播停服维护 1开服  2序列号 
            {
                for (int i = 0; i < zoneList.Count; i++)
                {
                    Log.Console($"zoneList111: {zoneList[i]} ");

                    long chatServerId = StartSceneConfigCategory.Instance.GetBySceneName(zoneList[i], "Chat").InstanceId;
                    A2A_ServerMessageRResponse g_SendChatRequest = (A2A_ServerMessageRResponse)await ActorMessageSenderComponent.Instance.Call
                        (chatServerId, new A2A_ServerMessageRequest()
                        {
                            MessageType = NoticeType.StopSever,
                            MessageValue = "停服维护"
                        });
                }
            }

            long accountServerId = StartSceneConfigCategory.Instance.AccountCenterConfig.InstanceId;
            A2A_ServerMessageRResponse response = (A2A_ServerMessageRResponse)await ActorMessageSenderComponent.Instance.Call
                (accountServerId, new A2A_ServerMessageRequest()
                {
                    MessageType = NoticeType.StopSever,
                    MessageValue = $"{ss[2]}_{ss[3]}"
                });

            if (ss[2] == "0")  //0全部广播停服维护 十分钟后数据落地
            {
                OnStopServer(zoneList).Coroutine();
            }

#endif
        }

        public static Dictionary<long, int> ShaiCha(Dictionary<long, int> dic, int showNum, out int minValue)
        {

            //排序
            dic = dic.OrderByDescending(o => o.Value).ToDictionary(p => p.Key, o => o.Value);
            int num = 0;
            int minValueNum = 0;
            foreach (long unitID in dic.Keys)
            {
                num++;

                if (num == dic.Count || num == showNum)
                {
                    minValueNum = dic[unitID];
                }

                if (num > showNum)
                {
                    dic.Remove(unitID);
                }
            }
            minValue = minValueNum;
            return dic;

        }

        public static async ETTask ServerRankConsoleHandler(string content)
        {
            await ETTask.CompletedTask;
            string[] chaxunInfo = content.Split(" ");
            if (chaxunInfo[0] != "serverrank")
            {
                return;
            }
#if SERVER
            int zone = int.Parse(chaxunInfo[1]);
            int pyzone = StartZoneConfigCategory.Instance.Get(zone).PhysicZone;
            long dbCacheId = DBHelper.GetDbCacheId(pyzone);

            Dictionary<long, int> dic = new Dictionary<long, int>();
            int lowCombat = 0;

            //查询全部玩家
            List<UserInfoComponent> userinfoComponentList = await Game.Scene.GetComponent<DBComponent>().Query<UserInfoComponent>(pyzone, d => d.Id > 0);
            for (int i = 0; i < userinfoComponentList.Count; i++)
            {
                UserInfoComponent userInfoComponent = userinfoComponentList[i];
                if (userInfoComponent.UserInfo.RobotId != 0)
                {
                    //continue;
                }


                if (userInfoComponent.UserInfo.Lv < 1)
                {
                    continue;
                }

                int combatFight = userInfoComponent.UserInfo.Combat;
                if (combatFight < lowCombat)
                {
                    continue;
                }

                dic.Add(userInfoComponent.UserInfo.UserId, combatFight);

                if (dic.Count >= 100)
                {

                    //开始筛查
                    dic = ShaiCha(dic, 10, out lowCombat);

                }
            }

            //开始筛查
            dic = ShaiCha(dic, 10, out lowCombat);

            Log.Debug($"服务器注册人数: {userinfoComponentList.Count}");

            foreach (long unitID in dic.Keys)
            {
                List<UserInfoComponent> userinfoComponentSing = await Game.Scene.GetComponent<DBComponent>().Query<UserInfoComponent>(pyzone, d => d.Id > 0 && d.UserInfo.UserId == unitID);
                if (userinfoComponentSing.Count > 0)
                {

                    //获取充值的数值组件
                    List<NumericComponent> numericComponent = await Game.Scene.GetComponent<DBComponent>().Query<NumericComponent>(pyzone, d => d.Id > 0 && d.Id == unitID);
                    string showStr = $"{userinfoComponentSing[0].UserInfo.Name} 战力:{userinfoComponentSing[0].UserInfo.Combat}金币:{userinfoComponentSing[0].UserInfo.Gold} 钻石:{userinfoComponentSing[0].UserInfo.Diamond} 职业{userinfoComponentSing[0].UserInfo.Occ}-{userinfoComponentSing[0].UserInfo.OccTwo} 充值:{numericComponent[0].GetAsInt(NumericType.RechargeNumber)}";
                    Log.Debug($"{showStr}");
                }
            }

#endif
        }

        public static async ETTask PaiMaiConsoleHandler(string content)
        {
            Console.WriteLine($"request.Context:  PaiMaiConsoleHandler: {content}");
            await ETTask.CompletedTask;
            string[] chaxunInfo = content.Split(" ");
            if (chaxunInfo[0] != "paimai")
            {
                Console.WriteLine($"C must have paimai zone");
                Log.Warning($"C must have paimai zone");
                return;
            }
            if (chaxunInfo.Length != 3)
            {
                Console.WriteLine($"C must have paimai zone");
                Log.Warning($"C must have paimai zone");
                return;
            }
#if SERVER
            int zone = int.Parse(chaxunInfo[1]);
            List<int> zonlist = new List<int> { };
            if (zone == 0)
            {
                zonlist = ServerMessageHelper.GetAllZone();
            }
            else
            {
                zonlist.Add(zone);
            }
            long maxGold = long.Parse(chaxunInfo[2]);
            for (int i = 0; i < zonlist.Count; i++)
            {
                int pyzone = StartZoneConfigCategory.Instance.Get(zonlist[i]).PhysicZone;
                long dbCacheId = DBHelper.GetDbCacheId(pyzone);

                List<KeyValuePairLong> allpaimai = new List<KeyValuePairLong>();    
                string levelInfo = $"{pyzone}区玩家拍卖金币>{maxGold}列表： \n";
                List<DataCollationComponent> userinfoComponentList = await Game.Scene.GetComponent<DBComponent>().Query<DataCollationComponent>(pyzone, d => d.PaiMaiGold > maxGold);
                for (int userinfo = 0; userinfo < userinfoComponentList.Count; userinfo++)
                {
                    DataCollationComponent dataComponent = userinfoComponentList[userinfo];
                    //if (GMHelp.GmAccount.Contains(dataComponent.Account))
                    //{
                    //    continue;
                    //}

                    allpaimai.Add( new KeyValuePairLong() { KeyId = dataComponent.Id, Value = dataComponent.PaiMaiGold } );
                }
                
                allpaimai.Sort(delegate (KeyValuePairLong a, KeyValuePairLong b)
                {
                    return (int)(a.Value - b.Value);   
                });

                for (int paimaigold = 0; paimaigold < allpaimai.Count; paimaigold++)
                {
                    KeyValuePairLong pairLong = allpaimai[paimaigold];

                    List<UserInfoComponent> userinfoComponentlist = await Game.Scene.GetComponent<DBComponent>().Query<UserInfoComponent>(pyzone, d => d.Id == pairLong.KeyId);
                    if (userinfoComponentlist == null || userinfoComponentlist.Count == 0)
                    {
                        return;
                    }
                    UserInfoComponent userInfoComponent = userinfoComponentlist[0]; 
                    levelInfo += $"{userInfoComponent.UserInfo.Name}   \t拍卖获得金币:{pairLong.Value}   \t账号:{userInfoComponent.Account}   \t钻石:{userInfoComponent.UserInfo.Diamond}  \t金币:{userInfoComponent.UserInfo.Gold} \n";
                }

                LogHelper.PaiMaiInfo(levelInfo);
            }
#endif
        }

        //allonline
        public static async ETTask AllOnLineConsoleHandler(string content)
        {
            Console.WriteLine($"request.Context:  AllOnLineConsoleHandler: {content}");
            await ETTask.CompletedTask;
            string[] chaxunInfo = content.Split(" ");
            if (chaxunInfo.Length != 2)
            {
                Console.WriteLine($"C must have allonline zone");
                Log.Warning($"C must have allonline zone");
                return;
            }

#if SERVER

            int zone = int.Parse(chaxunInfo[1]);
            List<int> zonlist = new List<int> { };
            if (zone == 0)
            {
                zonlist = ServerMessageHelper.GetAllZone();
            }
            else
            {
                zonlist.Add(zone);
            }

            for (int i = 0; i < zonlist.Count; i++)
            {
                int pyzone = StartZoneConfigCategory.Instance.Get(zonlist[i]).PhysicZone;

                long dbCacheId = DBHelper.GetDbCacheId(pyzone);
                long gateServerId = DBHelper.GetGateServerId(pyzone);

                //string gongzuoshiInfo = $"{pyzone}区所有在线玩家列表： \n";
                //List<UserInfoComponent> userinfoComponentList = await Game.Scene.GetComponent<DBComponent>().Query<UserInfoComponent>(pyzone, d => d.Id > 0);
                //for (int userinfo = 0; userinfo < userinfoComponentList.Count; userinfo++)
                //{
                //    UserInfoComponent userInfoComponent = userinfoComponentList[userinfo];
                //    if (userInfoComponent.UserInfo.RobotId != 0)
                //    {
                //        continue;
                //    }

                //    List<DataCollationComponent> dataCollations = await Game.Scene.GetComponent<DBComponent>().Query<DataCollationComponent>(pyzone, d => d.Id == userInfoComponent.Id);
                //    if (dataCollations == null || dataCollations.Count == 0)
                //    {
                //        continue;
                //    }

                //    List<ChengJiuComponent> chengJiuComponents = await Game.Scene.GetComponent<DBComponent>().Query<ChengJiuComponent>(pyzone, d => d.Id == userInfoComponent.Id);
                //    if (chengJiuComponents == null || chengJiuComponents.Count == 0)
                //    {
                //        continue;
                //    }

                //    List<TaskComponent> taskComponents = await Game.Scene.GetComponent<DBComponent>().Query<TaskComponent>(pyzone, d => d.Id == userInfoComponent.Id);
                //    if (taskComponents == null || taskComponents.Count == 0)
                //    {
                //        continue;
                //    }

                //    G2T_GateUnitInfoResponse g2M_UpdateUnitResponse = (G2T_GateUnitInfoResponse)await ActorMessageSenderComponent.Instance.Call
                //(gateServerId, new T2G_GateUnitInfoRequest()
                //{
                //    UserID = userInfoComponent.Id
                //});

                //    if (g2M_UpdateUnitResponse.SessionInstanceId == 0 || g2M_UpdateUnitResponse.PlayerState != (int)PlayerState.Game)
                //    {
                //        continue;
                //    }

                //    //名称 等级 账号 金币 钻石 充值额度  当前体力 成就值  击败BOSS数量 今日在线时间 总游戏在线时间 拍卖行收益  主线任务ID

                //    gongzuoshiInfo += $"账号: {userInfoComponent.Account} 名称:{userInfoComponent.UserInfo.Name} 等级:{userInfoComponent.UserInfo.Lv} " +
                //    $"金币:{userInfoComponent.UserInfo.Gold} 钻石:{userInfoComponent.UserInfo.Diamond} 充值额度:{dataCollations[0].Recharge} 当前体力:{userInfoComponent.UserInfo.PiLao}" +
                //    $"成就值:{chengJiuComponents[0].TotalChengJiuPoint} 击败boss数量:{userInfoComponent.UserInfo.MonsterRevives.Count} 今日在线时间:{dataCollations[0].TodayOnLine}" +
                //    $"拍卖收益:{dataCollations[0].GetCostByType(ItemGetWay.PaiMaiSell)}  主线任务:{dataCollations[0].MainTask}";
                //}

                //Log.Warning(gongzuoshiInfo);
                int numeber = 0;
                G2G_UnitListResponse g2M_UpdateUnitResponse = (G2G_UnitListResponse)await ActorMessageSenderComponent.Instance.Call
                    (gateServerId, new G2G_UnitListRequest() { });
                numeber += g2M_UpdateUnitResponse.OnLinePlayer;

                Console.WriteLine($"区： {pyzone}    在线人数: {numeber}");
            }
#endif
        }


        //gongzuoshi
        public static async ETTask GongZuoShiConsoleHandler(string content)
        {
            Console.WriteLine($"request.Context:  GongZuoShiConsoleHandler: {content}");
            await ETTask.CompletedTask;
            string[] chaxunInfo = content.Split(" ");
            if (chaxunInfo.Length != 2)
            {
                Console.WriteLine($"C must have gongzuoshi zone");
                Log.Warning($"C must have gongzuoshi zone");
                return;
            }

#if SERVER

            int zone = int.Parse(chaxunInfo[1]);
            List<int> zonlist = new List<int> { };
            if (zone == 0)
            {
                zonlist = ServerMessageHelper.GetAllZone();
            }
            else
            {
                zonlist.Add(zone);
            }

            //1.游戏总时长超过180分钟
            //2.击败BOSS数量小于3
            //3.游戏内成就点数小于50点
            //4.手机登录
            //5.当前体力小于50
            //6.今日在线时间超过120分钟
            //7.主线任务完成不超过10个
            //8.拍卖行收益总共超过100万

            long serverNow = TimeHelper.ServerNow();
            int curDate = ComHelp.GetDayByTime(serverNow);
           
            Dictionary<string, int> accountNumber = new Dictionary<string, int>();  

            for (int i = 0; i < zonlist.Count; i++)
            {
                int pyzone = StartZoneConfigCategory.Instance.Get(zonlist[i]).PhysicZone;

                long dbCacheId = DBHelper.GetDbCacheId(pyzone);

                string gongzuoshiInfo = $"{pyzone}区疑似工作室账号列表1： \n";


                long gateServerId = StartSceneConfigCategory.Instance.GetBySceneName(pyzone, "Gate1").InstanceId;
                G2G_UnitListResponse g2M_UpdateUnitResponse = (G2G_UnitListResponse)await ActorMessageSenderComponent.Instance.Call
                    (gateServerId, new G2G_UnitListRequest() { });

                Console.WriteLine($"{pyzone}区 在线人数:{g2M_UpdateUnitResponse.UnitList.Count}");
                for (int userinfo = 0; userinfo < g2M_UpdateUnitResponse.UnitList.Count; userinfo++)
                {
                    long unitId = g2M_UpdateUnitResponse.UnitList[userinfo];

                    List<UserInfoComponent> userinfoComponentList = await Game.Scene.GetComponent<DBComponent>().Query<UserInfoComponent>(pyzone, d => d.Id == unitId);
                    if(userinfoComponentList == null || userinfoComponentList.Count == 0)
                    {
                        continue;
                    }

                    UserInfoComponent userInfoComponent = userinfoComponentList[0];
                    if (userInfoComponent.UserInfo.RobotId != 0)
                    {
                        continue;
                    }

                    if (GMHelp.GmAccount.Contains(userInfoComponent.Account))
                    {
                        continue;
                    }

                    //击败boss>3返回
                    if (userInfoComponent.UserInfo.MonsterRevives.Count > 3)
                    {
                        continue;
                    }

                    //当前体力>50返回
                    if (userInfoComponent.UserInfo.PiLao > 50)
                    {
                        continue;
                    }

                    //if (curDate != ComHelp.GetDayByTime(userInfoComponent.LastLoginTime))
                    //{
                    //    continue;
                    //}

                    //非手机登录返回
                    //if (string.IsNullOrEmpty(userInfoComponent.Account) || userInfoComponent.Account[0] != '1')
                    //{
                    //    continue;
                    //}

                    List<DataCollationComponent> dataCollations = await Game.Scene.GetComponent<DBComponent>().Query<DataCollationComponent>(pyzone, d => d.Id == userInfoComponent.Id);
                    if (dataCollations == null || dataCollations.Count == 0)
                    {
                        continue;
                    }
                    //游戏总时长超过180分钟返回
                    //暂时不写

                    //今日在线时间超过120分钟返回
                    if (dataCollations[0].TodayOnLine < 120)
                    {
                        continue;
                    }

                    //拍卖行收益总小于100万返回
                    //if (dataCollations[0].GetCostByType(ItemGetWay.PaiMaiBuy) < 1000000)
                    //{
                    //    continue;
                    //}

                    List<ChengJiuComponent> chengJiuComponents = await Game.Scene.GetComponent<DBComponent>().Query<ChengJiuComponent>(pyzone, d => d.Id == userInfoComponent.Id);
                    if (chengJiuComponents == null || chengJiuComponents.Count == 0)
                    {
                        continue;
                    }

                    //游戏内成就点数>50点返回
                    if (chengJiuComponents[0].TotalChengJiuPoint > 50)
                    {
                        continue;
                    }

                    List<TaskComponent> taskComponents = await Game.Scene.GetComponent<DBComponent>().Query<TaskComponent>(pyzone, d => d.Id == userInfoComponent.Id);
                    if (taskComponents == null || taskComponents.Count == 0)
                    {
                        continue;
                    }

                    if (taskComponents[0].GetMainTaskNumber() > 10)
                    {
                        continue;
                    }

                    List<DBCenterAccountInfo> accoutResult = await Game.Scene.GetComponent<DBComponent>().Query<DBCenterAccountInfo>(202, _account => _account.Account == userInfoComponent.Account);
                    if (accoutResult == null || accoutResult.Count == 0)
                    {
                        continue;
                    }
                    if (accoutResult[0].AccountType == 2)
                    {
                        continue;
                    }

                    //等级 充值  活跃度 体力 当前金币   成就点数  当前主线任务
                    gongzuoshiInfo += $"账号: {userInfoComponent.Account}  \t名称：{userInfoComponent.UserInfo.Name}  \t等级:{userInfoComponent.UserInfo.Lv}   \t充值:{dataCollations[0].Recharge}" +
                        $"\t体力:{userInfoComponent.UserInfo.PiLao}  \t金币:{userInfoComponent.UserInfo.Gold}   \t成就值:{chengJiuComponents[0].TotalChengJiuPoint}   \t拍卖消耗:{dataCollations[0].GetCostByType(ItemGetWay.PaiMaiBuy)}" +
                        $"\t当前主线:{dataCollations[0].MainTask}  \t角色天数:{userInfoComponent.GetCrateDay()}  \t设备:{dataCollations[0].GetDeviceID()} \n";


                    if(!accountNumber.ContainsKey(userInfoComponent.Account))
                    {
                        accountNumber.Add(userInfoComponent.Account, 0);
                    }
                    accountNumber[userInfoComponent.Account]++;
                }

                //foreach ( (string account, int number) in accountNumber )
                //{
                //     if (number >= 1) 一次以上封账号封角色id
                //{ 
                //}
                //    if (number >= 3)  //三次以上封账号封设备id
                //    {
                //        List<DBCenterAccountInfo> accoutResult = await Game.Scene.GetComponent<DBComponent>().Query<DBCenterAccountInfo>(202, _account => _account.Account == account);
                //        if (accoutResult != null && accoutResult.Count > 0)
                //        {
                //            accoutResult[0].AccountType = 2;
                //            Game.Scene.GetComponent<DBComponent>().Save<DBCenterAccountInfo>(202, accoutResult[0]).Coroutine();
                //        }
                //    }
                //}

                LogHelper.PaiMaiInfo(gongzuoshiInfo); 
            }
#endif
        }


        //gongzuoshi
        public static async ETTask GongZuoShi2_ConsoleHandler(string content)
        {
            Console.WriteLine($"request.Context:  GongZuoShiConsoleHandler: {content}");
            await ETTask.CompletedTask;
            string[] chaxunInfo = content.Split(" ");
            if (chaxunInfo.Length != 2)
            {
                Console.WriteLine($"C must have gongzuoshi zone");
                Log.Warning($"C must have gongzuoshi zone");
                return;
            }

#if SERVER

            int zone = int.Parse(chaxunInfo[1]);
            List<int> zonlist = new List<int> { };
            if (zone == 0)
            {
                zonlist = ServerMessageHelper.GetAllZone();
            }
            else
            {
                zonlist.Add(zone);
            }

            //1.游戏总时长超过180分钟
            //2.击败BOSS数量小于3
            //3.游戏内成就4個擊殺boss都沒完成 10000002-10000005
            //4.手机登录
            //5.当前体力小于50
            //6.今日在线时间超过120分钟
            //7.主线任务完成不超过10个
            //8.拍卖行收益总共超过100万
            long serverNow = TimeHelper.ServerNow();
            int curDate = ComHelp.GetDayByTime(serverNow);

            Dictionary<string, int> accountNumber = new Dictionary<string, int>();

            for (int i = 0; i < zonlist.Count; i++)
            {
                int pyzone = StartZoneConfigCategory.Instance.Get(zonlist[i]).PhysicZone;

                long dbCacheId = DBHelper.GetDbCacheId(pyzone);

                string gongzuoshiInfo = $"{pyzone}区疑似工作室账号列表2： \n";


                long gateServerId = StartSceneConfigCategory.Instance.GetBySceneName(pyzone, "Gate1").InstanceId;
                G2G_UnitListResponse g2M_UpdateUnitResponse = (G2G_UnitListResponse)await ActorMessageSenderComponent.Instance.Call
                    (gateServerId, new G2G_UnitListRequest() { });

                Console.WriteLine($"{pyzone}区 在线人数:{g2M_UpdateUnitResponse.UnitList.Count}");
                for (int userinfo = 0; userinfo < g2M_UpdateUnitResponse.UnitList.Count; userinfo++)
                {
                    long unitId = g2M_UpdateUnitResponse.UnitList[userinfo];

                    List<UserInfoComponent> userinfoComponentList = await Game.Scene.GetComponent<DBComponent>().Query<UserInfoComponent>(pyzone, d => d.Id == unitId);
                    if (userinfoComponentList == null || userinfoComponentList.Count == 0)
                    {
                        continue;
                    }
                    UserInfoComponent userInfoComponent = userinfoComponentList[0];

                    if (GMHelp.GmAccount.Contains(userInfoComponent.Account))
                    {
                        continue;
                    }

                    //击败boss>3返回
                    if (userInfoComponent.UserInfo.MonsterRevives.Count > 3)
                    {
                        continue;
                    }
                    //当前体力>50返回
                    if (userInfoComponent.UserInfo.PiLao > 50)
                    {
                        continue;
                    }

                    if (curDate != ComHelp.GetDayByTime(userInfoComponent.LastLoginTime))
                    {
                        continue;
                    }


                    //非手机登录返回
                    //if (string.IsNullOrEmpty(userInfoComponent.Account) || userInfoComponent.Account[0] != '1')
                    //{
                    //    continue;
                    //}

                    List<DataCollationComponent> dataCollations = await Game.Scene.GetComponent<DBComponent>().Query<DataCollationComponent>(pyzone, d => d.Id == userInfoComponent.Id);
                    if (dataCollations == null || dataCollations.Count == 0)
                    {
                        continue;
                    }
                    //游戏总时长超过180分钟返回
                    //暂时不写

                    //今日在线时间超过120分钟返回
                    if (dataCollations[0].TodayOnLine < 120)
                    {
                        continue;
                    }

                    //拍卖行收益总小于100万返回
                    //if (dataCollations[0].GetCostByType(ItemGetWay.PaiMaiBuy) < 1000000)
                    //{
                    //    continue;
                    //}

                    List<ChengJiuComponent> chengJiuComponents = await Game.Scene.GetComponent<DBComponent>().Query<ChengJiuComponent>(pyzone, d => d.Id == userInfoComponent.Id);
                    if (chengJiuComponents == null || chengJiuComponents.Count == 0)
                    {
                        continue;
                    }

                    //3.游戏内成就4個擊殺boss都沒完成 10000002 - 10000005
                    if (chengJiuComponents[0].ChengJiuCompleteList.Contains(10000002)
                        || chengJiuComponents[0].ChengJiuCompleteList.Contains(10000003)
                        || chengJiuComponents[0].ChengJiuCompleteList.Contains(10000004)
                        || chengJiuComponents[0].ChengJiuCompleteList.Contains(10000005))
                    {
                        continue;
                    }


                    List<TaskComponent> taskComponents = await Game.Scene.GetComponent<DBComponent>().Query<TaskComponent>(pyzone, d => d.Id == userInfoComponent.Id);
                    if (taskComponents == null || taskComponents.Count == 0)
                    {
                        continue;
                    }
                    if (taskComponents[0].GetMainTaskNumber() > 10)
                    {
                        continue;
                    }


                    List<DBCenterAccountInfo> accoutResult = await Game.Scene.GetComponent<DBComponent>().Query<DBCenterAccountInfo>(202, _account => _account.Account == userInfoComponent.Account);
                    if (accoutResult == null || accoutResult.Count == 0)
                    {
                        continue;
                    }
                    if (accoutResult[0].AccountType == 2)
                    {
                        continue;
                    }

                    //等级 充值  活跃度 体力 当前金币   成就点数  当前主线任务
                    gongzuoshiInfo += $"账号: {userInfoComponent.Account}  \t名称：{userInfoComponent.UserInfo.Name}  \t等级:{userInfoComponent.UserInfo.Lv}   \t充值:{dataCollations[0].Recharge}" +
                        $"\t体力:{userInfoComponent.UserInfo.PiLao}  \t金币:{userInfoComponent.UserInfo.Gold}   \t成就值:{chengJiuComponents[0].TotalChengJiuPoint}   \t拍卖消耗:{dataCollations[0].GetCostByType(ItemGetWay.PaiMaiBuy)}" +
                        $"\t当前主线:{dataCollations[0].MainTask}  \t角色天数:{userInfoComponent.GetCrateDay()}  \t设备:{dataCollations[0].GetDeviceID()} \n";


                    if (!accountNumber.ContainsKey(userInfoComponent.Account))
                    {
                        accountNumber.Add(userInfoComponent.Account, 0);
                    }
                    accountNumber[userInfoComponent.Account]++;
                }

                //foreach ((string account, int number) in accountNumber)
                //{
                //    if (number >= 3)
                //    {
                //        List<DBCenterAccountInfo> accoutResult = await Game.Scene.GetComponent<DBComponent>().Query<DBCenterAccountInfo>(202, _account => _account.Account == account);
                //        if (accoutResult != null && accoutResult.Count > 0)
                //        {
                //            accoutResult[0].AccountType = 2;
                //            Game.Scene.GetComponent<DBComponent>().Save<DBCenterAccountInfo>(202, accoutResult[0]).Coroutine();
                //        }
                //    }
                //}
                LogHelper.PaiMaiInfo(gongzuoshiInfo);
            }
#endif
        }

        //gold  diamond
        public static async ETTask GoldConsoleHandler(string content, string chaxun)
        {
            Console.WriteLine($"request.Context:  GoldConsoleHandler: {content}");
            await ETTask.CompletedTask;
            string[] chaxunInfo = content.Split(" ");
            if (chaxunInfo[0] != chaxun)
            {
                Console.WriteLine($"C must have gold zone");
                Log.Warning($"C must have gold zone");
                return;
            }
            if (chaxunInfo.Length != 3)
            {
                Console.WriteLine($"C must have gold zone");
                Log.Warning($"C must have gold zone");
                return;
            }
#if SERVER
            int zone = int.Parse(chaxunInfo[1]);
            List<int> zonlist = new List<int> { };
            if (zone == 0)
            {
                zonlist = ServerMessageHelper.GetAllZone();
            }
            else
            {
                zonlist.Add(zone);
            }
            long maxGold = long.Parse(chaxunInfo[2]);
            for (int i = 0; i < zonlist.Count; i++)
            {
                int pyzone = StartZoneConfigCategory.Instance.Get(zonlist[i]).PhysicZone;

                long dbCacheId = DBHelper.GetDbCacheId(pyzone);

                string levelInfo = $"{pyzone}区玩家{chaxun}>{maxGold}列表： \n";
                List<UserInfoComponent> userinfoComponentList = await Game.Scene.GetComponent<DBComponent>().Query<UserInfoComponent>(pyzone, d => d.Id > 0);
                for (int userinfo = 0; userinfo < userinfoComponentList.Count; userinfo++)
                {
                    UserInfoComponent userInfoComponent = userinfoComponentList[userinfo];
                    if (userInfoComponent.UserInfo.RobotId != 0 )
                    {
                        continue;
                    }

                    if (GMHelp.GmAccount.Contains(userInfoComponent.Account))
                    {
                        continue;
                    }

                    if (chaxun == "gold")
                    {
                        if (userInfoComponent.UserInfo.Gold < maxGold)
                        {
                            continue;
                        }

                        List<NumericComponent> NumericComponentlist = await Game.Scene.GetComponent<DBComponent>().Query<NumericComponent>(pyzone, d => d.Id == userInfoComponent.Id);
                        if (NumericComponentlist == null || NumericComponentlist.Count == 0)
                        {
                            continue;
                        }
                        int recharge = NumericComponentlist[0].GetAsInt(NumericType.RechargeNumber);

                        levelInfo = levelInfo + $"区: {pyzone} 玩家:{userInfoComponent.UserInfo.Name} 等级:{userInfoComponent.UserInfo.Lv} 金币:{userInfoComponent.UserInfo.Gold} 充值:{recharge} \n";
                    }
                    if (chaxun == "diamond")
                    {
                        if (userInfoComponent.UserInfo.Diamond < maxGold)
                        {
                            continue;
                        }

                        List<NumericComponent> NumericComponentlist = await Game.Scene.GetComponent<DBComponent>().Query<NumericComponent>(pyzone, d => d.Id == userInfoComponent.Id);
                        if (NumericComponentlist == null || NumericComponentlist.Count == 0)
                        {
                            continue;
                        }
                        int recharge = NumericComponentlist[0].GetAsInt(NumericType.RechargeNumber);

                        levelInfo = levelInfo + $"区: {pyzone} 玩家:{userInfoComponent.UserInfo.Name} 等级:{userInfoComponent.UserInfo.Lv} 钻石:{userInfoComponent.UserInfo.Diamond} 充值:{recharge} \n";
                    }
                }

                Log.Warning(levelInfo);
            }
#endif
        }

        public static async ETTask LevelConsoleHandler(string content)
        {
            await ETTask.CompletedTask;
            string[] chaxunInfo = content.Split(" ");
            if (chaxunInfo[0] != "level")
            {
                Log.Console($"C must have level zone");
                Log.Warning($"C must have level zone");
                return;
            }
            if (chaxunInfo.Length != 2)
            {
                Log.Console($"C must have level zone");
                Log.Warning($"C must have level zone");
                return;
            }
#if SERVER
            int zone = int.Parse(chaxunInfo[1]);
            List<int> zonlist = new List<int> { };
            if (zone == 0)
            {
                zonlist = ServerMessageHelper.GetAllZone();
            }
            else
            {
                zonlist.Add(zone);
            }

            for (int i = 0; i < zonlist.Count; i++)
            {
                int pyzone = StartZoneConfigCategory.Instance.Get(zonlist[i]).PhysicZone;

                long dbCacheId = DBHelper.GetDbCacheId(pyzone);

                Dictionary<int, int> levelPlayerCount = new Dictionary<int, int>();

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
                for (int level = 1; level <= 65; level++)
                {
                    int levelnumber = 0;
                    levelPlayerCount.TryGetValue(level, out levelnumber);
                    levelInfo = levelInfo + $"等级:{level}  人数:{levelnumber}  \n";
                }

                LogHelper.LogWarning(levelInfo, true);
            }
#endif
        }

        public static void KickOutConsoleHandler(string content)
        {
            //kickout 1    1
            string[] chaxunInfo = content.Split(" ");
            if (chaxunInfo[0] != "kickout")
            {
                return;
            }
#if SERVER
            int zone = int.Parse(chaxunInfo[1]);
            int pyzone = StartZoneConfigCategory.Instance.Get(zone).PhysicZone;
            long unitid = long.Parse(chaxunInfo[2]);

            DisconnectHelper.KickPlayer(pyzone, unitid).Coroutine();
#endif
        }

        public static async ETTask CombatConsoleHandler(string content)
        {
            await ETTask.CompletedTask;
            string[] ss = content.Split(" ");
            string zoneid = ss[1];
#if SERVER
            List<int> zoneList = ServerMessageHelper.GetAllZone();
            for (int i = 0; i < zoneList.Count; i++)
            {
                long rankServerId = StartSceneConfigCategory.Instance.GetBySceneName(zoneList[i], "Rank").InstanceId;
                await ServerMessageHelper.SendServerMessage(rankServerId, NoticeType.RankRefresh, String.Empty);
                await TimerComponent.Instance.WaitAsync(10000);
            }
#endif
        }
        
        public static async ETTask<string> ChaXunConsoleHandler(string content)
        {
            await ETTask.CompletedTask;
            //chaxun 1 ""
            string[] chaxunInfo = content.Split(" ");
            if (chaxunInfo[0] != "chaxun")
            {
                return string.Empty;
            }

#if SERVER
            int zone = int.Parse(chaxunInfo[1]);
            int pyzone = StartZoneConfigCategory.Instance.Get(zone).PhysicZone;
            long dbCacheId = DBHelper.GetDbCacheId(pyzone);

            //查询全区金币异常
            if (chaxunInfo.Length == 2)
            {
                List<UserInfoComponent> userinfoComponentList = await Game.Scene.GetComponent<DBComponent>().Query<UserInfoComponent>(pyzone, d => d.Id > 0);
                for (int i = 0; i < userinfoComponentList.Count; i++)
                {
                    UserInfoComponent userInfoComponent = userinfoComponentList[i];
                    if (userInfoComponent.UserInfo.RobotId != 0)
                    {
                        continue;
                    }
                    long gold = userInfoComponent.UserInfo.Gold;
                    long diamond = userInfoComponent.UserInfo.Diamond;

                    if (gold > 1000000 || diamond > 10000)
                    {
                        long unitId = userinfoComponentList[0].Id;

                        List<BagComponent> baginfoInfoList = await Game.Scene.GetComponent<DBComponent>().Query<BagComponent>(pyzone, d => d.Id == unitId);
                        List<BagInfo> bagInfosAll = baginfoInfoList[0].GetAllItems();

                        string infolist = $"{userInfoComponent.UserInfo.Name}:  \n";
                        infolist = infolist + $"金币： {gold} \n";
                        infolist = infolist + $"钻石： {diamond} \n";

                        for (int b = 0; b < bagInfosAll.Count; b++)
                        {
                            infolist = infolist + $"{bagInfosAll[b].ItemID};{bagInfosAll[b].ItemNum}\n";
                        }
                        LogHelper.LogWarning(infolist);
                    }
                }
            }

            //查询单个玩家
            if (chaxunInfo.Length == 3)
            {
                LogHelper.LogDebug($"name: {chaxunInfo[2]}");
                List<UserInfoComponent> userinfoComponentList = await Game.Scene.GetComponent<DBComponent>().Query<UserInfoComponent>(pyzone, d => d.Id > 0 && d.UserInfo.Name == chaxunInfo[2]);
                if (userinfoComponentList.Count == 0)
                {
                    return string.Empty;
                }
                long unitId = userinfoComponentList[0].Id;
                IActorResponse reqEnter = (M2G_RequestEnterGameState)await MessageHelper.CallLocationActor(unitId, new G2M_RequestEnterGameState()
                {
                    GateSessionActorId = -1
                });
                if (reqEnter.Error != ErrorCode.ERR_Success)
                {
                    Log.Console("玩家不在线！");
                    return "玩家不在线！";
                }
                else
                {
                    Log.Console(reqEnter.Message);
                    return reqEnter.Message;
                }
            }

#endif
            return string.Empty;
        }

        public static async ETTask<int> ReloadDllConsoleHandler(string content)
        {
            await ETTask.CompletedTask;
            string[] ss = content.Split(" ");

            if (ss.Length != 3)
            {
                return ErrorCode.ERR_Parameter;
            }

            int loadType = int.Parse(ss[1]);
            string LoadValue = ss[2];
#if SERVER
            //Game.EventSystem.Add(DllHelper.GetHotfixAssembly());
            //Game.EventSystem.Load();

            List<StartProcessConfig> listprogress = StartProcessConfigCategory.Instance.GetAll().Values.ToList();
            Log.Console("C2M_Reload_a: listprogress " + listprogress.Count);
            Log.Warning("C2M_Reload_a: listprogress " + listprogress.Count);
            for (int i = 0; i < listprogress.Count; i++)
            {
                List<StartSceneConfig> processScenes = StartSceneConfigCategory.Instance.GetByProcess(listprogress[i].Id);
                if (processScenes.Count == 0)  // || listprogress[i].Id == 203)
                {
                    continue;
                }

                StartSceneConfig startSceneConfig = processScenes[0];
                Log.Console("C2M_Reload_a: processScenes " + startSceneConfig);
                Log.Warning("C2M_Reload_a: processScenes " + startSceneConfig);
                try
                {
                    long mapInstanceId = StartSceneConfigCategory.Instance.GetBySceneName(startSceneConfig.Zone, startSceneConfig.Name).InstanceId;
                    A2G_Reload createUnit = (A2G_Reload)await ActorMessageSenderComponent.Instance.Call(
                        mapInstanceId, new G2A_Reload() { LoadType = loadType, LoadValue = LoadValue });

                    if (createUnit.Error != ErrorCode.ERR_Success)
                    {
                        Log.Console("C2M_Reload_a: error " + startSceneConfig);
                        Log.Warning("C2M_Reload_a: error " + startSceneConfig);
                    }
                }
                catch (Exception ex)
                {
                    Log.Error(ex);
                }
            }
#endif
            return ErrorCode.ERR_Success;
        }

        public static async ETTask<int> BlackConsoleHandler(string content)
        {
            await ETTask.CompletedTask;

#if SERVER
            string[] chaxunInfo = content.Split(" ");
            int zone = int.Parse(chaxunInfo[1]);
            int pyzone = StartZoneConfigCategory.Instance.Get(zone).PhysicZone;
            string userName = chaxunInfo[2];
            List<UserInfoComponent> accountInfoList = await Game.Scene.GetComponent<DBComponent>().Query<UserInfoComponent>(pyzone, d => d.UserInfo.Name == userName);
            if (accountInfoList == null || accountInfoList.Count == 0)
            {
                return ErrorCode.ERR_NotFindAccount;
            }
            List<DBCenterAccountInfo> accoutResult = await Game.Scene.GetComponent<DBComponent>().Query<DBCenterAccountInfo>(202, _account => _account.Id == accountInfoList[0].UserInfo.AccInfoID);
            if (accoutResult == null || accoutResult.Count == 0)
            {
                return ErrorCode.ERR_NotFindAccount;
            }
            accoutResult[0].AccountType = 2;
            Game.Scene.GetComponent<DBComponent>().Save<DBCenterAccountInfo>(202, accoutResult[0]).Coroutine();
#endif
            return ErrorCode.ERR_Success;
        }

        public static async ETTask<int> MailConsoleHandler(string content)
        {
            await ETTask.CompletedTask;
            //mail 区服(0所有区服  1指定区服)  玩家ID(0所有玩家)  道具 邮件类型 参数 管理员
            //mail 0 0 1;1 2 “6” tt
            string[] mailInfo = content.Split(" ");
            if (mailInfo[0] != "mail" && mailInfo.Length < 6)
            {
                Log.Console("邮件发送失败！");
                Log.Warning("邮件发送失败！");
                return ErrorCode.ERR_Parameter;
            }
            try
            {
                int mailtype = int.Parse(mailInfo[4]);
            }
            catch (Exception ex)
            {
                Log.Console("邮件发送失败！" + ex.ToString());
                Log.Warning("邮件发送失败！" + ex.ToString());
                return ErrorCode.ERR_Parameter;
            }

#if SERVER
            //全服邮件
            if (mailInfo[1] == "0")
            {
                if (mailInfo.Length < 7 && mailInfo[6] != DllHelper.Admin)
                {
                    Log.Console("发送全服邮件0！");
                    return ErrorCode.ERR_Parameter;
                }
                Log.Console("发送全服邮件1！");
            }
            List<int> zoneList = new List<int> { };
            if (mailInfo[1] == "0")
            {
                zoneList = ServerMessageHelper.GetAllZone();
            }
            else
            {
                zoneList.Add(int.Parse(mailInfo[1]));
            }

            for (int i = 0; i < zoneList.Count; i++)
            {
                try
                {
                    int pyzone = StartZoneConfigCategory.Instance.Get(zoneList[i]).PhysicZone;
                    Console.WriteLine($"邮件； {zoneList[i]} {pyzone} {content}");
                    long gateServerId = StartSceneConfigCategory.Instance.GetBySceneName(pyzone, "EMail").InstanceId;
                    E2M_GMEMailSendResponse g2M_UpdateUnitResponse = (E2M_GMEMailSendResponse)await ActorMessageSenderComponent.Instance.Call
                        (gateServerId, new M2E_GMEMailSendRequest()
                        {
                            UserName = mailInfo[2],
                            Itemlist = mailInfo[3],
                            Title = mailInfo[5],
                            ActorId = zoneList[i],
                            MailType = int.Parse(mailInfo[4]),
                        });
                    if (g2M_UpdateUnitResponse.Error == ErrorCode.ERR_Success)
                    {
                        Log.Console($"邮件发送成功！：{pyzone}区");
                    }
                    else
                    {
                        Log.Console($"邮件发送失败！：{pyzone}区：" + g2M_UpdateUnitResponse.Message);
                    }
                }
                catch (Exception ex)
                {
                    Log.Console("邮件发送异常！： " + ex.ToString());
                }
            }
#endif

            return ErrorCode.ERR_Success;
        }

        public static async ETTask<int> Mail2ConsoleHandler(string content)
        {
            await ETTask.CompletedTask;
            //mail 区服(0所有区服  1指定区服)  玩家ID(0所有玩家)  道具 邮件类型 参数 管理员
            //mail 0 0 1;1 2 “6” tt
            string[] mailInfo = content.Split(" ");
            if (mailInfo[0] != "mail" && mailInfo.Length < 6)
            {
                Log.Console("邮件发送失败！");
                Log.Warning("邮件发送失败！");
                return ErrorCode.ERR_Parameter;
            }
            try
            {
                int mailtype = int.Parse(mailInfo[4]);
            }
            catch (Exception ex)
            {
                Log.Console("邮件发送失败！" + ex.ToString());
                Log.Warning("邮件发送失败！" + ex.ToString());
                return ErrorCode.ERR_Parameter;
            }

#if SERVER
            //全服邮件
            if (mailInfo[1] == "0")
            {
                if (mailInfo.Length < 7 && mailInfo[6] != DllHelper.Admin)
                {
                    Log.Console("发送全服邮件0！");
                    return ErrorCode.ERR_Parameter;
                }
                Log.Console("发送全服邮件1！");
            }
            List<int> zoneList = new List<int> { };
            if (mailInfo[1] == "0")
            {
                zoneList = ServerMessageHelper.GetAllZone();
            }
            else
            {
                zoneList.Add(int.Parse(mailInfo[1]));
            }

            for (int i = 0; i < zoneList.Count; i++)
            {
                try
                {
                    int pyzone = StartZoneConfigCategory.Instance.Get(zoneList[i]).PhysicZone;
                    long gateServerId = StartSceneConfigCategory.Instance.GetBySceneName(pyzone, "EMail").InstanceId;
                    E2M_GMEMailSendResponse g2M_UpdateUnitResponse = (E2M_GMEMailSendResponse)await ActorMessageSenderComponent.Instance.Call
                        (gateServerId, new M2E_GMEMailSendRequest()
                        {
                            UserName = mailInfo[2],
                            Itemlist = mailInfo[3],
                            Title = mailInfo[5],
                            ActorId = zoneList[i],
                            MailType = int.Parse(mailInfo[4]),
                        });
                    if (g2M_UpdateUnitResponse.Error == ErrorCode.ERR_Success)
                    {
                        Log.Console($"邮件发送成功！：{pyzone}区");
                    }
                    else
                    {
                        Log.Console($"邮件发送失败！：{pyzone}区：" + g2M_UpdateUnitResponse.Message);
                    }
                }
                catch (Exception ex)
                {
                    Log.Console("邮件发送异常！： " + ex.ToString());
                }
            }
#endif

            return ErrorCode.ERR_Success;
        }
    }
}
