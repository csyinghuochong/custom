﻿using System;

namespace ET
{

    [ActorMessageHandler]
    public class C2M_RandomTowerBeginHandler : AMActorLocationRpcHandler<Unit, C2M_RandomTowerBeginRequest, M2C_RandomTowerBeginResponse>
    {
        protected override async ETTask Run(Unit unit, C2M_RandomTowerBeginRequest request, M2C_RandomTowerBeginResponse response, Action reply)
        {
            int randomTowerid = unit.GetComponent<NumericComponent>().GetAsInt(NumericType.RandomTowerId);
            if (randomTowerid == 0)
            {
                randomTowerid = TowerHelper.GetFirstTowerIdByScene(SceneTypeEnum.RandomTower);
            }
            else
            {
                randomTowerid += request.RandomNumber;
            }
            if (randomTowerid > TowerHelper.GetLastTowerIdByScene(SceneTypeEnum.RandomTower))
            {
                reply();
                return;
            }
            if (unit.DomainScene().GetComponent<RandomTowerComponent>() == null)
            {
                reply();
                return;
            }

            unit.DomainScene().GetComponent<RandomTowerComponent>().TowerId = randomTowerid;
            TowerConfig randowTowerConfig = TowerConfigCategory.Instance.Get(randomTowerid);
            FubenHelp.CreateMonsterList(unit.DomainScene(), randowTowerConfig.MonsterSet);

            reply();
            await ETTask.CompletedTask;
        }
    }
}