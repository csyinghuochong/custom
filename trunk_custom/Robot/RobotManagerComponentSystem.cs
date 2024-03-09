using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;

namespace ET
{
    [ObjectSystem]
    public class RobotManagerComponentAwakeSystem : AwakeSystem<RobotManagerComponent>
    {
        public override void Awake(RobotManagerComponent self)
        {
            self.RobotNumber.Clear();
            self.ZoneIndex = Game.Options.Process * 10000;
        }
    }

    public static class RobotManagerComponentSystem
    {

        public static async ETTask RemoveRobot(this RobotManagerComponent self, Scene robotScene, string exitType)
        {
            //self.ZoneIndex--;
            if (self == null || robotScene.GetComponent<BehaviourComponent>() == null)
            {
                return;
            }
            int robotId = robotScene.GetComponent<BehaviourComponent>().RobotConfig.Id;
            if (self.RobotNumber.ContainsKey(robotId))
            {
                self.RobotNumber[robotId]--;
                if (self.RobotNumber[robotId] < 0)
                {
                    self.RobotNumber[robotId] = 0;
                }
            }
            Log.Debug($"机器人退出： {exitType}");
            robotScene.GetComponent<SessionComponent>().Session.Dispose();
            await TimerComponent.Instance.WaitAsync(200);
            robotScene.Dispose();
        }

        public static async ETTask RemoveRobot_2(this RobotManagerComponent self, Scene robotScene, string exitType)
        {
            //self.ZoneIndex--;
            //if (self == null || robotScene.GetComponent<BehaviourComponent>() == null)
            //{
            //    return;
            //}

            //Log.Debug($"机器人掉线退出：{robotScene.Id}");
            //robotScene.GetComponent<SessionComponent>().Session.Dispose();
            //await TimerComponent.Instance.WaitAsync(200);
            //robotScene.Dispose();
            await ETTask.CompletedTask;
        }

        public static async ETTask<Scene> NewRobot_2(this RobotManagerComponent self, int zone, int robotZone, int robotId, string account, string passward)
        {
            Scene zoneScene = null;
            try
            {
                //同一个进程robotZone是自增的
                zoneScene = SceneFactory.CreateZoneScene(robotZone, "Robot", self);
                bool innernet = ComHelp.IsInnerNet();
                int registerCode = await LoginHelper.Register(zoneScene, !innernet, VersionMode.Beta, account, passward);

                string adress = ServerHelper.GetServerIpList(innernet, zone);
                string[] serverdomain = adress.Split(':');
                if (!serverdomain[0].Contains("127.0.0.1")
                 && !serverdomain[0].Contains("192")
                 && !serverdomain[0].Contains("39")
                 && !serverdomain[0].Contains("47.94.107.92"))
                {
                    IPAddress[] xxc = Dns.GetHostEntry(serverdomain[0]).AddressList;
                    adress = $"{xxc[0]}:{serverdomain[1]}";
                }

                Log.Console($"NewRobot:{adress} {robotZone}  {account}");
                int errorCode = await LoginHelper.Login(zoneScene, adress, account, passward);
                Session session = zoneScene.GetComponent<SessionComponent>().Session;
                if (session == null)
                {
                    Log.Console($"session == null  {robotZone}  {account}");
                    return null;
                }
                if (registerCode == ErrorCode.ERR_Success)
                {
                    A2C_CreateRoleData g2cCreateRole = await LoginHelper.CreateRole(zoneScene, 1, self.Parent.GetComponent<RandNameComponent>().GetRandomName());
                    AccountInfoComponent playerComponent = zoneScene.GetComponent<AccountInfoComponent>();
                    if (playerComponent == null || g2cCreateRole.createRoleInfo == null)
                    {
                        return null;
                    }
                    playerComponent.ServerId = zone;
                    playerComponent.CurrentRoleId = g2cCreateRole.createRoleInfo.UserID;

                    errorCode = await LoginHelper.GetRealmKey(zoneScene);
                    errorCode = await LoginHelper.EnterGame(zoneScene, "", false, 0); 
                    Log.Console($"create robot ok: {robotZone}");
                }
                else if (registerCode == ErrorCode.ERR_AccountAlreadyRegister)
                {
                    AccountInfoComponent playerComponent = zoneScene.GetComponent<AccountInfoComponent>();
                    if (playerComponent.CreateRoleList.Count > 0)
                    {
                        playerComponent.ServerId = zone;
                        playerComponent.CurrentRoleId = playerComponent.CreateRoleList[0].UserID;

                        errorCode = await LoginHelper.GetRealmKey(zoneScene);
                        errorCode = await LoginHelper.EnterGame(zoneScene, "", false, 0);
                        Log.Debug($"create robot ok: {robotZone}");
                    }
                    else
                    {
                        Log.Debug($"{account}  {zone} 角色为空");

                        A2C_CreateRoleData g2cCreateRole = await LoginHelper.CreateRole(zoneScene, 1, self.Parent.GetComponent<RandNameComponent>().GetRandomName());
                        playerComponent = zoneScene.GetComponent<AccountInfoComponent>();
                        if (playerComponent == null || g2cCreateRole.createRoleInfo == null)
                        {
                            return null;
                        }
                        Log.Debug($"{account}  {zone} 创角成功");
                        playerComponent.ServerId = zone;
                        playerComponent.CurrentRoleId = g2cCreateRole.createRoleInfo.UserID;

                        errorCode = await LoginHelper.GetRealmKey(zoneScene);
                        errorCode = await LoginHelper.EnterGame(zoneScene, string.Empty, false, 0);
                        Log.Debug($"create robot ok: {robotZone}");
                    }
                }
                else
                {
                    Log.Debug($"create robot error: {robotZone}");
                }

                return errorCode == ErrorCode.ERR_Success ? zoneScene : null;
            }
            catch (Exception e)
            {
                zoneScene?.Dispose();
                throw new Exception($"RobotSceneManagerComponent create robot fail, zone: {robotZone}", e);
            }
        }

        public static async ETTask<Scene> NewRobot(this RobotManagerComponent self, int zone, int robotZone, int robotId)
        {
            int robotNumber = 0;
            if (!self.RobotNumber.ContainsKey(robotId))
            {
                self.RobotNumber.Add(robotId, 0);
                Log.Debug($"robotId[新]: 0");
            }
            else
            {
                Log.Debug($"robotId[增]: {self.RobotNumber[robotId]}");
            }
            robotNumber = self.RobotNumber[robotId]++;
            string account = $"{robotId}_{zone}_{robotNumber}_0617";   //服务器

            Scene robotScene = await self.NewRobot_2(zone, robotZone, robotId, account, ComHelp.RobotPassWord);
            return robotScene;
            //同一个进程robotZone是自增的
            //zoneScene = SceneFactory.CreateZoneScene(robotZone, "Robot", self);
            //string account = $"{robotId}_{zone}_{robotNumber}_0221";    //本地
            //bool innernet = ComHelp.IsInnerNet();
            //VersionMode versionMode = VersionMode.BanHao;
            //VersionMode versionMode = VersionMode.Beta;
            //    int registerCode = await LoginHelper.Register(zoneScene, !innernet, versionMode, account, ComHelp.RobotPassWord);
            //    string adress = ServerHelper.GetServerIpList(innernet, zone);
            //    string[] serverdomain = adress.Split(':');
            //    if (!serverdomain[0].Contains("127.0.0.1")
            //     && !serverdomain[0].Contains("192")
            //     && !serverdomain[0].Contains("39")
            //     && !serverdomain[0].Contains("47.94.107.92"))
            //    {
            //        IPAddress[] xxc = Dns.GetHostEntry(serverdomain[0]).AddressList;
            //        adress = $"{xxc[0]}:{serverdomain[1]}";
            //    }

            //    Log.Console($"NewRobot:{adress} {robotZone}  {account}");
            //    int errorCode = await LoginHelper.Login(zoneScene, adress, account, ComHelp.RobotPassWord);
            //    Session session = zoneScene.GetComponent<SessionComponent>().Session;
            //    if (session == null)
            //    {
            //        Log.Console($"session == null  {robotZone}  {account}");
            //        return null;
            //    }
            //    if (registerCode == ErrorCode.ERR_Success)
            //    {
            //        A2C_CreateRoleData g2cCreateRole = await LoginHelper.CreateRole(zoneScene, 1, self.Parent.GetComponent<RandNameComponent>().GetRandomName());
            //        AccountInfoComponent playerComponent = zoneScene.GetComponent<AccountInfoComponent>();
            //        if (playerComponent == null || g2cCreateRole.createRoleInfo == null)
            //        {
            //            return null;
            //        }
            //        playerComponent.ServerId = zone;
            //        playerComponent.CurrentRoleId = g2cCreateRole.createRoleInfo.UserID;

            //        errorCode = await LoginHelper.GetRealmKey(zoneScene);
            //        errorCode = await LoginHelper.EnterGame(zoneScene, "", false, 0);
            //        Log.Console($"create robot ok: {robotZone}");
            //    }
            //    else if (registerCode == ErrorCode.ERR_AccountAlreadyRegister)
            //    {
            //        AccountInfoComponent playerComponent = zoneScene.GetComponent<AccountInfoComponent>();
            //        if (playerComponent.CreateRoleList.Count > 0)
            //        {
            //            playerComponent.ServerId = zone;
            //            playerComponent.CurrentRoleId = playerComponent.CreateRoleList[0].UserID;

            //            errorCode = await LoginHelper.GetRealmKey(zoneScene);
            //            errorCode = await LoginHelper.EnterGame(zoneScene, "", false, 0 );
            //            Log.Debug($"create robot ok: {robotZone}");
            //        }
            //        else
            //        {
            //            Log.Debug($"{account}  {zone} 角色为空");
            //            //await TimerComponent.Instance.WaitAsync(200);
            //            //zoneScene?.Dispose();
            //            //return null;

            //            A2C_CreateRoleData g2cCreateRole = await LoginHelper.CreateRole(zoneScene, 1, self.Parent.GetComponent<RandNameComponent>().GetRandomName());
            //            playerComponent = zoneScene.GetComponent<AccountInfoComponent>();
            //            if (playerComponent == null || g2cCreateRole.createRoleInfo == null)
            //            {
            //                return null;
            //            }
            //            Log.Debug($"{account}  {zone} 创角成功");
            //            playerComponent.ServerId = zone;
            //            playerComponent.CurrentRoleId = g2cCreateRole.createRoleInfo.UserID;

            //            errorCode = await LoginHelper.GetRealmKey(zoneScene);
            //            errorCode = await LoginHelper.EnterGame(zoneScene, "", false, 0 );
            //            Log.Debug($"create robot ok: {robotZone}");
            //        }
            //    }
            //    else
            //    {
            //        Log.Debug($"create robot error: {robotZone}");
            //    }

            //    return errorCode == ErrorCode.ERR_Success ?  zoneScene : null;
            //}
            //catch (Exception e)
            //{
            //    zoneScene?.Dispose();
            //    throw new Exception($"RobotSceneManagerComponent create robot fail, zone: {robotZone}", e);
            //}
        }
        
        public static void RemoveAll(this RobotManagerComponent self)
        {
            foreach (Entity robot in self.Children.Values.ToArray())        
            {
                robot.Dispose();
            }
        }
        
        public static void Remove(this RobotManagerComponent self, long id)
        {
            self.GetChild<Scene>(id)?.Dispose();
        }

        public static void Clear(this RobotManagerComponent self)
        {
            foreach (Entity entity in self.Children.Values.ToArray())
            {
                entity.Dispose();
            }
        }
    }
}