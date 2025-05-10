﻿using System;

namespace ET
{
    [ActorMessageHandler]
    public class M2Arena_ArenaEnterHandler : AMActorRpcHandler<Scene, M2Arena_ArenaEnterRequest, Arena2M_ArenaEnterResponse>
    {
        protected override async ETTask Run(Scene scene, M2Arena_ArenaEnterRequest request, Arena2M_ArenaEnterResponse response, Action reply)
        {
            //不在时间范围内， 返回0


            response.FubenInstanceId = scene.GetComponent<ArenaSceneComponent>().GetArenaInstanceId(request.UserID, request.SceneId);

            reply();
            await ETTask.CompletedTask;
        }
    }
}
