using UnityEditor;
using UnityEngine;
using System.Xml;
using System.Text;
using System;
using System.Collections.Generic;
using Assets.Scripts.Com.Game.Module.Scene;


/// <summary>
/// 怪物节点
/// </summary>
public class MonsterNode : EditorWindow
{
    public static Transform RootTrans;

    private int addId;
    private ECamp addCamp = ECamp.Enemy;
    private Vector3 addPos;
    private float addRotation;
    private EFlag addFlag = EFlag.OneHeroIn;
    private int addNum = 1;
    private float addRadius = 1f;
    private int addTrigger;
    private string addModelName = "";
    private float addDelay = 0f;

    void OnGUI()
    {
        if(RootTrans != null)
            EditorGUILayout.LabelField("注意：本次添加的怪物将添加到" + RootTrans.name + "的条件下！");

        addId = EditorGUILayout.IntField("怪物表的id:", addId);
        addCamp = (ECamp)EditorGUILayout.EnumPopup("阵营:", addCamp);
        addNum = EditorGUILayout.IntField("数量：", addNum);
        addRadius = EditorGUILayout.FloatField("随机范围", addRadius);
        addPos = EditorGUILayout.Vector3Field("位置: ", addPos);

        addRotation = EditorGUILayout.FloatField("方向: ", addRotation);
        if (GUILayout.Button("复制选中位置和方向"))
        {
            if (Selection.activeTransform == null)
            {
                Debug.LogWarning("请先选中场景中的物件！！！");
            }
            else
            {
                addPos = Selection.activeTransform.position;
                addRotation = Selection.activeTransform.eulerAngles.y;
            }
        }

        EditorGUILayout.LabelField("比如大乱斗的防御塔被推掉，促发一个超级兵。此处填130004000");
        addTrigger = EditorGUILayout.IntField("促发开关：唯一id ", addTrigger);

        addModelName = EditorGUILayout.TextField("模型名字（防御塔专用）：", addModelName);
        addDelay = EditorGUILayout.FloatField("延迟刷出时间：", addDelay);

        EditorGUILayout.Space();

        if (GUILayout.Button("确认添加节点"))
        {
            AddNode();
        }
    }

    /// <summary>
    /// 添加节点
    /// 创建圆柱体
    /// </summary>
    private void AddNode()
    {
        var childGo = GameObject.CreatePrimitive(PrimitiveType.Cylinder);
        var vo = childGo.AddComponent<MonsterlVo>();
        vo.id = RootTrans.childCount;
        vo.actId = addId;
        vo.camp = addCamp;
        vo.actFlag = int.Parse(RootTrans.name.Substring(5));
        vo.x = addPos.x;
        vo.y = addPos.y;
        vo.z = addPos.z;
        vo.r = addRotation;
        vo.actNum = addNum;
        vo.randRadius = addRadius;
        vo.trigger = addTrigger;
        vo.modelName = addModelName;
        vo.delay = addDelay;
        
        var childTrans = childGo.transform;
        childGo.name = "Monster_" + vo.id;
        childTrans.parent = RootTrans;
        childTrans.localPosition = vo.position;
        childTrans.localEulerAngles = vo.rotation;

        childGo.name = vo.ToString();
        Debug.Log("添加怪物成功：" + vo);
        this.Close();
    }
}
