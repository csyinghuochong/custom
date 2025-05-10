﻿using System;
using System.Collections.Generic;

namespace ET
{

    [ActorMessageHandler]
    public class Actor_PickItemHandler : AMActorLocationRpcHandler<Unit, Actor_PickItemRequest, Actor_PickItemResponse>
    {
        private int OnFubenPick(Unit unit, Actor_PickItemRequest request, int sceneTypeEnum, List<long> removeIds)
        {
            List<DropInfo> drops = request.ItemIds;
           
            long serverTime = TimeHelper.ServerNow();
            int errorCode = ErrorCode.ERR_Success;
            //DropType ==  0 公共掉落 2保护掉落   1私有掉落 3 归属掉落

            int cellindex = unit.GetComponent<NumericComponent>().GetAsInt(NumericType.HappyCellIndex);

            for (int i = drops.Count - 1; i >= 0; i--)
            {
                Unit unitDrop = unit.GetParent<UnitComponent>().Get(drops[i].UnitId);
                DropComponent dropComponent = null;
                if (drops[i].DropType != 1)
                {
                    if (unitDrop == null)
                    {
                        errorCode = ErrorCode.ERR_NetWorkError;
                        continue;
                    }
                    dropComponent = unitDrop.GetComponent<DropComponent>();
                    int dropType = dropComponent.DropType;

                    if (dropType == 0 && sceneTypeEnum == SceneTypeEnum.Happy && cellindex != dropComponent.CellIndex)
                    {
                        errorCode = ErrorCode.Error_PickErrorCell;
                        continue;
                    }
                   
                    if (dropType == 2 && dropComponent.OwnerId != 0 && dropComponent.OwnerId != unit.Id && serverTime < dropComponent.ProtectTime)
                    {
                        errorCode = ErrorCode.ERR_ItemDropProtect;
                        continue;
                    }
                    if (dropType == 3 && dropComponent.OwnerId != 0 && dropComponent.OwnerId != unit.Id)
                    {
                        errorCode = ErrorCode.ERR_ItemBelongOther;
                        continue;
                    }
                }
                int addItemID = dropComponent !=null ? dropComponent.ItemID : drops[i].ItemID;
                int addItemNum = dropComponent != null ? dropComponent.ItemNum : drops[i].ItemNum;
                List<RewardItem> rewardItems = new List<RewardItem>();
                rewardItems.Add(new RewardItem() { ItemID = addItemID, ItemNum = addItemNum });
                bool success = unit.GetComponent<BagComponent>().OnAddItemData(rewardItems, string.Empty, $"{ItemGetWay.PickItem}_{TimeHelper.ServerNow()}");
                if (!success)
                {
                    errorCode = ErrorCode.ERR_BagIsFull;
                    continue;
                }
                //移除非私有掉落
                if (drops[i].DropType != 1)
                {
                    unit.GetParent<UnitComponent>().Remove(unitDrop.Id);       //移除掉落ID
                    removeIds.Add(drops[i].UnitId);
                }
                FubenHelp.SendFubenPickMessage(unit, drops[i]);
                ItemConfig itemConfig = ItemConfigCategory.Instance.Get(addItemID);
                if (sceneTypeEnum == SceneTypeEnum.Happy && itemConfig.ItemQuality >= 5)
                {
                    string uername = unit.GetComponent<UserInfoComponent>().UserInfo.Name;
                    string getmessage = $"{uername}在喜从天降活动这种获得: <color=#{ComHelp.QualityReturnColor(5)}>{itemConfig.ItemName}</color>";
                    ServerMessageHelper.SendBroadMessage(unit.DomainZone(), NoticeType.Notice, getmessage);
                }
            }
            
            return errorCode;
        }

        private int OnTeamPick(Unit unit, Actor_PickItemRequest request, int sceneTypeEnum, List<long> removeIds)
        {
            long debugId = 1231456;
            if (unit.Id == debugId)
            {
                LogHelper.LogDebug($"OnTeamPick1: {debugId} {unit.GetComponent<UserInfoComponent>().UserName}");
            }

            List<DropInfo> drops = request.ItemIds;
            long serverTime = TimeHelper.ServerNow();
            int errorCode = ErrorCode.ERR_Success;

            //DropType ==  0 公共掉落 2保护掉落   1私有掉落
            TeamDungeonComponent teamDungeonComponent = unit.DomainScene().GetComponent<TeamDungeonComponent>();
            for (int i = drops.Count - 1; i >= 0; i--)
            {
                Unit unitDrop = unit.GetParent<UnitComponent>().Get(drops[i].UnitId);
                DropComponent dropComponent = null;
                if (drops[i].DropType != 1)
                {
                    if (unitDrop == null)
                    {
                        errorCode = ErrorCode.ERR_ItemNotExist;
                        continue; 
                    }
                    dropComponent = unitDrop.GetComponent<DropComponent>();
                    int dropType = dropComponent.DropType;
                    if (dropType == 2 && dropComponent.OwnerId != 0 && dropComponent.OwnerId != unit.Id && serverTime < dropComponent.ProtectTime)
                    {
                        errorCode = ErrorCode.ERR_ItemDropProtect;
                        continue;
                    }
                    if (dropType == 3 && dropComponent.OwnerId != 0 && dropComponent.OwnerId != unit.Id)
                    {
                        errorCode = ErrorCode.ERR_ItemBelongOther;
                        continue;
                    }
                }

                int addItemID = dropComponent!=null ? dropComponent.ItemID : drops[i].ItemID;
                int addItemNum = dropComponent != null ? dropComponent.ItemNum : drops[i].ItemNum;
                ItemConfig itemConfig = ItemConfigCategory.Instance.Get(addItemID);

                bool teshuItem = itemConfig.ItemQuality >= 4 && itemConfig.ItemType == 2 && itemConfig.ItemSubType == 1;

                //紫色品质通知客户端抉择
                //DropType ==   0 公共掉落 1私有掉落 2保护掉落   3 归属掉落
                //if (unit.DomainZone() == 5)
                //{
                //    if (teamDungeonComponent.IsInTeamDrop(unitDrop.Id))
                //    {
                //        TeamDropItem teamDropItem = teamDungeonComponent.GetTeamDropItem(unitDrop.Id);
                //        Console.WriteLine($"teamDropItem:  {teamDropItem}");
                //    }
                //}
                if (drops[i].DropType != 1 && teamDungeonComponent.IsAllGiveDrop(unitDrop.Id)
                    && !teamDungeonComponent.ItemFlags.ContainsKey(unitDrop.Id))
                {
                    teamDungeonComponent.ItemFlags[unitDrop.Id] = unit.Id;
                }
                if (drops[i].DropType != 1 && teamDungeonComponent.IsInTeamDrop(unitDrop.Id)
                    && !teamDungeonComponent.ItemFlags.ContainsKey(unitDrop.Id))
                {
                    errorCode = ErrorCode.Error_PickWaitSelect;
                }
                if (drops[i].DropType == 0 && itemConfig.ItemQuality >= 4  && !teshuItem
                    && !teamDungeonComponent.ItemFlags.ContainsKey(unitDrop.Id))
                {
                    teamDungeonComponent.AddTeamDropItem( drops[i]);   //这个地方通知客户端弹窗需求还是放弃
                    continue;
                }

                //普通道具直接随机分配
                M2C_SyncChatInfo m2C_SyncChatInfo = FubenHelp.m2C_SyncChatInfo;
                m2C_SyncChatInfo.ChatInfo = new ChatInfo();
                m2C_SyncChatInfo.ChatInfo.PlayerLevel = unit.GetComponent<UserInfoComponent>().UserInfo.Lv;
                m2C_SyncChatInfo.ChatInfo.Occ = unit.GetComponent<UserInfoComponent>().UserInfo.Occ;
                m2C_SyncChatInfo.ChatInfo.ChannelId = (int)ChannelEnum.Pick;
                m2C_SyncChatInfo.ChatInfo.Time = TimeHelper.ServerNow();
                string colorValue = ComHelp.QualityReturnColor(itemConfig.ItemQuality);
                string numShow = "";
                if (itemConfig.Id == 1)
                {
                    numShow = unitDrop.GetComponent<DropComponent>().ItemNum.ToString();
                }

                Unit owner = null;
                if (drops[i].DropType == 1)
                {
                    owner = unit;
                }
                else
                {
                    //已经分配过的
                    if (teamDungeonComponent.ItemFlags.ContainsKey(unitDrop.Id))
                    {
                        owner = unit.GetParent<UnitComponent>().Get(teamDungeonComponent.ItemFlags[unitDrop.Id]);

                        string pick_name = teamDungeonComponent.TeamPlayers[teamDungeonComponent.ItemFlags[unitDrop.Id]].PlayerName;
                        pick_name += (owner == null ? "(未在副本中)" : string.Empty);
                        m2C_SyncChatInfo.ChatInfo.ChatMsg = m2C_SyncChatInfo.ChatInfo.ChatMsg + $"{pick_name}拾取{itemConfig.ItemName}";
                    }
                    else
                    {
                        int maxRollpoint = 0;
                        long maxPlayerId = 0;
                        Dictionary<long, TeamPlayerInfo> allPlayer = teamDungeonComponent.TeamPlayers;
                        foreach((long uid, TeamPlayerInfo TeamPlayerInfo) in allPlayer)
                        {
                            int rollpoint = 0;
                            if (teshuItem && TeamPlayerInfo.RobotId > 0)
                            {
                                rollpoint = 0;
                            }
                            else
                            {
                                rollpoint = (RandomHelper.RandomNumber(1, 100));
                            }

                            if (rollpoint >= maxRollpoint)
                            {
                                maxRollpoint = rollpoint;
                                maxPlayerId = uid;
                            }
                            m2C_SyncChatInfo.ChatInfo.ChatMsg += $"{TeamPlayerInfo.PlayerName}:{rollpoint}点";
                            m2C_SyncChatInfo.ChatInfo.ChatMsg += "  ";
                        }
                        
                        teamDungeonComponent.ItemFlags.Add(unitDrop.Id, maxPlayerId);
                        owner = unit.GetParent<UnitComponent>().Get(maxPlayerId);
                        string pick_name = teamDungeonComponent.TeamPlayers[maxPlayerId].PlayerName;
                        pick_name += (owner == null ? "(未在副本中)" : string.Empty);
                        m2C_SyncChatInfo.ChatInfo.ChatMsg = $"<color=#FDD376>{pick_name}</color>拾取<color=#{colorValue}>{numShow}{itemConfig.ItemName}</color>({m2C_SyncChatInfo.ChatInfo.ChatMsg})";
                    }
                }

                if (owner != null)
                {
                    List<RewardItem> rewardItems = new List<RewardItem>();
                    rewardItems.Add(new RewardItem() { ItemID = addItemID, ItemNum = addItemNum });

                    bool success = owner.GetComponent<BagComponent>().OnAddItemData(rewardItems, string.Empty, $"{ItemGetWay.PickItem}_{TimeHelper.ServerNow()}");
                    if (!success)
                    {
                        errorCode = owner.Id == unit.Id ? ErrorCode.ERR_BagIsFull : ErrorCode.ERR_ItemBelongOther;
                        continue;
                    }
                }
                if (drops[i].DropType != 1)
                {
                    unit.GetParent<UnitComponent>().Remove(unitDrop.Id);
                }
                MessageHelper.SendToClient(UnitHelper.GetUnitList(unit.DomainScene(), UnitType.Player), m2C_SyncChatInfo);
            }

            return errorCode;
        }

        protected override async ETTask Run(Unit unit, Actor_PickItemRequest request, Actor_PickItemResponse response, Action reply)
        {
            UnitInfoComponent unitInfoComponent = unit.GetComponent<UnitInfoComponent>();
            //DropType ==  0 公共掉落 2保护掉落   1私有掉落
            for (int i = request.ItemIds.Count - 1; i >= 0; i--) 
            {
                if (request.ItemIds[i].DropType != 1)
                {
                    continue;
                }
                bool have = false;
                for (int d = unitInfoComponent.Drops.Count - 1; d >= 0; d--)
                {
                    if (unitInfoComponent.Drops[d].ItemID == request.ItemIds[i].ItemID
                      && unitInfoComponent.Drops[d].ItemNum == request.ItemIds[i].ItemNum)
                    {
                        have = true;
                        unitInfoComponent.Drops.RemoveAt(d);
                        break;
                    }
                }
                if (!have)
                {
                    Log.Warning($"无效的私人掉落: {unit.DomainZone()}   {unit.Id}   {request.ItemIds[i].ItemID}   {request.ItemIds[i].ItemNum}");
                    request.ItemIds.RemoveAt(i);
                }
            }
            if (request.ItemIds.Count ==0)
            {
                response.Error = ErrorCode.ERR_ItemNotExist;
                reply();
                return;
            }

            List<long> removeIds = new List<long>();
            int sceneTypeEnum = unit.DomainScene().GetComponent<MapComponent>().SceneTypeEnum;
            if (sceneTypeEnum == SceneTypeEnum.TeamDungeon)
            {
                response.Error = OnTeamPick(unit, request, sceneTypeEnum, removeIds);
            }
            else
            {
                response.Error = OnFubenPick(unit, request, sceneTypeEnum, removeIds);
            }

            reply();
            await ETTask.CompletedTask;
        }
    }

}
