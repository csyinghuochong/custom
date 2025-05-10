﻿using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Bson.Serialization.Options;
using System.Collections.Generic;

namespace ET
{

	[BsonIgnoreExtraElements]
	public class DBAccountInfo : Entity, IAwake
	{
		//用户名
		public string Account { get; set; }

		//密码
		public string Password { get; set; }

		//UserList列表
		public List<long> UserList = new List<long>();

		//删除UserList列表
		public List<long> DeleteUserList = new List<long>();

        //禁封角色列表
        public List<long> BanUserList = new List<long>();
        
        [BsonDictionaryOptions(DictionaryRepresentation.ArrayOfArrays)]
        public Dictionary<long, long> BanUserTime = new Dictionary<long, long>();

        public int AccountType; //账号类型     0正常  1白名单  2黑名单

		public long CreateTime; //创建时间
		
        public List<BagInfo> BagInfoList = new List<BagInfo>();

        public int HaveItemById(long bagInfoId)
        {
            for (int i = 0; i < BagInfoList.Count; i++)
            {
                if (BagInfoList[i].BagInfoID == bagInfoId)
                {
                    return i;
                }
            }
            return -1;
        }
    }
}
