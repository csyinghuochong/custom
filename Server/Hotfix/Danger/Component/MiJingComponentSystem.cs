﻿using System.Collections.Generic;
using System.Linq;

namespace ET
{
    public static  class MiJingComponentSystem
    {


        public static void OnKillEvent(this MiJingComponent self, Unit defend)
        {
            if (defend.ConfigId != self.BossId)
            {
                return;
            }

            List<TeamPlayerInfo> players = new List<TeamPlayerInfo>();
            players.AddRange(self.PlayerDamageList.Take(5));

            self.SendReward(players, 0, 0, "1;150000@10010085;100").Coroutine();
            self.SendReward(players, 1, 1, "1;100000@10010085;75").Coroutine(); ;
            self.SendReward(players, 2, 2, "1;75000@10010085;50").Coroutine(); ;
            self.SendReward(players, 3, 4, "1;50000@10010085;40").Coroutine(); ;
            self.SendReward(players, 5, 9, "1;30000@10010085;30").Coroutine(); ;
            self.SendReward(players, 10, 19, "1;20000@10010085;20").Coroutine();

            self.PlayerDamageList.Clear();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="self"></param>
        /// <param name="players"></param>
        /// <param name="start"></param>
        /// <param name="end"></param>
        /// <param name="rewardList"></param>
        public static async ETTask SendReward(this MiJingComponent self, List<TeamPlayerInfo> players, int start, int end,  string rewardList)
        {
            long serverTime = TimeHelper.ServerNow();
            long mailServerId = DBHelper.GetMailServerId(self.DomainZone());
            for (int i = start; i <= end; i++)
            {
                if (i >= players.Count || players[i].RobotId > 0)
                {
                    return;
                }
                MailInfo mailInfo = new MailInfo();
                mailInfo.Status = 0;
                int num = i + 1;
                mailInfo.Context = $"恭喜你在秘境中获得第{num}名,获得如下奖励";
                mailInfo.Title = "秘境领主排名奖励";
                mailInfo.MailId = IdGenerater.Instance.GenerateId();
                string[] needList = rewardList.Split('@');
                for (int k = 0; k < needList.Length; k++)
                {
                    string[] itemInfo = needList[k].Split(';');
                    if (itemInfo.Length < 2)
                    {
                        continue;
                    }
                    int itemId = int.Parse(itemInfo[0]);
                    int itemNum = int.Parse(itemInfo[1]);
                    mailInfo.ItemList.Add(new BagInfo() { ItemID = itemId, ItemNum = itemNum, GetWay = $"{ItemGetWay.MiJingBoss}_{serverTime}" });
                }
                Log.Warning($"世界Boss排名奖励1: {self.DomainZone()}  {players[i].UserID}");

                // MailHelp.SendUserMail(self.DomainZone(),  players[i].UserID, mailInfo).Coroutine();
                E2M_EMailSendResponse g_EMailSendResponse = (E2M_EMailSendResponse)await ActorMessageSenderComponent.Instance.Call
                                       (mailServerId, new M2E_EMailSendRequest()
                                       {
                                           Id = players[i].UserID,
                                           MailInfo = mailInfo,
                                           GetWay = ItemGetWay.MiJingBoss,
                                       });
                if (g_EMailSendResponse.Error != ErrorCode.ERR_Success)
                {
                    Log.Warning($"世界Boss排名奖励失败: {players[i].UserID}");
                }
            }
        }

        public static void OnUpdateDamage(this MiJingComponent self,  Unit attack,  Unit defend, long damage)
        {
            if (!defend.IsBoss() || defend.ConfigId != self.BossId)
            {
                return;
            }

            TeamPlayerInfo teamPlayerInfo = null;
            for (int i = 0; i < self.PlayerDamageList.Count; i++)
            {
                if (self.PlayerDamageList[i].UserID == attack.Id)
                {
                    teamPlayerInfo = self.PlayerDamageList[i];
                    teamPlayerInfo.Damage += (int)damage;
                }
            }
            if (teamPlayerInfo == null)
            {
                UserInfo userInfo = attack.GetComponent<UserInfoComponent>().UserInfo;
                teamPlayerInfo = new TeamPlayerInfo();
                teamPlayerInfo.UserID = attack.Id;
                teamPlayerInfo.PlayerName = userInfo.Name;
                teamPlayerInfo.Damage = (int)damage;
                teamPlayerInfo.PlayerLv = userInfo.Lv;
                self.PlayerDamageList.Add(teamPlayerInfo);
            }
            if (TimeHelper.ServerNow() - self.LastTime < 1000)
            {
                return;
            }
            self.LastTime = TimeHelper.ServerNow();
            self.PlayerDamageList.Sort(delegate (TeamPlayerInfo a, TeamPlayerInfo b)
            {
                return (int)b.Damage - (int)a.Damage;
            });

            List<Unit> allPlayer = UnitHelper.GetUnitList(self.DomainScene(), UnitType.Player);
            for (int i = 0; i < allPlayer.Count; i++)
            {
                self.M2C_SyncMiJingDamage.DamageList.Clear();
                self.M2C_SyncMiJingDamage.DamageList.AddRange(self.PlayerDamageList.Take(5));
                MessageHelper.SendToClient(allPlayer[i], self.M2C_SyncMiJingDamage);
            }
        }
    }
}
