﻿using System.Collections.Generic;
using UnityEngine;

namespace ET
{
    public class TeamDropItem : Entity, IAwake
    {
        //public bool AllGive = false;
        public long EndTime = 0;   //-1已分配好
        public DropInfo DropInfo; 
        public List<long> NeedPlayers = new List<long>();
        public List<long> GivePlayers = new List<long>();
    }

    public class TeamDungeonComponent : Entity, IAwake, IDestroy
    {
        public long Timer;
        public int FubenType;
        public long EnterTime;
        public TeamInfo TeamInfo;

        public List<long> EnterPlayers = new List<long> { };    

        public Dictionary<long, TeamPlayerInfo> TeamPlayers = new Dictionary<long, TeamPlayerInfo>();
       
        public List<int> BoxReward = new List<int>();
        public List<int> KillBossList = new List<int>();
        public List<TeamDropItem> TeamDropItems = new List<TeamDropItem>();
        public Dictionary<long, long> ItemFlags = new Dictionary<long, long>();

        public M2C_TeamPickMessage m2C_TeamPickMessage = new M2C_TeamPickMessage();

        public Vector3 BossDeadPosition = Vector3.zero;
    }
}
