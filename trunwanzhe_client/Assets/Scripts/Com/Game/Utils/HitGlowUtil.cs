using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using Assets.Scripts.Com.Game.Utils.Timers;
using Assets.Scripts.Com.Game.Manager;

namespace Assets.Scripts.Com.Game.Utils
{
    class HitGlowObject
    {
        private const string SCALE_NAME = "_TintColorScale";
        private const string START_TIME = "_StartTime";
        private const string END_TIME = "_EndTime";

      
        private Renderer[] mRenderList;
        private GameTimer mGameTimer;
        private bool mResetShader;

        

        public void SetParam(float scale, float duration)
        {
            if (mGameTimer != null)
            {
                mGameTimer.Dispose();
            }

            if (duration <= 0)
            {
                OnTimerComplete();
                return;
            }

            SetScale(scale, Time.timeSinceLevelLoad, Time.timeSinceLevelLoad + duration);
            mGameTimer = GameTimer.SetTimeout(duration, OnTimerComplete);
        }

        private void OnTimerComplete()
        {
            SetScale(0, 0, 0);

            if (mResetShader && mShader != null)
            {
                ChangeShader(mShader);

                mShader = null;
            }

         
            mRenderList = null;

            HitGlowUtil.RemoveHitObject(this);
        }

        private Shader mShader;
        private void ChangeShader(Shader shader)
        {
            for (int i = 0, count = mRenderList.Length; i < count; i++)
            {
                Renderer render = mRenderList[i];
                if (render != null)
                {
                    if (mShader == null && mResetShader)
                    {
                        mShader = render.sharedMaterial.shader;
                    }

                    render.material.shader = shader;
                }
            }
        }

        private void SetScale(float scale, float startTime, float endTime)
        {
            for (int i = 0, count = mRenderList.Length; i < count; i++)
            {
                Renderer render = mRenderList[i];
                if (render != null)
                {
                    Material material = render.material;

                    material.SetFloat(SCALE_NAME, scale);
                    material.SetFloat(START_TIME, startTime);
                    material.SetFloat(END_TIME, endTime);
                }
            }
        }
    }

    class HitGlowUtil
    {
        private static Stack<HitGlowObject> sHitGlowObjPool = new Stack<HitGlowObject>();

        
        internal static void RemoveHitObject(HitGlowObject go)
        {
            sHitGlowObjPool.Push(go);
        }

        public static void Dispose()
        {
            sHitGlowObjPool.Clear();
        }
    }
}
