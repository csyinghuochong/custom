﻿using System;

namespace ET
{
    public class A2R_GetRealmKeyHandler : AMActorRpcHandler<Scene, A2R_GetRealmKey, R2A_GetRealmKey>
    {
        protected override async ETTask Run(Scene scene, A2R_GetRealmKey request, R2A_GetRealmKey response, Action reply)
        {
            try
            {
                if (scene.SceneType != SceneType.Realm)
                {
                    Log.Warning($"请求的Scene错误1，当前Scene为：{scene.SceneType}");
                    response.Error = ErrorCode.ERR_RequestSceneTypeError;
                    reply();
                    return;
                }

                string key = TimeHelper.ServerNow().ToString() + RandomHelper.RandInt64().ToString();
                scene.GetComponent<TokenComponent>().Remove(request.AccountId);
                scene.GetComponent<TokenComponent>().Add(request.AccountId, key);
                response.RealmKey = key.ToString();
                reply();

            }
            catch (Exception ex)
            { 
                Log.Error (ex.ToString());  
            }
           
            await ETTask.CompletedTask;
        }
    }
}