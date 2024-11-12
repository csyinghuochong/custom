using MongoDB.Bson;
using MongoDB.Bson.Serialization;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ET
{
    public static  class ArchiveHelper
    {

        public static void OnArchiveHandler(int zone, long unitid)
        {
            ActivityComponent activityComponent = GetDBComponent<ActivityComponent>(zone, unitid, DBHelper.ActivityComponent);
            if (activityComponent == null)
            {
                Console.WriteLine($"OnArchiveHandler  activityComponent==null:   {zone} {unitid}");
                return;
            }


            BagComponent bagComponent = GetDBComponent<BagComponent>(zone, unitid, DBHelper.BagComponent);
            if (bagComponent==null)
            {
                Console.WriteLine($"OnArchiveHandler  bagComponent==null:   {zone} {unitid}");
                return;
            }

            ChengJiuComponent chengJiuComponent = GetDBComponent<ChengJiuComponent>(zone, unitid, DBHelper.ChengJiuComponent);
            if (chengJiuComponent == null)
            {
                Console.WriteLine($"OnArchiveHandler  chengJiuComponent==null:   {zone} {unitid}");
                return;
            }

            DBFriendInfo dBFriendInfo = GetDBComponent<DBFriendInfo>(zone, unitid, DBHelper.DBFriendInfo);
            if (dBFriendInfo == null)
            {
                Console.WriteLine($"OnArchiveHandler  dBFriendInfo==null:   {zone} {unitid}");
                return;
            }

            DBMailInfo dBMailInfo = GetDBComponent<DBMailInfo>(zone, unitid, DBHelper.DBMailInfo);
            if (dBMailInfo == null)
            {
                Console.WriteLine($"OnArchiveHandler  dBMailInfo==null:   {zone} {unitid}");
                return;
            }

            ////PaiMaiHelper.Instance.GetPaiMaiId(1)
            //DBPaiMainInfo dBPaiMainInfo = GetDBComponent<DBPaiMainInfo>(zone, unitid, DBHelper.DBPaiMainInfo);
            //if (dBPaiMainInfo == null)
            //{
            //    Console.WriteLine($"OnArchiveHandler  dBPaiMainInfo==null:   {zone} {unitid}");
            //    return;
            //}

            //被推广人可能会领取两次推广奖励
            //DBPopularizeInfo dBPopularizeInfo = GetDBComponent<DBPopularizeInfo>(zone, unitid, DBHelper.DBPopularizeInfo);

            //宠物天梯可能没有及时刷新
            //DBRankInfo 

            //全服公用数据，兑换比例。。。
            //DBServerInfo

            //全服邮件
            //DBServerMailInfo

            //帮会这个太多情况了，回档会导致自己丢失帮会。。。。。
            //DBUnionInfo dBUnionInfo;


        }

        public static K GetDBComponent<K>(int zone, long userID, string componentType) where K : Entity, new()
        {
            string filePath = $"C:/WJ/WJBeta{zone}/{componentType}.bson"; // 替换为你的.bson文件路径
            var list = new List<BagComponent>();
            using (var stream = File.OpenRead(filePath))
            {
                while (stream.Position != stream.Length)
                {
                    var document = BsonSerializer.Deserialize<BsonDocument>(stream);

                    BsonElement bsonElement  = document.ElementAt(0);

                    if (bsonElement.Value.AsInt64.Equals(userID))
                    {
                        var obj = BsonSerializer.Deserialize<K>(document);
                        return obj as K;
                    }
                }
            }

            return null;
        }


    }
}
