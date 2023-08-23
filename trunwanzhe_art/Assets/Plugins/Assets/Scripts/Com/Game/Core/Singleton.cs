using System;
namespace Assets.Scripts.Com.Game.Core
{
    public class Singleton<T> where T : new()
    {
        private static T sInstance = (default(T) == null) ? new T() : default(T);

        public static T Instance
        {
            get
            {
                return sInstance;
            }
        }

        protected Singleton()
        {
            InternalInit();
        }

        protected virtual void InternalInit()
        {

        }

        protected void Recreate()
        {
            sInstance = (default(T) == null) ? new T() : default(T);
        }
    }
}

