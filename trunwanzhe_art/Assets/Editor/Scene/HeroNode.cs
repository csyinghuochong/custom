using UnityEditor;
using UnityEngine;
using System.Xml;
using System.Text;
using System;
using System.Collections.Generic;
using Assets.Scripts.Com.Game.Module.Scene;


/// <summary>
/// 添加英雄节点
/// </summary>
public class HeroNode : EditorWindow
{
    public static Transform RootTrans;

    private int addId;
    private int heroId;
    private ECamp addCamp = ECamp.Friend;
    private Vector3 addPos;
    private float addRotation;

    void OnGUI()
    {
        EditorGUILayout.BeginVertical();

        if (RootTrans != null)
            EditorGUILayout.LabelField("添加的英雄出生点id: " + RootTrans.name.Substring(5));

        heroId = EditorGUILayout.IntField("英雄表的id:", heroId);
        addCamp = (ECamp)EditorGUILayout.EnumPopup("阵营:", addCamp);
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

        EditorGUILayout.Space();

        if (GUILayout.Button("确认添加英雄出生点"))
        {
            AddNode();
        }

        EditorGUILayout.EndVertical();
    }

    /// <summary>
    /// 添加节点
    /// 创建圆柱体
    /// </summary>
    private void AddNode()
    {
        var childGo = GameObject.CreatePrimitive(PrimitiveType.Cube);
        var vo = childGo.AddComponent<HeroVo>();
        vo.id = int.Parse(RootTrans.name.Substring(5));
        vo.heroId = heroId;
        vo.camp = addCamp;
        vo.x = addPos.x;
        vo.y = addPos.y;
        vo.z = addPos.z;
        vo.r = addRotation;

        var childTrans = childGo.transform;
        childTrans.parent = RootTrans;
        childTrans.localPosition = vo.position;
        childTrans.localEulerAngles = vo.rotation;

        childGo.name = vo.ToString();
        Debug.Log("添加英雄出生点成功：" + vo);
        this.Close();
    }
}
