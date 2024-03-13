﻿namespace ET
{

    public class Team_OnRecvTeamInvite : AEventClass<EventType.RecvTeamInvite>
    {
        protected override void Run(object cls)
        {
            EventType.RecvTeamInvite args = (EventType.RecvTeamInvite)cls;
            PopupTipHelp.OpenPopupTip( args.ZoneScene, "组队邀请", $"{args.m2C_TeamInviteResult.TeamPlayerInfo.PlayerName}邀请你组队",
                () => 
                {
                    args.ZoneScene.GetComponent<TeamComponent>().AgreeTeamInvite(args.m2C_TeamInviteResult).Coroutine();
                }
                ).Coroutine();
        }
    }

    public class Team_OnTeamDungeonOpen : AEventClass<EventType.RecvTeamDungeonOpen>
    {
        protected override void Run(object cls)
        {
            EventType.RecvTeamDungeonOpen args = (EventType.RecvTeamDungeonOpen)cls;
            Scene zoneScene = args.ZoneScene;
            if (zoneScene.GetComponent<MapComponent>().SceneTypeEnum == SceneTypeEnum.TeamDungeon)
            {
                return;
            }
            TeamComponent teamComponent = zoneScene.GetComponent<TeamComponent>();
            UserInfo userInfo = zoneScene.GetComponent<UserInfoComponent>().UserInfo;
            TeamInfo teamInfo = teamComponent.GetSelfTeam();
            if (teamInfo == null)
            {
                return;
            }
            int robotNumber = 0;
            for (int i = 0; i < teamInfo.PlayerList.Count; i++)
            {
                if (teamInfo.PlayerList[i].RobotId > 0)
                {
                    robotNumber++;
                }
            }

            string tip = string.Empty;
            if (robotNumber > 0)
            {
                tip = "<color=#FDFB47>队伍内有人机,副本掉率将降低!</color>\n建议:和其他玩家组队爆率将获得大幅度提升\n";
            }
            RecvTeamDungeonPrepare(args).Coroutine();
            //PopupTipHelp.OpenPopupTip(args.ZoneScene, "组队邀请", $"{tip}是否进入副本？",
            //    () =>
            //    {
            //        //RunAsync(args).Coroutine();
                   
            //    }
            //    ).Coroutine();
        }

        private async ETTask RecvTeamDungeonPrepare(EventType.RecvTeamDungeonOpen args)
        {
            Scene zoneScene = args.ZoneScene;
            UI uI = await UIHelper.Create(zoneScene, UIType.UITeamDungeonPrepare);
            uI.GetComponent<UITeamDungeonPrepareComponent>().OnUpdateUI(args.TeamInfo, ErrorCode.Err_HaveNotPrepare);
        }
    }

    [Event]
    public class Team_OnTeamDungeonSettlement : AEventClass<EventType.TeamDungeonSettlement>
    {
        protected override void Run(object cls)
        {
            RunAsync(cls as EventType.TeamDungeonSettlement).Coroutine();
        }

        private async ETTask RunAsync(EventType.TeamDungeonSettlement args)
        {
            await TimerComponent.Instance.WaitAsync(3000);
            if (UIHelper.GetUI(args.ZoneScene, UIType.UITeamDungeonSettlement) != null)
                return;
            int sceneTypeEnum = args.ZoneScene.GetComponent<MapComponent>().SceneTypeEnum;
            if (sceneTypeEnum == (int)SceneTypeEnum.MainCityScene)
            {
                return;
            }
            UI ui = await UIHelper.Create(args.ZoneScene, UIType.UITeamDungeonSettlement);
            ui.GetComponent<UITeamDungeonSettlementComponent>().OnUpdateUI(args.m2C_FubenSettlement);
        }
    }

    
    [Event]
    public class Team_OnTeamDungeonBoxReward : AEventClass<EventType.TeamDungeonBoxReward>
    {
        protected override void Run(object cls)
        {
            EventType.TeamDungeonBoxReward args = (EventType.TeamDungeonBoxReward)cls;
            UI ui = UIHelper.GetUI(args.Scene, UIType.UITeamDungeonSettlement);
            if (ui != null)
            {
                ui.GetComponent<UITeamDungeonSettlementComponent>().OnTeamDungeonBoxReward(args.m2C_FubenSettlement);
            }
        }
    }
}
