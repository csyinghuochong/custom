using System;
using System.Collections.Generic;
using System.Linq;

namespace ET
{

    [ObjectSystem]
    public class UnitComponentAwakeSystem1 : AwakeSystem<UnitComponent>
    {
        public override void Awake(UnitComponent self)
        {
            self.AoI.Clear();
            self.Units.Clear();

            self.UnitComponents.Clear();
        }
    }

    [ObjectSystem]
    public class UnitComponentDestroySystem : DestroySystem<UnitComponent>
    {
        public override void Destroy(UnitComponent self)
        {
            for (int i = self.Units.Count - 1; i >= 0; i--)
            {
                self.Units[i] = null;
            }
            self.Units.Clear();
            self.UnitComponents.Clear();    
        }
    }

    public static class UnitComponentSystem
    {
        public static void Add(this UnitComponent self, Unit unit)
        {
            if (self.Units.Count >= 5000)
            {
                Log.Error($"self.Units.Count >= 5000");
            }

            if (unit.Type == UnitType.Player && self.AoI.Count < 100)
            {
                self.AoI.Add(unit.Id);
            }

            self.Units.Add(unit);
        }

        public static void AddPlayer(this UnitComponent self, Unit unit)
        {
            if (unit.Type == UnitType.Player && !self.AllPlayers.Contains(unit.Id)
                && unit.GetComponent<UserInfoComponent>().UserInfo.Lv >= 10)
            {
                self.AllPlayers.Add(unit.Id);
            }

        }

        public static Unit Get(this UnitComponent self, long id)
        {
            Unit unit = self.GetChild<Unit>(id);
            return unit;
        }

        public static void Remove(this UnitComponent self, long id)
        {
            self.AoI.Remove(id);

            Unit unit = self.GetChild<Unit>(id);
            self.Units.Remove(unit);
            unit?.Dispose();
        }

        public static List<Unit> GetAll(this UnitComponent self)
        {
            return self.Units;
            //return self.Children.Values.ToArray();
        }

    }
}