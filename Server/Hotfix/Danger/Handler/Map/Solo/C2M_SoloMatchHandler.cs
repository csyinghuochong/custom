﻿using System;
using System.Collections.Generic;
using System.Linq;


namespace ET
{

    [ActorMessageHandler]
    public class C2M_SoloMatchHandler : AMActorLocationRpcHandler<Unit, C2M_SoloMatchRequest, M2C_SoloMatchResponse>
    {
        protected override async ETTask Run(Unit unit, C2M_SoloMatchRequest request, M2C_SoloMatchResponse response, Action reply)
        {
            //获取地图类型,如果当前地图不是在主城就返回
            /*
            MapComponent mapComponent = unit.DomainScene().GetComponent<MapComponent>();
            if (mapComponent.SceneTypeEnum != SceneTypeEnum.MainCityScene)
            {
                reply();
                return;
            }
            */

            //给匹配服务器发送消息
            long soloServerId = DBHelper.GetSoloServerId(unit.DomainZone());  //获取solo服务器ID
            SoloPlayerInfo soloPlayerInfo = new SoloPlayerInfo();
            soloPlayerInfo.UnitId = unit.Id;
            soloPlayerInfo.Combat = unit.GetComponent<UserInfoComponent>().UserInfo.Combat;
            soloPlayerInfo.Name = unit.GetComponent<UserInfoComponent>().UserInfo.Name;
            soloPlayerInfo.Occ = unit.GetComponent<UserInfoComponent>().UserInfo.Occ;
            soloPlayerInfo.MatchTime = TimeHelper.ServerNow();
            S2M_SoloMatchResponse d2GGetUnit = (S2M_SoloMatchResponse)await ActorMessageSenderComponent.Instance.Call(soloServerId, new M2S_SoloMatchRequest()
            {
                SoloPlayerInfo = soloPlayerInfo,    
            });

            LogHelper.LogWarning("发送竞技场匹配地图消息" + soloPlayerInfo.UnitId, true);

            reply();
            await ETTask.CompletedTask;
        }
    }
}
