﻿namespace ET
{

    //技能通用类型
    public class Skill_Action_Common : SkillHandler
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
        
        public override void OnUpdate()
        {
            this.BaseOnUpdate();
            this.CheckChiXuHurt();
        }

        public override void OnFinished()
        {
            this.Clear();
        }
    }
}
