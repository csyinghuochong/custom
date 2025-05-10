﻿namespace ET
{

    /// <summary>
    /// 持续性伤害。 this.CheckChiXuHurt()已经实现了持续性伤害功能，
    /// </summary>
    public class Skill_DurationDamage : SkillHandler
    {
        public override void OnInit(SkillInfo skillId, Unit theUnitFrom)
        {
            this.BaseOnInit(skillId, theUnitFrom);
            this.SkillTriggerLastTime = TimeHelper.ServerNow();
        }

        public override void OnExecute()
        {
            this.InitSelfBuff();
            this.OnUpdate();
        }

        public override void OnUpdate()
        {
            //每间隔一段时间触发一次伤害
            long serverNow = TimeHelper.ServerNow();
            if (serverNow - this.SkillTriggerLastTime >= this.SkillConf.DamgeChiXuInterval)
            {
                SkillTriggerLastTime = TimeHelper.ServerNow();
                HurtIds.Clear();
                this.ExcuteSkillAction();
            }

            //技能存在时间
            if (serverNow > this.SkillEndTime)
            {
                this.SetSkillState(SkillState.Finished);
                return;
            }

            this.CheckChiXuHurt();
        }

        public override void OnFinished()
        {
            this.Clear();
        }
    }
}