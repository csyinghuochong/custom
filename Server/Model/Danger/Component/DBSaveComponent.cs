﻿using System.Collections.Generic;
using System;

namespace ET
{
    public class DBSaveComponent : Entity, IAwake, IDestroy, ITransfer
    {
        public long Timer;
        public long DBInterval;
        public long NoFindPath;
        public long SceondIndex;

        public HashSet<Type> EntityChangeTypeSet { get; } = new HashSet<Type>();
    }
}
