﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ET
{
    public class SoloDungeonComponent : Entity, IAwake, IDestroy
    {
        public long Timer;
        public long TimerNum;
        public bool SendReward;
        //public long PlayerUnit_1;
        //public long PlayerUnit_2;
    }
}
