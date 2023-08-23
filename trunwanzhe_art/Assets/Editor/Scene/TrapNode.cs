using UnityEditor;
using UnityEngine;
using System.Xml;
using System.Text;
using System;
using System.Collections.Generic;
using Assets.Scripts.Com.Game.Module.Scene;


/// <summary>
/// 添加陷阱节点
/// </summary>
public class TrapNode : EditorWindow
{
    public static Transform RootTrans;

    private int addId;
    private string trapIdStr;
    private ECamp addCamp = ECamp.Friend;
    private Vector3 addPos;
    private float addRotation;
    private Vector2 addSize;

    void OnGUI()
    {
        EditorGUILayout.BeginVertical();

        if (RootTrans != null)
        {
            EditorGUILayout.LabelField("添加的陷阱id: " + RootTrans.name.Substring(5));
            EditorGUILayout.LabelField("多个陷阱id用英文逗号隔开");
        }

        trapIdStr = EditorGUILayout.TextField("陷阱表的id:", trapIdStr);
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
        addSize = EditorGUILayout.Vector2Field("区域大小", addSize);

        EditorGUILayout.Space();

        if (GUILayout.Button("确认添加陷阱"))
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
        var vo = childGo.AddComponent<TrapVo>();
        vo.id = int.Parse(RootTrans.name.Substring(5));
        vo.trapIdStr = trapIdStr;
        vo.camp = addCamp;
        vo.x = addPos.x;
        vo.y = addPos.y;
        vo.z = addPos.z;
        vo.r = addRotation;
        vo.width = addSize.x;
        vo.height = addSize.y;

        var childTrans = childGo.transform;
        childTrans.parent = RootTrans;
        childTrans.localPosition = vo.position;
        childTrans.localEulerAngles = vo.rotation;

        var box = childTrans.GetComponent<BoxCollider>();
        box.size = vo.size;

        childGo.name = vo.ToString();
        Debug.Log("添加陷阱成功：" + vo +" => "+ vo.GetTrapId());
        this.Close();
    }
}

