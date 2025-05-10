﻿using System.Collections.Generic;

namespace ET
{
    public class SkillPassiveInfo
    {
        public int SkillId;
        public List<int> SkillPassiveTypeEnum;
        public List<float> SkillPro;                  //触发概率或者血量百分比
        public int TriggerOnce;                 //是否触发一次
        public long TriggerInterval;           //触发间隔
        public long LastTriggerTime;            //上次触发时间
        public int TriggerNumber;

        public SkillPassiveInfo(int skillId, List<int> skillPassiveTypeEnum, List<float> skillPro, int triggerOnce, double triggerTime)
        {
            this.SkillId = skillId;
            this.SkillPassiveTypeEnum = skillPassiveTypeEnum;
            this.SkillPro = skillPro;
            this.TriggerOnce = triggerOnce;
            this.TriggerInterval = (long)(1000 * triggerTime);
            this.LastTriggerTime = 0;
        }

        public void Reset()
        {

            this.LastTriggerTime = 0;
        }
    }

    public class SkillPassiveComponent : Entity, IAwake, IDestroy, ITransfer
    {
        public long Timer;
        public int UnitType;
        public long SingTimer;
        public int HuixueTimeNum;               //回血触发计时器,几秒触发
        public List<SkillPassiveInfo> SkillPassiveInfos = new List<SkillPassiveInfo>();
        public C2M_SkillCmd C2M_SkillCmd = new C2M_SkillCmd();
        public StateComponent StateComponent;
        public NumericComponent NumericComponent;

        public SkillPassiveInfo SingSkillIfo;
        public long SingTargetId = 0;

    }
}
