﻿using System;
using System.Collections.Generic;

namespace ET
{
    [ActorMessageHandler]
    public class C2M_PetFubenOverHandler : AMActorLocationHandler<Unit, C2M_PetFubenOverRequest>
    {
        protected override async ETTask Run(Unit unit, C2M_PetFubenOverRequest request)
        {
            await ETTask.CompletedTask;
            Scene domainScene = unit.DomainScene();
            MapComponent mapComponent = domainScene.GetComponent<MapComponent>();
            if (mapComponent.SceneTypeEnum == SceneTypeEnum.PetDungeon)
            {
                domainScene.GetComponent<PetFubenSceneComponent>().OnGameOver();
            }
            if (mapComponent.SceneTypeEnum == SceneTypeEnum.PetTianTi)
            {
                int result = domainScene.GetComponent<PetTianTiComponent>().GetCombatResult();
                result = result == CombatResultEnum.None ? CombatResultEnum.Fail : result;
                domainScene.GetComponent<PetTianTiComponent>().OnGameOver(result);
            }
            if (mapComponent.SceneTypeEnum == SceneTypeEnum.PetMing)
            {
                int result = domainScene.GetComponent<PetMingDungeonComponent>().GetCombatResult();
                result = result == CombatResultEnum.None ? CombatResultEnum.Fail : result;
                domainScene.GetComponent<PetMingDungeonComponent>().OnGameOver(result).Coroutine();
            }
        }
    }
}
