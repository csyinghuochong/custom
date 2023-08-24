using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Assets.Scripts.Com.Game.Coroutine
{
    class CoroutineUnit : MonoBehaviour
    {
        public Action mCallBack;
        public string mName;

        public void StartCoroutineFunc(string func)
        {
            StartCoroutine(func);
        }

        public void StartCoroutineFunc(IEnumerator func)
        {
            StartCoroutine(func);
        }

        public void StopCoroutineFunc(IEnumerator func)
        {
            StopCoroutine(func);
        }

        public void StopCoroutineFunc(string func)
        {
            StopCoroutine(func);
        }

        public static void EmptyAction()
        {

        }

    }
}
