﻿using System;

namespace ET
{
    //登录中心服
    public class G2L_RemoveLoginRecordHandler : AMActorRpcHandler<Scene, G2L_RemoveLoginRecord, L2G_RemoveLoginRecord>
    {
        protected override async ETTask Run(Scene scene, G2L_RemoveLoginRecord request, L2G_RemoveLoginRecord response, Action reply)
        {
            try
            {
                long accountId = request.AccountId;
                using (await CoroutineLockComponent.Instance.Wait(CoroutineLockType.LoginCenterLock, accountId.GetHashCode()))
                {
                    int zone = scene.GetComponent<LoginInfoRecordComponent>().Get(accountId);
                    if (request.ServerId == zone)
                    {
                        scene.GetComponent<LoginInfoRecordComponent>().Remove(accountId);
                    }
                }
                reply();
            }
            catch (Exception e) 
            {
                Log.Error(e.ToString());
            }
        }
    }
}