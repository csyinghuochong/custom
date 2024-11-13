using MongoDB.Bson;
using MongoDB.Bson.Serialization;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;

namespace ET
{
    public static  class ArchiveHelper
    {

        public static async ETTask OnArchiveHandler(int zone, long unitid, int day) //archive 5 2631939174340558848 1
        {
            await ETTask.CompletedTask;
            ActivityComponent old_activityComponent = GetDBComponent<ActivityComponent>(zone, unitid, day, DBHelper.ActivityComponent);
            if (old_activityComponent == null)
            {
                Console.WriteLine($"OnArchiveHandler  activityComponent==null:   {zone} {unitid}");
                return;
            }

            BagComponent old_bagComponent = GetDBComponent<BagComponent>(zone, unitid, day, DBHelper.BagComponent);
            if (old_bagComponent==null)
            {
                Console.WriteLine($"OnArchiveHandler  bagComponent==null:   {zone} {unitid}");
                return;
            }

            ChengJiuComponent old_chengJiuComponent = GetDBComponent<ChengJiuComponent>(zone, unitid, day, DBHelper.ChengJiuComponent);
            if (old_chengJiuComponent == null)
            {
                Console.WriteLine($"OnArchiveHandler  chengJiuComponent==null:   {zone} {unitid}");
                return;
            }

            DBFriendInfo old_dBFriendInfo = GetDBComponent<DBFriendInfo>(zone, unitid, day, DBHelper.DBFriendInfo);
            if (old_dBFriendInfo == null)
            {
                Console.WriteLine($"OnArchiveHandler  dBFriendInfo==null:   {zone} {unitid}");
                return;
            }

            DBMailInfo old_dBMailInfo = GetDBComponent<DBMailInfo>(zone, unitid, day, DBHelper.DBMailInfo);
            if (old_dBMailInfo == null)
            {
                Console.WriteLine($"OnArchiveHandler  dBMailInfo==null:   {zone} {unitid}");
                return;
            }

            // 会通知拍卖服移除玩家上架的道具。
            ////PaiMaiHelper.Instance.GetPaiMaiId(1) 
            //DBPaiMainInfo dBPaiMainInfo = GetDBComponent<DBPaiMainInfo>(zone, unitid, DBHelper.DBPaiMainInfo);
            //if (dBPaiMainInfo == null)
            //{
            //    Console.WriteLine($"OnArchiveHandler  dBPaiMainInfo==null:   {zone} {unitid}");
            //    return;
            //}

            //被推广人可能会领取两次推广奖励
            //推广组件不用判断， 也不用移除
            DBPopularizeInfo old_dBPopularizeInfo = GetDBComponent<DBPopularizeInfo>(zone, unitid, day, DBHelper.DBPopularizeInfo);
            

            //宠物天梯可能没有及时刷新
            //DBRankInfo 

            //全服公用数据，兑换比例。。。
            //DBServerInfo

            //全服邮件
            //DBServerMailInfo

            //帮会这个太多情况了，回档会导致自己丢失帮会。。。。。
            //目前只处理一种。前后帮会id一致的情况下不处理，否则退出帮会
            //DBUnionInfo dBUnionInfo;

            //DBUnionManager dBUnionManager;

            DataCollationComponent old_dataCollationComponent = GetDBComponent<DataCollationComponent>(zone, unitid, day, DBHelper.DataCollationComponent);
            if (old_dataCollationComponent == null)
            {
                Console.WriteLine($"OnArchiveHandler  DataCollationComponent==null:   {zone} {unitid}");
                return;
            }

            EnergyComponent old_energyComponent = GetDBComponent<EnergyComponent>(zone, unitid, day, DBHelper.EnergyComponent);
            if (old_energyComponent == null)
            {
                Console.WriteLine($"OnArchiveHandler  energyComponent==null:   {zone} {unitid}");
                return;
            }

            JiaYuanComponent old_jiaYuanComponent = GetDBComponent<JiaYuanComponent>(zone, unitid, day, DBHelper.JiaYuanComponent);
            if (old_jiaYuanComponent == null)
            {
                Console.WriteLine($"OnArchiveHandler  jiaYuanComponent==null:   {zone} {unitid}");
                return;
            }

            NumericComponent old_numericComponent = GetDBComponent<NumericComponent>(zone, unitid, day, DBHelper.NumericComponent);
            if (old_numericComponent == null)
            {
                Console.WriteLine($"OnArchiveHandler  jiaYuanComponent==null:   {zone} {unitid}");
                return;
            }

            PetComponent old_petComponent = GetDBComponent<PetComponent>(zone, unitid, day, DBHelper.PetComponent);
            if (old_petComponent == null)
            {
                Console.WriteLine($"OnArchiveHandler  petComponent==null:   {zone} {unitid}");
                return;
            }

            RechargeComponent old_rechargeComponent = GetDBComponent<RechargeComponent>(zone, unitid, day, DBHelper.RechargeComponent);
            if (old_rechargeComponent == null)
            {
                Console.WriteLine($"OnArchiveHandler  rechargeComponent==null:   {zone} {unitid}");
                return;
            }

            ReddotComponent old_reddotComponent = GetDBComponent<ReddotComponent>(zone, unitid, day, DBHelper.ReddotComponent);
            if (old_reddotComponent == null)
            {
                Console.WriteLine($"OnArchiveHandler  reddotComponent==null:   {zone} {unitid}");
                return;
            }

            ShoujiComponent old_shoujiComponent = GetDBComponent<ShoujiComponent>(zone, unitid, day, DBHelper.ShoujiComponent);
            if (old_shoujiComponent == null)
            {
                Console.WriteLine($"OnArchiveHandler  shoujiComponent==null:   {zone} {unitid}");
                return;
            }

            SkillSetComponent old_skillSetComponent = GetDBComponent<SkillSetComponent>(zone, unitid, day, DBHelper.SkillSetComponent);
            if (old_skillSetComponent == null)
            {
                Console.WriteLine($"OnArchiveHandler  skillSetComponent==null:   {zone} {unitid}");
                return;
            }

            TaskComponent old_taskComponent = GetDBComponent<TaskComponent>(zone, unitid, day, DBHelper.TaskComponent);
            if (old_taskComponent == null)
            {
                Console.WriteLine($"OnArchiveHandler  taskComponent==null:   {zone} {unitid}");
                return;
            }

            TitleComponent old_titleComponent = GetDBComponent<TitleComponent>(zone, unitid, day, DBHelper.TitleComponent);
            if (old_taskComponent == null)
            {
                Console.WriteLine($"OnArchiveHandler  titleComponent==null:   {zone} {unitid}");
                return;
            }

            UserInfoComponent old_userInfoComponent = GetDBComponent<UserInfoComponent>(zone, unitid, day, DBHelper.UserInfoComponent);
            if (old_userInfoComponent == null)
            {
                Console.WriteLine($"OnArchiveHandler  userInfoComponent==null:   {zone} {unitid}");
                return;
            }


            DBAccountInfo old_dbAccountInfo = GetDBComponent<DBAccountInfo>(zone, old_userInfoComponent.UserInfo.AccInfoID, day, DBHelper.DBAccountInfo);
            if (old_dbAccountInfo == null)
            {
                Console.WriteLine($"OnArchiveHandler  old_dbAccountInfo==null:   {zone} {unitid}");
                return;
            }


            Console.WriteLine($"正确获取到玩家全部数据！！！");

            string account = old_userInfoComponent.Account;
            //通知gate服该玩家在回档中，禁止登陆。。。。

            Console.WriteLine("准备回档 ，通知玩家可以下线！！");
            await NoticeAccountServerArchive(zone, account, unitid, 1);

            //踢玩家下线并存库。。
            Console.WriteLine($"通知游戏服玩家下线操作！！！");
            //ConsoleHelper.KickOutConsoleHandler($"kickout {zone} {unitid}");
            await DisconnectHelper.KickOutPlayer(zone, unitid);


            await TimerComponent.Instance.WaitAsync(TimeHelper.Second * 10);

            Console.WriteLine($"移除该玩家在缓存服数据！！！");
            //移除缓存...  并存库。。
            DBHelper.DeleteUnitCache(zone, unitid).Coroutine();


            //移除拍卖行自己的所有装备。。。。。
            long paimaiInstanceid = DBHelper.GetPaiMaiServerId(zone);
            P2A_DeleteRoleData deleteResponse2 = (P2A_DeleteRoleData)await ActorMessageSenderComponent.Instance.Call
           (paimaiInstanceid, new A2P_DeleteRoleData()
           {
               DeleUserID = unitid,
               AccountId = old_userInfoComponent.UserInfo.AccInfoID, //没用到
               DeleteType = 1,
           });

            //已经被拍卖的装备不找回。。。
            List<long> soldbaginfoids = new List<long>() ;
            List <DataCollationComponent> new_dataCollationComponents = await Game.Scene.GetComponent<DBComponent>().Query<DataCollationComponent>(zone, d => d.Id == unitid);
            if (new_dataCollationComponents != null && new_dataCollationComponents.Count > 0)
            {
                soldbaginfoids = new_dataCollationComponents[0].SoldBagInfoIDList;  
            }
            List<DBAccountInfo> new_dbAccountInfos = await Game.Scene.GetComponent<DBComponent>().Query<DBAccountInfo>(zone, d => d.Id == old_userInfoComponent.UserInfo.AccInfoID);
            if (new_dbAccountInfos == null || new_dbAccountInfos.Count == 0)
            {
                Console.WriteLine($"OnArchiveHandler  new_dbAccountInfos==null:   {zone} {unitid}");
                return;
            }
            for (int i = 0; i < new_dbAccountInfos[0].BagInfoList.Count; i++)
            {
                soldbaginfoids.Add(new_dbAccountInfos[0].BagInfoList[i].BagInfoID);
            }
            //排除在账号仓库的道具。。。

            int occ = old_userInfoComponent.UserInfo.Occ;
            int occTwo = old_userInfoComponent.UserInfo.OccTwo;
            List<BagInfo> bagInfos = old_bagComponent.GetAllItems(occ, occTwo );
            for (int i = 0; i < bagInfos.Count; i++)
            {
                if (soldbaginfoids.Contains(bagInfos[i].BagInfoID))
                {
                    bagInfos[i].ItemID = 0;   //登陆时候会移除。
                }
            }

            long oldunionid = old_numericComponent.GetAsLong(NumericType.UnionId_0);
            long newunionid = 0;
            List<NumericComponent> new_numericComponents = await Game.Scene.GetComponent<DBComponent>().Query<NumericComponent>(zone, d => d.Id == unitid);
            if (new_numericComponents != null && new_numericComponents.Count > 0)
            {
                newunionid = new_numericComponents[0].GetAsLong(NumericType.UnionId_0);
            }

            //处理家族数据, 家族id相等不处理。
            if (oldunionid == newunionid)
            {
                ////
            }
            else
            {
                ///把该玩家从家族中移除。。。
                if (newunionid > 0)
                {
                    long dbCacheId = DBHelper.GetUnionServerId(zone);
                    U2M_UnionLeaveResponse d2GGetUnit = (U2M_UnionLeaveResponse)await ActorMessageSenderComponent.Instance.Call(dbCacheId, new M2U_UnionLeaveRequest()
                    {
                        UnionId = newunionid,
                        UserId = unitid,
                    });
                }

                ///清空该玩家的家族id 
                old_numericComponent.ApplyValue(NumericType.UnionLeader, 0);
                old_numericComponent.ApplyValue(NumericType.UnionId_0, 0);
                old_userInfoComponent.UpdateRoleData(UserDataType.UnionName, "", false);
            }


            //删除DB数据
            ////推广组件不用判断， 也不用移除
            List<string> allComponets = DBHelper.GetAllUnitComponent();
            for (int i = 0; i < allComponets.Count; i++)
            {
                Console.WriteLine($"AllUnitComponent:  {allComponets[i]}！！！");
                //个人数据组件
                //
                //ActivityComponent    BagComponent     ChengJiuComponent    DBFriendInfo 
                //DBMailInfo    DBPopularizeInfo     DataCollationComponent  EnergyComponent 
                //JiaYuanComponent    NumericComponent     PetComponent     RechargeComponent 
                //ReddotComponent     ShoujiComponent     SkillSetComponent    TaskComponent 
                //TitleComponent      UserInfoComponent 
                //Game.Scene.GetComponent<DBComponent>().Remove<Entity>(zone, unitid, allComponets[i]).Coroutine();
            }

            //除了DBFriendInfo  DBMailInfo   DBPopularizeInfo几个组件，其他的都是进入游戏的已经加载到缓存服，这三个组件需要的时候才加载。

            //导入DB数据
            await SaveDBComponent(zone, old_activityComponent);
            await SaveDBComponent(zone, old_bagComponent);
            await SaveDBComponent(zone, old_chengJiuComponent);
            await SaveDBComponent(zone, old_dBFriendInfo);
            await SaveDBComponent(zone, old_dBMailInfo);
            await SaveDBComponent(zone, old_dBPopularizeInfo);
            await SaveDBComponent(zone, old_dataCollationComponent);
            await SaveDBComponent(zone, old_energyComponent);
            await SaveDBComponent(zone, old_jiaYuanComponent);
            await SaveDBComponent(zone, old_numericComponent);
            await SaveDBComponent(zone, old_petComponent);
            await SaveDBComponent(zone, old_rechargeComponent);
            await SaveDBComponent(zone, old_reddotComponent);
            await SaveDBComponent(zone, old_shoujiComponent);
            await SaveDBComponent(zone, old_skillSetComponent);
            await SaveDBComponent(zone, old_taskComponent);
            await SaveDBComponent(zone, old_titleComponent);
            await SaveDBComponent(zone, old_userInfoComponent);

            Console.WriteLine("回档完成 ，通知玩家可以上线！！");
            await NoticeAccountServerArchive(zone, account, unitid, 0);
            //archive 5 2631939174340558848 1
        }

        public static async ETTask SaveDBComponent<T>(int zone,T entity) where T : Entity
        {
            await Game.Scene.GetComponent<DBComponent>().Save(zone, entity); 
        }

        public static async ETTask NoticeAccountServerArchive(int zone, string acccout, long unitid, int archive)
        {
            long gateinstanceid = StartSceneConfigCategory.Instance.GetBySceneName(zone, "Account").InstanceId;
            A2A_ServerMessageRResponse g_SendChatRequest = (A2A_ServerMessageRResponse)await ActorMessageSenderComponent.Instance.Call
              (gateinstanceid, new A2A_ServerMessageRequest()
              {
                  MessageType = NoticeType.Archive,
                  MessageValue = $"{acccout} {unitid} {archive}",
              });
        }

        public static K GetDBComponent<K>(int zone, long userID, int day, string componentType) where K : Entity, new()
        {
            string filePath = $"C:/WJ/{day}/WJBeta{zone}/{componentType}.bson"; // 替换为你的.bson文件路径
            //if (ComHelp.IsInnerNet())
            //{
            //    filePath = $"C:/WJ/WJBeta{zone}/{componentType}.bson"; // 替换为你的.bson文件路径
            //}
            //else
            //{
            //    filePath = $"C:/WJ/WJBeta{zone}/{componentType}.bson"; // 替换为你的.bson文件路径
            //}

            var list = new List<BagComponent>();
            using (var stream = File.OpenRead(filePath))
            {
                while (stream.Position != stream.Length)
                {
                    var document = BsonSerializer.Deserialize<BsonDocument>(stream);

                    BsonElement bsonElement  = document.ElementAt(0);

                    if (bsonElement.Value.AsInt64.Equals(userID))
                    {
                        var obj = BsonSerializer.Deserialize<K>(document);
                        return obj as K;
                    }
                }
            }

            return null;
        }


        public static async ETTask InitETmongoExport(string batchFilePath)
        {
            List<string> KillInfoList = new List<string>();
            long serverTime = TimeHelper.ServerNow();
            List<ServerItem> serverItems = ServerHelper.GetServerList(ComHelp.IsInnerNet());
            for (int i = 0; i < serverItems.Count; i++)
            {
                
                if (serverItems[i].Show != 0 && serverItems[i].ServerOpenTime <= serverTime)
                {
                    //ping - n 10 127.0.0.1 > nul
                    //mongodump - d WJBeta5 - o C:/ WJ / 1

                    KillInfoList.Add("ping -n 10 127.0.0.1>nul");
                    KillInfoList.Add($"mongodump -d WJBeta{serverItems[i].ServerId} -o C:/WJ/1");
                }
            }

            KillInfoList.Add("ping -n 10 127.0.0.1>nul");
            KillInfoList.Add($"mongodump -d WJBeta202(center) -o C:/WJ/1");

            LogHelper.WriteLogList(KillInfoList, batchFilePath, false);

            await ETTask.CompletedTask;
        }

        //@"F:\\soft\\MongoDB\\bin\\ETmongoExport.bat"
        //只能中心服执行  ExecuteBatchFile(@"C:\path\to\your\batchfile.bat");
        //内网   F:\soft\MongoDB\bin\ETmongoExport.bat
        public static async ETTask ExecuteBatchFile()
        {
            string workingDirectory = ComHelp.IsInnerNet() ? @"F:\soft\MongoDB\bin" : @"C:\Program Files\MongoDB\Server\4.0\bin";
            string batchFilePath = workingDirectory + @"\ETmongoExport_all.bat";  

            await InitETmongoExport(batchFilePath);

            //C:\WJ\1\111
            string filepath = "C:/WJ/{0}/";
            RenameFolderName(string.Format(filepath, 6), string.Format(filepath, 7));
            RenameFolderName(string.Format(filepath, 5), string.Format(filepath, 6));
            RenameFolderName(string.Format(filepath, 4), string.Format(filepath, 5));
            RenameFolderName(string.Format(filepath, 3), string.Format(filepath, 4));
            RenameFolderName(string.Format(filepath, 2), string.Format(filepath, 3));
            RenameFolderName(string.Format(filepath, 1), string.Format(filepath, 2));

            await TimerComponent.Instance.WaitAsync(TimeHelper.Second * 10);

            ProcessStartInfo startInfo = new ProcessStartInfo
            {
                FileName = batchFilePath,
                UseShellExecute = true,
                WorkingDirectory = workingDirectory,
                CreateNoWindow = false // 如果不希望显示命令提示符窗口，可以设置为true
            };

            using (Process process = Process.Start(startInfo))
            {
                process.WaitForExit(); // 如果需要等待批处理执行完成可以使用这个方法
            }

            await TimerComponent.Instance.WaitAsync(TimeHelper.Second * 10);
        }


        private static void RenameFolderName(string originalFolderPath , string newFolderPath)
        {
            try
            {
                // 确保新的文件夹名称不存在
                if (!Directory.Exists(originalFolderPath))
                {
                    return;
                }

                if (Directory.Exists(newFolderPath))
                {
                    Directory.Delete(newFolderPath, true);
                }

                var fileInfo = new FileInfo(originalFolderPath);
                if ((fileInfo.Attributes & FileAttributes.ReadOnly) > 0)
                {
                    fileInfo.Attributes ^= FileAttributes.ReadOnly;
                }

                // 重命名文件夹
                Directory.Move(originalFolderPath, newFolderPath);
                Console.WriteLine($"文件夹名称已修改:{originalFolderPath}  {newFolderPath}");
            }
            catch (Exception ex)
            {
                Console.WriteLine("发生错误: " + ex.Message);
            }
        }
    }
}
