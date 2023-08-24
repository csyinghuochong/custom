using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using Assets.Scripts.Com.Game.Utils.Timers;
using Assets.Scripts.Com.Game.Manager;

namespace Assets.Scripts.Com.Game.Utils
{
    class FadeGameObject
    {
        public const string TOON_TRANSPARENT = "ToonTransparent";
        public const string TOON_OPAQUE = "ToonBasicOpaque";
        public const string TOON_OPAQUE_Hit = "ToonBasicOpaqueHit";
        public const string BEGIN_ALPHA = "_BeginAlpha";
        public const string END_ALPHA = "_EndAlpha";
        public const string END_TIME = "_EndTime";

        private Renderer[] mRenderList;

        public FadeGameObject(GameObject go, float alpha)
        {
            if (go == null)
                return;

            mRenderList = go.GetComponentsInChildren<Renderer>();

            if (alpha == 1.0f)
            {
               
            }
            else
            {
              
            }
        }

        public FadeGameObject(GameObject go, float beginAlpha, float endAlpha, float time, Action callBack)
        {
            if (go == null)
                return;

            mRenderList = go.GetComponentsInChildren<Renderer>();

            bool isFadeIn = endAlpha > beginAlpha;
           
        }

        private void ChangeShader(Shader shader)
        {
            for (int i = 0, count = mRenderList.Length; i < count; i++)
            {
                Renderer render = mRenderList[i];
                if (render != null)
                    render.material.shader = shader;
            }
        }

        private void ChangeShader(Shader shader, float beginAlpha, float endAlpha, float time)
        {
            for (int i = 0, count = mRenderList.Length; i < count; i++)
            {
                Renderer render = mRenderList[i];

                if (render != null)
                {
                    Material material = render.material;
                    material.shader = shader;

                    material.SetFloat(BEGIN_ALPHA, beginAlpha);
                    material.SetFloat(END_ALPHA, endAlpha);
                    material.SetFloat(END_TIME, Time.timeSinceLevelLoad + time);
                }
            }
        }
    }

    class FadeUtil
    {
        //淡入;
        public static void FadeIn(GameObject go, float time = 1.0f, Action callBack = null, float beginAlpha = 0f, float endAlpha = 1.0f)
        {
            new FadeGameObject(go, beginAlpha, endAlpha, time, callBack);
        }

        //淡出;
        public static void FadeOut(GameObject go, float time = 1.0f, Action callBack = null, float beginAlpha = 1.0f, float endAlpha = 0f)
        {
            new FadeGameObject(go, beginAlpha, endAlpha, time, callBack);
        }

        //设置透明度
        public static void SetAlpha(GameObject go, float alpha)
        {
            new FadeGameObject(go, alpha);
        }
    }
}
