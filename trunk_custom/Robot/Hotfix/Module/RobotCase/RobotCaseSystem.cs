using System;
using System.Collections.Generic;

namespace ET
{
    public static class RobotCaseSystem
    {
        // 创建机器人，生命周期是RobotCase
        public static async ETTask NewRobot(this RobotCase self, int count, List<Scene> scenes)
        {
            ETTask[] tasks = new ETTask[count];
            for (int i = 0; i < count; ++i)
            {
                tasks[i] = self.NewRobot(scenes);
            }

            await ETTaskHelper.WaitAll(tasks);
        }

        private static async ETTask NewRobot(this RobotCase self, List<Scene> scenes)
        {
            try
            {
                scenes.Add(await self.NewRobot());
            }
            catch (Exception e)
            {
                Log.Error(e);
            }
        }

        // 创建机器人，生命周期是RobotCase
        public static async ETTask NewZoneRobot(this RobotCase self, int zone, int count, List<Scene> scenes)
        {
            ETTask[] tasks = new ETTask[count];
            for (int i = 0; i < count; ++i)
            {
                tasks[i] = self.NewZoneRobot(zone + i, scenes);
            }

            await ETTaskHelper.WaitAll(tasks);
        }

        // 这个方法创建的是进程所属的机器人，建议使用RobotCase.NewRobot来创建
        private static async ETTask NewZoneRobot(this RobotCase self, int zone, List<Scene> scenes)
        {
            try
            {
                scenes.Add(await self.NewRobot(zone));
            }
            catch (Exception e)
            {
                Log.Error(e);
            }
        }

        public static async ETTask<Scene> NewRobot(this RobotCase self, int zone)
        {
            return await self.NewRobot(zone, $"Robot_{zone}");
        }

        public static async ETTask<Scene> NewRobot(this RobotCase self, int zone, string name)
        {
            Scene zoneScene = null;
            try
            {
                bool innernet = ComHelp.IsInnerNet();
                zoneScene = SceneFactory.CreateZoneScene(zone, name, self);
                await LoginHelper.Register(zoneScene, !innernet, VersionMode.Beta, zone.ToString(), zone.ToString());
                await LoginHelper.Login(zoneScene, ServerHelper.GetServerIpList(innernet, 1), zone.ToString(), zone.ToString());
                A2C_CreateRoleData g2cCreateRole = await LoginHelper.CreateRole(zoneScene, 1, zone.ToString());
                zoneScene.GetComponent<AccountInfoComponent>().ServerId = 1;
                zoneScene.GetComponent<AccountInfoComponent>().CurrentRoleId = g2cCreateRole.createRoleInfo.UserID;
                await LoginHelper.GetRealmKey(zoneScene);
                await LoginHelper.EnterGame(zoneScene, "", false, 0, 0);
                Log.Debug($"create robot ok: {zone}");
                return zoneScene;
            }
            catch (Exception e)
            {
                zoneScene?.Dispose();
                throw new Exception($"RobotCase create robot fail, zone: {zone}", e);
            }
        }

        private static async ETTask<Scene> NewRobot(this RobotCase self)
        {
            await ETTask.CompletedTask;
            int zone = self.GetParent<RobotCaseComponent>().GetN();
            Scene zoneScene = null;

            try
            {
                zoneScene = SceneFactory.CreateZoneScene(zone, $"Robot_{zone}", self);
                Log.Debug($"create robot ok: {zone}");
                return zoneScene;
            }
            catch (Exception e)
            {
                zoneScene?.Dispose();
                throw new Exception($"RobotCase create robot fail, zone: {zone}", e);
            }
        }
    }
}