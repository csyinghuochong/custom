using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EffectConfig : MonoBehaviour 
{
    public enum eUpdateMode 
    {
        None,
        FollowOwner,
        FollowTarget,
        TargetPoint,
        TargetCenter,
        Center,
    }
    //是否需要镜像
    public bool mirror = false;
    //持续时间
    public float duration = 3;
    //开始时位置
    public eUpdateMode onStartPosition;
    //更新时位置
    public eUpdateMode onUpdatePosition;
    //匹配节点(有些特效需要绑定到人物的节点上)
    public Transform[] matchNodes;
}
