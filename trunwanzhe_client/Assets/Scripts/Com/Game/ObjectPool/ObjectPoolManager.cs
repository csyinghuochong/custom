
using Assets.Scripts.Com.Net.Protos.Proto;
using UnityEngine;

namespace Assets.Scripts.Com.Game.ObjectPool
{
    class ObjectPoolManager
    {
        public static readonly ObjectPool<RecycleMS> sMemoryStreamPool = new ObjectPool<RecycleMS>();
        public static readonly ObjectPool<RawPacket> sRawPacketPool = new ObjectPool<RawPacket>();

        public static void ClearPool()
        {

        }

        private static void ClearGameObjectPool(UnityAssetPool pool)
        {
            if (pool != null)
                pool.Dispose();
        }
    }
}
