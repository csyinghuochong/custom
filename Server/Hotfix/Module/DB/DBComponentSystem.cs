﻿using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using MongoDB.Driver;

namespace ET
{
    [ObjectSystem]
    public class DBComponentAwakeSystem : AwakeSystem<DBComponent, string, string, int>
    {
        public override void Awake(DBComponent self, string dbConnection, string dbName, int zone)
        {
            self.Transfers.Clear();
        }
    }

    [ObjectSystem]
    public class DBComponentDestroySystem : DestroySystem<DBComponent>
    {
        public override void Destroy(DBComponent self)
        {
            self.Transfers.Clear();
        }
    }


    public static class DBComponentSystem
    {
        public static void InitDatabaseNew(this DBComponent self, StartZoneConfig startZoneConfig)
        {
            if (!self.ZoneDatabases.ContainsKey(startZoneConfig.Id))
            {
                var mongoClient = new MongoClient(startZoneConfig.DBConnection);
                var database = mongoClient.GetDatabase(startZoneConfig.DBName);
                self.ZoneDatabases.Add(startZoneConfig.Id, database);
                Log.Info($"Init Database zone:{startZoneConfig.Id.ToString()}");


                MongoClientSettings mongoSettings = new MongoClientSettings();
                TimeSpan t = new TimeSpan(100);
                mongoSettings.ConnectTimeout = t;//设置连接超时时长
                mongoSettings.MaxConnectionPoolSize = 2000;//设置连接池最大连接数
                MongoCredential credentials = MongoCredential.CreateCredential(startZoneConfig.DBName, "用户名", "密码");//添加用户名、密码
                mongoSettings.Credential = credentials;
                mongoSettings.Server = new MongoServerAddress(startZoneConfig.DBConnection);//服务器地址
                mongoSettings.ReadPreference = new ReadPreference(ReadPreferenceMode.Primary);
                mongoClient = new MongoClient(mongoSettings);

                var mongoDataBase = mongoClient.GetDatabase(startZoneConfig.DBName);
                self.ZoneDatabases.Add(startZoneConfig.Id, database);
            }
        }

        public static void InitDatabase(this DBComponent self, StartZoneConfig startZoneConfig)
        {
            if (!self.ZoneDatabases.ContainsKey(startZoneConfig.Id))
            {
                var mongoClient = new MongoClient(startZoneConfig.DBConnection);
                var database = mongoClient.GetDatabase(startZoneConfig.DBName);
                self.ZoneDatabases.Add(startZoneConfig.Id, database);
                Log.Info($"Init Database zone:{startZoneConfig.Id.ToString()}");
            }
        }

        #region Query

        public static async ETTask<T> Query<T>(this DBComponent self, int zone, long id, string collection = null) where T : Entity
        {
            using (await CoroutineLockComponent.Instance.Wait(CoroutineLockType.DB, id % DBComponent.TaskCount))
            {
                IAsyncCursor<T> cursor = await self.GetCollection<T>(zone, collection).FindAsync(d => d.Id == id);

                return await cursor.FirstOrDefaultAsync();
            }
        }

        public static async ETTask<List<T>> Query<T>(this DBComponent self, int zone, Expression<Func<T, bool>> filter, string collection = null)
                where T : Entity
        {
            using (await CoroutineLockComponent.Instance.Wait(CoroutineLockType.DB, RandomHelper.RandInt64() % DBComponent.TaskCount))
            {
                IAsyncCursor<T> cursor = await self.GetCollection<T>(zone, collection).FindAsync(filter);
                return await cursor.ToListAsync();
            }
        }

        public static async ETTask<List<T>> Query<T>(this DBComponent self, int zone, long taskId, Expression<Func<T, bool>> filter, string collection = null)
                where T : Entity
        {
            using (await CoroutineLockComponent.Instance.Wait(CoroutineLockType.DB, taskId % DBComponent.TaskCount))
            {
                IAsyncCursor<T> cursor = await self.GetCollection<T>(zone, collection).FindAsync(filter);

                return await cursor.ToListAsync();
            }
        }

        public static async ETTask Query(this DBComponent self, int zone, long id, List<string> collectionNames, List<Entity> result)
        {
            if (collectionNames == null || collectionNames.Count == 0)
            {
                return;
            }

            using (await CoroutineLockComponent.Instance.Wait(CoroutineLockType.DB, id % DBComponent.TaskCount))
            {
                foreach (string collectionName in collectionNames)
                {
                    IAsyncCursor<Entity> cursor = await self.GetCollection(zone, collectionName).FindAsync(d => d.Id == id);

                    Entity e = await cursor.FirstOrDefaultAsync();

                    if (e == null)
                    {
                        continue;
                    }

                    result.Add(e);
                }
            }
        }

        public static async ETTask<List<T>> QueryJson<T>(this DBComponent self, int zone, string json, string collection = null) where T : Entity
        {
            using (await CoroutineLockComponent.Instance.Wait(CoroutineLockType.DB, RandomHelper.RandInt64() % DBComponent.TaskCount))
            {
                FilterDefinition<T> filterDefinition = new JsonFilterDefinition<T>(json);
                IAsyncCursor<T> cursor = await self.GetCollection<T>(zone, collection).FindAsync(filterDefinition);
                return await cursor.ToListAsync();
            }
        }

        public static async ETTask<List<T>> QueryJson<T>(this DBComponent self, int zone, long taskId, string json, string collection = null) where T : Entity
        {
            using (await CoroutineLockComponent.Instance.Wait(CoroutineLockType.DB, RandomHelper.RandInt64() % DBComponent.TaskCount))
            {
                FilterDefinition<T> filterDefinition = new JsonFilterDefinition<T>(json);
                IAsyncCursor<T> cursor = await self.GetCollection<T>(zone, collection).FindAsync(filterDefinition);
                return await cursor.ToListAsync();
            }
        }

        #endregion

        #region Insert

        public static async ETTask InsertBatch<T>(this DBComponent self, int zone, IEnumerable<T> list, string collection = null) where T : Entity
        {
            if (collection == null)
            {
                collection = typeof(T).Name;
            }

            using (await CoroutineLockComponent.Instance.Wait(CoroutineLockType.DB, RandomHelper.RandInt64() % DBComponent.TaskCount))
            {
                await self.GetCollection(zone, collection).InsertManyAsync(list);
            }
        }

        #endregion

        #region Save

        public static async ETTask Save<T>(this DBComponent self, int zone, T entity, string collection = null) where T : Entity
        {
            if (entity == null)
            {
                Log.Error($"save entity is null: {typeof(T).Name}");

                return;
            }

            if (collection == null)
            {
                collection = entity.GetType().Name;
            }

            using (await CoroutineLockComponent.Instance.Wait(CoroutineLockType.DB, entity.Id % DBComponent.TaskCount))
            {
                await self.GetCollection(zone, collection).ReplaceOneAsync(d => d.Id == entity.Id, entity, new ReplaceOptions { IsUpsert = true });
            }
        }

        public static async ETTask Save<T>(this DBComponent self, int zone, long taskId, T entity, string collection = null) where T : Entity
        {
            if (entity == null)
            {
                Log.Error($"save entity is null: {typeof(T).Name}");

                return;
            }

            if (collection == null)
            {
                collection = entity.GetType().Name;
            }

            using (await CoroutineLockComponent.Instance.Wait(CoroutineLockType.DB, taskId % DBComponent.TaskCount))
            {
                await self.GetCollection(zone, collection).ReplaceOneAsync(d => d.Id == entity.Id, entity, new ReplaceOptions { IsUpsert = true });
            }
        }

        public static async ETTask Save(this DBComponent self, int zone, long id, List<Entity> entities)
        {
            if (entities == null)
            {
                Log.Error($"save entity is null");
                return;
            }

            using (await CoroutineLockComponent.Instance.Wait(CoroutineLockType.DB, id % DBComponent.TaskCount))
            {
                foreach (Entity entity in entities)
                {
                    if (entity == null)
                    {
                        continue;
                    }

                    await self.GetCollection(zone, entity.GetType().Name)
                            .ReplaceOneAsync(d => d.Id == entity.Id, entity, new ReplaceOptions { IsUpsert = true });
                }
            }
        }
        #endregion

        #region Remove

        public static async ETTask<long> Remove<T>(this DBComponent self, int zone, long id, string collection = null) where T : Entity
        {
            using (await CoroutineLockComponent.Instance.Wait(CoroutineLockType.DB, id % DBComponent.TaskCount))
            {
                DeleteResult result = await self.GetCollection<T>(zone, collection).DeleteOneAsync(d => d.Id == id);

                return result.DeletedCount;
            }
        }

        public static async ETTask<long> Remove<T>(this DBComponent self, int zone, long taskId, long id, string collection = null) where T : Entity
        {
            using (await CoroutineLockComponent.Instance.Wait(CoroutineLockType.DB, taskId % DBComponent.TaskCount))
            {
                DeleteResult result = await self.GetCollection<T>(zone, collection).DeleteOneAsync(d => d.Id == id);

                return result.DeletedCount;
            }
        }

        public static async ETTask<long> Remove<T>(this DBComponent self, int zone, Expression<Func<T, bool>> filter, string collection = null) where T : Entity
        {
            using (await CoroutineLockComponent.Instance.Wait(CoroutineLockType.DB, RandomHelper.RandInt64() % DBComponent.TaskCount))
            {
                DeleteResult result = await self.GetCollection<T>(zone, collection).DeleteManyAsync(filter);

                return result.DeletedCount;
            }
        }

        public static async ETTask<long> Remove<T>(this DBComponent self, int zone, long taskId, Expression<Func<T, bool>> filter, string collection = null)
                where T : Entity
        {
            using (await CoroutineLockComponent.Instance.Wait(CoroutineLockType.DB, taskId % DBComponent.TaskCount))
            {
                DeleteResult result = await self.GetCollection<T>(zone, collection).DeleteManyAsync(filter);

                return result.DeletedCount;
            }
        }

        #endregion

        /// <summary>
        /// /old
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="self"></param>
        /// <param name="id"></param>
        /// <param name="ids"></param>
        /// <param name="collection"></param>
        /// <returns></returns>
        public static async ETTask<List<T>> Query<T>(this DBComponent self, long id, List<long> ids, string collection = null) where T : Entity
        {
            using (await CoroutineLockComponent.Instance.Wait(CoroutineLockType.DB, id % DBComponent.TaskCount))
            {
                List<Entity> asas = new List<Entity>();
                foreach (long uuid in ids)
                {
                    IAsyncCursor<T> cursor = await self.GetCollection<T>(1, collection).FindAsync(d => d.Id == uuid);
                    Entity component = await cursor.FirstOrDefaultAsync();
                    asas.Add(component);
                }
                //List<AccountInfo> result = await DBComponent.Instance.Query<AccountInfo>(1, new List<long>());
                return asas as List<T>;
            }
        }
    }
}