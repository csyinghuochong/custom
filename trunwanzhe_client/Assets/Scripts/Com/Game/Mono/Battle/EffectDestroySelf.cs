using UnityEngine;
using System.Collections;
namespace Assets.Scripts.Com.Game.Mono
{
    public class EffectDestroySelf : MonoBehaviour
    {

        public float duration = 5;
        private float mStartTime = 0;
        void Start()
        {
            this.mStartTime = Time.time;
        }

        void OnEnable()
        {
            this.mStartTime = Time.time;
        }
        // Update is called once per frame
        void Update()
        {
            if (Time.time - this.mStartTime > this.duration)
            {
                Destroy(this.gameObject);
            }
        }
    }
}