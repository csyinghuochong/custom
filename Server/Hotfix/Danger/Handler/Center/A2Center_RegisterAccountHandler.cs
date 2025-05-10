﻿using System;
using System.Collections.Generic;

namespace ET
{

    [ActorMessageHandler]
    public class A2Center_RegisterAccountHandler : AMActorRpcHandler<Scene, A2Center_RegisterAccount, Center2A_RegisterAccount>
    {
        protected override async ETTask Run(Scene scene, A2Center_RegisterAccount request, Center2A_RegisterAccount response, Action reply)
        {

            using (await CoroutineLockComponent.Instance.Wait(CoroutineLockType.Register, request.AccountName.GetHashCode()))
            {
                Log.Warning($"A2Center_RegisterAccount:{request.AccountName}");
                List<DBCenterAccountInfo> result = await Game.Scene.GetComponent<DBComponent>().Query<DBCenterAccountInfo>(scene.DomainZone(), _account => _account.Account == request.AccountName);

                //如果查询数据不为空,表示当前账号已经被注册
                if (result.Count > 0)
                {
                    response.Message = result[0].Id.ToString();
                    reply();
                    return;
                }

                //创建一条数据库信息,创建账号信息
                DBCenterAccountInfo newAccount = scene.AddChild<DBCenterAccountInfo>();
                newAccount.Account = request.AccountName;
                newAccount.Password = request.Password;
                newAccount.PlayerInfo = new PlayerInfo();
                newAccount.CreateTime = TimeHelper.ServerNow();

                //抖音账户 和 v20 直接实名
                if (request.age_type > 0)
                {
                    newAccount.PlayerInfo.Name = "loginType_" + request.LoginType;
                    newAccount.PlayerInfo.RealName = 1;
                    newAccount.PlayerInfo.IdCardNo = string.Empty;
                }

                //Log.Warning($"注册三方账号: {MongoHelper.ToJson(newAccount)}");
                await Game.Scene.GetComponent<DBComponent>().Save(scene.DomainZone(), newAccount);
                newAccount.Dispose();
                response.AccountId = newAccount.Id;
                //发送创建回执
                reply();
            }
        }
    }
}
