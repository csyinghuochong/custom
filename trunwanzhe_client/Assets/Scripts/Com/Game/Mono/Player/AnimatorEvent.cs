using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Assets.Scripts.Com.Game.Mono.Player
{
    class AnimatorEvent : MonoBehaviour
    {
        //是否开始IK动画
        public bool ikActive = true;
        public event Action ikHandle;

        //前提是在Unity导航菜单栏中打开Window-&gt;Animator打开动画控制器窗口，在这里必须勾选IK Pass！！！
        void OnAnimatorIK()
        {
            //if the IK is active, set the position and rotation directly to the goal. 
            if (ikActive)
            {
                ikHandle();
            }
        }

        /// <summary>
        /// 动画事件处理
        /// </summary>
        /// <param name="clipName"></param>
        void AnimationEvent(string clipName)
        {

        }  
    }
}
