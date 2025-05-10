﻿namespace ET
{

    //闪电链
    public class Skill_ChainLightning : SkillHandler
    {

        public override void OnInit(SkillInfo skillId, Unit theUnitFrom)
        {
            this.BaseOnInit(skillId, theUnitFrom);
        }

        public override void OnExecute()
        {
            this.InitSelfBuff();
            this.OnUpdate();
        }

        public void BroadcastSkill(long unitid, long targetId, float x, float y, float z)
        {
            MessageHelper.Broadcast(this.TheUnitFrom, new M2C_ChainLightning() 
            {
                UnitId = unitid,
                TargetID = targetId, 
                SkillID = this.SkillInfo.WeaponSkillID,
                PosX = x, PosY = y, PosZ = z
            });
        }

        public override void OnUpdate()
        {
            long serverNow = TimeHelper.ServerNow();
            if (serverNow - this.SkillTriggerLastTime < 500)
            {
                return;
            }
            this.SkillTriggerLastTime = serverNow;

            //从目标点最近的位置开始释放闪电链。最多连5米以内的5个单位
            Unit lastTarget = this.TheUnitFrom;
            Unit target = null;
            if (this.HurtIds.Count == 0)
            {
                target = AIHelp.GetNearestEnemy(lastTarget, 10f, true);
                if (target == null ||( target!= null && !this.CheckShape(target.Position)))
                {
                    this.SetSkillState(SkillState.Finished);
                    this.BroadcastSkill(this.TheUnitFrom.Id, 0, this.TargetPosition.x, this.TargetPosition.y, this.TargetPosition.z);
                    return;
                }
            }
            else
            { 
                lastTarget = this.TheUnitFrom.GetParent<UnitComponent>().Get(this.HurtIds[this.HurtIds.Count - 1]);
                if (lastTarget == null)
                {
                    this.SetSkillState(SkillState.Finished);
                    return;
                }
                target = AIHelp.GetNearestUnit(this.TheUnitFrom, lastTarget.Position, 5f, this.HurtIds);
                if (target == null)
                {
                    this.SetSkillState(SkillState.Finished);
                    return;
                }
            }

            if (lastTarget != null && target != null)
            {
                this.OnAddHurtIds(target.Id);
                this.OnCollisionUnit(target);
                this.BroadcastSkill(lastTarget.Id, target.Id, 0f,0f,0f);
            }

            if (serverNow > this.SkillEndTime || this.HurtIds.Count >= 5)
            {
                this.SetSkillState(SkillState.Finished);
            }

            this.CheckChiXuHurt();
        }

        public override void OnFinished()
        {
            this.Clear();
        }
    }
}
