using UnityEngine;
using System.Collections;
using System.Collections.Generic;

namespace Assets.Scripts.Com.Game.Mono
{
    public class ResetEffect : MonoBehaviour
    {
        private GameObject[] mParticlesGoList;
        private ParticleSystem[] mParticles;
        private bool mbShouldReset = false;

        int mPSStartRotationsCount;

        int mParticlesCount;
        void Awake()
        {
            this.mParticles = this.GetComponentsInChildren<ParticleSystem>(true);
            mParticlesGoList = new GameObject[mParticles.Length];
          
        }

        void ResetPSStartRotation()
        {
            if (mPSStartRotationsCount > 0)
            {
                for (int i = 0; i < mPSStartRotationsCount; i++)
                {
                
                }
            }
        }

        private GameObject GetParticlesGo(ParticleSystem ps, int index)
        {
            GameObject go = mParticlesGoList[index];

            if (go == null)
            {
                go = ps.gameObject;

                mParticlesGoList[index] = go;
            }

            return go;
        }


        void ResetParticles()
        {
            if (mParticlesCount > 0)
            {
                ParticleSystem ps = null;
                for (int i = 0; i < mParticlesCount; i++)
                {
                    ps = this.mParticles[i];
                    if (ps)
                    {
                        ps.Clear();
                        GetParticlesGo(ps, i).SetActive(true);
                    }
                }
            }

        }

        void ClearParticles()
        {
            if (mParticlesCount > 0)
            {
                ParticleSystem ps = null;
                for (int i = 0; i < mParticlesCount; i++)
                {
                    ps = this.mParticles[i];
                    if (ps)
                    {
                        ps.Clear();
                        GetParticlesGo(ps, i).SetActive(false);
                    }
                }
            }
        }

        void LateUpdate()
        {
            if (this.mbShouldReset)
            {
                this.ResetPSStartRotation();
                this.ResetParticles();
                this.mbShouldReset = false;
            }
        }
        void OnDisable()
        {
            this.mbShouldReset = true;
            this.ClearParticles();
        }
    }
}
