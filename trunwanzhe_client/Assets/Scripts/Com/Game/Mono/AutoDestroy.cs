using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Assets.Scripts.Com.Game.Mono
{
    class AutoDestroy : MonoBehaviour
    {
        public float aliveTime = 2f;

        float curTime = 0;

        void Update()
        {
            curTime += Time.deltaTime;
            if (curTime >= aliveTime)
            {
                Dispose();
            }
        }

        void Dispose()
        {
            Destroy(this.gameObject);
        }
    }
}
