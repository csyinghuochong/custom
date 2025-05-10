using System;
using System.Collections.Generic;
using MongoDB.Bson.Serialization.Attributes;
using ProtoBuf;

namespace ET
{
    [ProtoContract]
    [Config]
    public partial class JiaYuanConfigCategory : ProtoObject, IMerge
    {
        public static JiaYuanConfigCategory Instance;
		
        [ProtoIgnore]
        [BsonIgnore]
        private Dictionary<int, JiaYuanConfig> dict = new Dictionary<int, JiaYuanConfig>();
		
        [BsonElement]
        [ProtoMember(1)]
        private List<JiaYuanConfig> list = new List<JiaYuanConfig>();
		
        public JiaYuanConfigCategory()
        {
            Instance = this;
        }
        
        public void Merge(object o)
        {
            JiaYuanConfigCategory s = o as JiaYuanConfigCategory;
            this.list.AddRange(s.list);
        }
		
        public override void EndInit()
        {
            foreach (JiaYuanConfig config in list)
            {
                config.EndInit();
                this.dict.Add(config.Id, config);
            }            
            this.AfterEndInit();
        }
		
        public JiaYuanConfig Get(int id)
        {
            this.dict.TryGetValue(id, out JiaYuanConfig item);

            if (item == null)
            {
                throw new Exception($"配置找不到，配置表名: {nameof (JiaYuanConfig)}，配置id: {id}");
            }

            return item;
        }
		
        public bool Contain(int id)
        {
            return this.dict.ContainsKey(id);
        }

        public Dictionary<int, JiaYuanConfig> GetAll()
        {
            return this.dict;
        }

        public JiaYuanConfig GetOne()
        {
            if (this.dict == null || this.dict.Count <= 0)
            {
                return null;
            }
            return this.dict.Values.GetEnumerator().Current;
        }
    }

    [ProtoContract]
	public partial class JiaYuanConfig: ProtoObject, IConfig
	{
		/// <summary>Id</summary>
		[ProtoMember(1)]
		public int Id { get; set; }
		/// <summary>名称</summary>
		[ProtoMember(2)]
		public string Name { get; set; }
		/// <summary>下一级ID</summary>
		[ProtoMember(3)]
		public int NextID { get; set; }
		/// <summary>等级</summary>
		[ProtoMember(4)]
		public int Lv { get; set; }
		/// <summary>升级经验</summary>
		[ProtoMember(5)]
		public int Exp { get; set; }
		/// <summary>人口上限</summary>
		[ProtoMember(6)]
		public int PeopleNumMax { get; set; }
		/// <summary>需要玩家等级</summary>
		[ProtoMember(7)]
		public int NeedRoseLv { get; set; }
		/// <summary>农场种植上限</summary>
		[ProtoMember(8)]
		public int FarmNumMax { get; set; }
		/// <summary>农场描述</summary>
		[ProtoMember(9)]
		public string JiaYuanDes { get; set; }
		/// <summary>兑换经验消耗资金</summary>
		[ProtoMember(10)]
		public int ExchangeExpCostZiJin { get; set; }
		/// <summary>兑换获得经验</summary>
		[ProtoMember(11)]
		public int ExchangeExp { get; set; }
		/// <summary>兑换获得资金消耗金币</summary>
		[ProtoMember(12)]
		public int ExchangeZiJinCostGold { get; set; }
		/// <summary>兑换获得资金</summary>
		[ProtoMember(13)]
		public int ExchangeZiJin { get; set; }
		/// <summary>家园每小时产出经验</summary>
		[ProtoMember(14)]
		public int JiaYuanAddExp { get; set; }
		/// <summary>宠物栏位</summary>
		[ProtoMember(15)]
		public int PetNum { get; set; }
		/// <summary>属性上限</summary>
		[ProtoMember(16)]
		public string ProMax { get; set; }

	}
}
