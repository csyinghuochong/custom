﻿using UnityEngine;

namespace ET
{
    [Event]
    public class Login_OnReturnLogin : AEventClass<EventType.ReturnLogin>
    {

        protected override  void Run(object cls)
        {
            OnReturnLogin(cls as EventType.ReturnLogin);
        }

        private async ETTask RunAsync2(EventType.ReturnLogin args, long waitTime)
        {
            long instanceId = args.ZoneScene.InstanceId;
            if (TimerComponent.Instance == null)
            {
                return;
            }
            await TimerComponent.Instance?.WaitAsync(waitTime);
            if (instanceId != args.ZoneScene.InstanceId)
            {
                return;
            }
            Camera camera = UIComponent.Instance.MainCamera.gameObject.GetComponent<Camera>();
            camera.GetComponent<MyCamera_1>().enabled = false;

            //reload dll
            //GameObjectPoolComponent.Instance.DisposeAll();
            //GameObject.Destroy(GameObject.Find("Global"));
            //Game.Scene.GetComponent<SceneManagerComponent>().ChangeScene(args.ZoneScene, (int)SceneTypeEnum.InitScene, 1).Coroutine();
            //CodeLoader.Instance.OnApplicationQuit();    //Game.Close
            //CodeLoader.Instance.Dispose();              //this.monoTypes.Clear()

            //not  reload dll
            //int lastScene = args.ZoneScene.GetComponent<MapComponent>().SceneTypeEnum;
            Session session = args.ZoneScene.GetComponent<SessionComponent>().Session;
            if (session != null && !session.IsDisposed)
            {
                session.GetComponent<PingComponent>().DisconnectType = -1;
            }
            Game.Scene.GetComponent<SceneManagerComponent>().ChangeScene(args.ZoneScene, (int)SceneTypeEnum.LoginScene, SceneTypeEnum.NONE, 1).Coroutine();
            args.ZoneScene.Dispose();
            Scene zoneScene = SceneFactory.CreateZoneScene(1, "Game", Game.Scene);

            EventType.AppStartInitFinish.Instance.ZoneScene = zoneScene;
            Game.EventSystem.PublishClass(EventType.AppStartInitFinish.Instance);
        }

        private void  OnReturnLogin(EventType.ReturnLogin args)
        {
            UIHelper.Clear();
            UnitFactory.LoadingScene = false;
            MapComponent mapComponent = args.ZoneScene.GetComponent<MapComponent>();
            mapComponent.SceneTypeEnum = (int)SceneTypeEnum.LoginScene;

            if (args.ErrorCode == ErrorCode.ERR_OtherAccountLogin)
            {
                FloatTipManager.Instance.ShowFloatTip("账号异地登录");
                RunAsync2(args, 100).Coroutine();
            }
            else if (args.ErrorCode == ErrorCode.ERR_KickOutPlayer)
            {
                PopupTipHelp.OpenPopupTip_2(args.ZoneScene, "重新登录", "由于您长时间未操作，请重新登录！", () => {
                    RunAsync2(args, 100).Coroutine();
                }).Coroutine();
            }
            else if (args.ErrorCode == ErrorCode.ERR_PackageFrequent)
            {
                PopupTipHelp.OpenPopupTip_2(args.ZoneScene, "消息异常", "请重新登录", () => {
                    RunAsync2(args, 100).Coroutine();
                }).Coroutine();
            }
            else
            {
                RunAsync2(args, 100).Coroutine();
            }

        }
    }
}
