﻿using System.Linq;
using UnityEngine;

namespace ET
{
    public class Behaviour_Target : BehaviourHandler
    {

        public override int BehaviourId()
        {
            return BehaviourType.Behaviour_Target;
        }

        public override bool Check(BehaviourComponent aiComponent, AIConfig aiConfig)
        {
            return aiComponent.NewBehaviour == BehaviourId();
        }

        public override async ETTask Execute(BehaviourComponent aiComponent, AIConfig aiConfig, ETCancellationToken cancellationToken)
        {
            Unit unit = UnitHelper.GetMyUnitFromZoneScene(aiComponent.ZoneScene());
            Vector3 targetPosition = aiComponent.TargetPosition;
            //Log.Console($"Behaviour_Target: Execute");
            while (true)
            {
                if (unit.IsDisposed)
                {
                    return;
                }
                Unit target = AIHelp.GetNearestEnemy(unit, 10);
                if (target!=null && aiComponent.HaveHaviour(BehaviourType.Behaviour_ZhuiJi))
                {
                    aiComponent.TargetID = target.Id;
                    aiComponent.ChangeBehaviour(BehaviourType.Behaviour_ZhuiJi);
                    return;
                }

                if (Vector3.Distance(unit.Position, targetPosition) > 1f)
                {
                    unit.MoveToAsync2(targetPosition).Coroutine();
                }
                
                bool timeRet = await TimerComponent.Instance.WaitAsync(1000, cancellationToken);
                if (!timeRet)
                {
                    return;
                }
            }

        }
    }
}
