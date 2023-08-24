using UnityEngine;
using System.Collections;
using System.Collections.Generic;
namespace Assets.Scripts.Com.Game.Mono
{
    public class ResetParticle : MonoBehaviour
    {
        private ParticleSystem[] mParticles;
        private bool mbShouldReset = false;
        void Awake()
        {
            this.mParticles = this.GetComponentsInChildren<ParticleSystem>(true);
        }

        void LateUpdate()
        {
            if (this.mbShouldReset)
            {
                if (this.mParticles != null)
                {
                    for (int i = 0, count = mParticles.Length; i < count; i++)
                    {
                        ParticleSystem ps = mParticles[i];
                        ps.gameObject.SetActive(true);
                        ps.Clear();
                    }
                }
                this.mbShouldReset = false;
            }
        }

        void OnDisable()
        {
            this.mbShouldReset = true;
            if (this.mParticles != null)
            {
                for (int i = 0, count = mParticles.Length; i < count; i++)
                {
                    ParticleSystem ps = mParticles[i];
                    ps.gameObject.SetActive(false);
                    ps.Clear();
                }
            }
        }
    }
}