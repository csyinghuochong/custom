﻿using System.Linq;

namespace ET
{

    public static class PlayerComponentSystem
    {
        public class AwakeSystem : AwakeSystem<PlayerComponent>
        {
            public override void Awake(PlayerComponent self)
            {
            }
        }

        [ObjectSystem]
        public class PlayerComponentDestroySystem : DestroySystem<PlayerComponent>
        {
            public override void Destroy(PlayerComponent self)
            {
            }
        }

        public static void Add(this PlayerComponent self, Player player)
        {
            self.idPlayers.Add(player.AccountId, player);

            if (!self.instanceToId.ContainsKey(player.InstanceId))
            {
                self.instanceToId.Add(player.InstanceId, player.Id);
            }
            else
            {
                self.instanceToId[player.InstanceId] = player.Id;
            }
        }

        public static Player Get(this PlayerComponent self, long id)
        {
            self.idPlayers.TryGetValue(id, out Player gamer);
            return gamer;
        }

        public static int GetSameIpNumber(this PlayerComponent self, long accountid,  string ip)
        {
            int number = 0;
            foreach ( (long id , Player Player) in self.idPlayers )
            {
                if (id == accountid)
                {
                    continue;
                }
                if (!string.IsNullOrEmpty(Player.RemoteAddress) && Player.RemoteAddress.Contains(ip))
                {
                    number++;
                }
            }
            return number;
        }

        public static Player GetByUserId(this PlayerComponent self, long id)
        {
            foreach (var player in self.idPlayers.Values)
            {
                if (player.UnitId == id)
                {
                    return player;
                }
            }
            return null;
        }

        public static void Remove(this PlayerComponent self, long id)
        {
            self.idPlayers.Remove(id);
        }

        public static Player[] GetAll(this PlayerComponent self)
        {
            return self.idPlayers.Values.ToArray();
        }

        public static long GetActorId(this Player self)
        {
            return ConfigData.AccountOldLogic ? self.UnitId : self.InstanceId;
        }
    }
}