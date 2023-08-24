using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Assets.Scripts.Com.Game.Mono.Utils
{
    class CoroutineUtil : MonoBehaviour
    {
        private static CoroutineUtil instance;
        public static CoroutineUtil Instance
        {
            get
            {
                return instance;
            }
        }

        void Awake()
        {
            if (instance == null)
                instance = this;
        }

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

    }
}
