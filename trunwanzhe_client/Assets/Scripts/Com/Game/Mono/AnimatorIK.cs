using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Assets.Scripts.Com.Game.Mono
{
    class AnimatorIK : MonoBehaviour
    {
        Animator animator;
        Transform mIkPointTf;
        bool ikActive = true;

        void Awake()
        {
            if (gameObject == null)
                return;

            animator = gameObject.GetComponent<Animator>();
            ikActive = true;
        }

        //设置IK点
        public void SetIKPoint(Transform ikpoint)
        {
            mIkPointTf = ikpoint;
        }

        public void ActiveIK(bool active)
        {
            if (ikActive == active)
                return;

            ikActive = active;
        }

        void SetIK()
        {
            if (animator == null || mIkPointTf ==null)
                return;

            animator.SetIKPosition(AvatarIKGoal.LeftHand, mIkPointTf.position);
            animator.SetIKRotation(AvatarIKGoal.LeftHand, mIkPointTf.rotation);
            animator.SetIKPositionWeight(AvatarIKGoal.LeftHand, 1);
        }

        void OnAnimatorIK()
        {
            if (!ikActive)
                return;

            SetIK();
        }

    }
}
